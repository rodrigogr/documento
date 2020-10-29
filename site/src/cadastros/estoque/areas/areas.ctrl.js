'use strict'
angular.module('CadastrosModule').controller('AreaCtrl',
    function ($scope, $state, AreaService, UtilsService, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'Áreas');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

        $scope.data = {
            areas: [],
            areasCopy: [],
            descricaoSelecionado: '',
            deleteArea: null,
            areaSelecionado: {
                descricao: '',
                id: ''
            },
            errors: []
        };


        $scope.$on('$viewContentLoaded', function () {
            $scope.updateList($scope.current_page);
        })

        $scope.closeModal = function () {
            $('#novoArea').modal('hide');
        }

        $scope.closeDeleteModal = function () {
            $('#deleteAlert').modal('hide');
        }

        $scope.showDeleteAlert = function (area) {
            $scope.data.deleteArea = area;
            $('#deleteAlert').modal('show');
            event.stopPropagation();
        }

        $scope.closeModalError = function () {
            $('#errorArea').modal('hide');
        }

        $scope.pesquisar = function () {
            var item = $scope.data.descricaoSelecionado.toLowerCase();

            if ($scope.data.descricaoSelecionado === "") {
                $scope.data.areas = $scope.data.areasCopy;
            } else {
                $scope.data.areas = $scope.data.areasCopy.filter(x => x.descricao.toLowerCase().indexOf(item) > -1);
            }
        }

        $scope.deleteArea = function () {
            AreaService.deleteAreass($scope.data.deleteArea).then(function (data) {
                if (data.success) {
                    $scope.updateList($scope.current_page);
                    $scope.closeDeleteModal();

                } else {
                    $scope.data.errors = data.data;
                    $('#errorArea').modal('show');
                }
            });
        }

        $scope.updateAreas = function () {
            return AreaService.getAllAreas().then(function (result) {
                if (result.data.length) {
                    $scope.data.areas = result.data;
                    $scope.data.areasCopy = result.data;
                } else {
                    $scope.data.areas = [];
                    $scope.data.areasCopy = [];
                }
            });
        }

        $scope.saveArea = function () {
            if (!$scope.data.areaSelecionado.id) {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar área!');
                    return false;
                }
                AreaService.saveAreas($scope.data.areaSelecionado).then(function (data) {
                    if (!data.hasOwnProperty("success")) {
                        $scope.updateList($scope.current_page);
                        $('#novoArea').modal('hide');
                    } else {
                        $scope.data.errors = data.data;
                        $('#errorArea').modal('show');
                    }
                }, function (result) {
                    $scope.data.errors = result;
                    $('#errorArea').modal('show');
                });
            } else {
                if (!$scope.accessPagina.editar) {
                    UtilsService.toastError('Você não tem permissão para editar área!');
                    return false;
                }
                AreaService.editAreas($scope.data.areaSelecionado).then(function (data) {
                    if (!data.hasOwnProperty("success")) {
                        $scope.updateList($scope.current_page);
                        $('#novoArea').modal('hide');
                    } else {
                        $scope.data.errors = data.data;
                        $('#errorArea').modal('show');
                    }
                }, function (result) {
                    $scope.data.errors = result;
                    $('#errorArea').modal('show');
                });
            }
        }

        $scope.editArea = function (area) {
            $scope.data.areaSelecionado.descricao = area.descricao;
            $scope.data.areaSelecionado.id = area.id;
            $('#novoArea').modal('show');
        }

        $scope.createArea = function () {
            $scope.data.areaSelecionado.descricao = '';
            $scope.data.areaSelecionado.id = '';
            $('#novoArea').modal('show');
        }

        $scope.closeAlert = function () {
            // ngDialog.close('modalAlert');
        }

        $scope.deleteArea = function () {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir unidade!');
                return false;
            }
            AreaService.deleteAreas($scope.data.deleteArea).then(function (data) {
                if (!data.hasOwnProperty("success")) {
                    $scope.closeDeleteModal();
                    $scope.updateList($scope.current_page);
                } else {
                    $scope.data.errors = data.data;
                    $('#errorArea').modal('show');
                }
            });
        }

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/areas?page=${page}`);
            $scope.data.areas = result.data.data;
            $scope.data.areasCopy = result.data.data;
            // $scope.Itens = result.data.data;
            $scope.current_page = result.data.current_page;
            $scope.total = result.data.total;
            $scope.per_page = result.data.per_page;
            $scope.pageCount = Math.ceil(result.data.total / result.data.per_page);
            let pageCount = $scope.pageCount;
            if (pageCount >= 6) {
                if (page > 3 && page < pageCount - 2)
                    $scope.pages = [page - 2, page - 1, page, page + 1, page + 2];
                else if (page == pageCount - 1)
                    $scope.pages = [page - 4, page - 3, page - 2, page - 1, page];
                else if (page <= 3)
                    $scope.pages = [1, 2, 3, 4, 5];
            } else {
                $scope.pages = [];
                for (let i = 1; i <= pageCount; i++) {
                    $scope.pages.push(i);
                }
            }
            $scope.$digest();
        }
    }
)