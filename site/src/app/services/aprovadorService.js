angular.module('appServices').service('AprovadorService', ['$q', 'config','$http', AprovadorService]);

function AprovadorService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllAprovadores = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/aprovadores',
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


	/*self.saveAprovadores = function(aprovador) {
		return $http.post(config.apiUrl + 'api/aprovadores', aprovador).then(handleSuccess, handleError);
	};*/
	self.saveAprovadores = function(aprovador) {
		return $http.post(config.apiUrl + 'api/aprovadores', aprovador).then(handleSuccess, handleError);
	};

	self.editAprovadores = function(aprovador) {
		return $http.patch(config.apiUrl + 'api/aprovadores/' + aprovador.id, aprovador).then(handleSuccess, handleError);
	};

	self.deleteAprovadores = function(aprovador) {
		return $http.delete(config.apiUrl + 'api/aprovadores/' + aprovador.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	}
}
