'use strict'
angular.module('ComprasModule').controller('SolicitacaoCtrl',
	function ($scope, UtilsService, PedidoService, UsuarioService, $timeout,
		AprovadorService, ProdutoService, EmpresaService, $state, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('compras', 'solicitações');
		let produtos, grupoProd, allGrupoProduto, aprovadores;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

		$scope.ngOnInit = async() => {
            $('.loader').show();
            $scope.data.filtro = 'Solicitado';
            $scope.updateList();
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
            await $http.get(`${config.apiUrl}api/departamentos`)
                .then(result => $scope.data.departamentos = result.data.data);
            await $http.get(`${config.apiUrl}api/grupo_produtos`)
                .then(result => $scope.allGrupoProduto = result.data.data);
            await UsuarioService.getAllUsuarios()
                .then(result => $scope.data.usuarios = result.data);
            // await Promise.all(basicData);
            //$scope.data.grupoProdutos = allGrupoProduto.filter(x => grupoProd.find( y => y === x.id));
            $('.loader').hide();
		};

		/*let basicData = [
			UsuarioService.getAllUsuarios()
			    .then(result => $scope.data.usuarios = result.data),
			ProdutoService.getAllProduto()
                .then(function (result) {
                    produtos = result.data;
                    $scope.data.allListaProdutos = produtos;
                    $scope.data.listaProdutos = produtos.filter(x => x.produto.status === 1);
                    grupoProd = $scope.data.listaProdutos.map(x => x.grupo.id).filter( function (elem, i, array) {
                        return array.indexOf(elem) === i ;
                    });
                })
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
                departamento: '',
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
            listaFilterProdutos:null,
			usuarios: [],
			itemSelecionado: {
				id: '',
				tipo_lancamento: '',
				idproduto: '',
				quantidade: ''
			},
			pedidocopy: undefined,
			listaEmpresasNovas: [],
			errors: [],
			filtro: ''
		};

		$scope.pesquisar = function () {
		    if ($scope.data.descricaoSelecionado.length !== 0 && $scope.data.descricaoSelecionado.length < 3) {
		        UtilsService.toastInfo('Digite no mínimo três caracteres');
		        return false;
            }
            $scope.data.filtro = '';
            $scope.updateList(undefined,$scope.data.descricaoSelecionado);
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
		}

		$scope.closeModal = function () {
			$('#novoPedido').modal('hide');
		}

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		}

		$scope.showDeleteAlert = function (solicitacao) {
			$scope.data.deleteSolicitacao = {};
			$scope.data.deleteSolicitacao.id = solicitacao.id;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		$scope.closeModalError = function () {
			$('#errorPedido').modal('hide');
			$scope.data.errors = [];
		};

		$scope.deleteSolicitacao = function () {
			PedidoService.deletePedidos($scope.data.deleteSolicitacao).then(function (data) {
				if (!data.errors) {
					$scope.updateSolicitacoes(undefined);
					$scope.closeDeleteModal();
					UtilsService.toastSuccess(data.data);
				} else {
					$scope.closeDeleteModal();
                    UtilsService.toastError(data.data);
				}
			}).finally(() => $scope.data.deleteSolicitacaoId = null);
		};

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

		/*$scope.adicionarItem = function () {
			validaItem();
			let exists = $scope.data.pedidoSelecionado.listaItens.find(x => x.idproduto === $scope.data.itemSelecionado.idproduto);
			if ($scope.data.errors.length === 0) {
				if (exists === undefined) {
					let produtoSelecionado = $scope.data.listaProdutos.find(function (x) {
						return x.produto.id === parseInt($scope.data.itemSelecionado.idproduto);
					});
					$scope.data.pedidoSelecionado.listaItens.push({
						nome: produtoSelecionado.produto.descricao,
						id: 0,
						tipo: produtoSelecionado.unidade.descricao,
						idproduto: $scope.data.itemSelecionado.idproduto,
						tipo_lancamento: produtoSelecionado.grupo.descricao,
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
		};*/

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

        $scope.produtoSelecionadoLista = (item) => {
            $scope.data.itemSelecionado.nomeProduto = item.descricao;
            $scope.data.itemSelecionado.idproduto = item.id;
            $scope.data.itemSelecionado.unidadeProduto = item.unidade_produto.descricao;
            $scope.data.itemSelecionado.nomeTipo = item.grupo_produto.descricao;
            $("#ttexto").val(item.descricao);
            $("#listaProdutos").modal('hide');
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

		$scope.updateSolicitacoes = async(status, abrir) => {
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
		};

		$scope.salvarSolicitacao = async() => {
            $("#loading").modal('show');
            $("#salvar").attr("disabled","disbled");
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

                $scope.data.pedidoSelecionado.solicitacao = 1; //indicação que criação partiu de solicitação

				if (!$scope.data.pedidoSelecionado.id)
					result = await PedidoService.savePedidos($scope.data.pedidoSelecionado);
				else
					result = await PedidoService.editSolicitacao($scope.data.pedidoSelecionado);
				//envia e-mails para os aprovadores informando nova solicitação
                await PedidoService.notificacaoAprovador($scope.data.pedidoSelecionado);
				UtilsService.toastSuccess('Solicitação efetuada com sucesso!');
                $("#salvar").removeAttr("disabled");
				$scope.updateSolicitacoes(undefined);
				$('.modal').modal('hide');
			} catch (e) {
                UtilsService.toastError(e);
                $("#salvar").removeAttr("disabled");
			} finally {
			    $("#loading").modal('hide');
            }
		};

		function limpaItensSelecionados() {
			$scope.data.itemSelecionado = {
				id: '',
				tipo_lancamento: '',
				idproduto: '',
				quantidade: '',
                nomeProduto: ''
			};
		}

		$scope.removerItem = function (index, itemPedido) {
			if (itemPedido.id !== "") {
				$scope.data.pedidoSelecionado.itensRemovidos.push(itemPedido.id);
			}
			$scope.data.pedidoSelecionado.listaItens.splice(index, 1);
		}

		$scope.editSolicitacao = function (solicitacao) {
			$scope.data.solicitacaocopy = solicitacao;
			$scope.data.pedidoSelecionado = {};
			limpaItensSelecionados();
			$scope.data.pedidoSelecionado.id = solicitacao.id;
			$scope.data.pedidoSelecionado.requerente = solicitacao.requerente;
			$scope.data.pedidoSelecionado.departamento = String(solicitacao.departamento);
			$scope.data.pedidoSelecionado.descricao = solicitacao.descricao;
			$scope.data.pedidoSelecionado.solicitado = $scope.data.usuarios.filter( x => x.id === solicitacao.solicitado_id)[0].nome;
			$scope.data.pedidoSelecionado.expectativa_entrega = UtilsService.toDate(solicitacao.expectativa_entrega);
			$scope.data.pedidoSelecionado.status = solicitacao.status;
			$scope.data.pedidoSelecionado.motivo_negado = solicitacao.motivo_negado;
			$scope.data.pedidoSelecionado.listaItens = solicitacao.items_pedido;
			$scope.data.pedidoSelecionado.dt_criacao = solicitacao.created_at;

			$("#novoPedido").modal('show');
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
			$scope.data.pedidoSelecionado.id = '';
			$scope.data.pedidoSelecionado.tipo_lancamento = '';
			$scope.data.pedidoSelecionado.motivo_negado = '';
			$('#novoPedido').modal('show');
			$timeout(function (){ $("#requerente").focus(); },500);
		};

		$scope.filtrarSolicitacao = () => {
            let filtro;
            filtro = $scope.data.allSolicitacoes.filter((x) => {
                if ($scope.data.filtro === 'todos')
                    return x;
                else if ($scope.data.filtro === 'Aprovado')
                    return x.status !== 'Solicitado' && x.status !== 'Cancelado';
                else
                    return x.status === $scope.data.filtro;
            });
            $scope.data.solicitacoes = filtro;
        };

		$scope.imprimirSolicitacao = () => {
            let prom;
            $("#loading").show();
            prom = $http.post(`${config.apiUrl}api/pedidos/imprimir_solicitacao`, $scope.data.pedidoSelecionado, {
                responseType: 'arraybuffer'
            });
            prom.then(result => {
                let blob = new Blob([result.data], {
                    type: 'application/pdf'
                });
                $('#showPdf').modal('show');
                $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);
            })
                .catch(() => UtilsService.openErrorMsg())
                .finally(() => $("#loading").hide());
        };

		$scope.current_page = 1;
		$scope.updateList = async(page, search=false) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = null;
            if (search) {
                result = {
                    data: await PedidoService.searchPedidos(search)
                };
                $scope.data.solicitacoes = result.data.data;
            } else {
                result = await $http.get(`${config.apiUrl}api/pedidos/solicitacao?page=${page}`);
                $scope.data.solicitacoes = result.data.data.filter((x) => {
                    if ($scope.data.filtro !== '')
                        return x.status === $scope.data.filtro;
                    else
                        return x;
                });
            }
            $scope.data.allSolicitacoes = result.data.data;

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
		};

        $scope.tipoProduto = () => {
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

	});