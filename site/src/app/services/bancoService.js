angular.module('appServices').service('BancoService', ['$q', 'config', BancoService]);

function BancoService($q, config) {

	this.data = {
		user: {}
	};

	this.getAllCarteirasDisponiveis = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/conta_bancarias/carteiras_disponiveis',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.getAllCarteiras = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/carteiras',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.getAllLayoutRemessa = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/layout_remessa',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.getAllLayoutRetorno = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/layout_retorno',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.getAllContasBancarias = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/conta_bancarias/select',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.getAllContasBancariasCadastro = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/conta_bancarias',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.getAllBancos = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/bancos',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.saveBanco = function (banco) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/bancos',
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				codigo: banco.codigo,
				descricao: banco.descricao,
				url: banco.url
			}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.editBanco = function (banco) {
		return $q.when($.ajax({
			type: 'PATCH',
			url: config.apiUrl + 'api/bancos/' + banco.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				codigo: banco.codigo,
				descricao: banco.descricao,
				url: banco.url
			}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.deleteBanco = function (banco) {
		return $q.when($.ajax({
			type: 'DELETE',
			url: config.apiUrl + 'api/bancos/' + banco.id,
			header: {
				'Content-Type': 'application/json'
			}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.saveContaBancaria = function (contaBancaria) {
		if (contaBancaria.tipo_banco === 'caixa') {
			dados = {
				tipo_banco: contaBancaria.tipo_banco,
				descricao: contaBancaria.descricao,
				saldo: contaBancaria.saldo,
                saldo_value: contaBancaria.saldoValue,
				data_saldo_inicial: contaBancaria.data_saldo_inicial
			}
		} else {
			dados = {
                idbanco: contaBancaria.idbanco,
                tipo_banco: contaBancaria.tipo_banco,
                agencia: contaBancaria.agencia,
                conta: contaBancaria.conta,
                tipo: contaBancaria.tipo,
                operacao: contaBancaria.operacao,
                relatorio: contaBancaria.relatorio ? 1 : 0,
                saldo: contaBancaria.saldo,
                saldo_value: contaBancaria.saldoValue,
                data_saldo_inicial: contaBancaria.data_saldo_inicial
            }
		}
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/conta_bancarias',
			header: {
				'Content-Type': 'application/json'
			},
			data: dados
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.editContaBancaria = function (contaBancaria) {
        if (contaBancaria.tipo_banco === 'caixa') {
            dados = {
                tipo_banco: contaBancaria.tipo_banco,
                descricao: contaBancaria.descricao,
                saldo: contaBancaria.saldo,
                saldo_value: contaBancaria.saldoValue,
                data_saldo_inicial: contaBancaria.data_saldo_inicial
            }
        } else {
            dados = {
                idbanco: contaBancaria.idbanco,
                tipo_banco: contaBancaria.tipo_banco,
                agencia: contaBancaria.agencia,
                conta: contaBancaria.conta,
                tipo: contaBancaria.tipo,
                operacao: contaBancaria.operacao,
                relatorio: contaBancaria.relatorio ? 1 : 0,
                saldo: contaBancaria.saldo,
                saldo_value: contaBancaria.saldoValue,
                data_saldo_inicial: contaBancaria.data_saldo_inicial
            }
        }
		return $q.when($.ajax({
			type: 'PATCH',
			url: config.apiUrl + 'api/conta_bancarias/' + contaBancaria.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: dados
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.deleteContaBancaria = function (contaBancaria) {
		return $q.when($.ajax({
			type: 'DELETE',
			url: config.apiUrl + 'api/conta_bancarias/' + contaBancaria.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.getAllConfiguracaoCateira = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/configuracao_carteira',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.saveConfiguracaoCarteira = function (configuracaoCarteira) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/configuracao_carteira',
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				id_conta_bancaria: configuracaoCarteira.id_conta_bancaria,
				id_carteira: configuracaoCarteira.id_carteira,
				id_layout_remessa: configuracaoCarteira.id_layout_remessa,
				id_layout_retorno: configuracaoCarteira.id_layout_retorno,
				agencia: configuracaoCarteira.agencia,
				conta_corrente: configuracaoCarteira.conta_corrente,
				codigo_cedente: configuracaoCarteira.codigo_cedente,
				primeiro_dado_config: configuracaoCarteira.primeiro_dado_config,
				segundo_dado_config: configuracaoCarteira.segundo_dado_config,
				instru_cobranca_um: configuracaoCarteira.instru_cobranca_um,
				instru_cobranca_dois: configuracaoCarteira.instru_cobranca_dois,
				instru_cobranca_tres: configuracaoCarteira.instru_cobranca_tres,
				nosso_numero_inicio: configuracaoCarteira.nosso_numero_inicio,
				nosso_numero_fim: configuracaoCarteira.nosso_numero_fim
			}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.editConfiguracaoCarteira = function (configuracaoCarteira) {
		return $q.when($.ajax({
			type: 'PATCH',
			url: config.apiUrl + 'api/configuracao_carteira/' + configuracaoCarteira.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				id_conta_bancaria: configuracaoCarteira.id_conta_bancaria,
				id_carteira: configuracaoCarteira.id_carteira,
				id_layout_remessa: configuracaoCarteira.id_layout_remessa,
				id_layout_retorno: configuracaoCarteira.id_layout_retorno,
				agencia: configuracaoCarteira.agencia,
				conta_corrente: configuracaoCarteira.conta_corrente,
				codigo_cedente: configuracaoCarteira.codigo_cedente,
				primeiro_dado_config: configuracaoCarteira.primeiro_dado_config,
				segundo_dado_config: configuracaoCarteira.segundo_dado_config,
				instru_cobranca_um: configuracaoCarteira.instru_cobranca_um,
				instru_cobranca_dois: configuracaoCarteira.instru_cobranca_dois,
				instru_cobranca_tres: configuracaoCarteira.instru_cobranca_tres,
				nosso_numero_inicio: configuracaoCarteira.nosso_numero_inicio,
				nosso_numero_fim: configuracaoCarteira.nosso_numero_fim
			}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

	this.deleteConfiguracaoCateira = function (contaBancaria) {
		return $q.when($.ajax({
			type: 'DELETE',
			url: config.apiUrl + 'api/configuracao_carteira/' + contaBancaria.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (error) {
			throw error;
		}));
	};

}