'use strict'
angular.module('CadastrosModule').controller('GrupoLancamentoCtrl',
    function ($scope, $state, LancamentoService, UtilsService, HeaderFactory, $http, config,AuthService) {

        HeaderFactory.setHeader('CADASTROS', 'GRUPO DE CONTA');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.ngOnInit = function () {
            $scope.updateList($scope.current_page)
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data)
            // LancamentoService.getAllGrupoLancamentos().then(function (result) {
            // 	$scope.data.grupoLancamentos = result.data;
            // });
        };

        $scope.data = {
            deleteGrupoLancamento: null,
            grupoLancamentoSelecionado: {
                descricao: '',
                id: ''
            }
        };

        $scope.closeModal = function () {
            $('#novoGrupo').modal('hide');
        };

        $scope.closeDeleteModal = function () {
            $('#deleteAlert').modal('hide');
        };

        $scope.showDeleteAlert = function (grupoLancamento) {
            $scope.data.deleteGrupoLancamento = grupoLancamento;
            $('#deleteAlert').modal('show');
            event.stopPropagation();
        };

		$scope.deleteGrupoLancamento = function () {
			LancamentoService.deleteGrupoLancamentos($scope.data.deleteGrupoLancamento).then(function (result) {
				if (!result.errors) {
					$scope.updateGrupoLancamentos();
					$scope.closeDeleteModal();
                    UtilsService.toastSuccess(result.data);
				} else {
					$scope.closeDeleteModal();
                    UtilsService.toastError('Falha ao excluir');
				}
			}).catch(function (error) {
				$scope.closeDeleteModal();
				UtilsService.toastError(error.responseJSON.message);
			});
		};

        $scope.updateGrupoLancamentos = function () {
            return LancamentoService.getAllGrupoLancamentos().then(function (result) {
                $scope.data.grupoLancamentos = result.data;
            });
        };

		$scope.saveGrupoLancamento = function () {
			if (!$scope.data.grupoLancamentoSelecionado.id) {
				LancamentoService.saveGrupoLancamentos($scope.data.grupoLancamentoSelecionado).then(function (result) {
					$scope.updateGrupoLancamentos();
					UtilsService.toastSuccess(result.data);
					$('#novoGrupo').modal('hide');
				}).catch(function (error) {
					console.log(error);
                    UtilsService.toastError(error.responseJSON.message.descricao);
				});
			} else {
				LancamentoService.editGrupoLancamentos($scope.data.grupoLancamentoSelecionado).then(function (result) {
					$scope.updateGrupoLancamentos();
                    UtilsService.toastSuccess(result.data);
					$('#novoGrupo').modal('hide')
				}).catch(function (error) {
                    console.log(error);
                    UtilsService.toastError(error.responseJSON.message.descricao);
                });
			}
		};

        $scope.editGrupoLancamento = function (grupoLancamento) {
            if ($scope.accessPagina.editar) {
                $scope.data.grupoLancamentoSelecionado.descricao = grupoLancamento.descricao;
                $scope.data.grupoLancamentoSelecionado.id = grupoLancamento.id;
                $('#novoGrupo').modal('show');
            }
        };

        $scope.createGrupoLancamento = function () {
            $scope.data.grupoLancamentoSelecionado.descricao = '';
            $scope.data.grupoLancamentoSelecionado.id = '';
            $('#novoGrupo').modal('show');
        };

        $scope.goToTipoLancamento = function () {
            $state.go('CadTipoLanc');
        };

        $scope.closeAlert = function () {
        };

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/grupo_lancamentos?page=${page}`);
            $scope.data.grupoLancamentos = result.data.data;
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