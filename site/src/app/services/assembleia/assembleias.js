angular.module('appServices').service('AssembleiaService', ['$q', 'config', AssembleiaService]);

function AssembleiaService($q, config) {
    var self = this;

	self.data = {
		user: {}
	};

    self.read = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/assembleias',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

    self.salvar = function (data) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/assembleias',
			header: {
				'Content-Type': 'application/json'
			},
			data: data
		}).then(function(data) {
			return data;
		}));
	};
}
