'use strict'
angular.module('DocumentosModule').controller('DocumentosCtrl',
    function ($scope, $state, $http, $filter, HeaderFactory, AuthService, UtilsService, config) {

        HeaderFactory.setHeader('documento', 'Documentos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);


    });