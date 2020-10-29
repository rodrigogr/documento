angular.module('appServices').service('PedidoService', ['$q', 'config','$http', PedidoService]);

function PedidoService($q, config,$http) {
	var self = this;

	self.data = {
		user: {}
	};

    //## PEDIDOS ##
	self.getAllPedidos = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/pedidos',
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
	self.savePedidos = function(pedido) {
		return $http.post(config.apiUrl + 'api/pedidos', pedido).then(handleSuccess, handleError);
	};

	self.editPedidos = function(pedido) {
		return $http.patch(config.apiUrl + 'api/pedidos/' + pedido.id, pedido).then(handleSuccess, handleError);
	};

	self.deletePedidos = function(pedido) {
		return $http.delete(config.apiUrl + 'api/pedidos/' + pedido.id).then(handleSuccess, handleError);
	};

	self.getPedidos = function(id) {
		return $http.get(config.apiUrl + 'api/pedidos/' + id).then(handleSuccess, handleError);
	};

    self.getAllSolicitacoes = function() {
        return $http.get(config.apiUrl + 'api/solicitacao/').then(handleSuccess, handleError);
    };

	self.editSolicitacao = function(solicitacao) {
		return $http.patch(config.apiUrl + 'api/solicitacao/' + solicitacao.id, solicitacao).then(handleSuccess, handleError);
	};

	self.deleteSolicitacao = function(solicitacaoId) {
		return $http.delete(config.apiUrl + 'api/solicitacao/' + solicitacaoId).then(handleSuccess, handleError);
	};

	self.getSolicitacao = function(id) {
		return $http.get(config.apiUrl + 'api/solicitacao/' + id).then(handleSuccess, handleError);
	};
    self.searchPedidos = function(search) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/pedidos/search/',
            header: {
                'Content-Type': 'application/json'
            },
            data: {tag: search}
        }).then(function(data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };

    self.deleteItensByPedido = function(pedido) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/pedidos/pedidoDeleteItens/',
            header: {
                'Content-Type': 'application/json'
            },
            data: {idpedido: pedido}
        }).then(function(data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };

    self.notificacaoAprovador = function(pedido) {
        return $http.post(config.apiUrl + 'api/pedidos/notificacao_aprovador',pedido).then(handleSuccess, handleError);
    };

	function handleSuccess(res) { return res.data; }
	function handleError(res) { 
		throw res.data.message; 
	}

}
