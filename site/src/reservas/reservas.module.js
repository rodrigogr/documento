'use strict'
angular.module('ReservaModules', [
		'ui.router',
		'ngAria',
		'toastr',
		'oitozero.ngSweetAlert'
	])
	.config(function ($stateProvider, $urlRouterProvider) {
		$stateProvider
			.state('ReservaLocal', {
				url: "/reservas/local",
				templateUrl: 'src/reservas/local-reservavel/localReservavel.ctrl.html',
				controller: 'LocalReservavelCtrl'
			})
	});