'use strict'
angular.module('CadastrosModule').controller('RuaCtrl',
	function ($scope, $state, RuaService, UtilsService, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'Ruas');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

		$scope.data = {
			ruas: [],
			ruasCopy: [],
			descricaoSelecionado: "",
			deleteRua: null,
			ruaSelecionado: {
				descricao: '',
				id: ''
			},
			errors: []
		};

		$scope.pesquisar = function () {
			var item = $scope.data.descricaoSelecionado.toLowerCase();
			if ($scope.data.descricaoSelecionado === "") {
				$scope.data.ruas = $scope.data.ruasCopy;
			} else {
				$scope.data.ruas = $scope.data.ruasCopy.filter(x => x.descricao.toLowerCase().indexOf(item) > -1);
			}
		};

		$scope.$on('$viewContentLoaded', function () {
			$scope.updateList($scope.current_page);
		});

		$scope.closeModal = function () {
			$('#novoRua').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (rua) {
			$scope.data.deleteRua = rua;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorRua').modal('hide');
		};

		$scope.deleteRua = function () {
			RuaService.deleteRuas($scope.data.deleteRua).then(function (data) {
				if (!data.errors) {
					$scope.updateList($scope.current_page);
					$scope.closeDeleteModal();

				} else {
					$scope.closeDeleteModal();
					alert('Falha ao excluir');
				}
			});
		};

		$scope.updateRuas = function () {
			return RuaService.getAllRuas().then(function (result) {
				if (result.data.length) {
					$scope.data.ruas = result.data;
					$scope.data.ruasCopy = result.data;
				} else {
					$scope.data.ruas = [];
					$scope.data.ruasCopy = [];
				}
			});
		};

		$scope.saveRua = function () {
			if (!$scope.data.ruaSelecionado.id) {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar rua!');
                    return false;
                }
				RuaService.saveRuas($scope.data.ruaSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoRua').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorRua').modal('show');
					}


				}, function (result) {
					$scope.data.errors = result;
					$('#errorRua').modal('show');
				});
			} else {
                if (!$scope.accessPagina.editar) {
                    UtilsService.toastError('Você não tem permissão para cadastrar rua!');
                    return false;
                }
				RuaService.editRuas($scope.data.ruaSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoRua').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorRua').modal('show');
					}
				}, function (result) {
					$scope.data.errors = result;
					$('#errorRua').modal('show');
				});
			}
		};

		$scope.editRua = function (rua) {
            if (!$scope.accessPagina.editar) {
                return false;
            }
			$scope.data.ruaSelecionado.descricao = rua.descricao;
			$scope.data.ruaSelecionado.id = rua.id;
			$('#novoRua').modal('show');
		};

		$scope.createRua = function () {
			$scope.data.ruaSelecionado.descricao = '';
			$scope.data.ruaSelecionado.id = '';
			$('#novoRua').modal('show');
		};

		$scope.closeAlert = function () {
			// ngDialog.close('modalAlert');
		};

		$scope.deleteRua = function () {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir rua!');
                return false;
            }
			RuaService.deleteRuas($scope.data.deleteRua).then(function (data) {
				if (!data.hasOwnProperty("success")) {
					$scope.closeDeleteModal();
					$scope.updateList($scope.current_page);
				} else {
					$scope.data.errors = data.data;
					$('#errorRua').modal('show');
				}
			});
		}

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/ruas?page=${page}`);
			$scope.data.ruas = result.data.data;
			$scope.data.ruasCopy = result.data.data;
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