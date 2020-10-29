angular.module('appServices').service('UnidadeProdutoService', ['$q', 'config','$http', UnidadeProdutoService]);

function UnidadeProdutoService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllUnidadeProduto = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/unidade_produtos',
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

	self.saveUnidades = function(unidade) {
		return $http.post(config.apiUrl + 'api/unidade_produtos', unidade).then(handleSuccess, handleError);
	};

	self.editUnidades = function(unidade) {
		return $http.patch(config.apiUrl + 'api/unidade_produtos/' + unidade.id, unidade).then(handleSuccess, handleError);
	};

	self.deleteUnidades = function(unidade) {
		return $http.delete(config.apiUrl + 'api/unidade_produtos/' + unidade.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	};
}
