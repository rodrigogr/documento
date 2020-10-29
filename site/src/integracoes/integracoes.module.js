'use strict'
angular.module('IntegracoesModules', [
		'ui.router'
	])
	.config(function ($stateProvider) {
		$stateProvider
			.state('arquivoContabil', {
				url: "/integracoes/arquivoContabil",
				templateUrl: 'src/integracoes/arquivo-contabil/arquivoContabil.html',
				controller: 'ArqContabilCtrl'
			})
	});