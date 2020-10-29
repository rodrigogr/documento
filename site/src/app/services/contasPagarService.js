angular.module('appServices').service('ContasPagarService', ['$q', 'config', ContasPagarService]);

function ContasPagarService($q, config) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllContasPagar = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/lancamento_agendar',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.saveContasPagar = function (data) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/lancamento_agendar',
			header: {
				'Content-Type': 'application/json'
			},
			data: data
		}).then(function(data) {
			return data;
		}));
	};

	self.deleteContasPagar = function (contasPagar) {
		return $q.when($.ajax({
			type: 'DELETE',
			url: config.apiUrl + 'api/lancamento_agendar/' + contasPagar.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.editContasPagar = function (contasPagar, parcelas, acrescimos) {
		contasPagar.parcelas = parcelas;
		contasPagar.acrescimos = acrescimos;
		return $q.when($.ajax({
			type: 'PATCH',
			url: config.apiUrl + 'api/lancamento_agendar/' + contasPagar.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: contasPagar
		}).then(function(data) {
			return data;
		}));
	};

	self.getDemonstrativo = function (contasPagar) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/lancamento_agendar/demonstrativo/' + contasPagar.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.contasVencidas = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/lancamento_agendar/contas_vencidas/',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};
}