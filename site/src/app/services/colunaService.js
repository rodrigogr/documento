angular.module('appServices').service('ColunaService', ['$q', 'config','$http', ColunaService]);

function ColunaService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllColunas = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/colunas',
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

			
	self.saveColunas = function(coluna) {
		return $http.post(config.apiUrl + 'api/colunas', coluna).then(handleSuccess, handleError);
	};

	self.editColunas = function(coluna) {
		return $http.patch(config.apiUrl + 'api/colunas/' + coluna.id, coluna).then(handleSuccess, handleError);
	};

	self.deleteColunas = function(coluna) {
		return $http.delete(config.apiUrl + 'api/colunas/' + coluna.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	};
        

}
