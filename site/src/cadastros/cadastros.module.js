'use strict'
angular.module('CadastrosModule', [
		'ui.router',
		'appDirectives',
		'appFilters',
		'ngAria',
		'ui.utils.masks',
		'toastr',
		'ngMask',
		'oitozero.ngSweetAlert',
		'ui.tinymce',
		'ui.bootstrap'
	])
	.config(function ($stateProvider, $urlRouterProvider) {
		$stateProvider
			.state('CadTipoInad', {
				url: "/cadastro/inadimplencia/tipo",
				templateUrl: 'src/cadastros/inadimplencia/tipo/tipoInadimplencia.Ctrl.html',
				controller: 'TipoInadimplenciaCadCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadSitInad', {
				url: "/cadastro/inadimplencia/situacao",
				templateUrl: 'src/cadastros/inadimplencia/situacao/situacaoInadimplencia.Ctrl.html',
				controller: 'SituacaoInadimplenciaCadCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadDept', {
				url: "/cadastro/departamentos",
				templateUrl: 'src/cadastros/departamentos/departamentos.ctrl.html',
				controller: 'DepartamentoCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadGrupCalc', {
				url: "/cadastro/grupoCalculo",
				templateUrl: 'src/cadastros/grupo-calculo/grupoCalculo.ctrl.html',
				controller: 'GrupoCalculoCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadInfo', {
				url: "/cadastro/informativo",
				templateUrl: 'src/cadastros/informativo/informativo.ctrl.html',
				controller: 'InformativoCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadConfigCond', {
				url: "/cadastro/configuracao/condominio",
				templateUrl: 'src/cadastros/config-condominio/configCondominio.ctrl.html',
				controller: 'ConfiguracaoCondominioCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadConfigReceit', {
				url: "/cadastro/configuracao/receita",
				templateUrl: 'src/cadastros/config-receita/configReceita.ctrl.html',
				controller: 'ConfiguracaoReceitaCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadGrupLanc', {
				url: "/cadastro/grupoLancamento",
				templateUrl: 'src/cadastros/grupos-conta/grupoConta.ctrl.html',
				controller: 'GrupoLancamentoCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('CadTipoLanc', {
				url: "/cadastro/tipoLancamento",
				templateUrl: 'src/cadastros/planos-conta/planosConta.ctrl.html',
				controller: 'TipoLancamentoCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadArea', {
				url: "/area",
				templateUrl: 'src/cadastros/estoque/areas/areas.ctrl.html',
				controller: 'AreaCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadColuna', {
				url: "/coluna",
				templateUrl: 'src/cadastros/estoque/colunas/coluna.ctrl.html',
				controller: 'ColunaCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadGrupo', {
				url: "/grupo",
				templateUrl: 'src/cadastros/estoque/grupo-produtos/gruposProdutos.ctrl.html',
				controller: 'GrupoCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadNivel', {
				url: "/nivel",
				templateUrl: 'src/cadastros/estoque/niveis/niveis.ctrl.html',
				controller: 'NivelCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadProduto', {
				url: "/produto",
				templateUrl: 'src/cadastros/estoque/produtos/produtos.ctrl.html',
				controller: 'ProdutoCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadRua', {
				url: "/rua",
				templateUrl: 'src/cadastros/estoque/ruas/ruas.ctrl.html',
				controller: 'RuaCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadSequencia', {
				url: "/sequencia",
				templateUrl: 'src/cadastros/estoque/sequencias/sequencia.ctrl.html',
				controller: 'SequenciaCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('ComprasCadUnidade', {
				url: "/unidade",
				templateUrl: 'src/cadastros/estoque/unidades/unidades.ctrl.html',
				controller: 'UnidadeCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('reservaLocal', {
				url: "/unidade",
				templateUrl: 'src/cadastros/estoque/unidades/unidades.ctrl.html',
				controller: 'UnidadeCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('reservaCalendario', {
				url: "/unidade",
				templateUrl: 'src/cadastros/estoque/unidades/unidades.ctrl.html',
				controller: 'UnidadeCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
			.state('reservaAprovacao', {
				url: "/unidade",
				templateUrl: 'src/cadastros/estoque/unidades/unidades.ctrl.html',
				controller: 'UnidadeCtrl',
				resolve: {
					onEnter: () => window.stop()
				}
			})
	});