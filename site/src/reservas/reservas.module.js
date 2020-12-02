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
				templateUrl: 'src/reservas/local-reservavel/localReservavel.ctrl.html',
				controller: 'LocalReservavelCtrl',
				resolve: {onEnter: () => window.stop()}
			});
	});