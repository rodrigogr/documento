angular.module('appServices').service('RuaService', ['$q', 'config','$http', RuaService]);

function RuaService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllRuas = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/ruas',
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

			
	self.saveRuas = function(rua) {
		return $http.post(config.apiUrl + 'api/ruas', rua).then(handleSuccess, handleError);
	};

	self.editRuas = function(rua) {
		return $http.patch(config.apiUrl + 'api/ruas/' + rua.id, rua).then(handleSuccess, handleError);
	};

	self.deleteRuas = function(rua) {
		return $http.delete(config.apiUrl + 'api/ruas/' + rua.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	};
        

}
