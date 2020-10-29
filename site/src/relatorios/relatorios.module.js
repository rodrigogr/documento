'use strict'
angular.module('RelatoriosModule', [
		'ui.router',
		'appDirectives',
		'appFilters',
		'ngAria',
		'ui.utils.masks',
		'toastr',
		'ngMask',
		'oitozero.ngSweetAlert',
		'ui.tinymce'
	])
	.config(function ($stateProvider, $urlRouterProvider) {
		$stateProvider
			.state('RelInadAcord', {
				url: "/relatorio/inadimplencia/acordo",
				templateUrl: 'src/relatorios/inadimplencia/acordo/relatorioInadimplenciaAcordo.Ctrl.html',
				controller: 'RelatorioInadimplenciaAcordoCtrl',
				resolve: { onEnter: () => window.stop() }
			})
			.state('RelPrevReal', {
				url: "/relatorio/previstoRealizado",
				templateUrl: 'src/relatorios/previsto-realizado/relatorioPrevistoRealizado.Ctrl.html',
				controller: 'RelatorioPrevistoRealizadoCtrl',
				resolve: { onEnter: () => window.stop() }
			})
			.state('RelContAnal', {
				url: "/relatorio/contasPagar/analitico",
				templateUrl: 'src/relatorios/contas-pagar/analitico/relCPAnalitico.Ctrl.html',
				controller: 'RelatorioContasPagarAnaliticoCtrl',
				resolve: { onEnter: () => window.stop() }
			})
			.state('RelContSint', {
				url: "/relatorio/contasPagar/sintetico",
				templateUrl: 'src/relatorios/contas-pagar/sintetico/relCPSintetico.Ctrl.html',
				controller: 'RelatorioContasPagarSinteticoCtrl',
				resolve: { onEnter: () => window.stop() }
			})
			.state('RelInadAnal', {
				url: "/relatorio/inadimplencia/analitico",
				templateUrl: 'src/relatorios/inadimplencia/analitico/relInadiAnalitico.ctrl.html',
				controller: 'RelatorioInadimplenciaAnaliticoCtrl',
				resolve: { onEnter: () => window.stop() }
			})
			.state('RelInad', {
				url: "/relatorio/inadimplentes",
				templateUrl: 'src/relatorios/inadimplencia/inadimplentes/relInadiInadimplentes.ctrl.html',
				controller: 'RelatorioInadimplentesCtrl',
				resolve: { onEnter: () => window.stop() }
			})
			.state('RelTitProv', {
				url: "/relatorio/titulosProvisionados",
				templateUrl: 'src/relatorios/contas-receber/titulosProvisionados/relCRTitulosProvisionados.Ctrl.html',
				controller: 'TitulosProvisionadosCtrl',
				resolve: { onEnter: () => window.stop() }
			})	
			.state('RelTitReceb', {
				url: "/relatorio/titulosRecebidos",
				templateUrl: 'src/relatorios/contas-receber/titulos-recebidos/relCRTitulosRecebidos.Ctrl.html',
				controller: 'TitulosRecebidosRelatorioCtrl',
				resolve: { onEnter: () => window.stop() }
			})
	});