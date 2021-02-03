'use strict'
angular.module('ReservasModule', [
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
	.config(function ($stateProvider) {
		$stateProvider
			.state('reservaLocal', {
				url: "/reservas/local",
				templateUrl: 'src/reservas/local-reservavel/localReservavel.html',
				controller: 'LocalReservavelCtrl',
				resolve: {onEnter: () => window.stop()}
			})
			.state('reservaCalendario', {
				url: "/reservas/calendario",
				templateUrl: 'src/reservas/calendario-reserva/calendarioReserva.html',
				controller: 'CalendarioReservaCtrl',
				resolve: {onEnter: () => window.stop()}
			})
			.state('reservaAprovacao', {
				url: "/reservas/aprovacao",
				templateUrl: 'src/reservas/aprovacao-pendente/aprovacaoPendente.html',
				controller: 'AprovacaoReservaCtrl',
				resolve: {onEnter: () => window.stop()}
			});
	});