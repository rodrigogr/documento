angular.module('appServices').service('GrupoProdutoService', ['$q', 'config','$http', GrupoProdutoService]);

function GrupoProdutoService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllGrupoProduto = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/grupo_produtos',
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

				
	self.saveGrupos = function(grupo) {
		return $http.post(config.apiUrl + 'api/grupo_produtos', grupo).then(handleSuccess, handleError);
	};

	self.editGrupos = function(grupo) {
		return $http.patch(config.apiUrl + 'api/grupo_produtos/' + grupo.id, grupo).then(handleSuccess, handleError);
	};

	self.deleteGrupos = function(grupo) {
		return $http.delete(config.apiUrl + 'api/grupo_produtos/' + grupo.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	};

}
