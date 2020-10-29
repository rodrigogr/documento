'use strict'
angular.module('CadastrosModule').controller('ConfiguracaoCondominioCtrl',
    function ($scope, $state, ConfiguracaoService, UtilsService, HeaderFactory, AuthService) {
        HeaderFactory.setHeader('Cadastros', 'configurações de condomínio');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.data = {};
        $scope.ngOnInit = () => {
            ConfiguracaoService.getConfiguracaoCondominio().then(function (result) {
                result.data[0].calculomessubsequente = result.data[0].calculomessubsequente === 1;
                result.data[0].compensarabatimento = result.data[0].compensarabatimento === 1;
                $scope.data.configuracaoCondominio = result.data[0];
            });
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        $scope.saveConfiguracaoCondominio = async (data) => {
            try {
                if ($scope.accessPagina.inserir) {
                    if (data.diavencimento > 31 || data.diavencimento < 1) throw 'selecione um dia entra 1 e 28';
                    await ConfiguracaoService.saveConfiguracaoCondominio(data);
                    UtilsService.toastSuccess("Salvo com sucesso");
                } else {
                    throw 'Você não tem permissão para alterar essa data';
                }
            } catch (e) {
                UtilsService.toastError(e);
            }
        }
    }
);