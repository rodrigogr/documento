angular.module('appServices').service('BioacessoService', ['$q', 'config', BioacessoService]);

function BioacessoService($q, config) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getImoveisByQuadraAndLote = function(quadra, lote) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/imoveis/busca_morador/' + quadra + '/' + lote,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.getImovel = function(idImovel) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/imoveis/' + idImovel,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.getAllFornecedor = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/empresas',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

}
