'use strict'
angular.module('PatrimonioModule').controller('PatrimonioManutencaoCtrl',
    function ($scope, PatrimonioManutencaoService, PatrimonioBensService, EmpresaService, UtilsService, DateService, UsuarioService, HeaderFactory, $state, AuthService)
    {
        HeaderFactory.setHeader('patrimônio', 'manutenção');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        var self = this;

        var mManutencaoSrv = PatrimonioManutencaoService;
        var mBensSrv = PatrimonioBensService;
        var mEmpresaSrv = EmpresaService;
        var mUtilSrv = UtilsService;
        var mUsuarioSrv = UsuarioService;

        $scope.mDateSrv = DateService;

        $scope.$watch('data.model.retorno',
            function(v)
            {
                // Ao marcar 'Retornou?' com 'sim', autopreencher 'data de retorno' com a data de 'hoje'.
                if (v) {
                    $scope.data.model.data_retorno = new Date();
                } else {
                    $scope.data.model.data_retorno = null;
                }
            });

        $scope.data = {
            'model': {},
            'list': {},

            // Marca se o conteúdo deve ser editavel ou não. A manutenção só
            // deve ser editavel caso seja nova ou não tenha ainda dados de
            // retorno.
            'editavel': true
        };

        $scope.init = function()
        {
            mManutencaoSrv.read().then(e => $scope.data.rows = e.data);
            mEmpresaSrv.getAllEmpresas().then(e => $scope.data.list.fornecedores = e.data);
            mBensSrv.readSemPendente().then(e => $scope.data.list.patrimonios = e.data);
            mUsuarioSrv.getAllUsuarios2().then( e => $scope.data.list.usuarios = e.data);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        $scope.newRow = function()
        {
            $scope.data.model = {
                'data_saida': new Date()
            };

            // Limpar o objeto patrimonioSelecionado para que ao abrir
            // novamente o modal, não venha já selecionado o patrimonio da
            // seleção anterior.
            $scope.data.patrimonioSelecionado = null;

            $scope.data.editavel = true;

            self.openModal();
        };

        $scope.editRow = function(e, row)
        {
            e.preventDefault();
            var model = angular.copy(row);

            // Ao editar o formulário é necessário preencher manualmente o
            // patrimonio selecionado, porque o combo de patrimonios já virá
            // selecionado automaticamente.
            $scope.data.patrimonioSelecionado = $scope.data.list.patrimonios.find(e => e.id == row.id_patrimonio);

            model.data_saida = $scope.mDateSrv.isoToDateObj(model.data_saida);
            model.previsao_retorno = $scope.mDateSrv.isoToDateObj(model.previsao_retorno);
            model.data_retorno = $scope.mDateSrv.isoToDateObj(model.data_retorno);
            model.fim_garantia = $scope.mDateSrv.isoToDateObj(model.fim_garantia);
            model.retorno = !!model.data_retorno;

            // A manutenção só deve ser editavel caso seja nova ou não tenha
            // ainda dados de retorno.
            $scope.data.editavel = !model.retorno;

            $scope.data.model = model;
            self.openModal();
        };

        $scope.submit = function()
        {
            if ($scope.data.model.id) {
                if ($scope.data.editavel) {
                    if (!$scope.accessPagina.editar) {
                        UtilsService.toastError('Você não tem permissão para editar esse registro!');
                        return false;
                    }
                    $scope.update();
                }
            } else {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar registro!');
                    return false;
                }
                $scope.create();
            }
        };

        $scope.create = function()
        {
            var srv = function()
            {
                var model = angular.copy($scope.data.model);
                return mManutencaoSrv.create(model);
            };

            self.save(srv);
        };

        $scope.update = function()
        {
            var srv = function()
            {
                var model = angular.copy($scope.data.model);
                return mManutencaoSrv.update(model, model.id);
            };

            self.save(srv);
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
            $scope.data.model.data_saida = $scope.mDateSrv.gmtToISO($scope.data.model.data_saida);
            $scope.data.model.previsao_retorno = $scope.mDateSrv.gmtToISO($scope.data.model.previsao_retorno);
            $scope.data.model.data_retorno = $scope.mDateSrv.gmtToISO($scope.data.model.data_retorno);
            $scope.data.model.fim_garantia = $scope.mDateSrv.gmtToISO($scope.data.model.fim_garantia);

            $scope.data.model.id_patrimonio = $scope.data.patrimonioSelecionado.id;

            callback().then(function(ret) {
                    mUtilSrv.openSuccessAlert(ret.data);
                    mManutencaoSrv.read().then(e => $scope.data.rows = e.data);
                    $scope.closeModal();
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
