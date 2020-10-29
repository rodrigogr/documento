'use strict'
angular.module('appServices').service('PagamentoService',
	function ($q, config, $http) {
		var self = this;

		self.data = {
			user: {}
		};

		self.getAllPagamentos = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/pagamento',
				header: {
					'Content-Type': 'application/json'
				},
				data: {}
			}).then(function (data) {
				return data;
			}));
		};

		self.savePagamento = function (parcelas) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/pagamento/pagar',
				header: {
					'Content-Type': 'application/json'
				},
				data: {
					parcelas: parcelas
				}
			}).then(function (data) {
				return data;
			}));
		};

		self.consultaPagamentos = data => $http.post(`${config.apiUrl}api/pagamento/filtro`, data);

		self.estornoPagamento = function (parcelasEstorno) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/pagamento/estornar',
				header: {
					'Content-Type': 'application/json'
				},
				data: {
					parcelas: parcelasEstorno
				}
			}).then(function (data) {
				return data;
			}));
		};
		/*
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

		    self.editContasPagar = function (contasPagar, parcelas) {
		        contasPagar.parcelas = parcelas;
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
		    };*/
	}
)