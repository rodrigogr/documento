angular.module('appServices').service('ReceitaService', ['$http', '$q', 'config','UtilsService', ReceitaService]);

function ReceitaService($http, $q, config, UtilsService) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getInfoCalculoReceita = function (mes_ano_modelo) {
	    if (mes_ano_modelo){
	        mes_ano = mes_ano_modelo.split("-");
	        mes = mes_ano[0];
	        //colocando mes no padrao doi digitos para o mes
            if (mes.toString().length == 1)
                mes = "0"+mes;
	        ano = mes_ano[1];
	        url_api = config.apiUrl + 'api/receita_calculo/informacao/'+mes+'/'+ano;
        } else {
	        url_api = config.apiUrl + 'api/receita_calculo/informacao';
        }
		return $q.when($.ajax({
			type: 'GET',
			url: url_api,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.getAllCalculoReceita = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/receita_calculo',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.simulaCalculo = function (infoCalculo) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/receita_calculo/simular',
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				despesa_total: infoCalculo.despesa_total,
				area_total: infoCalculo.area_total,
				total_imoveis: infoCalculo.total_imoveis,
				fracao_ideal: infoCalculo.fracao_ideal,
				tipo_apuracao: infoCalculo.tipo_apuracao,
				data_vencimento: infoCalculo.data_vencimento,
				percentual_juros: infoCalculo.percentual_juros,
				percentual_multa: infoCalculo.percentual_multa,
				percentual_fundo_reserva: infoCalculo.percentual_fundo_reserva,
				carteira: infoCalculo.carteira
			}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.calculaCorrecoesBoleto = function (dadosBoleto) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/recebimento/manual/atualizar_juros_multa',
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				dados: dadosBoleto
			}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.visualizaBoletos = function (calculoId) {
		return window.open(config.apiUrl + 'api/receita_calculo/visualizar_boleto/' + calculoId, '_blank');
	};

	self.aprovaCalculo = function (infoCalculo, simulacaoCalculo) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/receita_calculo/aprovar_simulacao',
            header: {
                'Content-Type': 'application/json'
            },
            data: {
                despesa_total: simulacaoCalculo.despesaGeralTotal,
                area_total: infoCalculo.area_total,
                total_imoveis: infoCalculo.total_imoveis,
                fracao_ideal: infoCalculo.fracao_ideal.valor_rateio_m2,
                tipo_apuracao: infoCalculo.tipo_apuracao,
                data_vencimento: infoCalculo.data_vencimento,
                percentual_juros: infoCalculo.percentual_juros,
                percentual_multa: infoCalculo.percentual_multa,
                percentual_fundo_reserva: infoCalculo.percentual_fundo_reserva,
                carteira: infoCalculo.carteira,
                data_calculo: simulacaoCalculo.dataCalculo,
                formula_aplicada: simulacaoCalculo.formulaAplicada,
                termo_aprovacao: 1,
                lancamentos: simulacaoCalculo.lancamentos
            }
        }).then(function (data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
	};

	self.downloadRemessa = function (calculoId) {
		$('#loading-gerar_remessa').modal('show');
        $http.get(config.apiUrl + 'api/receita_calculo/emitir_remessa/' + calculoId)
            .then( function (response) {
                $('#loading-gerar_remessa').modal('hide');
                window.open(config.apiUrl + 'api/receita_calculo/emitir_remessa/' + calculoId);
            })
            .catch( function (e) {
                $('#loading-gerar_remessa').modal('hide');
                UtilsService.openAlert(e.data.message);
            });
	};

	self.sendBoletoCalculoEmail = function (calculoId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/receita_calculo/enviar_email/' + calculoId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.getRecebimentosManuais = function (data) {
		return $http.post(config.apiUrl + 'api/recebimento/manual', data);
	};

	self.atualizaBoleto = function (provisionarTitulo) {
		provisionarTitulo.com_correcao = provisionarTitulo.com_correcao ? 1 : 0;
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/recebimento/manual/atualizar_boleto',
			header: {
				'Content-Type': 'application/json'
			},
			data: provisionarTitulo
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.getDebitosPorRecebimento = function (recebimentoId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/manual/debitos/' + recebimentoId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.getSaldoAReceberPorRecebimento = function (recebimentoId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/manual/saldo_receber/' + recebimentoId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.getOrdensPagamentoPorRecebimento = function (recebimentoId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/manual/ordem_pagamentos/' + recebimentoId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.recebimentoManualEviaEmail = function (recebimentoId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/manual/enviar_email/' + recebimentoId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.downloadRemessaRecebimentoManual = function (recebimentoId) {
        $('#loading-gerar_remessa').modal('show');
        $http.get(config.apiUrl + 'api/recebimento/manual/download_remessa/' + recebimentoId )
            .then( function (response) {
                $('#loading-gerar_remessa').modal('hide');
                window.open(config.apiUrl + 'api/recebimento/manual/download_remessa/' + recebimentoId , '_blank');
            })
            .catch( function (e) {
                $('#loading-gerar_remessa').modal('hide');
                UtilsService.openAlert(e.data.message);
        	});
	};

	self.getAllLayoutRemessa = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/layout_remessa',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.consultaArquivosRetorno = function (search) {
		return $http.post(config.apiUrl + 'api/recebimento/consultar_arquivo', search);
	};


	self.realizaBaixaAutomatica = function (baixaAutomatica) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/recebimento/processar_arquivo_retorno',
			header: {
				'Content-Type': 'application/json'
			},
			data: baixaAutomatica
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.getAllTitulosProcessados = function (arquivoConsultaId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/titulos_processados/' + arquivoConsultaId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.receberTitulo = function (titulo) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/recebimento/manual/receber_titulo',
			header: {
				'Content-Type': 'application/json'
			},
			data: titulo
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.programarPreLancamento = function (preLancamento) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/recebimento/manual/receber_titulo/programar_lancamento',
            header: {
                'Content-Type': 'application/json'
            },
            data: preLancamento
        }).then(function (data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
	};

    self.baixarTitulo = function (titulo) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/recebimento/automatico/baixar_titulo',
            header: {
                'Content-Type': 'application/json'
            },
            data: titulo
        }).then(function (data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };
	
	self.receberTodosTitulos = function () {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/recebimento/receber_todos',
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				motivo: 'todos'
			}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));
	};

	self.cancelarTitulo = function (tituloId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/manual/cancelar_titulo/' + tituloId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));

	};

	self.cancelarProcessamento = function (tituloId) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/cancelar_processamento/' + tituloId,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));

	};

	self.printPendenciasSimularCalcular = function ($conteudo) {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/recebimento/print_pendencias_simular_calcular',
			header: {
				'Content-Type': 'application/json'
			},
			data: {$conteudo}
		}).then(function (data) {
			return data;
		}).catch(function (data) {
			throw data;
		}));

	};
}