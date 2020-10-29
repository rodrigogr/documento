'use strict'
angular.module('CadastrosModule').controller('ConfiguracaoReceitaCtrl',
    function ($scope, $state, ConfiguracaoService, UtilsService, BancoService, LancamentoService, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'configurações de receita');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.ngOnInit = () => {
            LancamentoService.getAllTipoLancamentos()
                .then(result => $scope.data.planoContas = result.data);
            ConfiguracaoService.getAllTipoInadiplencia()
                .then(result => $scope.data.tipoInadimplencias = result.data);
            BancoService.getAllCarteirasDisponiveis()
                .then(result => $scope.data.carteirasDisponiveis = result.data);
            ConfiguracaoService.getConfiguracaoReceita().then(function (result) {
                result.data[0].incidircorrecao = result.data[0].incidircorrecao === 1;
                result.data[0].visualizarinstrucao = result.data[0].visualizarinstrucao === 1;
                result.data[0].anexarprestacaodecontas = result.data[0].anexarprestacaodecontas === 1;
                result.data[0].versoboleto = result.data[0].versoboleto === 1;
                $scope.data.configuracaoReceita = result.data[0];
            });
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        $scope.data = {
            deleteGrupoCalculo: null
        };

        $scope.saveConfiguracaoReceita = function () {
            if (!$scope.data.configuracaoReceita.id_tipolancamentojuridico) {
                UtilsService.toastError("Necessário informar o lançamento jurídico.");
            }

            if (!$scope.data.configuracaoReceita.tempoinadimplencia) {
                throw UtilsService.toastError("Tempo de inadimplência tem que ser maior que 0.");
            }
            ConfiguracaoService.saveConfiguracaoReceita($scope.data.configuracaoReceita).then(function () {
                UtilsService.toastSuccess("Configurações salva com sucesso");
            });
        };

        $scope.getQtdCaracteresInstrucaoSacado = function () {
            if (!$scope.data.configuracaoReceita) return;
            return 690 - $scope.data.configuracaoReceita.instrucaosacado.length;
        };
    }
);