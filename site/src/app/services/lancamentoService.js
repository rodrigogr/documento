angular.module('appServices').service('LancamentoService',
	function ($q, config, $http, UtilsService) {
		this.getLancamentosPre = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/pre_lancamentos',
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

		this.getLancamentosRecorrente = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamento_recorrentes',
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

		this.deleteGrupoLancamentos = function (grupoLancamento) {
			return $q.when($.ajax({
				type: 'DELETE',
				url: config.apiUrl + 'api/grupo_lancamentos/' + grupoLancamento.id,
				header: {
					'Content-Type': 'application/json'
				},
				dataType: "json",
				data: {}
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.saveGrupoLancamentos = function (grupoLancamento) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/grupo_lancamentos',
				header: {
					'Content-Type': 'application/json'
				},
				dataType: "json",
				data: {
					descricao: grupoLancamento.descricao.toUpperCase()
				}
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.editGrupoLancamentos = function (grupoLancamento) {
			return $q.when($.ajax({
				type: 'PATCH',
				url: config.apiUrl + 'api/grupo_lancamentos/' + grupoLancamento.id,
				header: {
					'Content-Type': 'application/json'
				},
				data: {
					descricao: grupoLancamento.descricao.toUpperCase()
				}
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.getAllGrupoLancamentos = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/grupo_lancamentos',
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

		this.getGruposLancamentosTipo = function (tipo = null) {
			param = (tipo !== null) ? {
				"tipo": tipo
			} : {};
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/grupo_lancamentos_by_tipo',
				header: {
					'Content-Type': 'application/json'
				},
				data: param
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.saveTipoLancamentos = function (tipoLancamento) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/tipo_lancamentos',
				header: {
					'Content-Type': 'application/json'
				},
				data: {
					idgrupo_lancamento: tipoLancamento.idgrupo_lancamento,
					descricao: tipoLancamento.descricao.toUpperCase(),
					fluxo: tipoLancamento.fluxo
				}
				/*{
				 "idgrupo_lancamento": 1,
				 "descricao": "Tipo Novo Teste 2",
				 "fluxo": "DESPESA"
				 }*/
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.deleteTipoLancamentos = function (tipoLancamento) {
			return $q.when($.ajax({
				type: 'DELETE',
				url: config.apiUrl + 'api/tipo_lancamentos/' + tipoLancamento.id,
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

		this.editTipoLancamentos = function (tipoLancamento) {
			return $q.when($.ajax({
				type: 'PATCH',
				url: config.apiUrl + 'api/tipo_lancamentos/' + tipoLancamento.id,
				header: {
					'Content-Type': 'application/json'
				},
				data: {
					idgrupo_lancamento: tipoLancamento.idgrupo_lancamento,
					descricao: tipoLancamento.descricao.toUpperCase(),
					fluxo: tipoLancamento.fluxo
				}
				/*{
				 "idgrupo_lancamento": 1,
				 "descricao": "Tipo Novo Teste 2",
				 "fluxo": "DESPESA"
				 }*/
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.getAllTipoLancamentos = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/tipo_lancamentos',
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

		this.saveLancamentoEstimado = function (lancamentoEstimado) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/lancamentos_estimados',
				header: {
					'Content-Type': 'application/json'
				},
				data: {
					id_tipolancamento: lancamentoEstimado.id_tipolancamento,
					id_grupolancamento: lancamentoEstimado.id_grupolancamento,
					fundo_reserva: lancamentoEstimado.fundo_reserva ? 1 : 0,
					valor: lancamentoEstimado.valor
				}

			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.deleteLancamentoEstimado = function (lancamentoEstimado) {
			return $q.when($.ajax({
				type: 'DELETE',
				url: config.apiUrl + 'api/lancamentos_estimados/' + lancamentoEstimado.id,
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

		this.editLancamentoEstimado = function (lancamentoEstimado) {
			return $q.when($.ajax({
				type: 'PATCH',
				url: config.apiUrl + 'api/lancamentos_estimados/' + lancamentoEstimado.id,
				header: {
					'Content-Type': 'application/json'
				},
				data: {
					id_tipolancamento: lancamentoEstimado.id_tipolancamento,
					id_grupolancamento: lancamentoEstimado.id_grupolancamento,
					fundo_reserva: lancamentoEstimado.fundo_reserva ? 1 : 0,
					valor: lancamentoEstimado.valor
				}
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.getAllLancamentoEstimado = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamentos_estimados',
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

		this.getResumoLancamentoEstimado = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamentos_estimados/resumo',
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

		this.aprovaLancamentoEstimados = function (lancamentosEstimados) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/estimados',
				header: {
					'Content-Type': 'application/json'
				},
				data: lancamentosEstimados
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data.responseJSON.message;
			}));
		};

		this.getAllLancamentoAvulso = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamento_avulsos',
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

		this.getAllLancamentoAvulsoAntigo = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamento_avulsos/antigos',
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

		this.saveLancamentoAvulso = function (lancamentoAvulso) {
			var data = {};
			if (lancamentoAvulso.tipo_cobranca === 'antiga') {
				data = {
					tipo_cobranca: lancamentoAvulso.tipo_cobranca,
					id_configuracao_carteira: lancamentoAvulso.id_configuracao_carteira,
					id_layout_remessa: lancamentoAvulso.id_layout_remessa,
					idimovel: lancamentoAvulso.idimovel,
					id_empresa: lancamentoAvulso.id_empresa,
					valor: lancamentoAvulso.valor,
                    descricao: lancamentoAvulso.descricao,
					data_vencimento: lancamentoAvulso.data_vencimento,
					data_competencia:lancamentoAvulso.data_competencia,
					percentual_multa: lancamentoAvulso.percentual_multa,
					percentual_juros: lancamentoAvulso.percentual_juros,
					nosso_numero: lancamentoAvulso.nosso_numero,
					numero_documento: lancamentoAvulso.numero_documento,
					aceite: lancamentoAvulso.aceite ? 1 : 0,
					especie_doc: lancamentoAvulso.especie_doc,
					id_situacao_inadimplencia: lancamentoAvulso.situacao_inadimplencia,
					lancamentos: lancamentoAvulso.lancamentos
				}
			} else {
				data = {
					tipo_cobranca: lancamentoAvulso.tipo_cobranca,
					id_configuracao_carteira: lancamentoAvulso.id_configuracao_carteira,
					id_layout_remessa: lancamentoAvulso.id_layout_remessa,
					idimovel: lancamentoAvulso.idimovel,
					id_empresa: lancamentoAvulso.id_empresa,
					idtipo_lancamento: lancamentoAvulso.idtipo_lancamento,
					descricao: lancamentoAvulso.descricao,
					valor: lancamentoAvulso.valor,
					data_vencimento: lancamentoAvulso.data_vencimento
				}
			}
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/lancamento_avulsos',
				header: {
					'Content-Type': 'application/json'
				},
				data: data
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.checkEditLancamentoAntigo = function (id_lancamento) {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamento_avulsos/check_edit_lancamento_antigo/' + id_lancamento,
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

		this.editLancamentoAntigo = function (lancamentoAntigo) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/lancamento_avulsos/update_lancamento_antigo',
				header: {
					'Content-Type': 'application/json'
				},
				data: lancamentoAntigo
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.cancelamentoLancamento = function (id_lanc, motivo) {
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/lancamento_avulsos/cancela_lancamento_avulso',
				header: {
					'Content-Type': 'application/json'
				},
				data: {id:id_lanc, motivo:motivo}
			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.deletaLancamento = function (lancamentoAntigo) {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamento_avulsos/deleta_lancamento_antigo/' + lancamentoAntigo,
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

		this.sendBoletoAvulsoEmail = function (lancamentoAvulso) {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamento_avulsos/enviar_email/' + lancamentoAvulso.id_lancamento,
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

		this.getAllPreLancamento = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/pre_lancamentos',
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

		this.createPreLancamento = function (preLancamento) {
			preLancamento.desconto = preLancamento.desconto ? 1 : 0;
            preLancamento.valor_percentual = preLancamento.valor_percentual ? 1 : 0;
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/pre_lancamentos',
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

		this.editPreLancamento = function (preLancamento) {
			preLancamento.desconto = preLancamento.desconto ? 1 : 0;
            preLancamento.valor_percentual = preLancamento.valor_percentual ? 1 : 0;
			return $q.when($.ajax({
				type: 'PATCH',
				url: config.apiUrl + 'api/pre_lancamentos/' + preLancamento.id_lancamento,
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

		this.deletePreLancamento = function (preLancamento) {
			return $q.when($.ajax({
				type: 'DELETE',
				url: config.apiUrl + 'api/pre_lancamentos/' + preLancamento.id_lancamento,
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

		this.getAllLancamentoRecorrente = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/lancamento_recorrentes',
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

		this.createLancamentoRecorrente = function (lancamentoRecorrente) {
            lancamentoRecorrente.rateio =  lancamentoRecorrente.rateio ? 1 : 0;
            lancamentoRecorrente.fixo =  lancamentoRecorrente.fixo ? 1 : 0;
			return $q.when($.ajax({
				type: 'POST',
				url: config.apiUrl + 'api/lancamento_recorrentes',
				header: {
					'Content-Type': 'application/json'
				},
				data: lancamentoRecorrente

			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.editLancamentoRecorrente = function (lancamentoRecorrente) {
            lancamentoRecorrente.rateio =  lancamentoRecorrente.rateio ? 1 : 0;
			return $q.when($.ajax({
				type: 'PATCH',
				url: config.apiUrl + 'api/lancamento_recorrentes/' + lancamentoRecorrente.id_lancamento,
				header: {
					'Content-Type': 'application/json'
				},
				data: lancamentoRecorrente

			}).then(function (data) {
				return data;
			}).catch(function (data) {
				throw data;
			}));
		};

		this.deleteLancamentoRecorrente = function (lancamentoRecorrente) {
			return $q.when($.ajax({
				type: 'DELETE',
				url: config.apiUrl + 'api/lancamento_recorrentes/' + lancamentoRecorrente.id_lancamento,
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

		this.downloadRemessa = function (id_parcela) {
            $('#loading-gerar_remessa').modal('show');
            $http.get(config.apiUrl + 'api/lancamento_avulsos/gerar_remessa/' + id_parcela)
                .then( function (response) {
                    $('#loading-gerar_remessa').modal('hide');
                    window.open(config.apiUrl + 'api/lancamento_avulsos/gerar_remessa/' + id_parcela);
                })
                .catch( function (e) {
                    $('#loading-gerar_remessa').modal('hide');
                    UtilsService.openAlert(e.data.message);
                });
		};

		this.openEstimadosPdf = function () {
			return window.open(config.apiUrl + 'api/lancamentos_estimados/pdf/1', '_blank');
		};

		this.getUltimoEstimado = function () {
			return $q.when($.ajax({
				type: 'GET',
				url: config.apiUrl + 'api/estimados/ultima_estimativa',
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

		this.mesesAprovadosSemCalculo = function () {
            return $q.when($.ajax({
                type: 'GET',
                url: config.apiUrl + 'api/estimados/lista_estimados_sem_calculo',
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

        this.checkPeriodoLancamentoRecorrente = function (dados) {
			return dados;
		};

        this.getCalulosSimulados = function () {
            return $q.when($.ajax({
                type: 'GET',
                url: config.apiUrl + 'api/lancamento_recorrentes/calculos_simulados',
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
	});