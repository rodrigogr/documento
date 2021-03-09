'use strict'
angular.module('AssembleiasModule').controller('ResumoAssembleiasCtrl',
    function ($scope, $state, $http, HeaderFactory, AuthService, UtilsService, config) {

        HeaderFactory.setHeader('assembleias', 'Resumo');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

        
    });