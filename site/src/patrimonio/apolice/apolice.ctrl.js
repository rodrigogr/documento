'use strict'
angular.module('PatrimonioModule').controller('PatrimonioApoliceCtrl',
    function ($scope, PatrimonioApoliceService, EmpresaService, UtilsService, DateService, HeaderFactory, $state, AuthService)
    {
        HeaderFactory.setHeader('patrimônio', 'apólices');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        var self = this;

        var mEmpresaSrv = EmpresaService;
        var mUtilSrv = UtilsService ;

        $scope.mApoliceSrv = PatrimonioApoliceService;
        $scope.mDateSrv = DateService;

        $scope.data = {
            'model': {},
            'list': {}
        };

        $scope.init = function()
        {
            $scope.mApoliceSrv.read().then(e => $scope.data.rows = e.data);
            mEmpresaSrv.getAllEmpresas().then(e => $scope.data.list.seguradoras = e.data);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
            $scope.data_hoje = new Date();
        };

        window.addEventListener('apolice-patrimonios-edited',
            function(e)
            {
                $scope.mApoliceSrv.read().then(o => {
                    $scope.data.rows = o.data

                    // Envia alteracoes para q a controller interna possa
                    // atualizar a grade de patrimônios.
                    var event = new CustomEvent('apolice-edited', { 'detail': o.data.find(ob => ob.id == e.detail.id) });
                    window.dispatchEvent(event);
                });
            });

        $scope.newRow = function()
        {
            // Toda apólice possui um status implícito 'Ativo' ou 'Cancelado',
            // que é baseado no preenchimento do campo motivo_cancelamento,
            // Quando uma apólice é criada, não é necessário fazer essa
            // verificação, ela já inicia com status Ativo.
            $scope.data.model = {
                'status':'Ativo'
            };

            // Usado para habilitar/desabilitar o botão de inclusão de
            // patrimônios. Como esse botao pertence a outra controller,
            // é necessário fazer a comunicação via serviço.
            $scope.mApoliceSrv.setStatus('Ativo');

            self.openModal();
        };

        $scope.editRow = function(e, row)
        {
            e.preventDefault();
            var model = angular.copy(row);

            model.data_inicio = $scope.mDateSrv.isoToDateObj(model.data_inicio);
            model.data_final = $scope.mDateSrv.isoToDateObj(model.data_final);

            // Toda apólice possui um status implícito 'Ativo' ou 'Cancelado',
            // que é baseado no preenchimento do campo motivo_cancelamento.
            // Se o campo está preenchido, então a apólice deve ter status
            // 'Cancelado'.
            model.status = model.motivo_cancelamento ? 'Cancelado' : 'Ativo';

            // Usado para habilitar/desabilitar o botão de inclusão de
            // patrimônios. Como esse botao pertence a outra controller,
            // é necessário fazer a comunicação via serviço.
            $scope.mApoliceSrv.setStatus(model.status);

            $scope.data.model = model;

            // Marca a apólice selecionada para que a controller interna possa
            // listar somente os patrimônios dessa apólice específica.
            var event = new CustomEvent('apolice-edited', { 'detail': model });
            window.dispatchEvent(event);

            self.openModal();
        };

        $scope.submit = function()
        {
            if (!$scope.data.model.id) {
                $scope.create();
            }
        };

        $scope.create = function()
        {
            var srv = function()
            {
                var model = angular.copy($scope.data.model);
                return $scope.mApoliceSrv.create(model);
            };

            self.save(srv);
        };

        $scope.update = function()
        {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para cancelar esta apólice!');
                return false;
            }
            var srv = function()
            {
                var model = angular.copy($scope.data.model);
                return $scope.mApoliceSrv.update(model, model.id);
            };

            self.save(srv);
        };

        $scope.openModalCancelamento = function (e)
        {
            e.preventDefault();
            $('#cancelamento').modal('show');
        };

        $scope.closeModalCancelamento = function ()
        {
            // Limpa a variavel motivo_cancelamento, para evitar que ao salvar
            // a apólice, salve esse campo também, o que consideraria a apólice
            // como cancelada.
            $scope.data.model.motivo_cancelamento = '';

            // TODO: ver se há necessidade de evento aqui.
            $('#cancelamento').modal('hide');
        };

        $scope.closeModal = function()
        {
            $('#registro').modal('hide');
        };

        this.openModal = function ()
        {
            $('#registro').modal('show');
        };

        this.save = function (callback)
        {
            if ($scope.data.model.data_final < new Date()) {
                $scope.data.model.status = 'Expirado';

                // Usado para habilitar/desabilitar o botão de inclusão de
                // patrimônios. Como esse botao pertence a outra controller,
                // é necessário fazer a comunicação via serviço.
                $scope.mApoliceSrv.setStatus('Expirado');
            }

            $scope.data.model.data_inicio = $scope.mDateSrv.gmtToISO($scope.data.model.data_inicio);
            $scope.data.model.data_final = $scope.mDateSrv.gmtToISO($scope.data.model.data_final);

            callback()
                .then(function(ret) {
                    mUtilSrv.openSuccessAlert(ret.data);
                    $scope.mApoliceSrv.read().then(e => $scope.data.rows = e.data);
                    $scope.closeModal();
                    $scope.closeModalCancelamento();
                })
                .catch(function(error) {
                    if (error.responseJSON) {
                        mUtilSrv.openErrorMsg(error.responseJSON.message);
                    } else {
                        mUtilSrv.openErrorMsg(error.statusText);
                    }
                });
        };
    });
