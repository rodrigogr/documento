angular.module('appServices').service('AreaService', ['$q', 'config','$http', AreaService]);

function AreaService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllAreas = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/areas',
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

			
	self.saveAreas = function(area) {
		return $http.post(config.apiUrl + 'api/areas', area).then(handleSuccess, handleError);
	};

	self.editAreas = function(area) {
		return $http.patch(config.apiUrl + 'api/areas/' + area.id, area).then(handleSuccess, handleError);
	};

	self.deleteAreas = function(area) {
		return $http.delete(config.apiUrl + 'api/areas/' + area.id).then(handleSuccess, handleError);
	};

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		return {success:false,data:res.data.message}; 
	};
        

}
