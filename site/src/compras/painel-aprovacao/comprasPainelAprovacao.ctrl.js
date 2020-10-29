'use strict'
angular.module('ComprasModule').controller('PainelAprovacaoCtrl',
	function ($scope, UtilsService, PedidoService, UsuarioService, $timeout,
		AprovadorService, ProdutoService, EmpresaService, $state, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('compras', 'Painel de Aprovação');
		let produtos, usuarios, aprovadores;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

		$scope.ngOnInit = async() => {
			$('.loader').show();
			$scope.data.filtro = 'aguardando';
			$scope.updatePedidos(undefined);
            await $http.get(`${config.apiUrl}api/departamentos`)
                .then(result => $scope.data.departamentos = result.data.data);
			// await Promise.all(basicData);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
            $('.loader').hide();
		};

		/*let basicData = [
			UsuarioService.getAllUsuarios()
			.then(result => usuarios = result.data),
			AprovadorService.getAllAprovadores()
			.then(result => {
				aprovadores = result.data;
				listaUsuarios();
			}),
			ProdutoService.getAllProduto()
			.then(function (result) {
				produtos = result.data;
                $scope.data.allListaProdutos = produtos;
                $scope.data.listaProdutos = produtos.filter(x => x.produto.status == 1);
			}),
			EmpresaService.getAllEmpresas()
			.then(result => $scope.data.empresas = result.data)
		]*/

		$scope.data = {
			pedidos: [],
			deletePedido: null,
			pedidosCopy: [],
			descricaoSelecionado: "",
			pedidoSelecionado: {
				descricao: '',
				id: '',
				solicitado_id: '',
				expectativa_entrega: '',
				expectativa_valor: '',
				status: 'Pendente',
				itensRemovidos: [],
				listaItens: [],
				listaFornecedores: []
			},
			status: [{
					id: 'Pendente',
					nome: 'Pendente'
				},
				{
					id: 'Em Aberto',
					nome: 'Em Aberto'
				},
				{
					id: 'Em cotação',
					nome: 'Em cotação'
				},
				{
					id: 'Aprovação da compra',
					nome: 'Aprovação da compra'
				},
				{
					id: 'Compra aprovada',
					nome: 'Compra aprovada'
				},
				{
					id: 'Cancelado',
					nome: 'Cancelado'
				}
			],
			empresaSelecionadaNova: undefined,
			empresaSelecionada: undefined,
			listaProdutos: null,
			usuarios: [],
			itemSelecionado: {
				id: '',
				tipo_lancamento: '',
				idproduto: '',
				quantidade: ''
			},
			pedidocopy: undefined,
			listaEmpresasNovas: [],
			tipos: [{
					id: 'Produto',
					descricao: 'Produto'
				}
				// Desabilitado pois não exite cadastro de servico
				// {
				// 	id: 'Serviço',
				// 	descricao: 'Serviço'
				// }
			],
			errors: [],
            btnNome: '',
            filtro: ''
		};

		$scope.pesquisar = function () {
			let item = $scope.data.descricaoSelecionado.toLowerCase();
            if ($scope.data.descricaoSelecionado.length === 1) {
                return $scope.filtrarSolicitacao();
            } else if ($scope.data.descricaoSelecionado.length > 2) {
				$scope.data.pedidos = $scope.data.pedidosCopy.filter((x) => {
					let descricao = x.pedido.descricao.toLowerCase();
					let requerente = x.pedido.requerente.toLowerCase();
					return descricao.indexOf(item) > -1 || requerente.indexOf(item) > -1;
					// x.pedido.descricao.indexOf(item.toLowerCase()).toLowerCase() > -1 || x.pedido.requerente.indexOf(item.toLowerCase()).toLowerCase() > -1
                });
			}
		};

        $scope.filtrarSolicitacao = () => {
            let filtro;
            filtro = $scope.data.pedidosCopy.filter((x) => {
                if ($scope.data.filtro === 'aguardando')
                    return x.status === 'Solicitado' || x.status === 'Aprovação da compra';
                else if ($scope.data.filtro === 'aprovado')
                    return x.status !== 'Solicitado' && x.status !== 'Aprovação da compra' && x.status !== 'Cancelado';
                else if ($scope.data.filtro === 'cancelado')
                    return x.status === 'Cancelado';
                else
                    return x;
            });
            $scope.data.pedidos = filtro;
        };

		$scope.verificaValor = function () {
			if ($scope.data.itemSelecionado.quantidade === undefined) {
				$scope.data.itemSelecionado.quantidade = "";
				$scope.data.errors = [];
				UtilsService.toastError("O campo quantidade precisa ser pelo menos 1 unidade!");
			}
		};

		let listaUsuarios = () => {
			$scope.data.usuarios = [];
			angular.forEach(aprovadores, function (item) {
				if (item.aprovador.tipo === 'Solicitações e compras' || item.aprovador.tipo === 'Solicitações') {
					let exists = $scope.data.usuarios.find(x => x.id === item.usuario.id);
					if (exists === undefined) {
						let usuario = {
							id: item.usuario.id,
							nome: item.usuario.login
						};
						$scope.data.usuarios.push(usuario);
					}
				}
			});
		};

		$scope.closeModal = function () {
			$('#novoPedido').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

        $scope.closeNegarPedido = function () {
            $('#negarAlert').modal('hide');
        };

		$scope.showDeleteAlert = function (pedido) {
			$scope.data.deletePedido = pedido;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorPedido').modal('hide');
			$scope.data.errors = [];
		};

		$scope.deletePedidos = function () {
			PedidoService.deletePedidos($scope.data.deletePedido).then(function (data) {
				if (!data.errors) {
					$scope.updatePedidos(undefined);
					$scope.closeDeleteModal();
                    $('#emAberto').modal('hide');
					UtilsService.toastSuccess(data.message);
				} else {
					$scope.closeDeleteModal();
                    UtilsService.toastError(data.message);
				}
			});
		}

		function validaItem() {
			$scope.data.errors = [];
			if ($scope.data.itemSelecionado.tipo_lancamento === "") {
				$scope.data.errors.push({
					tipoLancamento: "Tipo de Lançamento é obrigatório!"
				});
			}
			if ($scope.data.itemSelecionado.idproduto === "") {
				$scope.data.errors.push({
					idproduto: "Produto é obrigatório!"
				});
			}
			if ($scope.data.itemSelecionado.quantidade === "" || $scope.data.itemSelecionado.quantidade === 0) {
				$scope.data.errors.push({
					quantidade: "Quantidade é obrigatório!"
				});
			}
		}

		$scope.adicionarItem = function () {
			validaItem();
			let exists = $scope.data.pedidoSelecionado.listaItens.find(x => x.idproduto === $scope.data.itemSelecionado.idproduto);
			if ($scope.data.errors.length === 0) {
				if (exists === undefined) {
					let produtoSelecionado = produtos.find(function (x) {
						return x.produto.id === parseInt($scope.data.itemSelecionado.idproduto);
					});
					$scope.data.pedidoSelecionado.listaItens.push({
						nome: produtoSelecionado.produto.descricao,
						id: 0,
						tipo: produtoSelecionado.unidade.descricao,
						idproduto: $scope.data.itemSelecionado.idproduto,
						tipo_lancamento: $scope.data.itemSelecionado.tipo_lancamento,
						quantidade: $scope.data.itemSelecionado.quantidade
					});
					limpaItensSelecionados();
				} else {
					UtilsService.toastError("Produto já selecionado!")
				}
			} else {
				angular.forEach($scope.data.errors, function (value, key) {
                    UtilsService.toastError(value);
                });
			}
		}

		$scope.updatePedidos = async(status, abrir) => {
			try {
				$('.loader').show();
				$scope.updateList($scope.current_page);
				if (status !== undefined && (status !== 'Cancelado' && status !== 'Pendente')) {
					// let pedido = $scope.data.pedidos.find(x => x.pedido.id === $scope.data.pedidoSelecionado.id);
					let dados = await $http.get(`${config.apiUrl}api/pedidos/${$scope.data.pedidoSelecionado.id}`);
					let pedido = {
						pedido: dados.data.data,
						itens: dados.data.data.items_pedido,
						fornecedores: dados.data.data.fornecedores
                    };
					pedido.continuacao = true;
					if (abrir) $scope.editPedido(pedido);
				}
				// $scope.$digest();
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		}

		let VMPedidos = (data) => {
			if (data && data.length) {
				data.forEach(x => {
					x.pedido.expectativa_entrega = UtilsService.toDate(x.pedido.expectativa_entrega);
				})

			}
			return data;
		}

		$scope.savePedido = async() => {
			try {
				if (!$scope.accessPagina.inserir) {
					throw 'Você não tem permissão para solicitar pedidos!';
					return false;
				}
				let errors = [];
				let dataAtual = new Date();
				if ($scope.data.pedidoSelecionado.listaItens.length === 0)
					errors.push({
						listaItens: "Pelo menos 1 Item de Pedido é necessário!"
					});
				$scope.data.pedidoSelecionado.expectativa_entrega.setHours(dataAtual.getHours());
				$scope.data.pedidoSelecionado.expectativa_entrega.setMinutes(dataAtual.getMinutes());
				$scope.data.pedidoSelecionado.expectativa_entrega.setSeconds(dataAtual.getSeconds());
				$scope.data.pedidoSelecionado.expectativa_entrega.setMilliseconds(dataAtual.getMilliseconds());
				if (dataAtual.getTime() > $scope.data.pedidoSelecionado.expectativa_entrega.getTime())
					errors.push({
						dataInferior: "Você não pode solicitar um pedido com Data Inferior a de Hoje!"
					});
				if (errors.length != 0) throw errors;
				if (!$scope.data.pedidoSelecionado.id)
					await PedidoService.savePedidos($scope.data.pedidoSelecionado);
				else
					await PedidoService.editPedidos($scope.data.pedidoSelecionado);
				$scope.updatePedidos(undefined);
				$('.modal').modal('hide');
			} catch (e) {
				$scope.data.errors = e;
                angular.forEach($scope.data.errors, function (value, key) {
                    UtilsService.toastError(key + ': ' + value);
                });
			}
		}

		$scope.excluirFornecedoCotacao = function (index, id) {
			if (id > 0) {
				$scope.data.pedidoSelecionado.listaExcluirFornecedor.push(id);
			}
			$scope.data.pedidoSelecionado.listaFornecedores.splice(index, 1);
		}

		$scope.adicionarEmpresaNova = function () {
			let exists = $scope.data.listaEmpresasNovas.find(x => x.id === parseInt($scope.data.empresaSelecionadaNova));
			let exists_cadastro = $scope.data.pedidoSelecionado.listaFornecedores.find(x => x.id === parseInt($scope.data.empresaSelecionadaNova));
			if ($scope.data.empresaSelecionadaNova !== undefined && $scope.data.empresaSelecionadaNova !== "") {
				if (exists === undefined && exists_cadastro === undefined) {
					let fornecedorSelecionado = $scope.data.empresas.find(x => x.id === parseInt($scope.data.empresaSelecionadaNova));
					$scope.data.listaEmpresasNovas.push(fornecedorSelecionado);
				} else {
					UtilsService.toastError("Fornecedor já selecionado!");
				}
			}
		}

		$scope.adicionarEmpresaCotacao = function () {
			if ($scope.data.listaEmpresasNovas.length > 0) {
				$scope.data.listaEmpresasNovas.forEach(function (item) {
					let fornecedorSelecionado = $scope.data.empresas.find(x => x.id === parseInt(item.id));
					fornecedorSelecionado["idfornecedorpedido"] = 0;
					fornecedorSelecionado["listaItens"] = [];
					fornecedorSelecionado["valorTotal"] = 0;
					fornecedorSelecionado["valorTotalCalculado"] = 0;
					fornecedorSelecionado["acrescimo"] = 0;
					fornecedorSelecionado["desconto"] = 0;
					fornecedorSelecionado["observacao"] = "";
					fornecedorSelecionado["status"] = "Aprovado";
					$scope.data.pedidocopy.itens.forEach(function (itemPedido) {
						let produtoSelecionado = produtos.find(function (x) {
							return x.produto.id === parseInt(itemPedido.idproduto);
						});
						fornecedorSelecionado.listaItens.push({
							nome: produtoSelecionado.produto.descricao,
							idItem: itemPedido.id,
							id: 0,
							idproduto: itemPedido.idproduto,
							tipo_lancamento: itemPedido.tipo_lancamento,
							quantidade: itemPedido.quantidade,
							quantidadeFornecedor: 0,
							valorUnitarioFornecedor: 0,
							valorTotal: 0
						});
					});
					$scope.data.pedidoSelecionado.listaFornecedores.push(fornecedorSelecionado);
				});
				$('#novoFornecedor').modal('hide');
			} else {
				UtilsService.toastError("É necesário selecionar ao menos um Fornecedor!");
			}
		}

		$scope.excluirEmpresaNova = function (index) {
			$scope.data.listaEmpresasNovas.splice(index, 1);
		}

		function limpaItensSelecionados() {
			$scope.data.itemSelecionado = {
				id: '',
				tipo_lancamento: 'Produto',
				idproduto: '',
				quantidade: ''
			};
		}

		$scope.removerItem = function (index, itemPedido) {
			if (itemPedido.id !== "") {
				$scope.data.pedidoSelecionado.itensRemovidos.push(itemPedido.id);
			}
			$scope.data.pedidoSelecionado.listaItens.splice(index, 1);
		}

		$scope.excluirFornecedor = function (index, fornecedor) {
			if (index !== undefined) {
				$scope.data.pedidoSelecionado.listaFornecedores.splice(index, 1);
			}
		}

		$scope.adicionarEmpresa = function () {
			if ($scope.data.empresaSelecionada !== undefined) {
				let exists = $scope.data.pedidoSelecionado.listaFornecedores.find(x => x.id === parseInt($scope.data.empresaSelecionada));
				if (exists === undefined) {
					let empresa = $scope.data.empresas.find(x => x.id === parseInt($scope.data.empresaSelecionada));
					$scope.data.pedidoSelecionado.listaFornecedores.push(empresa);
				} else {
					UtilsService.toastError("Fornecedor já selecionado!")
				}
			}
		}

		$scope.alterarValorTotal = function (item, fornecedor) {
			item.valorTotal = item.quantidadeFornecedor * item.valorUnitarioFornecedor;
			let valorTotal = 0;
			$scope.data.pedidoSelecionado.listaFornecedores.forEach(function (forn) {
				if (forn.id === fornecedor.id) {
					forn.listaItens.forEach(function (fornItem) {
						//if(item.id !== fornItem.id){
						valorTotal += parseFloat(fornItem.valorTotal);
						//}
					});
				}
			});
			fornecedor.valorTotal = valorTotal;
			fornecedor.valorTotalCalculado = (valorTotal + fornecedor.acrescimo) - fornecedor.desconto;
			$scope.alterarValorCalculado(fornecedor);
		}

		$scope.alterarValorCalculado = function (fornecedor) {
			if (fornecedor.acrescimo === null) {
				fornecedor.acrescimo = 0;
			}
			if (fornecedor.desconto === null) {
				fornecedor.desconto = 0;
			}
			fornecedor.valorTotalCalculado = (parseFloat(fornecedor.valorTotal) + parseFloat(fornecedor.acrescimo)) - parseFloat(fornecedor.desconto);
		};

		$scope.editPedido = function (pedido) {
			$scope.data.pedidocopy = pedido;
			$scope.data.pedidoSelecionado = {};
			limpaItensSelecionados();
			$scope.data.pedidoSelecionado.itensRemovidos = [];
            $scope.data.pedidoSelecionado.requerente = pedido.requerente;
            $scope.data.pedidoSelecionado.departamento = String(pedido.departamento);
            $scope.data.pedidoSelecionado.departamento_desc = $scope.data.departamentos.find( x => x.id === pedido.departamento);
			$scope.data.pedidoSelecionado.descricao = pedido.pedido.descricao;
			$scope.data.pedidoSelecionado.id = pedido.pedido.id;
            $scope.data.pedidoSelecionado.solicitado_id = pedido.pedido.solicitado_id.toString();
			$scope.data.pedidoSelecionado.solicitado = pedido.usuario_solicitacao;
			$scope.data.pedidoSelecionado.expectativa_entrega = new Date(pedido.pedido.expectativa_entrega);
			$scope.data.pedidoSelecionado.data_solicitacao = new Date(pedido.updated_at);
			$scope.data.pedidoSelecionado.expectativa_valor = pedido.pedido.expectativa_valor;
			$scope.data.pedidoSelecionado.status = pedido.pedido.status;
			$scope.data.pedidoSelecionado.motivo_negado = pedido.pedido.motivo_negado;
			$scope.data.pedidoSelecionado.movimentado = pedido.pedido.movimentado;
			$scope.data.pedidoSelecionado.listaFornecedores = [];
			$scope.data.pedidoSelecionado.listaItens = [];
			$scope.data.pedidoSelecionado.listaExcluirFornecedor = [];

            pedido.itens.forEach(function (item) {
                $scope.data.pedidoSelecionado.listaItens.push({
                    nome: item.produto.descricao,
                    id: item.id,
                    idproduto: item.idproduto,
                    tipo_lancamento: item.tipo_lancamento,
                    quantidade: item.quantidade
                });
            });

			pedido.fornecedores.forEach(function (item) {
				if (!item.hasOwnProperty("fornecedores")) {
					item["fornecedores"] = item;
				}

				let fornecedorSelecionado = {};
				fornecedorSelecionado["id"] = item.fornecedores.empresa.id;
				fornecedorSelecionado["nome_fantasia"] = item.fornecedores.empresa.nome_fantasia;
				fornecedorSelecionado["idfornecedorpedido"] = item.fornecedores.id;
				fornecedorSelecionado["listaItens"] = [];
				fornecedorSelecionado["valorTotal"] = item.fornecedores.valorTotal;
				fornecedorSelecionado["valorTotalCalculado"] = item.fornecedores.valorTotalCalculado === null ? 0 : item.fornecedores.valorTotalCalculado;
				fornecedorSelecionado["acrescimo"] = item.fornecedores.acrescimo === null ? 0 : item.fornecedores.acrescimo;
				fornecedorSelecionado["desconto"] = item.fornecedores.desconto === null ? 0 : item.fornecedores.desconto;
				fornecedorSelecionado["observacao"] = item.fornecedores.observacao;
				fornecedorSelecionado["status"] = item.fornecedores.status === null ? 'Não Aprovado' : item.fornecedores.status;
				if (item.item !== undefined && item.item.length > 0) {
					item.item.forEach(function (itemPedido) {
                        let produtoSelecionado = $scope.data.pedidoSelecionado.listaItens.find(function (x) {
                            return x.idproduto === parseInt(itemPedido.idproduto);
                        });
						let melhorPreco = true;
						if (pedido.fornecedores.length === 1) {
							melhorPreco = true;
						} else {
							let valor = itemPedido.item.valorTotal;
							pedido.fornecedores.forEach(function (itemFornMaior) {
								let lista = itemFornMaior.item.filter(x => x.idproduto === itemPedido.idproduto && x.item.id !== itemPedido.item.id);
								lista.forEach(function (itemPedidoMaior) {
									if (itemPedidoMaior.item.valorTotal < valor) {
										melhorPreco = false;
									}
								});
							});
						}
						fornecedorSelecionado.listaItens.push({
							nome: produtoSelecionado.nome,
							idproduto: itemPedido.idproduto,
							tipo_lancamento: itemPedido.tipo_lancamento,
							quantidade: itemPedido.quantidade,
							id: itemPedido.item.id,
							melhorPreco: melhorPreco,
							idItem: itemPedido.item.iditem,
							quantidadeFornecedor: itemPedido.item.quantidadeFornecedor,
							valorUnitarioFornecedor: itemPedido.item.valorUnitarioFornecedor,
							valorTotal: itemPedido.item.valorTotal
						});
					});
				} else {
					pedido.itens.forEach(function (itemPedido) {
                        let produtoSelecionado = $scope.data.pedidoSelecionado.listaItens.find(function (x) {
                            return x.idproduto === parseInt(itemPedido.idproduto);
                        });
						fornecedorSelecionado.listaItens.push({
							nome: produtoSelecionado.nome,
							idItem: itemPedido.id,
							id: 0,
							melhorPreco: true,
							idproduto: itemPedido.idproduto,
							tipo_lancamento: itemPedido.tipo_lancamento,
							quantidade: itemPedido.quantidade,
							quantidadeFornecedor: 0,
							valorUnitarioFornecedor: 0,
							valorTotal: 0
						});
					});
				}
				$scope.data.pedidoSelecionado.listaFornecedores.push(fornecedorSelecionado);
			});

			if ($scope.data.pedidoSelecionado.status === 'Aprovação da compra') {
				let index = 0;
				let valorMelhor = $scope.data.pedidoSelecionado.listaFornecedores[0].valorTotal;
				$scope.data.pedidoSelecionado.listaFornecedores.forEach(function (x, i) {
					if (i >= 0) {
						if (x.valorTotal < valorMelhor) {
							index = i;
							valorMelhor = x.valorTotal;
						}
					}
				});
				$scope.data.pedidoSelecionado.listaFornecedores[index]["melhorPreco"] = true;
			}

			if (pedido.continuacao) {
				$(function() { $("#loading").show() });
                $timeout($scope.showModals,2000);
			} else {
                $scope.showModals();
			}
		};

		$scope.showModals = function () {
            switch($scope.data.pedidoSelecionado.status) {
                case 'Em Aberto':
                    $(function () { $("#emAberto").modal('show') });
                    break;
                case 'Aprovação da compra':
                    $(function () { $("#aprovacaoCompra").modal('show') });
                    break;
                case 'Em cotação':
                    $(function () { $("#emCotacao").modal('show') });
                    break;
                case 'Compra aprovada':
                    $(function () { $("#compraAprovada").modal('show') });
                    break;
                case 'Compra Provisionada':
                    $(function () { $("#provisaoCompra").modal('show') });
                    break;
                case 'Compra Encerrada':
                    $(function () { $("#encerradaCompra").modal('show') });
                    break;
                case 'Cancelado':
                    if ($scope.data.pedidoSelecionado.listaFornecedores.length > 0)
                        $(function () { $("#aprovacaoCompra").modal('show') });
                    else
                        $(function () { $("#emAberto").modal('show') });
                    break;
                default:
                    $(function () { $("#novoPedido").modal('show') });
            }
            $(function() { $("#loading").hide() });
        };

		$scope.provisionarCompra = function () {
			$('.fade').hide();
            sessionStorage.setItem("menu","contasPagar");
			$state.go('CPLancamentosCompra', {
				id: $scope.data.pedidoSelecionado.id
			});
		}

		$scope.encerrarCompra = function () {
			alterarStatus('Compra Encerrada', 'Compra Provisionada');
		}

		$scope.fecharEncerrar = function () {
			$("#encerradaCompra").modal('hide');
		}

		$scope.abrirFornecedor = function () {
			$scope.data.listaEmpresasNovas = [];
			$('#novoFornecedor').modal('show');
		}

		function alterarStatus(statusNovo, statusAnterior, aprovacao = false) {
			$scope.data.pedidoSelecionado.status = statusNovo;
			let dataAtual = new Date();
			if (!aprovacao && statusNovo === "Em Aberto" && dataAtual.getTime() >= $scope.data.pedidoSelecionado.expectativa_entrega.getTime()) {
				$scope.data.pedidoSelecionado.status = statusAnterior;
				UtilsService.toastError("Você não pode solicitar um pedido com Data Inferior a de Hoje!");
			} else {
				PedidoService.editPedidos($scope.data.pedidoSelecionado).then(function (data) {
					let abrir = true;
					if (statusAnterior === "Em Aberto") {
                        $(function () { $("#emAberto").modal('hide') });
					} else if (statusAnterior === "Em cotação") {
                        $(function () { $("#emCotacao").modal('hide') });
					} else if (statusAnterior === "Aprovação da compra") {
                        $(function () { $("#aprovacaoCompra").modal('hide') });
					} else if (statusAnterior === "Compra aprovada") {
                        $(function () { $("#compraAprovada").modal('hide') });
					} else if (statusAnterior === "Compra Provisionada") {
                        $(function () { $("#provisaoCompra").modal('hide') });
					} else if (statusAnterior === "Compra Encerrada") {
                        $(function () { $("#encerradaCompra").modal('hide') });
					} else {
                        $(function () { $("#novoPedido").modal('hide') });
					}
					if (statusNovo === "Em cotação Salvar" || statusAnterior === 'Compra Provisionada' || statusNovo === 'Em Aberto Aprovação' || 'Aprovação da compra' ) {
						abrir = false;
					}
					if (aprovacao) {
					    UtilsService.toastSuccess(aprovacao+' com sucesso!');
                    }
					$scope.updatePedidos(statusAnterior, abrir);
                    $scope.updateList($scope.current_page);
				}, function (result) {
					$scope.data.errors = result;
					$scope.data.pedidoSelecionado.status = statusAnterior;
                    angular.forEach($scope.data.errors, function (value, key) {
                        UtilsService.toastError(value);
                    });
				});
			}
		}

        $scope.aprovarSolicitacao = () => {
            alterarStatus('Em Aberto','Solicitado', 'Solicitação aprovada');
        };

        $scope.confirmaNegarSolicitacao = (pedido_ou_solicitacao) => {
            $scope.data.btnNome = pedido_ou_solicitacao;
            $("#negarAlert").modal("show");
        };

        $scope.negarPedido = () => {
            alterarStatus('Cancelado',$scope.data.pedidoSelecionado.status);
            $("#negarAlert").modal("hide");
        };

		$scope.salvarAprovacaoCompra = function () {
			alterarStatus('Aprovação da compra', 'Em cotação');
		};

		$scope.salvarCotacao = function () {
			alterarStatus('Em cotação Salvar', 'Em cotação');
		};

		$scope.aprovarEmCotacao = function () {
			if ($scope.data.pedidoSelecionado.listaFornecedores.length === 0) {
				UtilsService.toastError("É necessário selecionar um fornecedor!")
			} else
				alterarStatus('Em cotação', 'Em Aberto');
		};

		$scope.aprovarEmCotacaoAutomatica = function () {
			if ($scope.data.pedidoSelecionado.listaFornecedores.length === 0) {
				UtilsService.toastError("É necessário selecionar um fornecedor!");
			} else
				alterarStatus('Em cotação Email', 'Em Aberto');
		};

		$scope.excluirPedido = function () {
			alterarStatus('Cancelado', 'Em Aberto');
		};

		$scope.aprovarPedidoValor = function (pedido) {
			angular.forEach($scope.data.pedidoSelecionado.listaFornecedores, function (forn) {
				if (forn.id === pedido.id) forn.status = "Aprovado";
				else forn.status = "Não Aprovado";
			});
			alterarStatus('Compra aprovada', 'Aprovação da compra','Pedido aprovado');
		};

		$scope.aprovarPedido = function () {
			alterarStatus('Em Aberto', 'Pendente');
		};

		$scope.cancelarPedido = function () {
			alterarStatus('Cancelado', 'Pendente');
		};

		$scope.createPedido = function () {
			if (!$scope.accessPagina.inserir) {
				UtilsService.toastError('Você não tem permissão para solicitar pedidos!');
				return false;
			}
			$scope.data.pedidoSelecionado = {};
			limpaItensSelecionados();
			$scope.data.pedidoSelecionado.listaItens = [];
			$scope.data.pedidoSelecionado.itensRemovidos = []
			$scope.data.pedidoSelecionado.descricao = '';
			$scope.data.pedidoSelecionado.id = '';
			$('#novoPedido').modal('show');
		};

		$scope.closeAlert = function () {
			// ngDialog.close('modalAlert');
		};

		// $scope.deletePedidos = function () {
		// 	PedidoService.deletePedidos($scope.data.deletePedido).then(function () {
		// 		$scope.closeDeleteModal();
		// 		$scope.updatePedidos(undefined);
		// 	});
		// };

		$scope.lancarEstqPatm = async(id) => {
			try {
				$('.loader').show();
				let result = await $http.get(`${config.apiUrl}api/pedidos/getinfomov/${id}`);
				$('#infoEstPatrModal').modal('show');
				$scope.infoEstPatrModal = {
					estoque: result.data.estoque,
					patrimonio: result.data.patrimonio
				}
				$scope.$digest();
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		};

		$scope.movProducts = async(id) => {
			// UtilsService.closeAllModal();
			try {
				$('.loader').show();
				let result = await $http.post(`${config.apiUrl}api/pedidos/movprodutos/${id}`, {});
				$('#infoEstPatrModal').modal('hide');
				$('.fade').modal('hide');
				// $('#provisaoCompra').modal('hide');
				$scope.encerrarCompra();
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		};

        $scope.verTextoMotivo = () => {
            $("#verTexto").modal("show");
        };

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/pedidos/aprovacao?page=${page}`);
			let result2 = VMPedidos(result.data.data);
            $scope.data.pedidos = result2.filter((x) => {
                if ($scope.data.filtro === 'aguardando')
                    return x.status === 'Solicitado' || x.status === 'Aprovação da compra';
                else if ($scope.data.filtro === 'aprovado')
                    return x.status !== 'Solicitado' && x.status !== 'Aprovação da compra' && x.status !== 'Cancelado';
                else if ($scope.data.filtro === 'cancelado')
                    return x.status !== 'Cancelado';
                else
                    return x;
            });
			$scope.data.pedidosCopy = VMPedidos(result.data.data);
			$scope.current_page = result.data.current_page;
			$scope.total = result.data.total;
			$scope.per_page = result.data.per_page;
			$scope.pageCount = Math.ceil(result.data.total / result.data.per_page);
			let pageCount = $scope.pageCount;
			if (pageCount >= 6) {
				if (page > 3 && page < pageCount - 2)
					$scope.pages = [page - 2, page - 1, page, page + 1, page + 2];
				else if (page === pageCount - 1)
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
	}
);