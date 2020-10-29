'use strict'
angular.module('CadastrosModule').controller('SequenciaCtrl',
	function ($scope, $state, SequenciaService, UtilsService, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'sequências');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

		$scope.$on('$viewContentLoaded', function () {
			$scope.updateList($scope.current_page);
		});

		$scope.data = {
			sequencias: [],
			sequenciasCopy: [],
			descricaoSelecionado: "",
			deleteSequencia: null,
			sequenciaSelecionado: {
				descricao: '',
				id: ''
			},
			errors: []
		};

		$scope.pesquisar = function () {
			var item = $scope.data.descricaoSelecionado.toLowerCase();

			if ($scope.data.descricaoSelecionado === "") {
				$scope.data.sequencias = $scope.data.sequenciasCopy;
			} else {
				$scope.data.sequencias = $scope.data.sequenciasCopy.filter(x => x.descricao.toLowerCase().indexOf(item) > -1);
			}
		}

		$scope.closeModal = function () {
			$('#novoSequencia').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (sequencia) {
			$scope.data.deleteSequencia = sequencia;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorSequencia').modal('hide');
		};

		$scope.deleteSequencia = function () {
			SequenciaService.deleteSequencias($scope.data.deleteSequencia).then(function (data) {
				if (!data.errors) {
					$scope.updateList($scope.current_page);
					$scope.closeDeleteModal();

				} else {
					$scope.closeDeleteModal();
					alert('Falha ao excluir');
				}
			});
		};

		$scope.updateSequencias = function () {
			return SequenciaService.getAllSequencias().then(function (result) {
				if (result.data.length) {
					$scope.data.sequencias = result.data;
					$scope.data.sequenciasCopy = result.data;
				} else {
					$scope.data.sequencias = [];
					$scope.data.sequenciasCopy = [];
				}
			});
		};

		$scope.saveSequencia = function () {
			if (!$scope.data.sequenciaSelecionado.id) {
                if (!$scope.accessPagina.inserir){
                    UtilsService.toastError('Você não tem permissão para cadastrar sequência!');
                    return false;
                }
				SequenciaService.saveSequencias($scope.data.sequenciaSelecionado).then(function (data) {

					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoSequencia').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorSequencia').modal('show');
					}

				}, function (result) {
					$scope.data.errors = result;
					$('#errorSequencia').modal('show');
				});
			} else {
                if (!$scope.accessPagina.editar){
                    UtilsService.toastError('Você não tem permissão para cadastrar editar!');
                    return false;
                }
				SequenciaService.editSequencias($scope.data.sequenciaSelecionado).then(function (data) {

					if (!data.hasOwnProperty("success")) {
						$scope.updateList($scope.current_page);
						$('#novoSequencia').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorSequencia').modal('show');
					}
				}, function (result) {
					$scope.data.errors = result;
					$('#errorSequencia').modal('show');
				});
			}
		};

		$scope.editSequencia = function (sequencia) {
            if (!$scope.accessPagina.editar){
                return false;
            }
			$scope.data.sequenciaSelecionado.descricao = sequencia.descricao;
			$scope.data.sequenciaSelecionado.id = sequencia.id;
			$('#novoSequencia').modal('show');
		};

		$scope.createSequencia = function () {
			$scope.data.sequenciaSelecionado.descricao = '';
			$scope.data.sequenciaSelecionado.id = '';
			$('#novoSequencia').modal('show');
		};

		$scope.closeAlert = function () {
			// ngDialog.close('modalAlert');
		};


		$scope.deleteSequencia = function () {
            if (!$scope.accessPagina.excluir){
                UtilsService.toastError('Você não tem permissão para excluir editar!');
                return false;
            }
			SequenciaService.deleteSequencias($scope.data.deleteSequencia).then(function (data) {
				if (!data.hasOwnProperty("success")) {
					$scope.closeDeleteModal();
					$scope.updateList($scope.current_page);
				} else {
					$scope.data.errors = data.data;
					$('#errorSequencia').modal('show');
				}
			});
		}

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/sequencias?page=${page}`);
			$scope.data.sequencias = result.data.data;
			$scope.data.sequenciasCopy = result.data.data;
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