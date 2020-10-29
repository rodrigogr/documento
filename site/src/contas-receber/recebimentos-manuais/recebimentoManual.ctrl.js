'use strict'
angular.module('ContasReceberModule').controller('RecebimentoManualCtrl',
    function ($scope, $http, $filter, config, ReceitaService, UtilsService, BancoService, HeaderFactory, AuthService, $state) {

        HeaderFactory.setHeader('Receitas', 'Recebimento manual');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.ngOnInit = () => {
            BancoService.getAllLayoutRemessa().then(result => $scope.data.layoutArquivos = result.data);
            BancoService.getAllCarteirasDisponiveis().then(result => $scope.data.carteirasDisponiveis = result.data);
            AuthService.aclPaginaService($state.current.name, user.id).then(result => $scope.accessPagina = result.data);
            $scope.search = {
                mes_competencia: new Date().getMonth(),
                ano_competencia: new Date().getFullYear()
            };
            $('.loader').hide();
        };

		var ano = new Date();
		$scope.data = {
			recebimentosManuais: [],
			debitos: [],
			saldosReceber: [],
			ordensPagamento: [],
			tabStatus: 'Debitos',
			rebimentoIdSelecionado: '',
			provisionarTitulo: {
				id_parcela: '',
				id_configuracao_carteira: '',
				id_layout_remessa: '',
				data_vencimento: null,
				com_correcao: true,
				mais_lancamentos: true,
				data_correcao: null,
				juros: 0,
				multa: 0,
				valor_juridico: 0,
				valor_correcao: 0,
				valor_desconto: 0,
				valor_abatimento: 0,
				valor_total: 0,
				valor_origem: 0
			},
			jurosDiv: false,
			recebimentoTitulo: {
				id_titulo: '',
				valor_titulo: 0,
				valor_pago: 0,
				valor_juros: 0,
				valor_multa: 0,
				valor_abatimento: 0,
				valor_desconto: 0,
				valor_juridico: 0,
				valor_correcao: 0,
				data_pagamento: '',
				data_compensacao: '',
				nosso_numero: '',
				observacao: '',
				received: false,
				i_agree: false
			},
			meses: [{
					codigo: 1,
					nome: 'JANEIRO'
				},
				{
					codigo: 2,
					nome: 'FEVEREIRO'
				},
				{
					codigo: 3,
					nome: 'MARÇO'
				},
				{
					codigo: 4,
					nome: 'ABRIL'
				},
				{
					codigo: 5,
					nome: 'MAIO'
				},
				{
					codigo: 6,
					nome: 'JUNHO'
				},
				{
					codigo: 7,
					nome: 'JULHO'
				},
				{
					codigo: 8,
					nome: 'AGOSTO'
				},
				{
					codigo: 9,
					nome: 'SETEMBRO'
				},
				{
					codigo: 10,
					nome: 'OUTUBRO'
				},
				{
					codigo: 11,
					nome: 'NOVEMBRO'
				},
				{
					codigo: 12,
					nome: 'DEZEMBRO'
				}
			],
			preLancamento: {
				valor: 0,
				ano: ano.getFullYear(),
				mes: '',
				desconto: 0,
				id_titulo: ''
			},
			detalhePagamento: null
		}

		$scope.selecionaRecebimentoManual = async(recebimentoManual) => {
			try {
				$('.loader').show();
				if ($scope.data.rebimentoSelecionado && $scope.data.rebimentoSelecionado.id === recebimentoManual.id) {
					$scope.data.rebimentoSelecionado = {};
					$scope.data.debitos = [];
					$scope.data.saldosReceber = [];
					$scope.data.ordensPagamento = [];
				} else {
					$scope.data.rebimentoSelecionado = recebimentoManual;
					var debitosPromise = ReceitaService.getDebitosPorRecebimento(recebimentoManual.id);
					var saldosReceberPromise = ReceitaService.getSaldoAReceberPorRecebimento(recebimentoManual.id);
					var ordensPagamentoPromise = ReceitaService.getOrdensPagamentoPorRecebimento(recebimentoManual.id);
					let results = await Promise.all([debitosPromise, saldosReceberPromise, ordensPagamentoPromise]);
					$scope.data.debitos = results[0].data;
					$scope.data.saldosReceber = results[1].data;
					$scope.data.ordensPagamento = results[2].data;
					$scope.$digest();
				}
			} catch (e) {
				console.error(e);
				UtilsService.toastError();
			} finally {
				$('.loader').hide();
			}
		};

		let setNull = () => {
			$scope.data.debitos = {};
			$scope.data.SaldoReceber = {};
			$scope.data.ordensPagamento = {};
			$scope.data.rebimentoSelecionado = null;
			$scope.data.recebimentosManuais = [];
		}

		$scope.buscaRecebimentos = async(search) => {
			try {
				$('.loader').show();
				setNull();
				search = JSON.parse(JSON.stringify(search || $scope.search));
				if (search.tipo == "nosso_numero" && !search.numero) return;
				if (search.tipo == "nosso_numero_origem" && !search.numero) return;
				/*if (search.quadra) search.quadra = ("0" + search.quadra).slice(-2);
				if (search.lote) search.lote = ("0" + search.lote).slice(-2);*/
				let result = await ReceitaService.getRecebimentosManuais(search);
				if (result.data.data.length === 0)
					UtilsService.toastInfo('Nenhum resultado encontrado');
				else
					$scope.data.recebimentosManuais = result.data.data;
				$scope.$digest();
			} catch (e) {
				UtilsService.toastError(e.data.message || e);
			} finally {
				$('.loader').hide();
			}
		};

		$scope.showProvisionarTituloModal = function (ordemPagamento) {
			$scope.data.provisionarTitulo = {
				id_parcela: ordemPagamento.id,
				id_configuracao_carteira: _.first($scope.data.carteirasDisponiveis).id_carteira_conta,
				id_layout_remessa: _.first($scope.data.layoutArquivos).id,
				data_vencimento: new Date().toLocaleDateString('pt-BR'),
				data_vencimento_origem: ordemPagamento.data_vencimento_origem,
				com_correcao: false,
				mais_lancamentos: false,
				data_correcao: new Date().toLocaleDateString('pt-BR'),
				valor_desconto: 0,
				valor_correcao: 0,
				valor_juridico: 0,
				valor_abatimento: 0,
				valor_total: ordemPagamento.valor,
				valor_origem: ordemPagamento.valor_origem
			};
			$('#provisionarTitulo').modal('show');
		};

		$scope.calcJurosMulta = function (id_boleto, data_vencimento_origem, data_correcao, tela, valor_titulo) {
			$('#calculando').show();
			$scope.data.calcDiv = true;
			let data_vencimento_format = $filter('formatOtherDate')('dd/mm/yyyy', data_correcao);
			var dados = {
				'id_boleto': id_boleto,
				'vencimento_origem': data_vencimento_origem,
				'vencimento_correcao': data_vencimento_format
			};
			ReceitaService.calculaCorrecoesBoleto(dados).then(function (result) {
				if (tela == 'Atualizar') {
					$scope.data.provisionarTitulo.juros = result.juros;
					$scope.data.provisionarTitulo.multa = result.multa;
					$scope.atualizaValorTotal();
				} else if (tela == 'Receber') {
					$scope.data.recebimentoTitulo.valor_juros = result.juros;
					$scope.data.recebimentoTitulo.valor_multa = result.multa;
					$scope.atualizaValorReceber();
				}
			}).finally(() => $('#calculando').hide());
		};

        $scope.atualizaBoleto = async () => {
            try {
                if (!$scope.accessPagina.editar) {
                    throw 'ERRO.<br>Você não tem permissões para atualizar esse título!'
                }
                $('#loadingAtualizarTitulo').modal('show');
                let result = await ReceitaService.atualizaBoleto($scope.data.provisionarTitulo);
                //resetando os dados que tinham sido selecionados
                $scope.data.rebimentoSelecionado = {};
                $scope.data.debitos = [];
                $scope.data.saldosReceber = [];
                $scope.data.ordensPagamento = [];
                $scope.buscaRecebimentos();
                UtilsService.openSuccessAlert(result.data);
            } catch (e) {
                UtilsService.toastError(e.responseJSON && e.responseJSON.message || e);
            } finally {
                $('#provisionarTitulo').modal('hide');
                $('#loadingAtualizarTitulo').modal('hide');
            }
        };

		$scope.enviaEmail = async(recebimentoId) => {
			try {
				$('.loader').show();
				let result = await ReceitaService.recebimentoManualEviaEmail(recebimentoId);
				UtilsService.toastSuccess(result.data);
			} catch (e) {
				console.error(e);
				UtilsService.toastError(e.responseJSON && e.responseJSON.message);
			} finally {
				$('.loader').hide();
			}
		}

		$scope.downloadRemessa = function (recebimentoId) {
			ReceitaService.downloadRemessaRecebimentoManual(recebimentoId);
		}

		$scope.gerarBoleto = function (recebimentoId) {
            $('#loadingPdf').modal('show');
			// window.open(config.apiUrl + 'api/recebimento/manual/visualizar_boleto/' + recebimentoId, '_blank');
            let prom;
            prom = $http.get(`${config.apiUrl}api/recebimento/manual/visualizar_boleto/` + recebimentoId, {
                responseType: 'arraybuffer'
            });
            prom.then(
                function success(response) {
                    let blob = new Blob([response.data], {
                        type: 'application/pdf'
                    });

                    $('#showPdf').modal('show');
                    $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);

                }, function error(e) {
                    UtilsService.toastError(e || 'Não foi encontrado nenhum resultado!');

                }
            ).catch( (e) => {
            	console.log(e);
			}).finally( () => {
                $('#loadingPdf').modal('hide');
			})
		};

		$scope.openReceberTitulo = function (ordemPagamento) {
			// data_correcao = new Date().toLocaleDateString('pt-BR')
			// let data_vencimento_format = $filter('formatOtherDate')('dd/mm/yyyy', data_correcao);
			this.calcJurosMulta(ordemPagamento.id, ordemPagamento.data_vencimento_origem, $filter('date')(new Date().toLocaleDateString('pt-BR'), "yyyy-MM-dd"), 'Receber', ordemPagamento.valor_origem);
			$scope.data.recebimentoTitulo = {
				id_titulo: ordemPagamento.id,
				valor_titulo: ordemPagamento.valor_origem,
				valor_pago: 0,
				data_pagamento: new Date().toLocaleDateString('pt-BR'),
				data_compensacao: new Date().toLocaleDateString('pt-BR'),
				observacao: '',
				data_vencimento_origem: ordemPagamento.data_vencimento_origem,
				received: (ordemPagamento.situacao == 'Compensado') ? 1 : 0,
				valor_juridico: 0,
				valor_correcao: 0,
				valor_desconto: 0,
				valor_abatimento: 0
			};
			$('#receberTitulo').modal('show');
		}

		$scope.closeReceberTitulo = function () {
			$('#receberTitulo').modal('hide');
		}

        $scope.receberTitulo = async () => {
            try {
                if (!$scope.accessPagina.inserir) {
                    throw 'Você não tem permissão para receber esse título!';
                }
                //Verifica se já foi recebido uma vez, pois caso tenha é necessario concordar
                if ($scope.data.recebimentoTitulo.received && !$scope.data.recebimentoTitulo.i_agree) {
                    throw 'Necessário concordar o recebimento';
                }
                if ($scope.data.recebimentoTitulo.valor_pago <= 0) {
                    throw 'O valor Pago não foi definido';
                }
                let isConfirmed = false;
                if ($scope.data.recebimentoTitulo.valor_pago !== parseFloat($scope.data.recebimentoTitulo.valor_receber.toFixed(2), 2)) {
                    isConfirmed = await UtilsService.confirmAlert3('Receber título', 'Deseja realmente receber este título com valor divergente?', 'Cancelar', 'Sim', true, true);
                } else {
                    isConfirmed = await UtilsService.confirmAlert3('Receber título', 'Confirmar o recebimento', 'Cancelar', 'Sim', true, true);
                }

				if (!isConfirmed) return;
				$('.loader').show();
				let result = await ReceitaService.receberTitulo($scope.data.recebimentoTitulo);
				UtilsService.toastSuccess(result.data);
				$scope.buscaRecebimentos();
				$scope.closeReceberTitulo();

				if ($scope.data.recebimentoTitulo.valor_pago > parseFloat($scope.data.recebimentoTitulo.valor_receber.toFixed(2), 2)) {
					let isConfirmed = await UtilsService.confirmAlert3('Recebimento a maior', 'Gerar um desconto futuro?', 'Não', 'Sim', true, true);
					if (isConfirmed) {
						$scope.data.preLancamento.desconto = 1;
						$scope.data.preLancamento.id_titulo = $scope.data.recebimentoTitulo.id_titulo;
						$scope.data.preLancamento.valor = $scope.data.recebimentoTitulo.valor_pago - $scope.data.recebimentoTitulo.valor_receber;
						UtilsService.toastSuccess('ok');
						$('#preLancamento').modal('show');
					} else {
						$scope.buscaRecebimentos();
					}
				} else if ($scope.data.recebimentoTitulo.valor_pago < parseFloat($scope.data.recebimentoTitulo.valor_receber.toFixed(2), 2)) {
					let isConfirmed = await UtilsService.confirmAlert3('Recebimento a menor', 'Gerar um lançamento a receber futuro?', 'Não', 'Sim', true, true);
					if (isConfirmed) {
						$scope.data.preLancamento.desconto = 0;
						$scope.data.preLancamento.id_titulo = $scope.data.recebimentoTitulo.id_titulo;
						$scope.data.preLancamento.valor = $scope.data.recebimentoTitulo.valor_receber - $scope.data.recebimentoTitulo.valor_pago;
						$('#preLancamento').modal('show');
						UtilsService.toastSuccess('ok');
					} else {
						$scope.buscaRecebimentos();
					}
				} else {
					$scope.buscaRecebimentos();
				}
			} catch (e) {
				console.error(e);
				UtilsService.toastError(e.responseJSON && e.responseJSON.message || e);
			}
		}

		$scope.cancelarTitulo = function (tituloId) {
			ReceitaService.cancelarTitulo(tituloId).then(function (result) {
				UtilsService.openSuccessAlert(result.data);
			}).catch(function (error) {
				UtilsService.openAlert(error.responseJSON.message);
			});
		}

		$scope.isAcoes = function (x, c = null) {
			if (!x) return;
			let sit = x.situacao.toLowerCase();
            let isCompensado = (!c) ? sit === 'compensado' : false;
			let isCancelado = sit === 'cancelado';
			let isNegociado = sit === 'negociado';
			return isCompensado || isCancelado || isNegociado;
		}

		$scope.preLancamento = async() => {
			try {
				if (!$scope.data.preLancamento.mes) {
					throw 'Selecione um mês';
				}
				$('#preLancamento').modal('hide');
				$('#loadingAtualizarTitulo').modal('show');
				let result = await ReceitaService.programarPreLancamento($scope.data.preLancamento);
				$scope.buscaRecebimentos();
				UtilsService.openSuccessAlert(result.data);
				$('#loadingAtualizarTitulo').modal('hide');
			} catch (e) {
				console.error(e);
				UtilsService.openErrorMsg(e || 'Erro');
			}
		}

		$scope.openDetalhes = function (ordemPagamento) {
			$scope.data.detalhePagamento = ordemPagamento;
			$('#demonstrativo').modal('show');
		}

		$scope.closeModalDemonstrativo = function () {
			$('#demonstrativo').modal('hide');
		}
		$scope.atualizaValorReceber = function () {
			var v_titulo = $scope.data.recebimentoTitulo.valor_titulo ? $scope.data.recebimentoTitulo.valor_titulo : 0;
			var v_juros = $scope.data.recebimentoTitulo.valor_juros ? $scope.data.recebimentoTitulo.valor_juros :0;
			var v_multa = $scope.data.recebimentoTitulo.valor_multa? $scope.data.recebimentoTitulo.valor_multa :0;
			var v_juridico = $scope.data.recebimentoTitulo.valor_juridico? $scope.data.recebimentoTitulo.valor_juridico:0;
			var v_correcao = $scope.data.recebimentoTitulo.valor_correcao? $scope.data.recebimentoTitulo.valor_correcao :0;
			var v_desconto = $scope.data.recebimentoTitulo.valor_desconto? $scope.data.recebimentoTitulo.valor_desconto :0;
			var v_abatimento = $scope.data.recebimentoTitulo.valor_abatimento? $scope.data.recebimentoTitulo.valor_abatimento :0;
			$scope.data.recebimentoTitulo.valor_receber = ((v_titulo + v_juros + v_multa + v_juridico + v_correcao) - (v_desconto + v_abatimento));
			// $scope.data.recebimentoTitulo.valor_receber = (($scope.data.recebimentoTitulo.valor_titulo + $scope.ata.recebimentoTitulo.valor_juros + $scope.data.recebimentoTitulo.valor_multa + $scope.data.recebimentoTitulo.valor_juridico + $scope.data.recebimentoTitulo.valor_correcao) - ($scope.data.recebimentoTitulo.valor_desconto + $scope.data.recebimentoTitulo.valor_abatimento));
		}

		$scope.atualizaValorTotal = function () {
			var v_titulo = $scope.data.provisionarTitulo.valor_origem? $scope.data.provisionarTitulo.valor_origem:0;
			var v_juros = $scope.data.provisionarTitulo.juros? $scope.data.provisionarTitulo.juros:0;
			var v_multa = $scope.data.provisionarTitulo.multa? $scope.data.provisionarTitulo.multa:0;
			var v_juridico = $scope.data.provisionarTitulo.valor_juridico? $scope.data.provisionarTitulo.valor_juridico:0;
			var v_correcao = $scope.data.provisionarTitulo.valor_correcao? $scope.data.provisionarTitulo.valor_correcao:0;
			var v_desconto = $scope.data.provisionarTitulo.valor_desconto? $scope.data.provisionarTitulo.valor_desconto:0;
			var v_abatimento = $scope.data.provisionarTitulo.valor_abatimento? $scope.data.provisionarTitulo.valor_abatimento:0;
			$scope.data.provisionarTitulo.valor_total = ((v_titulo + v_juros + v_multa + v_juridico + v_correcao) - (v_desconto + v_abatimento));
		}
	}
)