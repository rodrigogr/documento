'use strict'
angular.module('DocumentosModule').controller('DocumentosCtrl',
    function ($scope, $state, $http, $filter, HeaderFactory, AuthService, UtilsService, config) {

        HeaderFactory.setHeader('documento', 'Documentos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.listDocument = function () {
            var promisse = ($http.get(`${config.apiUrl}api/documentos`));
            promisse.then(function (result) {
                $scope.listDocuments = result.data.data;
            });
        };
        $scope.listDocument();

    });