'use strict'
angular.module('PatrimonioModule').controller('PatrimonioBaixaCtrl',
    function ($scope, PatrimonioBaixaService, PatrimonioBensService, UtilsService, DateService, ValorService, HeaderFactory, $state, AuthService) {

        HeaderFactory.setHeader('patrimônio', 'baixa');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        var self = this;

        var mBaixaSrv = PatrimonioBaixaService;
        var mBensSrv = PatrimonioBensService;
        var mUtilSrv = UtilsService;
        var mValorSrv = ValorService;

        $scope.mDateSrv = DateService;

        $scope.data = {
            'model': {},
            'list': {}
        };

        $scope.$watch('data.patrimonioSelecionado', function(v)
        {
            if (v) {
                self.atualizarValores(v);
            }
        });

        $scope.init = function()
        {
            mBaixaSrv.read().then(e => $scope.data.rows = e.data);
            mBensSrv.read().then(e => $scope.data.list.patrimonios = e.data);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);

            // Não permite que seja selecionada data posterior ao dia de hoje.
            $('#data').attr('max', $scope.mDateSrv.gmtToISO(new Date()));
        };

        $scope.newRow = function()
        {
            $scope.data.model = {};

            // Limpar o objeto patrimonioSelecionado para que ao abrir
            // novamente o modal, não venha já selecionado o patrimonio da
            // seleção anterior.
            $scope.data.patrimonioSelecionado = null;

            self.openModal();
        };

        $scope.editRow = function(e, row)
        {
            e.preventDefault();
            var model = angular.copy(row);

            // Ao editar o formulário é necessário preencher manualmente o
            // patrimonio selecionado, porque o combo de patrimonios já virá
            // selecionado automaticamente.
            var patrimonioSelecionado = $scope.data.list.patrimonios.find(e => e.id == row.id_patrimonio);
            $scope.data.patrimonioSelecionado = patrimonioSelecionado;

            // Necessário atualizar os valores manualmente, porque o watch pode
            // não ser disparado se o usuário tiver selecionado anteriormente
            // um registro com o mesmo patrimônio.
            self.atualizarValores(patrimonioSelecionado);

            model.data = $scope.mDateSrv.isoToDateObj(model.data);
            $scope.data.model = model;

            self.openModal();
        };

        $scope.submit = function()
        {
            if (!$scope.data.model.id) {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar baixa!');
                    return false;
                }
                $scope.create();
            }
            // Não deve existir método para atualizar registro no formulário da
            // modal principal, porque uma baixa não pode ser editada após ser
            // criada. Uma baixa após criada pode apenas ser revogada.
        };

        $scope.create = function()
        {
            var srv = function()
            {
                var model = angular.copy($scope.data.model);
                return mBaixaSrv.create(model);
            };

            self.save(srv);
        };

        $scope.update = function()
        {
            if (!$scope.accessPagina.editar) {
                UtilsService.toastError('Você não tem permissão para revogar!')
                return false;
            }
            var srv = function()
            {
                var model = angular.copy($scope.data.model);
                return mBaixaSrv.update(model, model.id);
            };

            self.save(srv);
        };

        $scope.openModalRevogacao = function (e)
        {
            e.preventDefault();
            $('#revogacao').modal('show');
        };

        $scope.closeModalRevogacao = function ()
        {
            // Limpa a variavel motivo_revogacao, para evitar que ao salvar a
            // baixa, salve esse campo também, o que consideraria a baixa como
            // revogada.
            $scope.data.model.motivo_revogacao = '';

            $('#revogacao').modal('hide');
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
            $scope.data.model.data = $scope.mDateSrv.gmtToISO($scope.data.model.data);
            $scope.data.model.id_patrimonio = $scope.data.patrimonioSelecionado.id;

            callback().then(function(ret) {
                    mUtilSrv.openSuccessAlert(ret.data);

                    // Recarrega todos os dados, para mostrar as alterações.
                    $scope.init();

                    // Limpa o patrimonio selecionado, para que da proxima vez
                    // que entrar no registro, seja executado o watch sobre
                    // essa variavel.
                    $scope.data.patrimonioSelecionado = {};

                    $scope.closeModal();
                    $scope.closeModalRevogacao();
                })
                .catch(function(error) {
                    if (error.responseJSON) {
                        mUtilSrv.openErrorMsg(error.responseJSON.message);
                    } else {
                        mUtilSrv.openErrorMsg(error.statusText);
                    }
                });
        };

        this.atualizarValores = function(v)
        {
            // Verifica se o novo valor do patrimonioSelecionado é vazio ou não
            // v pode ser vazio e ainda não ser avaliado como vazio, por causa
            // dos valores padrões do objeto. Por isso é utilizado v.produto,
            // para garantir que realmente v, possui um patrimônio.
            if (v.produto) {
                $scope.data.patrimonioSelecionado.depreciacao = mValorSrv.depreciacao(v, v.produto);
                $scope.data.patrimonioSelecionado.valorAtual = $scope.data.patrimonioSelecionado.valor - $scope.data.patrimonioSelecionado.depreciacao;
                $scope.data.patrimonioSelecionado.valorDiferenca = $scope.data.model.valor - $scope.data.patrimonioSelecionado.valorAtual;
            }
        };
    });
