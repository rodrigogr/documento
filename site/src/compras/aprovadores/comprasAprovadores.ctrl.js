'use strict'
angular.module('ComprasModule').controller('AprovadorCtrl',
	function ($scope, AprovadorService, UsuarioService, $http, config, UtilsService, HeaderFactory, $state, AuthService) {

        HeaderFactory.setHeader('compras', 'aprovadores');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
		$scope.ngOnInit = () => {
			UsuarioService.getAllUsuarios()
				.then(result => $scope.data.usuarios = result.data);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
            $scope.updateList($scope.current_page);
		};
		$scope.data = {
			aprovadors: [],
			aprovadorsCopy: [],
			descricaoSelecionado: '',
			deleteAprovador: null,
            modulo_tipo: [
                {cod: 'ComprasSolicitacoes',nome: 'Solicitações'},
                {cod: 'ComprasPedido',nome: 'Pedidos'},
                {cod: 'ComprasPainel',nome: 'Painel de Aprovações'},
                {cod: 'ComprasProvisionar',nome: 'Provisionar Compras'}
            ],
			aprovadorSelecionado: {
				idusuario: '',
				email: '',
				tipo: '',
				id: ''
			},
			errors: []
		};
		$scope.pesquisar = function () {
			var item = $scope.data.descricaoSelecionado.toLowerCase();

			if ($scope.data.descricaoSelecionado.length <=1) {
				$scope.data.aprovadors = $scope.data.aprovadorsCopy;
			} else {
				$scope.data.aprovadors = $scope.data.aprovadorsCopy.filter(x => x.usuario.login.toLowerCase().indexOf(item) > -1);
			}
		};

		$scope.closeModal = function () {
			$('#novoAprovador').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (aprovador) {
			$scope.data.deleteAprovador = aprovador;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorAprovador').modal('hide');
		};

		$scope.deleteAprovador = function () {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir os aprovadores!');
                return false;
            }
			AprovadorService.deleteAprovadores($scope.data.deleteAprovador).then(function (data) {
				if (!data.errors) {
                    $scope.updateList($scope.current_page);
					$scope.closeDeleteModal();

				} else {
					$scope.closeDeleteModal();
					alert('Falha ao excluir');
				}
			});
		};

		$scope.saveAprovador = function () {
			// if (!$scope.data.aprovadorSelecionado.id) {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para cadastrar aprovadores!');
                    return false;
                }
				AprovadorService.saveAprovadores($scope.data.aprovadorSelecionado).then(function (data) {
					if (!data.hasOwnProperty("success")) {
                        $scope.updateList($scope.current_page);
						$('#novoAprovador').modal('hide');
					} else {
						$scope.data.errors = data.data;
                        UtilsService.toastError(data.data);
					}
				}, function (result) {
					if (!result.hasOwnProperty("success")) {
						$scope.data.errors = result;

					} else {
						$scope.data.errors = result.data;
					}

					$('#errorAprovador').modal('show');
				});
			/*} else {
                if (!$scope.accessPagina.editar) {
                    UtilsService.toastError('Você não tem permissão para editar os aprovadores!');
                    return false;
                }
				AprovadorService.editAprovadores($scope.data.aprovadorSelecionado).then(function (data) {


					if (!data.hasOwnProperty("success")) {
                        $scope.updateList($scope.current_page);
						$('#novoAprovador').modal('hide');
					} else {
						UtilsService.toastError(data.data);
					}

				}, function (result) {
					if (!result.hasOwnProperty("success")) {
						$scope.data.errors = result;
					} else {
						$scope.data.errors = result.data;
					}
					$('#errorAprovador').modal('show');
				});
			}*/
		};

		$scope.editAprovador = function (aprovador) {
			if (!$scope.accessPagina.editar) {
			    UtilsService.toastError('Você não tem permissão para alterar nesse painel.');
				return false;
			}

			$scope.data.aprovadorSelecionado = {};
            $scope.data.aprovadorSelecionado.id = aprovador.id;
            $scope.data.aprovadorSelecionado.email = aprovador.email;
			$scope.data.aprovadorSelecionado.idusuario = aprovador.idusuario.toString();
            $scope.data.aprovadorSelecionado.modulo_desc = $scope.data.modulo_tipo;
            let modulo = aprovador.tipo.split(', ');
            $scope.data.aprovadorSelecionado.modulo = {
                ComprasSolicitacoes: modulo.some(function (x) {
                    return (x === 'Solicitações');
                }),
                ComprasPedido: modulo.some(function (x) {
                    return (x === 'Pedidos');
                }),
                ComprasPainel: modulo.some(function (x) {
                    return (x === 'Painel de Aprovações');
                }),
                ComprasProvisionar: modulo.some(function (x) {
                    return (x === 'Provisionar Compras');
                }),
            };
			$('#novoAprovador').modal('show');
		};

		$scope.createAprovador = function () {
			$scope.data.aprovadorSelecionado = {};
            $scope.data.aprovadorSelecionado.id = '';
            $scope.data.aprovadorSelecionado.email = '';
			$scope.data.aprovadorSelecionado.idusuario = '';
			$scope.data.aprovadorSelecionado.modulo = {
                    ComprasSolicitacoes: false,
                    ComprasPedido: false,
                    ComprasPainel: false,
                    ComprasProvisionar: false
                };
			$scope.data.aprovadorSelecionado.modulo_desc = $scope.data.modulo_tipo;
			$('#novoAprovador').modal('show');
		};

		$scope.closeAlert = function () {
			// ngDialog.close('modalAlert');
		};


		$scope.deleteAprovador = function () {
			AprovadorService.deleteAprovadores($scope.data.deleteAprovador).then(function () {
				$scope.closeDeleteModal();
                $scope.updateList($scope.current_page);
			});
		};

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/aprovadores?page=${page}`);
			$scope.data.aprovadors = result.data.data;
			$scope.data.aprovadorsCopy = result.data.data;
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
);