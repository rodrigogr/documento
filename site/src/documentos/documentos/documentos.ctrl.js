'use strict'
angular.module('DocumentosModule').controller('DocumentosCtrl',
    function ($scope, $state, $http, $filter, HeaderFactory, AuthService, UtilsService, config) {

        HeaderFactory.setHeader('documento', 'Documentos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.category = {};

        $scope.listDocument = function () {
            var promisse = ($http.get(`${config.apiUrl}api/documentos`));
            promisse.then(function (result) {
                $scope.listDocuments = result.data.data;
            });
        };
        $scope.listDocument();

        $scope.listCategory = function () {
            var promisse = ($http.get(`${config.apiUrl}api/categorias`));
            promisse.then(function (result) {
                $scope.listCategories = result.data.data;
            });
        };
        $scope.listCategory();

        $scope.saveCategory = async function () {
            await UtilsService.confirmAlert('Adicionar nova Categoria?');
            $http({
                method: "POST",
                url: `${config.apiUrl}api/categorias`,
                data: $scope.category,
                headers: {
                    'Authorization': 'Bearer ' + AuthService.getToken()
                }
            })
                .then(function (response) {
                    UtilsService.toastSuccess("Categoria adicionada com sucesso!");
                }, function (error) {
                    UtilsService.openAlert(error.data.message);
                }).finally( ()=> {
                    $scope.category.nome = ''
                    $scope.listCategory()
                });
        };

        $scope.deleteCategory = async function(id){
            await UtilsService.confirmAlert('Excluir Categoria?');
            $http({
                method: 'DELETE',
                url: `${config.apiUrl}api/categorias/`+ id,
                data: $scope.category,
                headers: {
                    'Authorization': 'Bearer '+ AuthService.getToken()
                }
            }).then(function() {
                UtilsService.toastSuccess("Categoria excluída com sucesso!");
                $scope.listCategory()
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            });
        }

        $scope.openCategory = function () {
            $('#openCategory').modal('show');
        }

        $scope.closeCategory = function () {
            cleanFieldCategory()
            $('#openCategory').modal('hide');

        }

        function cleanFieldCategory()
        {
            $scope.category.nome = ''
        }
    });