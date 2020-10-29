/**
 * Created by rafael on 04/12/17.
 * Update Rafael on 10/01/2018
 */
'use strict'
angular.module('AppModule').controller('LoginCtrl',
    function ($scope, $state, LoginService, UtilsService, CryptoService) {
        $scope.credenciais = {
            login: '',
            password: ''
        };

        LoginService.getCondominio().then(result => $scope.condominio = result.data.nome_fantasia);

        $scope.onLogin = async () => {
            try {
                $('.loader').show();
                $scope.credenciais.password = CryptoService.sha1($scope.credenciais.password);
                await LoginService.logIn($scope.credenciais).then( result => {
                    localStorage.setItem('bioacs-crtk', result.data.token);
                    localStorage.setItem('bioacs-uid', JSON.stringify(result.data.usr));
                    $state.go('index');
                });
            } catch (e) {
                if (e.responseJSON.message.login) {
                    UtilsService.toastError(e.responseJSON.message.login[0]);
                } else if (e.responseJSON.message.pwd) {
                    UtilsService.toastError(e.responseJSON.message.pwd[0]);
                } else {
                    UtilsService.toastError(e.responseJSON.message);
                }
            } finally {
                $('.loader').hide();
            }
        };

        $scope.clearLogin = (campo) => {
            $("#"+campo).val('');
        }
    }
);