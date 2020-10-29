/**
 * Created by rafael on 07/12/2017.
 */
'use strict'
angular.module('appDirectives').directive("header", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/header/header.html',
        controller: headerCtrl
    }
});

function headerCtrl ($scope, $state, $filter, LoginService, UtilsService, config, AuthService) {

    $scope.modulo = sessionStorage.getItem("modulo");
    $scope.tela = sessionStorage.getItem("tela");
    let localSessions = JSON.parse(localStorage.getItem("bioacs-uid"));
    $scope.nome = localSessions.nome;
    let user = JSON.parse(localStorage.getItem("bioacs-uid"));

    AuthService.boxAppHeader(user).then(function (result) {
        let res = result.data;
        angular.forEach(res, function(obj) {
            if (obj.nome === 'portaria')
                obj.icon = 'flux';
            if (obj.nome === 'acesso_portal')
                obj.icon = 'tablet';
            if (obj.nome === 'sistema')
                obj.icon = 'system';
            if (obj.nome === 'admin')
                obj.icon = 'insert';
        });
        $scope.boxApp = res;
    });

    $scope.offLogin = function () {
        localStorage.clear();
        sessionStorage.clear();
        $state.go('login');
    };

    $scope.acesso = function () {

        LoginService.acessoLoginApps().then(function (result) {
            window.open(config.portariaUrl+'login/externo/'+result.data, '_self');
        }).catch(function (error) {
            UtilsService.toastError('Falha ao abrir o aplicativo!<br>('+(error.responseJSON.message || error.statusText )+')');
        }).finally( function() {

        });
    }
}