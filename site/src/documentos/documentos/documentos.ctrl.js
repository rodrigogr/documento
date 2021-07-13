'use strict'
angular.module('DocumentosModule').controller('DocumentosCtrl',
    function ($scope, $state, $http, $filter, HeaderFactory, AuthService, UtilsService, config) {

        HeaderFactory.setHeader('documento', 'Documentos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.category = {};
        $scope.documents = [];
        $scope.document = {};

        $scope.listDocument = function () {
            var promisse = ($http.get(`${config.apiUrl}api/documentos`));
            promisse.then(function (result) {
                $scope.listDocuments = result.data.data;
                angular.forEach($scope.listDocuments, function(obj) {
                    var tipoFile = obj.documento_nome.split('.')[1];
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
                $scope.documents = result.data;
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

        $scope.saveDocument = async function () {
            await UtilsService.confirmAlert('Publicar documento(s)?');
            $http({
                method: "POST",
                url: `${config.apiUrl}api/documentos`,
                data: $scope.documents,
                headers: {
                    'Authorization': 'Bearer ' + AuthService.getToken()
                }
            })
                .then(function (response) {
                    UtilsService.toastSuccess("Documento(s) publicado(s) com sucesso!");
                }, function (error) {
                    UtilsService.openAlert(error.data.message);
                }).finally(() => {
                    $scope.document = {};
                    $scope.listDocument()
                    $scope.closeModalDocument()
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
                data: $scope.document,
                headers: {
                    'Authorization': 'Bearer '+ AuthService.getToken()
                }
            }).then(function() {
                UtilsService.toastSuccess("Documento Excluído excluído com sucesso!");
                $scope.listDocument()
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            });
        }

        $scope.openModalCategory = function () {
            $scope.category.nome = ''
            $('#modalCategory').modal('show');
        }

        $scope.openModalDocument = function () {
            $scope.documents = [];
            $('#modalDocument').modal('show');
        }

        $scope.closeModalCategory = function () {
            $scope.category.nome = ''
            $('#modalCategory').modal('hide');

        }

        $scope.closeModalDocument = function () {
            $scope.documents = [];
            $('#modalDocument').modal('hide');
        }

        $scope.openDocument = function () {
            let file = $scope.documents.documents_rules ? $scope.documents.documents_rules : $scope.documents;
            window.open(file, '_blank');
        };

        $scope.deleteFile = function (file, index) {
            $scope.documents.splice(index, 1);
        };

        $scope.changeInputField = function (ele) {
            var file = ele.files[0];
            if (ele.files.length > 0) {
                if (file > 41943040) {
                    return UtilsService.openAlert('Tamanho máximo de anexos permitido foi atingido: 40MB');
                }
                $scope.documents.documents_rules = URL.createObjectURL(file);
                iconArquivo(ele.files[0]);

                $scope.getbase64(file);
            }
        }

        $scope.getbase64 = function (file) {
            let r = new FileReader();

            r.onloadend = function (e) {
                $scope.documents.push(
                    {
                        "nome": '',
                        "categoria": '',
                        "url_documento": $scope.documents.documents_rules,
                        "nome_original_documento": file.name,
                        "icon": $scope.fileIcon,
                    }
                )
                $scope.$apply();
            };
            $("#inputDocuments").val('');
            r.readAsDataURL(file);
        }

        function iconArquivo(file) {
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
            $scope.fileIcon = 'img/icons/icon_'+icon+'.png';
            $scope.fileName = file.name;
        }

        $scope.cleanDocuments = async function (){
            await UtilsService.confirmAlert('Excluir anexos?');
            $scope.documents = [];
            UtilsService.toastSuccess("Anexos excluídos com sucesso!");
        }
    });