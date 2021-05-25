'use strict'
angular.module('AssembleiasModule').controller('AssembleiaDetalhesCtrl',
    function ($scope, $state, $http, $filter, AssembleiaService, HeaderFactory, AuthService, UtilsService, config) {


        HeaderFactory.setHeader('assembleia', 'Detalhes');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);
    });