'use strict'
angular.module('PatrimonioModule').controller('PatrimonioBensCtrl',
    function ($scope, PatrimonioBensService, PatrimonioHistoricoService, ProdutoService, EmpresaService, UtilsService,
              ConfiguracaoService, DateService, ValorService, HeaderFactory, $state, AuthService)
    {
        HeaderFactory.setHeader('patrimônio', 'Bens');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

        var self = this;

        var mBensSrv = PatrimonioBensService;
        var mHistoricoSrv = PatrimonioHistoricoService;
        var mProdutoSrv = ProdutoService;
        var mEmpresaSrv = EmpresaService;
        var mUtilSrv = UtilsService;
        var mConfigSrv = ConfiguracaoService;
        var mValorSrv = ValorService;

        $scope.mDateSrv = DateService;

        $scope.data = {
            'model': {},
            'historico': {},
            'list': {}
        };

        $scope.$watch('data.produtoSelecionado',
            function(v)
            {
                // Verifica se o novo valor do produtoSelecionado é vazio ou não
                // v pode ser vazio e ainda não ser avaliado como vazio, por causa
                // dos valores padrões do objeto. Por isso é utilizado
                // v.grupo_produto, para garantir que realmente v, possui um
                // produto.
                if (v && v.grupo_produto) {
                    $scope.data.produtoSelecionado.depreciacaoStr = (v.grupo_produto.depreciacao * 100) + '%';
                    $scope.data.produtoSelecionado.depreciacao = mValorSrv.depreciacao($scope.data.model, v);
                    $scope.data.produtoSelecionado.valorAtual = $scope.data.model.valor - $scope.data.produtoSelecionado.depreciacao;
                }
            });

        $scope.init = function()
        {
            mBensSrv.read().then(e => $scope.data.rows = e.data);
            mHistoricoSrv.read().then(e => $scope.data.historico.rows = e.data);
            mProdutoSrv.getAllProduto().then(e => $scope.data.list.produtos = e.data.filter(f => f.produto.tipo === 1 && f.produto.status === 1));
            mEmpresaSrv.getAllEmpresas().then(e => $scope.data.list.fornecedores = e.data);
            mConfigSrv.getAllDepartamentos().then(e => $scope.data.list.departamentos = e.data);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        // TODO: Procurar um jeito de fazer isso no próprio template
        $scope.UltimoHistorico = function(modelId)
        {
            if ($scope.data.historico.rows) {
                var historico = $scope.data.historico.rows.filter(e => e.id_patrimonio === modelId);
                return historico[historico.length - 1];
            }

            return null;
        };

        $scope.newRow = function()
        {
            if (!$scope.accessPagina.inserir) {
                return false;
            }
            // Limpar o objeto model, e deixar a propriedade tipo_lancamento no
            // valor padrão, para inserir novo registro.
            $scope.data.model = {
                'tipo_lancamento':'MANUAL',
                'data_incorporacao':new Date()
            };

            // Limpar o objeto produtoSelecionado para que ao abrir novamente
            // o modal, não venha já selecionado o produto da seleção anterior.
            $scope.data.produtoSelecionado = null;

            self.openModal();
        };

        $scope.editRow = function(e, row)
        {

            e.preventDefault();
            var model = angular.copy(row);

            // Ao editar o formulário é necessário preencher manualmente o
            // produto selecionado, porque o combo de produtos já virá
            // selecionado automaticamente (essa ação também dispara o watch
            // sobre a variável data.produtoSelecionado, mas o produto
            // precisa ser único para cada patrimônio).
            $scope.data.produtoSelecionado = $scope.data.list.produtos.find(e => e.produto.id == row.id_produto).produto;

            model.fim_garantia = $scope.mDateSrv.isoToDateObj(model.fim_garantia);
            model.data_incorporacao = $scope.mDateSrv.isoToDateObj(model.data_incorporacao);
            model.data_compra = $scope.mDateSrv.isoToDateObj(model.data_compra);

            $scope.data.model = model;
            self.openModal();
        };

        $scope.submit = function()
        {
            if ($scope.data.model.id) {
                if (!$scope.accessPagina.editar) {
                    UtilsService.toastError('Você não tem permissão para editar esse item!');
                    return false;
                }
                $scope.update();
            } else {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar!');
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
                return mBensSrv.create(model);
            };

            self.save(srv);
        };

        $scope.update = function(form)
        {
            var srv = function()
            {
                var model = angular.copy($scope.data.model);
                return mBensSrv.update(model, model.id);
            };

            self.save(srv);
        };

        $scope.openModalHistorico = function ()
        {
            $('#historico').modal('show');
        };

        $scope.closeModalHistorico = function ()
        {
            $('#historico').modal('hide');
        };

        $scope.closeModal = function ()
        {
            $('#registro').modal('hide');
        };

        this.openModal = function ()
        {
            $('#registro').modal('show');
        };

        this.save = function (callback)
        {
            $scope.data.model.fim_garantia = $scope.mDateSrv.gmtToISO($scope.data.model.fim_garantia);
            $scope.data.model.data_incorporacao = $scope.mDateSrv.gmtToISO($scope.data.model.data_incorporacao);
            $scope.data.model.data_compra = $scope.mDateSrv.gmtToISO($scope.data.model.data_compra);

            $scope.data.model.id_produto = $scope.data.produtoSelecionado.id;

            callback().then(function(ret)
            {
                mUtilSrv.openSuccessAlert(ret.data);

                // Recarrega todos os dados, para mostrar as alterações.
                $scope.init();

                // Limpa o produto selecionado, para que da proxima vez que
                // entrar no patrimonio, seja executado o watch sobre essa
                // variavel.
                $scope.data.produtoSelecionado = {};

                $scope.closeModal();
            })
                .catch(function(error)
                {
                    if (error.responseJSON) {
                        mUtilSrv.openErrorMsg(error.responseJSON.message);
                    } else {
                        mUtilSrv.openErrorMsg(error.statusText);
                    }
                });
        };
    });