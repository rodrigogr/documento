'use strict'
angular.module('NotificacoesModules', [
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
			.state('NotfEnvEmail', {
				url: "/notificacoes/envioEmail",
				templateUrl: 'src/notificacoes/enviar-email/enviarEmail.Ctrl.html',
				controller: 'EnvioEmailCtrl'
			})
	});