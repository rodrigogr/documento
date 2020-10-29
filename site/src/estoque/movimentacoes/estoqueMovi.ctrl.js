'use strict'
angular.module('EstoqueModule').controller('EstoqueMoviCtrl',
	function ($scope, $http, config, UtilsService, HeaderFactory) {

        HeaderFactory.setHeader('estoque', 'movimentação de estoque');
		$scope.$ = $;

		$scope.ngOnInit = async() => {
			try {
				$('.loader').show();
				await pesquisar();
				await Promise.all(basicData);
				$scope.filterProdutos = $scope.produtos;
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		}

		let pesquisar = async() => {
			$scope.updateList(1);
			// let result = await $http.get(`${config.apiUrl}api/estoque/movimentacoes`);
			// $scope.itens = vmEstqMov(result.data);
			// $scope.$digest();
		}

		let vmEstqMov = (data) => {
			if (data && data.length) {
				data.forEach(x => {
					x.created_at = UtilsService.toDate(x.created_at);
				});
				data.sort((a, b) => a.created_at < b.created_at);
			}
			return data;
		}

		$scope.removeProduto = (prod) => {
			var index = $scope.item.estoque.indexOf(prod);
			if (index > -1) $scope.item.estoque.splice(index, 1);
			$scope.item.valor_itens = $scope.item.estoque.length && $scope.item.estoque.map(x => x.valor_unitario * x.quantidade).reduce((x, y) => x + y) || 0;
		}

		$scope.addProduto = (prod) => {
			prod.vmDescricao = $scope.produtos.find(x => x.id == prod.id_produto).descricao;
			$scope.item.estoque.push(Object.assign({}, prod));
			$scope.item.valor_itens = $scope.item.estoque.map(x => x.valor_unitario * x.quantidade).reduce((x, y) => x + y);
			$scope.produto = {
				valor_unitario: 0,
				quantidade: 1
			};
		}

		$scope.operacoes = () => {
			if (!$scope.item) return;
			else if ($scope.item.tipo == 'entrada') return ['manual', 'compras'];
			else return ['Consumo','Balanço', 'Devolução', 'Alienação', 'Doação', 'Permuta', 'Inservível', 'Sinistro', 'Morte', 'Verificação', 'Transferência', 'Recadastramento', 'Desmembramento'];
		}

		$scope.createMovi = () => {
			$scope.item = {
				tipo: 'entrada',
				operacao: 'manual',
				estoque: [],
			}
			$scope.produto = {
				valor_unitario: 0,
				quantidade: 1
			};
			$('#novaMovi').modal('show');
		}

		let basicData = [
			$http.get(`${config.apiUrl}api/empresas`)
			.then(result => $scope.fornecedores = result.data.data),
			$http.get(`${config.apiUrl}api/produtos/consumo`)
			.then(result => $scope.produtos = result.data),
			$http.get(`${config.apiUrl}api/grupo_produtos`)
			.then(result => $scope.grupoProdutos = result.data.data)
		]

		$scope.operacoesEntrada = ['Manual', 'Compras'];

		$scope.operacoesSaida = ['Balanço', 'Devolução', 'Alienação', 'Doação', 'Permuta', 'Inservível', 'Sinistro', 'Morte', 'Verificação', 'Transferência', 'Recadastramento', 'Desmenbramento', 'Correção'];

		$scope.submit = async(item) => {
			try {
				$('.loader').show();
				verifyItem(item);
				await $http.post(`${config.apiUrl}api/estoque/movimentacoes`, item);
				$('#novaMovi').modal('hide');
				await pesquisar();
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		}

		let verifyItem = (item) => {
			if (!item.estoque || !item.estoque.length) {
				UtilsService.openAlertAtencao('adicione pelo menos um produto');
				throw 'adicione pelo menos um produto';
			}
		}

		$scope.viewMov = (item) => {
			$scope.item = Object.assign({}, item);
			$('#viewMovi').modal('show');
		}

		$scope.delete = async(item) => {
			try {
				await UtilsService.confirmAlert('Excluir', 'Deseja realmente excluir o registro?');
				$('.loader').show();
				await $http.delete(`${config.apiUrl}api/estoque/movimentacoes/${item.id}`);
				$('#novaMovi').modal('hide');
				await pesquisar();
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		}

		$scope.changeGroup = (id) => {
			$scope.filterProdutos = $scope.produtos.filter(x => x.idgrupo_produto == id);
		}

		$scope.changeProduct = (id) => {
			$scope.produto.estoque_atual = $scope.produtos.find(x => x.id == id).quantidade_atual;
		}

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/estoque/movimentacoes?page=${page}`);
			$scope.itens = vmEstqMov(result.data.data);
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