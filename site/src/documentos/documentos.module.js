'use strict'
angular.module('DocumentosModule', [
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
			.state('documento', {
				url: "/documento",
				templateUrl: 'src/documentos/documentos/documentos.html',
				controller: 'DocumentosCtrl',
				resolve: {onEnter: () => window.stop()}
			})
	});