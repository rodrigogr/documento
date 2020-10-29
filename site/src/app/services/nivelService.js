angular.module('appServices').service('NivelService', ['$q', 'config','$http', NivelService]);

function NivelService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllNivels = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/niveis',
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

			
	self.saveNivels = function(nivel) {
		return $http.post(config.apiUrl + 'api/niveis', nivel).then(handleSuccess, handleError);
	};

	self.editNivels = function(nivel) {
		return $http.patch(config.apiUrl + 'api/niveis/' + nivel.id, nivel).then(handleSuccess, handleError);
	};

	self.deleteNivels = function(nivel) {
		return $http.delete(config.apiUrl + 'api/niveis/' + nivel.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	};
        

}
