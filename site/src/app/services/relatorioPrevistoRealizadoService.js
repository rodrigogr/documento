angular.module('appServices').service('relatorioPrevistoRealizadoService', ['$q', 'config', relatorioPrevistoRealizadoService]);

function relatorioPrevistoRealizadoService($q, config) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getLancamentosPre = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/pre_lancamentos',
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

	self.getLancamentosRecorrente = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/lancamento_recorrentes',
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
}