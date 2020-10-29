'use strict'
angular.module('CadastrosModule').controller('GrupoCtrl',
	function ($scope, $state, GrupoProdutoService, UtilsService, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'Grupo de produtos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

		$scope.data = {
			grupos: [],
			gruposCopy: [],
			descricaoSelecionado: '',
			deleteGrupo: null,
			grupoSelecionado: {
				descricao: '',
				id: '',
				status: '1'
			},
			status: [{
					id: '0',
					descricao: 'Inativo'
				},
				{
					id: '1',
					descricao: 'Ativo'
				}
			],
			errors: []
		};

		$scope.pesquisar = function () {
			var item = $scope.data.descricaoSelecionado.toLowerCase();
			if ($scope.data.descricaoSelecionado === "") {
				$scope.data.grupos = $scope.data.gruposCopy;
			} else {
				$scope.data.grupos = $scope.data.gruposCopy.filter(x => x.descricao.toLowerCase().indexOf(item) > -1);
			}
		};

		$scope.$on('$viewContentLoaded', function () {
			$scope.updateGrupos();
		});

		$scope.closeModal = function () {
			$('#novoGrupo').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (grupo) {
			$scope.data.deleteGrupo = grupo;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorGrupo').modal('hide');
		};

		$scope.deleteGrupo = function () {
		    if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir grupos!');
                return false;
            }
			GrupoProdutoService.deleteGrupos($scope.data.deleteGrupo).then(function (data) {
				if (!data.errors) {
					$scope.updateGrupos();
					$scope.closeDeleteModal();

				} else {
					$scope.closeDeleteModal();
					alert('Falha ao excluir');
				}
			});
		};

		$scope.updateGrupos = function () {
			return GrupoProdutoService.getAllGrupoProduto().then(function (result) {
				if (result.data.length) {
					$scope.data.grupos = result.data;
					$scope.data.gruposCopy = result.data;
				} else {
					$scope.data.grupos = [];
					$scope.data.gruposCopy = [];
				}
			});
		};

		$scope.saveGrupo = function () {
			if (!$scope.data.grupoSelecionado.id) {
			    if (!$scope.accessPagina.inserir){
			        UtilsService.toastError('Você não tem permissão para cadastrar grupos!');
			        return false;
			    }
				GrupoProdutoService.saveGrupos($scope.data.grupoSelecionado).then(function (data) {

					if (!data.hasOwnProperty("success")) {
						$scope.updateGrupos();
						UtilsService.toastSuccess('Grupo cadastrado!');
						$('#novoGrupo').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorGrupo').modal('show');
					}

				}, function (result) {
					$scope.data.errors = result;
					$('#errorGrupo').modal('show');
				});
			} else {
                if (!$scope.accessPagina.editar){
                    UtilsService.toastError('Você não tem permissão para editar grupos!');
                    return false;
                }
				GrupoProdutoService.editGrupos($scope.data.grupoSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
						$scope.updateGrupos();
                        UtilsService.toastSuccess('Grupo editado!');
						$('#novoGrupo').modal('hide');
					} else {
						$scope.data.errors = data.data;
						$('#errorGrupo').modal('show');
					}


				}, function (result) {
					$scope.data.errors = result;
					$('#errorGrupo').modal('show');
				});
			}
		};

		$scope.editGrupo = function (grupo) {
			$scope.data.grupoSelecionado.descricao = grupo.descricao;
			$scope.data.grupoSelecionado.id = grupo.id;
			$scope.data.grupoSelecionado.depreciacao = parseFloat(grupo.depreciacao);
			$scope.data.grupoSelecionado.status = grupo.status.toString();

			$('#novoGrupo').modal('show');
		};

		$scope.createGrupo = function () {
			$scope.data.grupoSelecionado.descricao = '';
			$scope.data.grupoSelecionado.id = '';
			$scope.data.grupoSelecionado.depreciacao = '';
			$scope.data.grupoSelecionado.status = '1';
			$('#novoGrupo').modal('show');
		};

		$scope.closeAlert = function () {
			// ngDialog.close('modalAlert');
		};


		$scope.deleteGrupo = function () {
			GrupoProdutoService.deleteGrupos($scope.data.deleteGrupo).then(function (data) {
				if (!data.hasOwnProperty("success")) {
					$scope.closeDeleteModal();
					$scope.updateGrupos();

				} else {
					$scope.data.errors = data.data;
					$('#errorGrupo').modal('show');
				}
			});
		}
	}
)