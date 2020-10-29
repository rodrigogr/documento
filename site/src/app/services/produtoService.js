angular.module('appServices').service('ProdutoService', ['$q', 'config','$http', ProdutoService]);

function ProdutoService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllProduto = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/produtos',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

			
	self.saveProdutos = function(produto) {
		return $http.post(config.apiUrl + 'api/produtos', produto).then(handleSuccess, handleError);
	};

	self.editProdutos = function(produto) {
		return $http.patch(config.apiUrl + 'api/produtos/' + produto.id, produto).then(handleSuccess, handleError);
	};

	self.deleteProdutos = function(nivel) {
		return $http.delete(config.apiUrl + 'api/produtos/' + nivel.id).then(handleSuccess, handleError);
	};


	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {errors:true,data:res.data.message};
	}
        

}
