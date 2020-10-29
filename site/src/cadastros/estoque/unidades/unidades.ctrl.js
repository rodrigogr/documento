'use strict'
angular.module('CadastrosModule').controller('UnidadeCtrl',
    function ($scope, $state, UnidadeProdutoService, UtilsService, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'Unidades');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.data = {
            unidades: [],
            unidadesCopy: [],
            descricaoSelecionado: '',
            deleteUnidade: null,
            unidadeSelecionado: {
                descricao: '',
                id: ''
            },
            errors: []
        }

        $scope.pesquisar = function () {
            var item = $scope.data.descricaoSelecionado.toLowerCase();
            if ($scope.data.descricaoSelecionado === "") {
                $scope.data.unidades = $scope.data.unidadesCopy;
            } else {
                $scope.data.unidades = $scope.data.unidadesCopy.filter(x => x.descricao.toLowerCase().indexOf(item) > -1);
            }
        }

        $scope.ngOnInit = function () {
            $scope.updateList($scope.current_page);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        $scope.closeModal = function () {
            $('#novoUnidade').modal('hide');
        }

        $scope.closeDeleteModal = function () {
            $('#deleteAlert').modal('hide');
        }

        $scope.showDeleteAlert = function (unidade) {
            $scope.data.deleteUnidade = unidade;
            $('#deleteAlert').modal('show');
            event.stopPropagation();
        }

        $scope.closeModalError = function () {
            $('#errorUnidade').modal('hide');
        }

        $scope.deleteUnidade = function () {
            UnidadeProdutoService.deleteUnidades($scope.data.deleteUnidade).then(function (data) {
                if (!data.errors) {
                    $scope.updateUnidades();
                    $scope.closeDeleteModal();
                } else {
                    $scope.closeDeleteModal();
                    alert('Falha ao excluir');
                }
            });
        }

        $scope.updateUnidades = function () {
            return UnidadeProdutoService.getAllUnidadeProduto().then(function (result) {
                if (result.data.length) {
                    $scope.data.unidades = result.data;
                    $scope.data.unidadesCopy = result.data;
                } else {
                    $scope.data.unidades = [];
                    $scope.data.unidadesCopy = [];
                }
            });
        }

        $scope.saveUnidade = function () {
            if (!$scope.data.unidadeSelecionado.id) {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar unidade!');
                    return false;
                }
                UnidadeProdutoService.saveUnidades($scope.data.unidadeSelecionado).then(function (data) {
                    if (!data.hasOwnProperty("success")) {
                        $scope.updateUnidades();
                        $('#novoUnidade').modal('hide');
                    } else {
                        $scope.data.errors = data.data;
                        $('#errorUnidade').modal('show');
                    }
                }, function (result) {
                    $scope.data.errors = result;
                    $('#errorUnidade').modal('show');
                });
            } else {
                if (!$scope.accessPagina.editar) {
                    UtilsService.toastError('Você não tem permissão para editar unidade!');
                    return false;
                }
                UnidadeProdutoService.editUnidades($scope.data.unidadeSelecionado).then(function (data) {
                    if (!data.hasOwnProperty("success")) {
                        $scope.updateUnidades();
                        $('#novoUnidade').modal('hide');
                    } else {
                        $scope.data.errors = data.data;
                        $('#errorUnidade').modal('show');
                    }
                }, function (result) {
                    $scope.data.errors = result;
                    $('#errorUnidade').modal('show');
                });
            }
        }

        $scope.editUnidade = function (unidade) {
            if (!$scope.accessPagina.editar) {
                return false;
            }
            $scope.data.unidadeSelecionado.descricao = unidade.descricao;
            $scope.data.unidadeSelecionado.id = unidade.id;
            $('#novoUnidade').modal('show');
        }

        $scope.createUnidade = function () {
            $scope.data.unidadeSelecionado.descricao = '';
            $scope.data.unidadeSelecionado.id = '';
            $('#novoUnidade').modal('show');
        }

        $scope.closeAlert = function () {
            // ngDialog.close('modalAlert');
        }


        $scope.deleteUnidade = function () {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir unidade!');
                return false;
            }
            UnidadeProdutoService.deleteUnidades($scope.data.deleteUnidade).then(function (data) {
                if (!data.hasOwnProperty("success")) {
                    $scope.closeDeleteModal();
                    $scope.updateUnidades();
                } else {
                    $scope.data.errors = data.data;
                    $('#errorUnidade').modal('show');
                }
            })
        };

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/unidade_produtos?page=${page}`);

            $scope.data.unidades = result.data.data;
            $scope.data.unidadesCopy = result.data.data;
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