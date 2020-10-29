'use strict'
angular.module('CadastrosModule').controller('GrupoCalculoCtrl',
    function ($scope, $state, ConfiguracaoService, UtilsService, $http, config, HeaderFactory, AuthService) {

		HeaderFactory.setHeader('Cadastros', 'CADASTRO DE GRUPOS DE CÁLCULO');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));$scope.ngOnInit = () => {
			$scope.updateList(1);
			$http.get(`${config.apiUrl}api/tipo_lancamentos`).then(result=> $scope.lancamentos =result.data.data.filter(x => x.fluxo == 'RECEITA') );
					$http.get(`${config.apiUrl}api/formulas`)
				.then(result => $scope.formulas = result.data.data);
		AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);};

		$scope.deleteGrupoCalculo = async(id) => {
			await UtilsService.confirmAlert('Excluir', 'Confirmar exclusão?');
			try {
				await $http.delete(`${config.apiUrl}api/grupo_calculo/${id}`);
				UtilsService.toastSuccess('Registro excluido');
				$scope.updateList(1);
			} catch (e) {
				console.error(e);
				UtilsService.toastError();
			}
		}


		$scope.saveGrupoCalculo = async(item) => {
			try {
				let result = item.id ? await $http.put(`${config.apiUrl}api/grupo_calculo/${item.id}`, item) :
					await $http.post(`${config.apiUrl}api/grupo_calculo`, item);
				$scope.updateList(1);
				$('#novoGrupoCalculo').modal('hide');
			} catch (e) {
				console.error(e);
			}
		}

		$scope.editGrupoCalculo = function (grupoCalculo) {
			$scope.item = Object.assign({}, grupoCalculo);
			$('#novoGrupoCalculo').modal('show');
		}

		$scope.createGrupoLancamento = function () {
			$scope.item = {};
			$('#novoGrupoCalculo').modal('show');
		}

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/grupo_calculo?page=${page}`);
			$scope.Itens = result.data.data;
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