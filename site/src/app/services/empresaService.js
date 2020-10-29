angular.module('appServices').service('EmpresaService', ['$q', 'config','$http', EmpresaService]);

function EmpresaService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllEmpresas = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/empresas',
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

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		throw res.data.message; 
	};
        

}
