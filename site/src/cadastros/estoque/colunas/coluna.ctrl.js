'use strict'
angular.module('CadastrosModule').controller('ColunaCtrl',
	function ($scope, $state, ColunaService, UtilsService, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'colunas');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

		$scope.data = {
			colunas: [],
			colunasCopy: [],
			descricaoSelecionado: "",
			deleteColuna: null,
			colunaSelecionado: {
				descricao: '',
				id: ''
			},
			errors: []
		};

		$scope.pesquisar = function () {
			var item = $scope.data.descricaoSelecionado.toLowerCase();

			if ($scope.data.descricaoSelecionado === "") {
				$scope.data.colunas = $scope.data.colunasCopy;
			} else {
				$scope.data.colunas = $scope.data.colunasCopy.filter(x => x.descricao.toLowerCase().indexOf(item) > -1);
			}
		}

		$scope.$on('$viewContentLoaded', function () {
			$scope.updateList($scope.current_page);
		});

		$scope.closeModal = function () {
			$('#novoColuna').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (coluna) {
			$scope.data.deleteColuna = coluna;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorColuna').modal('hide');
		};

		$scope.deleteColuna = function () {
			ColunaService.deleteColunas($scope.data.deleteColuna).then(function (data) {
				if (!data.errors) {
					$scope.updateList($scope.current_page);
					$scope.closeDeleteModal();

				} else {
					$scope.closeDeleteModal();
					alert('Falha ao excluir');
				}
			});
		};

		$scope.updateColunas = function () {
			return ColunaService.getAllColunas().then(function (result) {
				if (result.data.length) {
					$scope.data.colunas = result.data;
					$scope.data.colunasCopy = result.data;
				} else {
					$scope.data.colunas = [];
					$scope.data.colunasCopy = [];
				}
			});
		};

		$scope.saveColuna = function () {
			if (!$scope.data.colunaSelecionado.id) {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar coluna!');
                    return false;
                }
				ColunaService.saveColunas($scope.data.colunaSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoColuna').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorColuna').modal('show');
					}

				}, function (result) {
					$scope.data.errors = result;
					$('#errorColuna').modal('show');
				});
			} else {
                if (!$scope.accessPagina.editar) {
                    UtilsService.toastError('Você não tem permissão para editar coluna!');
                    return false;
                }
				ColunaService.editColunas($scope.data.colunaSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoColuna').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorColuna').modal('show');
					}
				}, function (result) {
					$scope.data.errors = result;
					$('#errorColuna').modal('show');
				});
			}
		};

		$scope.editColuna = function (coluna) {
            if (!$scope.accessPagina.editar) {
                return false;
            }
			$scope.data.colunaSelecionado.descricao = coluna.descricao;
			$scope.data.colunaSelecionado.id = coluna.id;
			$('#novoColuna').modal('show');
		};

		$scope.createColuna = function () {
			$scope.data.colunaSelecionado.descricao = '';
			$scope.data.colunaSelecionado.id = '';
			$('#novoColuna').modal('show');
		};

		$scope.closeAlert = function () {
			// ngDialog.close('modalAlert');
		};


		$scope.deleteColuna = function () {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir coluna!');
                return false;
            }
			ColunaService.deleteColunas($scope.data.deleteColuna).then(function (data) {
				if (!data.hasOwnProperty("success")) {
					$scope.closeDeleteModal();
					$scope.updateList($scope.current_page);

				} else {
					$scope.data.errors = data.data;
					$('#errorColuna').modal('show');
				}
			});
		}

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/colunas?page=${page}`);
			$scope.data.colunas = result.data.data;
			$scope.data.colunasCopy = result.data.data;
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