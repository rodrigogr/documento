'use strict'
angular.module('CadastrosModule').controller('TipoLancamentoCtrl',
    function ($scope, $state, LancamentoService, UtilsService, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'Plano de conta');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
		$scope.ngOnInit = async() => {
			try {
				$('.loader').show();
				await Promise.all([
					LancamentoService.getAllGrupoLancamentos()
					.then(result => $scope.data.grupoLancamentos = result),
                    AuthService.aclPaginaService($state.$current.name, user.id)
                        .then(result => $scope.accessPagina = result.data),
					$scope.updateList(1)
				]);
			} catch (e) {
                UtilsService.toastError(e.data.error);
			} finally {
				$('.loader').hide();
			}
		}

		$scope.data = {
			tipoLancamentoSelecionado: {
				fluxo: 'RECEITA'
			}
		}

		$scope.closeModal = function () {
			$('#novoLancamento').modal('hide');
		}

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		}

		$scope.showDeleteAlert = function (tipoLancamento) {
			$scope.data.deleteTipoLancamento = tipoLancamento;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		}

		$scope.deleteTipoLancamento = function () {
			LancamentoService.deleteTipoLancamentos($scope.data.deleteTipoLancamento).then(function (result) {
				if (!result.errors) {
					$scope.updateTipoLancamento();
                    UtilsService.toastSuccess(result.data);
					$scope.closeDeleteModal();
				} else {
					$scope.closeDeleteModal();
                    UtilsService.toastError('Falha ao excluir');
				}
			}).catch(function (error) {
				$scope.closeDeleteModal();
				UtilsService.toastError(error.responseJSON.message);
			});
		}

		$scope.updateTipoLancamento = function () {
			LancamentoService.getAllTipoLancamentos().then(function (result) {
				if (result.data.length) {
					$scope.data.tipoLancamentos = result.data;
				}
			});
		}

		$scope.saveTipoLancamento = async() => {
			try {
				var result;
				if (!$scope.data.tipoLancamentoSelecionado.id)
					result = await LancamentoService.saveTipoLancamentos($scope.data.tipoLancamentoSelecionado);
				else
					result = await LancamentoService.editTipoLancamentos($scope.data.tipoLancamentoSelecionado);
				UtilsService.toastSuccess(result.data);
				$scope.updateTipoLancamento();
			} catch (error) {
				console.error(error);
				UtilsService.toastError(error.responseJSON.message)
			} finally {
				$('#novoLancamento').modal('hide');
			}
		}

		$scope.editTipoLancamento = function (tipoLancamento) {
			$scope.data.tipoLancamentoSelecionado = Object.assign({}, tipoLancamento);
			$('#novoLancamento').modal('show');
		}

		$scope.createTipoLancamento = function (tipoLancamento) {
			$scope.data.tipoLancamentoSelecionado = {
				idgrupo_lancamento: 'RECEITA'
			};
			$('#novoLancamento').modal('show');
		}

		$scope.goToGrupoLancamento = function () {
			$state.go('CadGrupLanc')
		}

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/tipo_lancamentos?page=${page}`);
			$scope.data.tipoLancamentos = result.data.data;
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