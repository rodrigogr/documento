'use strict';
angular.module('ContasPagarModule').controller('ContasPagarCtrl',
    function ($scope, $http, $state, config, LancamentoService, UtilsService, ContasPagarService,
              BioacessoService, ConfiguracaoService, BancoService, TipoDocumentoService, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Despesas', 'Contas a pagar');
        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                if ($state.params.compras) {
                    await $scope.pesquisar(); //para trazer a listagem dos lancamentos normais
                    let pedido = (await $http.get(`${config.apiUrl}api/pedidos/${$state.params.id}`)).data.data;
                    if (pedido.status === 'Compra aprovada') {
                        setPedido(pedido);
                    }
                    $scope.$digest();
                } else {
                    await $scope.pesquisar();
                }
                await Promise.all(basicData);
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide();
            }
        };

        let setPedido = (data) => {
            let contaPagar = {};
            contaPagar.descricao = data.descricao;
            contaPagar.id_fornecedor = data.fornecedores.find(x => x.status === 'Aprovado').idfornecedor;
            contaPagar.valor = data.fornecedores.find(x => x.status === 'Aprovado').valorTotalCalculado;
            $scope.createContasPagar(contaPagar);
        };

        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        let basicData = [
            LancamentoService.getAllTipoLancamentos()
                .then(result => {
                    $scope.allPlanoContas = result.data.filter(x => x.fluxo === 'DESPESA');
                    $scope.planoContas = result.data.filter(x => x.fluxo === 'DESPESA');
                }),
            BioacessoService.getAllFornecedor().then(result => $scope.fornecedores = result.data),
            ConfiguracaoService.getAllDepartamentos().then(result => $scope.departamentos = result.data),
            BancoService.getAllContasBancarias().then(result => $scope.contasBancarias = result.data),
            ConfiguracaoService.getAllLocalidades().then(result => $scope.localidades = result.data),
            TipoDocumentoService.getAllTiposDocumento().then(result => $scope.tipoDocumento = result.data),
            LancamentoService.getGruposLancamentosTipo('DESPESA').then(result => $scope.grupoLancamentos = result.data),
            AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data)
        ];

        let modelViewContasPagar = (data) => {
            data.forEach(x => {
                x.l_fornecedor = $scope.getNameFornecedor(x);
                x.l_planoConta = $scope.getNamePlanoConta(x);
                x.l_valorTotal = x.valor + $scope.getTotalAcrescimosConta(x.acrescimos);
                x.data_base = UtilsService.toDate(x.data_base);
                x.parcelas.forEach(y => {
                    y.data_base = UtilsService.toDate(y.data_base)
                    y.data_pagamento = UtilsService.toDate(y.data_pagamento)
                    y.data_compensacao = UtilsService.toDate(y.data_compensacao)
                })
            });
            return data;
        };

        $scope.data = {
            showPesquisa: true,
            acao: null,
            stepStatus: 1,
            valorEntrada: 0,
            numeroParcelas: 0,
            dataPrimeiraParcela: null,
            tiposOperacoes: ['Débito', 'Provisão', 'Cancelado'],
            tiposPagamentosIni: ['À Vista', 'Depósito', 'Boleto', 'Cheque', 'DOC', 'TED'],
            tiposPagamentos: ['Dinheiro', 'Depósito', 'Boleto', 'Cheque', 'DOC', 'TED'],
            tipoLancamentoTaxa: '',
            valorTaxa: 0,
            contaPagarSelecionado: {
                descricao: "",
                id_tipo_lancamento: null,
                id_fornecedor: null,
                mes_competencia: null,
                ano_competencia: 2017,
                valor: 0,
                numero_nf: null,
                data_emissao_nf: "",
                id_localizacao: null,
                id_departamento: null,
                observacao: "",
                acrescimos: [],
                parcelas: []
            },
            parcelasSelecionado: [],
            acrescimosSelecionado: [],
            parcelaObj: {
                nome: "",
                id_conta_bancaria: "",
                data_base: new Date(),
                valor_pago: 0,
                tipo_operacao: "",
                forma_pagamento: "",
                data_compensacao: "",
                data_pagamento: "",
                valor_abatimento: 0,
                numero_comprovante: "",
                deleted: 0
            },
            acrescimoObj: {
                valor: 0,
                descricao: "",
                id_tipo_lancamento: "",
                id_grupo_lancamento: "",
                incluir_soma: false,
                deleted: 0
            },
            saldos: {
                saldoPagar: 0,
                valorPago: 0,
                valorTotal: 0,
                valorProvisionado: 0
            },
            meses: [
                {
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
        };

		$scope.pesquisar = async (srch) => {
			try {
				$('.loader').show();
				$scope.create = true;
				if (srch && srch !== "" && srch.type === 'vencidas')
					await $scope.updateList(1, true);
				else
					await $scope.updateList(1);
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (lancamentoContasPagar) {
			$scope.data.deleteContasPagar = lancamentoContasPagar;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		let canDelLanCtPg = true;
		$scope.deleteLancamentoContasPagar = async () => {
			try {
				$('.loader').show();
				if (!canDelLanCtPg) return;
				canDelLanCtPg = false;
				let result = await ContasPagarService.deleteContasPagar($scope.data.deleteContasPagar);
				await $scope.updateContasPagar();
				UtilsService.openSuccessAlert(result.data);
			} catch (e) {
				console.error(e);
				UtilsService.openAlertAtencao(e.responseJSON.message);
			} finally {
				$scope.closeDeleteModal();
				canDelLanCtPg = true;
				$('.loader').hide();
			}
		}

		$scope.updateContasPagar = function () {
			ContasPagarService.getAllContasPagar().then(function (result) {
				$scope.contasPagar = modelViewContasPagar(result.data);
			});
		};

		$scope.saveContasPagar = async function () {
			angular.forEach($scope.data.parcelasSelecionado, function (itm) {
				if (!itm.data_base) {
					UtilsService.openErrorMsg('Todas parcelas devem conter "Data de Vencimento"');
				}
			});

			if (!$scope.data.contaPagarSelecionado.id) {
                let contaPagarSelecionado = JSON.parse(JSON.stringify($scope.data.contaPagarSelecionado));
                if ($state.params.compras) contaPagarSelecionado.idCompra = $state.params.id;
                let parcelasSelecionado = JSON.parse(JSON.stringify($scope.data.parcelasSelecionado));
                let acrescimosSelecionado = JSON.parse(JSON.stringify($scope.data.acrescimosSelecionado || {}));
				contaPagarSelecionado.parcelas = parcelasSelecionado;
				contaPagarSelecionado.acrescimos = acrescimosSelecionado;
				await ContasPagarService.saveContasPagar(contaPagarSelecionado).then(result => {
					UtilsService.openSuccessAlert(result.data);
                    $scope.updateContasPagar();
                    $('#novasContasParaPagar').modal('hide');
				}).catch(function (error) {
				    if (error.responseJSON.message.descricao) {
				        var txt_resp = '';
                        angular.forEach(error.responseJSON.message.descricao, function (resp) {
                            txt_resp += resp+"<br>";
                        });
                        UtilsService.openAlertAtencao(txt_resp);
                    } else {
                        UtilsService.openAlert(error.responseJSON.message);
                    }
				});
			} else {
                $scope.data.contaPagarSelecionado.data_base = UtilsService.utcToDate($scope.data.contaPagarSelecionado.data_base);
                $scope.data.contaPagarSelecionado.data_emissao_nf = UtilsService.utcToDate($scope.data.contaPagarSelecionado.data_emissao_nf);
                angular.forEach($scope.data.parcelasSelecionado, function (itm) {
                    itm.data_base = UtilsService.utcToDate(itm.data_base);
                    itm.data_pagamento = UtilsService.utcToDate(itm.data_pagamento);
                    itm.data_compensacao = UtilsService.utcToDate(itm.data_compensacao);
                });
                $scope.data.contaPagarSelecionado.valor = $scope.data.saldos.valorTotal;
				await ContasPagarService.editContasPagar($scope.data.contaPagarSelecionado, $scope.data.parcelasSelecionado, $scope.data.acrescimosSelecionado)
                    .then(result => {
                        $scope.updateContasPagar();
                        UtilsService.toastSuccess(result.data);
                        $('#novasContasParaPagar').modal('hide');
                    })
                    .catch(function (error) {
                        console.log(error);
                        UtilsService.toastError(error.responseJSON.message);
                    });
			}
			if ($state.params.compras) {
				$('.fade').hide();
                sessionStorage.setItem("menu","compras");
				$state.go('ComprasPedido');
            }
		};

		$scope.createContasPagar = function (dados = null) {
            $scope.dateNow = new Date();
			$scope.data.acao = 'novo';
			$scope.data.saldos = {
				saldoPagar: 0,
				valorPago: 0,
				valorTotal: 0,
				valorProvisionado: 0
			};
			$scope.data.valorEntrada = 0;
			$scope.data.numeroParcelas = 0;
			$scope.data.dataPrimeiraParcela = null;
			$scope.data.acrescimoObj = {
				valor: 0,
				descricao: "",
				id_tipo_lancamento: "",
				incluir_soma: false,
				deleted: 0
			};
			$scope.data.contaPagarSelecionado = {
				descricao: (dados !== null && dados.descricao) ? dados.descricao : "",
				id_tipo_lancamento: null,
				id_fornecedor: (dados !== null && dados.id_fornecedor) ? dados.id_fornecedor : null,
				mes_competencia: $scope.dateNow.getMonth() + 1,
				ano_competencia: new Date().getFullYear(),
				data_base: new Date(),
				valor: (dados !== null && dados.valor) ? dados.valor : 0,
                id_tipo_documento: null,
				numero_nf: null,
				data_emissao_nf: "",
				id_localizacao: _.first($scope.localidades).id,
				id_departamento: _.first($scope.departamentos).id,
				observacao: "",
				parcelas: []
			};
			$scope.data.grupoCPSelecionado = [];
			$scope.data.parcelasSelecionado = [];
			$scope.data.acrescimosSelecionado = [];
			$scope.data.stepStatus = 1;
			$('#novasContasParaPagar').modal('show');
			$scope.atualizaSaldos();
		};

		$scope.editarContaPagar = async function (idConta) {
            let editContaPagar = {};
		    editContaPagar = (await $http.get(`${config.apiUrl}api/lancamento_agendar/`+idConta)).data.data;
            $scope.data.acao = $state.params.compras ? 'novo' : 'editar';
			let grpLan = JSON.parse(JSON.stringify($scope.grupoLancamentos));
			if (editContaPagar.tipo_lancamento) {
				$scope.data.grupoCPSelecionado = grpLan.filter(x => x.id === editContaPagar.tipo_lancamento.idgrupo_lancamento)[0];
				$scope.filterPC(editContaPagar.tipo_lancamento.idgrupo_lancamento);
			}
            $scope.data.contaPagarSelecionado = {};
			$scope.data.contaPagarSelecionado = {
				id: editContaPagar.id,
				descricao: editContaPagar.descricao,
				id_tipo_lancamento: editContaPagar.id_tipo_lancamento,
				id_fornecedor: editContaPagar.id_fornecedor,
				mes_competencia: editContaPagar.mes_competencia && editContaPagar.mes_competencia.toString(),
				ano_competencia: editContaPagar.ano_competencia,
				data_base: UtilsService.toDate(editContaPagar.data_base),
				valor: editContaPagar.valor,
                id_tipo_documento: null,
				numero_nf: editContaPagar.numero_nf,
				data_emissao_nf: UtilsService.toDate(editContaPagar.data_emissao_nf),
				id_localizacao: editContaPagar.id_localizacao,
				id_departamento: editContaPagar.id_departamento,
				observacao: editContaPagar.observacao,
				parcelas: []
			};
            $scope.data.parcelasSelecionado = editContaPagar.parcelas;
            angular.forEach($scope.data.parcelasSelecionado, function (itm) {
                itm.edit = itm.data_pagamento ? false : true;
                itm.data_base = UtilsService.toDate(itm.data_base);
                if (itm.data_pagamento) itm.data_pagamento = UtilsService.toDate(itm.data_pagamento);
                if (itm.data_compensacao) itm.data_compensacao = UtilsService.toDate(itm.data_compensacao);
            });
            $scope.data.acrescimosSelecionado = [];
            $scope.data.acrescimosSelecionado = editContaPagar.acrescimos;
            $scope.data.parcelasDelete = [];
			$scope.data.stepStatus = 1;
			$('#novasContasParaPagar').modal('show');
			$scope.atualizaSaldos();
			$scope.$digest();
		};

		$scope.atualizaSaldos = function () {
			var somaAcrescimos = 0;
			var somaDebitosParcelas = 0;
			var somaProvisionados = 0;
			angular.forEach($scope.data.acrescimosSelecionado, function (itm) {
				if ((itm.incluir_soma) && (!itm.deleted)) {
					somaAcrescimos += itm.valor;
				}
			});
			if ($scope.data.parcelasSelecionado && $scope.data.parcelasSelecionado.length > 0) {
				angular.forEach($scope.data.parcelasSelecionado, function (itm) {
					if (!itm.deleted) {
						if (itm.tipo_operacao == 'Débito') {
							somaDebitosParcelas += itm.valor_pago;
						}
					}
				});
				$scope.data.valorEntrada = somaDebitosParcelas;
				angular.forEach($scope.data.parcelasSelecionado, function (itm) {
					if (!itm.deleted) {
						if (itm.tipo_operacao !== 'Débito')
							somaProvisionados += itm.valor_pago;
					}
				});
			}
			if ($scope.data.parcelasSelecionado && $scope.data.parcelasSelecionado.length === 0) {
				somaDebitosParcelas = $scope.data.valorEntrada;
				somaProvisionados = 0;
				$scope.data.saldos.saldoPagar = ($scope.data.contaPagarSelecionado.valor + somaAcrescimos);
			}
			$scope.data.saldos.valorProvisionado = _.ceil(somaProvisionados, 2);
			$scope.data.saldos.valorPago = $scope.data.valorEntrada;
			if ($scope.data.parcelasSelecionado && $scope.data.parcelasSelecionado.length === 0) {
				$scope.data.saldos.saldoPagar = ($scope.data.contaPagarSelecionado.valor + somaAcrescimos);
			} else {
				$scope.data.saldos.saldoPagar = (($scope.data.contaPagarSelecionado.valor + somaAcrescimos) - ($scope.data.valorEntrada + $scope.data.saldos.valorProvisionado));
			}
			$scope.data.saldos.valorTotal = ($scope.data.contaPagarSelecionado.valor + somaAcrescimos);
		};

		$scope.getTotalAcrescimosConta = function (acrescimos) {
			var somaAcrescimos = 0;
			angular.forEach(
				acrescimos,
				function (itm) {
					if ((itm.incluir_soma) && (!itm.deleted)) {
						somaAcrescimos += itm.valor;
					}
				}
			);
			return somaAcrescimos;
		};

		$scope.getNamePlanoConta = function (contaPagar) {
			var planoConta = _.find($scope.allPlanoContas, {
				id: contaPagar.id_tipo_lancamento
			});
			return planoConta ? planoConta.descricao : '';
		};

		$scope.getNameLocalidade = function (contaPagar) {
			var localidade = _.find($scope.localidades, {
				id: contaPagar.id_localizacao
			});
			return localidade ? localidade.descricao : '';
		};

		$scope.getNameFornecedor = function (contaPagar) {
			var fornecedor = _.find($scope.fornecedores, {
				id: contaPagar.id_fornecedor
			});
			return fornecedor ? fornecedor.nome_fantasia : '';
		};

		$scope.getNameDepartamento = function (contaPagar) {
			var departamento = _.find($scope.departamentos, {
				id: contaPagar.id_departamento
			});
			return departamento ? departamento.descricao : '';
		};

		$scope.getNameContaBancaria = function (parcela) {
			var contaBancaria = _.find($scope.contasBancarias, {
				id_conta_bancaria: parcela.id_conta_bancaria
			});
			return contaBancaria ? contaBancaria.descricao : '';
		};

		$scope.nextStep = function () {
			$('.ba__modal-body-tipo-lancamento').scrollTop(0);
			if ($scope.data.stepStatus == 4 && validaParcelasPasso4() != '') {
				UtilsService.openAlertAtencao(validaParcelasPasso4());
			} else {
				$scope.atualizaSaldos();
				$scope.data.stepStatus = $scope.data.stepStatus + 1;
			}
		};

		$scope.previousStep = function () {
			$('.ba__modal-body-tipo-lancamento').scrollTop(0);
			$scope.data.stepStatus = $scope.data.stepStatus - 1;
			$scope.atualizaSaldos();
		};

		function validaParcelasPasso4() {
            let mensagem = '';
		    if (($scope.data.saldos.valorProvisionado + $scope.data.saldos.valorPago) !== $scope.data.saldos.valorTotal) {
		        mensagem = 'Existe <b>Saldo a pagar</b> para ser incluído!<br>Verifique por favor. ';
		        return mensagem;
            }
			for (var i = 0; i < $scope.data.parcelasSelecionado.length; i++) {
				if (($scope.data.parcelasSelecionado[i].tipo_operacao === 'Débito') && ($scope.data.parcelasSelecionado[i].data_pagamento === '')) {
					mensagem = 'Operação de débito da ' + (i + 1) + 'º parcela nao possui data de pagamento.'
				}
			}
			return mensagem;
		}

		$scope.closeContasPagarModal = function () {
			$('#novasContasParaPagar').modal('hide');
		};

		$scope.adicionarTaxa = function () {
			$scope.data.acrescimosSelecionado.push(_.clone($scope.data.acrescimoObj));
			$scope.data.acrescimoObj.incluir_soma = false;
			$scope.data.acrescimoObj.id_tipo_lancamento = null;
			$scope.data.acrescimoObj.valor = 0;
			$scope.data.acrescimoObj.deleted = 0;
			$scope.data.acrescimoObj.id_grupo_lancamento = null;
			$scope.atualizaSaldos();
		};

		$scope.excluirTaxa = function (index) {
			if (!$scope.data.acrescimosSelecionado[index].id) {
				$scope.data.acrescimosSelecionado.splice(index, 1);
			} else {
				$scope.data.acrescimosSelecionado[index].deleted = 1;
			}
			$scope.atualizaSaldos();
		};

		$scope.gerarParcelas = function () {
			$scope.data.parcelasSelecionado = [];
			$scope.atualizaSaldos();
			var valorParcela = ($scope.data.saldos.valorTotal - $scope.data.valorEntrada) / $scope.data.numeroParcelas;
			var now = new Date();
			var dataPrimeiraParcela = new Date($scope.data.dataPrimeiraParcela);
			if ($scope.data.valorEntrada >= $scope.data.saldos.valorTotal) {
				$scope.data.numeroParcelas = 0;
			}
			if ($scope.data.valorEntrada > 0) {
				var entradaPagamento = _.clone($scope.data.parcelaObj);
                entradaPagamento.nome = ($scope.data.forma_pagamento === 'À Vista') ? 'À Vista - ': 'Entrada - ';
				entradaPagamento.valor_pago = $scope.data.valorEntrada;
				entradaPagamento.tipo_operacao = 'Débito';
				entradaPagamento.forma_pagamento = 'Dinheiro';
				entradaPagamento.data_pagamento = now;
				entradaPagamento.data_base = UtilsService.toDate(now);
				entradaPagamento.id_conta_bancaria = _.first($scope.contasBancarias).id_conta_bancaria;
				$scope.data.parcelasSelecionado.push(entradaPagamento);
			}
			for (var i = 0; i < $scope.data.numeroParcelas; i++) {
				var novaParcela = _.clone($scope.data.parcelaObj);
				var dt_venc = null;
				novaParcela.nome = $scope.data.numeroParcelas === 1 ? '' : 'Parcela ' + (i + 1)+' - ';
				novaParcela.valor_pago = valorParcela;
				novaParcela.tipo_operacao = 'Provisão';
				novaParcela.forma_pagamento = $scope.data.forma_pagamento;
				dt_venc = new Date(dataPrimeiraParcela.getTime() + (i * 30 * 86400000));
				novaParcela.data_base = UtilsService.toDate(dt_venc);
				novaParcela.id_conta_bancaria = _.first($scope.contasBancarias).id_conta_bancaria;
				//novaParcela.data_pagamento = new Date(dataPrimeiraParcela.getTime() + (i * 30 * 86400000)).toLocaleDateString();
				$scope.data.parcelasSelecionado.push(novaParcela);
			}
			$scope.atualizaSaldos();
		};

		$scope.changeTipoOperacao = function (index) {
			if (($scope.data.parcelasSelecionado[index].forma_pagamento == 'Boleto') ||
				($scope.data.parcelasSelecionado[index].forma_pagamento == 'Depósito') ||
				($scope.data.parcelasSelecionado[index].forma_pagamento == 'Cheque')) {
				$scope.data.parcelasSelecionado[index].tipo_operacao = 'Provisão';
				$scope.data.parcelasSelecionado[index].data_pagamento = '';
			} else {
				$scope.data.parcelasSelecionado[index].tipo_operacao = 'Débito';
			}
			$scope.atualizaSaldos();
		};

		$scope.getDemonstrativo = function (contasPagar) {
			window.open(config.apiUrl + 'api/lancamento_agendar/demonstrativo/' + contasPagar.id, '_blank');
		};

		$scope.validateField = function () {
			switch ($scope.data.stepStatus) {
				case 1:
					return (!$scope.data.contaPagarSelecionado.descricao) ||
						(!$scope.data.contaPagarSelecionado.id_tipo_lancamento) ||
						(!$scope.data.contaPagarSelecionado.id_fornecedor) ||
						(!$scope.data.contaPagarSelecionado.data_base) ||
						(!$scope.data.contaPagarSelecionado.mes_competencia) ||
						(!$scope.data.contaPagarSelecionado.ano_competencia) ||
						(!$scope.data.contaPagarSelecionado.valor) ||
						($scope.data.contaPagarSelecionado.valor <= 0);
				case 2:
					return (!$scope.data.contaPagarSelecionado.id_localizacao) || (!$scope.data.contaPagarSelecionado.id_departamento);
				case 4:
					return ($scope.data.saldos.saldoPagar > 0 && $scope.data.acao === 'novo');
			}
		};

		$scope.sort = (prop) => {
			if ($scope.prop == prop)
				$scope.reverse = !$scope.reverse;
			else {
				$scope.reverse = false;
				$scope.prop = prop;
			}
		};

		$scope.filterPC = (id) => $scope.planoContas = $scope.allPlanoContas.filter(x => x.idgrupo_lancamento === id);
		$scope.filterPC2 = (id) => $scope.planoContas2 = $scope.allPlanoContas.filter(x => x.idgrupo_lancamento === id);

		$scope.canEditAndDelete = (lanc) => {
			let retorno = true;
			lanc.parcelas.forEach(x => {
				if (x.tipo_operacao === 'Débito' && x.id) {
					retorno = false;
					return;
				}
			});
			return retorno;
		};
		$scope.canEditInput = (tipo) => {
			let retorno = false;
			if (tipo) {
				if (tipo === 'Débito') {
					retorno = true;
				}
			} else {
				if ($scope.data.acao === 'editar') {
					retorno = true;
				}
			}
			return retorno;
		};
		$scope.editTotal = (id) => {
		    if (id) {
		        let x = 0;
                angular.forEach($scope.data.parcelasSelecionado, function (itm) {
                    if (!itm.data_pagamento) {
                        x++;
                    }
                });
                return (x === 0);
            } else {
		        return false;
            }
		};
		$scope.checkData = (srch) => {
			let ini = new Date(srch.data_inicio);
			let fim = new Date(srch.data_fim);
			if (ini > fim) {
				UtilsService.toastError('A data final não pode ser menor que a inicial');
				return false;
			} else {
				return true;
			}
		};
		$scope.pesquisaChange = () => {
			if ($scope.search.type === 'vencidas') {
				$scope.data.showPesquisa = false;
			} else {
				$scope.data.showPesquisa = true;
			}
		};

		$scope.current_page = 1;
		$scope.updateList = async(page, vencidas) => {
			if ($scope.search) $scope.search.page = page;
			else $scope.search = {page: page};
			let srch = UtilsService.serializeQueryString($scope.search);
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = !vencidas ? await $http.get(`${config.apiUrl}api/lancamento_agendar?${srch}`) : await $http.get(`${config.apiUrl}api/lancamento_agendar/contas_vencidas?page=${page}`);
			$scope.contasPagar = modelViewContasPagar(result.data.data);
			$scope.current_page = result.data.current_page;
			$scope.total = result.data.total;
			$scope.per_page = result.data.per_page;
			$scope.pageCount = Math.ceil(result.data.total / result.data.per_page);
			let pageCount = $scope.pageCount;
			if (pageCount >= 6) {
				if (page > 3 && page < pageCount - 2)
					$scope.pages = [page - 2, page - 1, page, page + 1, page + 2];
				else if (page == pageCount - 1)
					$scope.pages = [page - 4, page - 3, page - 2, page - 1, page];
				else if (page <= 3)
					$scope.pages = [1, 2, 3, 4, 5];
			} else {
				$scope.pages = [];
				for (let i = 1; i <= pageCount; i++) {
					$scope.pages.push(i);
				}
			}
			$scope.$digest();
		}

		$scope.mudaFormaPgto = () => {
            if ($scope.data.forma_pagamento === 'À Vista') {
                $scope.data.valorEntrada = $scope.data.saldos.valorTotal;
                $("#entrada").attr('disabled','disabled');
            } else {
                $("#entrada").removeAttr('disabled');
                $("#entrada").val("");
                $scope.data.valorEntrada = 0;
            }

		};
		$scope.addParcela = () => {
            var dt_venc = new Date();
            var novaParcela = _.clone($scope.data.parcelaObj);
            novaParcela.nome = 'Parcela '+($scope.data.parcelasSelecionado.length + 1);
            novaParcela.valor_pago = '';
            novaParcela.tipo_operacao = 'Provisão';
            novaParcela.forma_pagamento = 'Boleto';
            novaParcela.data_base = UtilsService.toDate(dt_venc);
            novaParcela.id_conta_bancaria = _.first($scope.contasBancarias).id_conta_bancaria;
            novaParcela.edit = true;
            novaParcela.deleted = 0;
            $scope.data.parcelasSelecionado.push(novaParcela);
            let scrollFim = $(".ba__modal-body-tipo-lancamento")[0].scrollHeight + $(".parcelas")[0].scrollHeight;
            $(".ba__modal-body-tipo-lancamento").animate({ scrollTop: scrollFim}, 1000);
            //animation nova parcela
            $scope.newParcelaAnimation();
        };

        $scope.newParcelaAnimation = () => {
			$(function(){
				var parcelas = ($(".parcelas").each( function(i){}).length)-1;
				var div = $('.parcelas:eq('+parcelas+')');
                div.css("border","1px solid #4fbd48");
                $({alpha:1}).animate({alpha:0}, {
					duration: 3000,
					step: function(){
						div.css('border-color','rgba(28,185,9,'+this.alpha+')');
					}
				});
			});
        };
        $scope.removeParcela = (index) => {
            if (!$scope.data.parcelasSelecionado[index].id) {
                $scope.data.parcelasSelecionado.splice(index, 1);
            } else {
                $scope.data.parcelasSelecionado[index].deleted = 1;
            }
            $scope.atualizaSaldos();
        }
	}
);