angular.module('appServices').service('SequenciaService', ['$q', 'config','$http', SequenciaService]);

function SequenciaService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllSequencias = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/sequencias',
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

			
	self.saveSequencias = function(sequencia) {
		return $http.post(config.apiUrl + 'api/sequencias', sequencia).then(handleSuccess, handleError);
	};

	self.editSequencias = function(sequencia) {
		return $http.patch(config.apiUrl + 'api/sequencias/' + sequencia.id, sequencia).then(handleSuccess, handleError);
	};

	self.deleteSequencias = function(sequencia) {
		return $http.delete(config.apiUrl + 'api/sequencias/' + sequencia.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	};
        

}
