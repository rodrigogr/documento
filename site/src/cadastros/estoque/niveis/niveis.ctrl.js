'use strict'
angular.module('CadastrosModule').controller('NivelCtrl',
	function ($scope, $state, NivelService, UtilsService, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'Níveis');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

		$scope.data = {
			niveis: [],
			niveisCopy: [],
			descricaoSelecionado: "",
			deleteNivel: null,
			nivelSelecionado: {
				descricao: '',
				id: ''
			},
			errors: []
		};

		$scope.pesquisar = function () {
			var item = $scope.data.descricaoSelecionado.toLowerCase();

			if ($scope.data.descricaoSelecionado === "") {
				$scope.data.niveis = $scope.data.niveisCopy;
			} else {
				$scope.data.niveis = $scope.data.niveisCopy.filter(x => x.descricao.toLowerCase().indexOf(item) > -1);
			}
		}

		$scope.$on('$viewContentLoaded', function () {
			$scope.updateList($scope.current_page);
		});

		$scope.closeModal = function () {
			$('#novoNivel').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (nivel) {
			$scope.data.deleteNivel = nivel;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorNivel').modal('hide');
		};

		$scope.deleteNivel = function () {
			NivelService.deleteNivels($scope.data.deleteNivel).then(function (data) {
				if (!data.hasOwnProperty("success")) {
					$scope.updateList($scope.current_page);
					$scope.closeDeleteModal();

				} else {
					$scope.closeDeleteModal();
					alert('Falha ao excluir');
				}
			});
		};

		$scope.updateNivels = function () {
			return NivelService.getAllNivels().then(function (result) {
				if (result.data.length) {
					$scope.data.niveis = result.data;
					$scope.data.niveisCopy = result.data;
				} else {
					$scope.data.niveis = [];
					$scope.data.niveisCopy = [];
				}
			});
		};

		$scope.saveNivel = function () {
			if (!$scope.data.nivelSelecionado.id) {
                if (!$scope.accessPagina.inserir){
                    UtilsService.toastError('Você não tem permissão para cadastrar nível!');
                    return false;
                }
				NivelService.saveNivels($scope.data.nivelSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoNivel').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorNivel').modal('show');
					}

				}, function (result) {
					$scope.data.errors = result;
					$('#errorNivel').modal('show');
				});
			} else {
                if (!$scope.accessPagina.editar){
                    UtilsService.toastError('Você não tem permissão para editar nível!');
                    return false;
                }
				NivelService.editNivels($scope.data.nivelSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoNivel').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorNivel').modal('show');
					}


				}, function (result) {
					$scope.data.errors = result;
					$('#errorNivel').modal('show');
				});
			}
		};

		$scope.editNivel = function (nivel) {
            if (!$scope.accessPagina.editar){
                return false;
            }
			$scope.data.nivelSelecionado.descricao = nivel.descricao;
			$scope.data.nivelSelecionado.id = nivel.id;
			$('#novoNivel').modal('show');
		};

		$scope.createNivel = function () {
			$scope.data.nivelSelecionado.descricao = '';
			$scope.data.nivelSelecionado.id = '';
			$('#novoNivel').modal('show');
		};

		$scope.closeAlert = function () {
			// ngDialog.close('modalAlert');
		};


		$scope.deleteNivel = function () {
            if (!$scope.accessPagina.excluir){
                UtilsService.toastError('Você não tem permissão para excluir nível!');
                return false;
            }
			NivelService.deleteNivels($scope.data.deleteNivel).then(function (data) {
				if (!data.hasOwnProperty("success")) {
					$scope.closeDeleteModal();
					$scope.updateList($scope.current_page);
				} else {
					$scope.data.errors = data.data;
					$('#errorNivel').modal('show');
				}
			});
		};

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/niveis?page=${page}`);
			$scope.data.niveis = result.data.data;
			$scope.data.niveisCopy = result.data.data;
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