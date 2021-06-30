'use strict'
angular.module('DocumentosModule').controller('DocumentosCtrl',
    function ($scope, $state, $http, $filter, HeaderFactory, AuthService, UtilsService, config) {

        HeaderFactory.setHeader('documento', 'Documentos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.category = {};
        $scope.document = {};

        $scope.listDocument = function () {
            var promisse = ($http.get(`${config.apiUrl}api/documentos`));
            promisse.then(function (result) {
                $scope.listDocuments = result.data.data;
                console.log($scope.listDocuments)
                angular.forEach($scope.listDocuments, function(obj) {
                    var tipoFile = obj.nome.split('.')[1];
                    var icon = 'file';
                    switch (tipoFile) {
                        case "jpeg":
                        case "jpg":
                            icon = 'jpeg';
                            break;
                        case "png":
                            icon = 'png';
                            break;
                        case "doc":
                        case "docx":
                            icon = 'word';
                            break;
                        case "xml":
                        case "xls":
                        case "xlsx":
                            icon = 'excel';
                            break;
                        case "pdf":
                            icon = 'pdf';
                            break;
                        case "txt":
                            icon = 'txt'
                            break;
                    }

                    obj.icon = 'img/icons/icon_'+icon+'.png';
                });
            });
        };
        $scope.listDocument();

        $scope.showDocument = function (id) {
            var promisse = ($http.get(`${config.apiUrl}api/documentos/` + id));
            promisse.then(function (result) {
                $scope.document = result.data;
            });
        };

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

        $scope.deleteDocument = async function(id){
            await UtilsService.confirmAlert('Excluir Documento?');
            $http({
                method: 'DELETE',
                url: `${config.apiUrl}api/documentos/`+ id,
                data: $scope.category,
                headers: {
                    'Authorization': 'Bearer '+ AuthService.getToken()
                }
            }).then(function() {
                UtilsService.toastSuccess("Excluído excluída com sucesso!");
                $scope.listDocuments()
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            });
        }

        $scope.openModalCategory = function () {
            $('#modalCategory').modal('show');
        }

        $scope.openModalDocument = function () {
            $('#modalDocument').modal('show');
        }

        $scope.closeModalCategory = function () {
            cleanFieldCategory()
            $('#modalCategory').modal('hide');

        }

        $scope.closeModalDocument = function () {
            $('#modalDocument').modal('hide');

        }

        function cleanFieldCategory()
        {
            $scope.category.nome = ''
        }

        $scope.openDocument = function (idDoc)
        {
            if(idDoc) {
                window.open(config.apiUrl + 'api/documentos/open/' + idDoc, '_blank');
            }
        };

        $scope.changeInputField = function (ele) {
            var file = ele.files[0];
            console.log(file)
            if (ele.files.length > 0) {
                if (file > 41943040) {
                    return UtilsService.openAlert('Tamanho máximo de anexos permitido foi atingido: 40MB');
                }

                $scope.document.documents_rules = URL.createObjectURL(file);
                iconArquivo(ele.files[0]);

                $scope.getbase64(file, ele.name);

            }
        }

        $scope.getbase64 = function (file, el) {
            let f = file;
            let r = new FileReader();

            r.onloadend = function (e) {

                let infoFile = {
                    name:  $scope.arquivoNome,
                    icon: $scope.arquivoIcon,
                    file: e.target.result
                }

                $scope.document[el].push(infoFile);
                $scope.$apply();
            };
            $("#inputDocuments").val('');
            r.readAsDataURL(f);
        }

        function iconArquivo(file) {
            console.log(file)
            var typeFile = file.name.split('.')[1];
            var icon = 'file';
            switch (typeFile) {
                case "jpeg":
                case "jpg":
                    icon = 'jpeg';
                    break;
                case "png":
                    icon = 'png';
                    break;
                case "doc":
                case "docx":
                    icon = 'word';
                    break;
                case "xml":
                case "xls":
                case "xlsx":
                    icon = 'excel';
                    break;
                case "pdf":
                    icon = 'pdf';
                    break;
                case "txt":
                    icon = 'txt'
                    break;
            }
            $scope.arquivoIcon = 'img/icons/icon_'+icon+'.png';
            $scope.arquivoNome = file.name;
        }
    });