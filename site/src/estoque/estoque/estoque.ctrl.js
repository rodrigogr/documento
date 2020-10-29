'use strict'
angular.module('EstoqueModule').controller('EstoqueCtrl',
	function ($scope, $http, config, HeaderFactory, UtilsService, $state, AuthService) {

        HeaderFactory.setHeader('estoque', 'estoque');
		$scope.ngOnInit = async() => {
			$scope.pesquisar();
		}

		$scope.pesquisar = async(term) => {
			try {
				$('.loader').show();
				$scope.updateList(1);
				// let result = await $http.post(`${config.apiUrl}api/produtos/search`, term);
				// $scope.itens = vmEstoque(result.data);
				// $scope.$digest();
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		}

		let vmEstoque = (data) => {
			$scope.qntTotais = 0;
			if (data && data.length) {
				$scope.qntTotais = data.map(c => c.qntAtual).reduce((x, y) => x + y)
			}
			return data;
		}

		$scope.detailProduto = async(item) => {
			try {
				$('.loader').show();
				$('#detailProduto').modal('show');
				for (let i = 0; i < 5; i++) $scope[`img${i}`] = null;
				let produto = (await $http.get(`${config.apiUrl}api/produtos/detail/${item.id}`)).data.data;
				$scope.item = produto;
				let imgs = produto.imagens;
				for (let i = 0; i < imgs.length; i++) {
					$scope[`img${i}`] = {
						load: true
					};
					$http.get(`${config.apiUrl}api/produtos/getImage64/${imgs[i]}`)
						.then(result => $scope[`img${i}`] = result.data)
				}
				$scope.$digest();
			} catch (e) {
				console.error(e)
			} finally {
				$('.loader').hide();
			}
		}

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if ($scope.search) $scope.search.page = page;
			else $scope.search = {
				page: page
			};
			let srch = UtilsService.serializeQueryString($scope.search);
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/produtos/search?${srch}`);
			$scope.itens = vmEstoque(result.data.data);
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