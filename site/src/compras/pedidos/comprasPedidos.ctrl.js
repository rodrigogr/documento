'use strict'
angular.module('ComprasModule').controller('PedidoCtrl',
	function ($scope, $httpParamSerializer, UtilsService, PedidoService, UsuarioService, $timeout,
		AprovadorService, ProdutoService, EmpresaService, $state, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('compras', 'pedidos');
		let produtos, usuarios, grupoProd, allGrupoProduto, empresa, aprovadores;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

		$scope.ngOnInit = async() => {
			// $('.loader').show();
			$scope.updatePedidos(undefined);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
            await $http.get(`${config.apiUrl}api/departamentos`)
                .then(result => $scope.data.departamentos = result.data.data);
            await $http.get(`${config.apiUrl}api/grupo_produtos`)
                .then(result => $scope.allGrupoProduto = result.data.data);
            // await Promise.all(basicData);
            // $scope.data.grupoProdutos = allGrupoProduto.filter(x => grupoProd.find( y => y === x.id));
            // $('.loader').hide();
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
                $scope.data.listaProdutos = produtos.filter(x => x.produto.status === 1);
                grupoProd = $scope.data.listaProdutos.map(x => x.grupo.id).filter( function (elem, i, array) {
                    return array.indexOf(elem) === i ;
                });
			}),
			EmpresaService.getAllEmpresas()
			.then(result => $scope.data.empresas = result.data)
		];*/

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
            fornecedor_excluir: [],
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
            listaFilterProdutos: null,
            listaEscolhaProdutos: {},
			usuarios: [],
			itemSelecionado: {
				id: '',
				tipo_lancamento: '',
				idproduto: '',
                nomeProduto: '',
                unidadeProduto: '',
                nomeTipo: '',
				quantidade: ''
			},
			pedidocopy: undefined,
			listaEmpresasNovas: [],
			tipos: [{
					id: 'Produto',
					descricao: 'Produto'
				}
				// Desabilitado pois não existe cadastro de servico
				// {
				// 	id: 'Serviço',
				// 	descricao: 'Serviço'
				// }
			],
			errors: []
		};

        $scope.pesquisar = function () {
            /*let item = $scope.data.descricaoSelecionado.toLowerCase();
            if ($scope.data.descricaoSelecionado.length > 2) {
                $scope.data.pedidos = $scope.data.pedidosCopy.filter((x) => {
                    let descricao = x.pedido.descricao.toLowerCase();
                    let requerente = x.pedido.requerente.toLowerCase();
                    return descricao.indexOf(item) > -1 || requerente.indexOf(item) > -1;
                });
            }*/
        };

		$scope.verificaValor = function () {
			if ($scope.data.itemSelecionado.quantidade === undefined) {
				$scope.data.itemSelecionado.quantidade = "";
				$scope.data.errors = [];
				UtilsService.toastError("O campo quantidade precisa ser pelo menos 1 unidade!");
			}
		};

		/*let listaUsuarios = () => {
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
		};*/

		$scope.closeModal = function () {
			$('#novoPedido').modal('hide');
		}

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		}

		$scope.showDeleteAlert = function (pedido) {
			$scope.data.deletePedido = pedido;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		}

		$scope.closeModalError = function () {
			$('#errorPedido').modal('hide');
			$scope.data.errors = [];
		}

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
		};

		function validaItem() {
			$scope.data.errors = [];
			if ($scope.data.itemSelecionado.tipo_lancamento === "") {
				$scope.data.errors.push("Tipo de Lançamento é obrigatório!");
			}
			if ($scope.data.itemSelecionado.idproduto === "") {
				$scope.data.errors.push("Produto é obrigatório!");
			}
			if ($scope.data.itemSelecionado.nomeProduto === "") {
                $scope.data.errors.push("Produto é obrigatório!");
            }
			if ($scope.data.itemSelecionado.quantidade === "" || $scope.data.itemSelecionado.quantidade === 0) {
				$scope.data.errors.push("Quantidade é obrigatório!");
			}
		}

        $scope.adicionarItem = function () {
            validaItem();
            let exists = $scope.data.pedidoSelecionado.listaItens.find(x => x.idproduto === $scope.data.itemSelecionado.idproduto);
            if ($scope.data.errors.length === 0) {
                if (exists === undefined) {
                    $scope.data.pedidoSelecionado.listaItens.push({
                        nome: $scope.data.itemSelecionado.nomeProduto,
                        id: 0,
                        tipo: $scope.data.itemSelecionado.tipo_lancamento,
                        nomeTipo: $scope.data.itemSelecionado.nomeTipo,
                        idproduto: $scope.data.itemSelecionado.idproduto,
                        tipo_lancamento: 'Produto',
                        quantidade: $scope.data.itemSelecionado.quantidade,
                        tipo_unidade: $scope.data.itemSelecionado.unidadeProduto
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
        };

		$scope.showAddItem = function () {
		    if ($scope.data.pedidoSelecionado.listaFornecedores.length == 0) {
		        UtilsService.toastInfo('Insira primeiro um novo fornecedor');
		        return false;
            }
            $("#addItem").modal('show');
        };

		$scope.adicionarItemEmCotacao = function () {
            let item = $scope.data.itemSelecionado;
            $scope.data.pedidoSelecionado.listaFornecedores.forEach(x => {
                x.listaItens.push({
                    id: 0,
                    idItem: 0,
                    idproduto: item.idproduto,
                    melhorPreco: false,
                    nome: $scope.data.itemSelecionado.nomeProduto,
                    quantidade: item.quantidade,
                    quantidadeFornecedor: 0,
                    tipo_lancamento: "Produto",
                    valorTotal: 0,
                    valorUnitarioFornecedor: 0
                })
            });
            limpaItensSelecionados();
            $("#addItem").modal('hide');
        };

		$scope.updatePedidos = async(status, abrir) => {
			try {
				// $('.loader').show();
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
				// $('.loader').hide();
			}
		};

		let VMPedidos = (data) => {
			if (data && data.length) {
				data.forEach(x => {
					x.pedido.expectativa_entrega = UtilsService.toDate(x.pedido.expectativa_entrega);
				})

			}
			return data;
		};

		$scope.savePedido = async() => {
            $("#salvar").attr("disabled","disbled");
            $("#loading").modal('show');
            try {
                if (!$scope.accessPagina.inserir) {
                    throw 'Você não tem permissão para solicitar pedidos!';
                    return false;
                }
                let dataAtual = new Date();
                let result = null;

                if (!$scope.data.pedidoSelecionado.requerente || !$scope.data.pedidoSelecionado.departamento
                    || !$scope.data.pedidoSelecionado.descricao ) {
                    throw "Os campos do formulário são obrigatórios!";
                    return;
                }
                if (!$scope.data.pedidoSelecionado.expectativa_entrega) {
                    throw "Campo expectativa de entrega é obrigatório!";
                    return;
                }
                if (UtilsService.getTimeData(dataAtual) > UtilsService.getTimeData($scope.data.pedidoSelecionado.expectativa_entrega)) {
                    throw "Você não pode solicitar um pedido com Data Inferior a de Hoje!";
                    return;
                }
                if ($scope.data.pedidoSelecionado.listaItens.length === 0) {
                    throw "Pelo menos 1 Item de Pedido é necessário!";
                    return;
                }
                if ($scope.data.pedidoSelecionado.listaFornecedores.length === 0) {
                    throw "Pelo menos 1 empresa é necessária para a cotação!";
                    return;
                }

                if (!$scope.data.pedidoSelecionado.id)
                    result = await PedidoService.savePedidos($scope.data.pedidoSelecionado);
                else
                    result = await PedidoService.editPedidos($scope.data.pedidoSelecionado);
                await PedidoService.notificacaoAprovador($scope.data.pedidoSelecionado);
                UtilsService.toastSuccess(result.data);
                $("#salvar").removeAttr("disabled");
                $scope.updatePedidos(undefined);
                $('.modal').modal('hide');
            } catch (e) {
                console.error(e);
                UtilsService.toastError(e);
            } finally {
                $("#salvar").removeAttr("disabled");
                $("#loading").modal('hide');
            }
		};

		$scope.excluirFornecedoCotacaoConfirmacao = function (index,empresa,id) {
		    $scope.data.fornecedor_excluir.nome = empresa;
		    $scope.data.fornecedor_excluir.id = id;
		    $scope.data.fornecedor_excluir.index = index;
            console.log($scope.data.fornecedor_excluir);
		    $("#deleteAlertFornecedor").modal('show');
		    return;
		};

		$scope.excluirFornecedoCotacao = function (index, id) {
			if (id > 0) {
				$scope.data.pedidoSelecionado.listaExcluirFornecedor.push(id);
			}
            $scope.data.pedidoSelecionado.listaFornecedores.splice(index, 1);

			if ($scope.data.pedidoSelecionado.listaFornecedores.length === 0 && $scope.data.pedidoSelecionado.listaExcluirFornecedor.length > 0) {
			    //exclui os itens desse pedido
                PedidoService.deleteItensByPedido($scope.data.pedidoSelecionado.id).then(x => console.log(x));
            }
            $scope.data.fornecedor_excluir = [];
            $("#deleteAlertFornecedor").modal('hide');
		};

		$scope.adicionarEmpresaNova = function () {
			let exists_cadastro = $scope.data.pedidoSelecionado.listaFornecedores.find(x => x.id === parseInt($scope.data.empresaSelecionada.id));
			let exists = $scope.data.listaEmpresasNovas.find(x => x.id === parseInt($scope.data.empresaSelecionada.id));
            if (exists === undefined && exists_cadastro === undefined) {
                $scope.data.listaEmpresasNovas.push($scope.data.empresaSelecionada);
                $scope.data.empresaSelecionada = {};
            } else {
                UtilsService.toastError("Fornecedor já selecionado!");
            }
		};

		$scope.adicionarEmpresaCotacao = function () {
			if ($scope.data.listaEmpresasNovas.length > 0) {
				$scope.data.listaEmpresasNovas.forEach(function (empresa) {
					let fornecedorSelecionado = {};
					fornecedorSelecionado["id"] = empresa.id;
					fornecedorSelecionado["nome_fantasia"] = empresa.nome_fantasia;
					fornecedorSelecionado["idfornecedorpedido"] = 0;
					fornecedorSelecionado["listaItens"] = [];
					fornecedorSelecionado["valorTotal"] = 0;
					fornecedorSelecionado["valorTotalCalculado"] = 0;
					fornecedorSelecionado["acrescimo"] = 0;
					fornecedorSelecionado["desconto"] = 0;
					fornecedorSelecionado["observacao"] = "";
					fornecedorSelecionado["status"] = "Aprovado";
					if ($scope.data.pedidoSelecionado.listaFornecedores.length > 0) {
                        $scope.data.pedidoSelecionado.listaFornecedores[0].listaItens.forEach(function (item) {
                            fornecedorSelecionado.listaItens.push({
                                nome: item.nome,
                                idItem: item.idItem,
                                id: 0,
                                idproduto: item.idproduto,
                                tipo_lancamento: item.tipo_lancamento,
                                quantidade: item.quantidade,
                                quantidadeFornecedor: 0,
                                valorUnitarioFornecedor: 0,
                                valorTotal: 0
                            });
                        });
                    }
					$scope.data.pedidoSelecionado.listaFornecedores.push(fornecedorSelecionado);
				});
				$('#novoFornecedor').modal('hide');
                let scrollFim = $("#listaFornecedoresCotacao")[0].scrollHeight;
                $("#listaFornecedoresCotacao").animate({ scrollTop: scrollFim}, 1000);
                $scope.data.listaEmpresasNovas = [];
			} else {
				UtilsService.toastError("É necesário selecionar ao menos um Fornecedor!");
			}
		};

		$scope.excluirEmpresaNova = function (index) {
			$scope.data.listaEmpresasNovas.splice(index, 1);
		};

		function limpaItensSelecionados() {
			$scope.data.itemSelecionado = {
                id: '',
                tipo_lancamento: '',
                idproduto: '',
                nomeProduto: '',
                unidadeProduto: '',
                nomeTipo: '',
                quantidade: ''
			};
			$(function() {
			    $("#ttexto").val('');
            })
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
            let exists = $scope.data.pedidoSelecionado.listaFornecedores.find(x => x.id === parseInt($scope.data.empresaSelecionada.id));
            if (exists === undefined) {
                let empresa = $scope.data.empresaSelecionada;
                $scope.data.pedidoSelecionado.listaFornecedores.push(empresa);
                $scope.data.empresaSelecionadaNova = '';
                $("#emptexto").val('');
            } else {
                UtilsService.toastError("Fornecedor já selecionado!")
            }
		};

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
		}

		$scope.editPedido = function (pedido) {
			$scope.data.pedidocopy = pedido;
			$scope.data.pedidoSelecionado = {};
			limpaItensSelecionados();
			$scope.data.listaProdutos = produtos;
            $scope.data.pedidoSelecionado.itensRemovidos = [];
            $scope.data.pedidoSelecionado.requerente = pedido.pedido.requerente;
            $scope.data.pedidoSelecionado.descricao = pedido.pedido.descricao;
            $scope.data.pedidoSelecionado.departamento = pedido.departamento;
            $scope.data.pedidoSelecionado.departamento_desc = $scope.data.departamentos.find( x => x.id === pedido.departamento);
			$scope.data.pedidoSelecionado.id = pedido.pedido.id;
			$scope.data.pedidoSelecionado.solicitado_id = pedido.pedido.solicitado_id.toString();
			$scope.data.pedidoSelecionado.solicitado = pedido.usuario_solicitacao;
			$scope.data.pedidoSelecionado.data_solicitacao = new Date(pedido.pedido.updated_at);
			$scope.data.pedidoSelecionado.expectativa_entrega = new Date(pedido.pedido.expectativa_entrega);
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
				// let fornecedorSelecionado = $scope.data.empresas.find(x => x.id === parseInt(item.fornecedores.idfornecedor));
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
				let valorMelhor = $scope.data.pedidoSelecionado.listaFornecedores[0].valorTotalCalculado;
				$scope.data.pedidoSelecionado.listaFornecedores.forEach(function (x, i) {
					if (i >= 0) {
						if (x.valorTotalCalculado < valorMelhor) {
							index = i;
							valorMelhor = x.valorTotalCalculado;
						}
					}
				});
				$scope.data.pedidoSelecionado.listaFornecedores[index]["melhorPreco"] = true;
			}
			/*let iItem = 0;
			angular.forEach($scope.data.pedidoSelecionado.listaFornecedores, function (item) {
				if (iItem > 0) {
					item["melhorPreco"] = false;
				}
				iItem++;
			});*/
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
		};

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

		function alterarStatus(statusNovo, statusAnterior) {
			$scope.data.pedidoSelecionado.status = statusNovo;
			let dataAtual = new Date();
			if (statusNovo === "Em Aberto" && dataAtual.getTime() >= $scope.data.pedidoSelecionado.expectativa_entrega.getTime()) {
				$scope.data.pedidoSelecionado.status = statusAnterior;
				UtilsService.toastError("Você não pode solicitar um pedido com Data Inferior a de Hoje!");
			} else {
			    $("#loading").modal('show');
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
					$scope.updatePedidos(statusAnterior, abrir);
                    $scope.updateList($scope.current_page);
				}, function (result) {
					$scope.data.errors = result;
					$scope.data.pedidoSelecionado.status = statusAnterior;
					if (result.code === 400 || result.code === 401) {
                        UtilsService.toastError(result.message);
                    } else {
                        angular.forEach($scope.data.errors, function (value, key) {
                            UtilsService.toastError(value);
                        });
                    }
				}).finally(() => $("#loading").modal('hide'));
			}
		}

		$scope.salvarAprovacaoCompra = function () {
			var validacoes_fornecedor = true;
            angular.forEach($scope.data.pedidoSelecionado.listaFornecedores, function (fornnecedor) {
            	angular.forEach(fornnecedor.listaItens, function (item) {
					if (!item.quantidadeFornecedor  || !item.valorUnitarioFornecedor) {
                        validacoes_fornecedor = false;
					}
                });
            });

            if(!validacoes_fornecedor) {
                UtilsService.toastError("É necessário informar a quantidade unitária e valor unitário do fornencedor.");
			} else {
                alterarStatus('Aprovação da compra', 'Em cotação');
			}
		};

		$scope.salvarCotacao = function () {
			alterarStatus('Em cotação Salvar', 'Em cotação');
		}

		$scope.aprovarEmCotacao = function () {
			if ($scope.data.pedidoSelecionado.listaFornecedores.length === 0) {
				UtilsService.toastError("É necessário selecionar um fornecedor!")
			} else
				alterarStatus('Em cotação', 'Em Aberto');
		}

		$scope.aprovarEmCotacaoAutomatica = function () {
			if ($scope.data.pedidoSelecionado.listaFornecedores.length === 0) {
				UtilsService.toastError("É necessário selecionar um fornecedor!");
			} else
				alterarStatus('Em cotação Email', 'Em Aberto');
		}

		$scope.excluirPedido = function () {
			alterarStatus('Cancelado', 'Em Aberto');
		};

		$scope.aprovarPedidoValor = function (pedido) {
			angular.forEach($scope.data.pedidoSelecionado.listaFornecedores, function (forn) {
				if (forn.id === pedido.id) forn.status = "Aprovado";
				else forn.status = "Não Aprovado";
			});
			alterarStatus('Compra aprovada', 'Aprovação da compra');
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
			$scope.data.pedidoSelecionado.itensRemovidos = [];
			$scope.data.pedidoSelecionado.descricao = '';
			$scope.data.pedidoSelecionado.motivo_negado = '';
			$scope.data.pedidoSelecionado.listaFornecedores = [];
			$scope.data.empresaSelecionada = '';
			$('#pedidoModal').modal('show');
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
				};
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

        $scope.imprimirCotacao = () => {
            let prom;
            $("#loading").show();
            prom = $http.post(`${config.apiUrl}api/pedidos/imprimir_cotacao`, $scope.data.pedidoSelecionado, {
                responseType: 'arraybuffer'
            });
            prom.then(result => {
                let blob = new Blob([result.data], {
                    type: 'application/pdf'
                });
                $('#showPdf').modal('show');
                $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);
            })
                .catch((e) => UtilsService.openErrorMsg(e))
                .finally(() => $("#loading").hide());
        };

		$scope.current_page = 1;
		$scope.updateList = async(page, search = null) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            $('.loader').show();
            let filtro = search ? '&'+search : '';
			let result = await $http.get(`${config.apiUrl}api/pedidos?page=${page}`+filtro);
			$scope.data.pedidos = VMPedidos(result.data.data);
			$scope.data.pedidosCopy = VMPedidos(result.data.data);
			$scope.current_page = result.data.current_page;
			$scope.total = result.data.total;
			$scope.from = result.data.from;
			$scope.to = result.data.to;
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
            $('.loader').hide();
		};
		$(function () {
            $("#solicitado").css('color','red');
        });

        $scope.tipoProduto = () => {
            /*$scope.data.listaFilterProdutos = $scope.data.listaProdutos.filter(x => x.grupo.id == $scope.data.itemSelecionado.tipo_lancamento);
            return;*/
            if ($("#insertProduto .twitter-typeahead").length > 0) {
                $("#insertProduto .twitter-typeahead").remove();
                $("#insertProduto").append('<input class="produtos ba__input-modal" ng-model="data.itemSelecionado.nomeProduto" type="text" id="ttexto" placeholder="Digite o nome do produto ou pesquise">');
            }

            var produtos = new Bloodhound({
                datumTokenizer: function(d) { return d.tokens; },
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: config.apiUrl + 'api/produtos/produtos_get?q=%QUERY&t='+$scope.data.itemSelecionado.tipo_lancamento,
                    wildcard: '%QUERY'
                },
                limit: 30
            });
            produtos.initialize();
            $('.produtos').typeahead({
                hint: true,
                highlight: true,
                minLength: 1
            }, {
                displayKey: 'descricao',
                source: produtos.ttAdapter(),
                templates: {
                    empty: [
                        '<div class="retorno-vazio">',
                        'nehum resultado encontrado',
                        '</div>'
                    ].join('\n')
                }
            }).bind("typeahead:selected", function(obj, datum) {
                // $('#tid').val(datum.id);
                $scope.data.itemSelecionado.idproduto = datum.id;
                $scope.data.itemSelecionado.unidadeProduto = datum.unidade_produto.descricao;
                $scope.data.itemSelecionado.nomeProduto = datum.descricao;
                $scope.data.itemSelecionado.nomeTipo = datum.grupo_produto.descricao;
            });
        };

        $(document).ready(function() {
            $("#ttexto").click(function() {
                if (!$scope.data.itemSelecionado.tipo_lancamento) {
                    UtilsService.toastInfo('Selecione o tipo de produto');
                }
            });
        });

        $scope.listaEmpresaModal = () => {
            $("#listaEmpresas").modal('show');
            $(".load-list").show();
            $(".prod-modal-list").hide();
            $timeout($scope.buscaListaEmpresas,500);
        };

        $scope.listaProdutosModal = () => {
            if (!$scope.data.itemSelecionado.tipo_lancamento) {
                UtilsService.toastInfo('Selecione o tipo!');
                return;
            }

            $("#listaProdutos").modal('show');
            $(".load-list").show();
            $(".prod-modal-list").hide();
            $timeout($scope.buscaListaProdutos,500);
        };

        $scope.buscaListaProdutos = async() => {
            try {
                await $http.get(config.apiUrl+'api/produtos/produtos_get?t='+$scope.data.itemSelecionado.tipo_lancamento)
                    .then( function(result) {
                        $scope.data.listaEscolhaProdutos = result.data;
                    });
            } catch (e) {
                UtilsService.toastError(e.data.message);
            } finally {
                $(".load-list").hide();
                $(".prod-modal-list").show();
            }
        };

        $scope.buscaListaEmpresas = async() => {
            try {
                if (!$scope.data.listaEscolhaEmpresas) {
                    await $http.get(config.apiUrl + 'api/empresas')
                        .then(function (result) {
                            $scope.data.listaEscolhaEmpresas = result.data.data;
                        });
                }
            } catch (e) {
                UtilsService.toastError(e.data.message);
            } finally {
                $(".load-list").hide();
                $(".prod-modal-list").show();
            }
        };

        $scope.produtoSelecionadoLista = (item) => {
            $scope.data.itemSelecionado.nomeProduto = item.descricao;
            $scope.data.itemSelecionado.idproduto = item.id;
            $scope.data.itemSelecionado.unidadeProduto = item.unidade_produto.descricao;
            $scope.data.itemSelecionado.nomeTipo = item.grupo_produto.descricao;
            $("#ttexto").val(item.descricao);
            $("#listaProdutos").modal('hide');
        };

        $scope.empresaSelecionadaLista = (item) => {
            $scope.data.empresaSelecionada = item;
            $scope.data.empresaSelecionadaNova = item.nome_fantasia;
            $("#emptexto").val(item.nome_fantasia);
            $("#listaEmpresas").modal('hide');
        };

        $(function () {
            var empresas = new Bloodhound({
                datumTokenizer: function(i) { return i.tokens; },
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: config.apiUrl + 'api/empresas_get?q=%QUERY',
                    wildcard: '%QUERY'
                },
                limit: 20
            });
            empresas.initialize();
            $('.empresas').typeahead({
                hint: true,
                highlight: true,
                minLength: 2
            }, {
                displayKey: 'nome_fantasia',
                source: empresas.ttAdapter(),
                templates: {
                    empty: [
                        '<div class="retorno-vazio">',
                        'nehum resultado encontrado',
                        '</div>'
                    ].join('\n')
                }
            }).bind("typeahead:selected", function(obj, datum) {
                $scope.data.empresaSelecionada = datum;
            });
        });

        $scope.filtro = async() => {
            await $scope.updateList(1,$httpParamSerializer($scope.search));
        }
	}
);