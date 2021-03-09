'use strict'
angular.module('AssembleiaModule', [
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
			.state('assembleia', {
				url: "/assembleias/",
				templateUrl: 'src/assembleia/home/home.ctrl.html',
				controller: 'AssembleiaHomeCtrl',
				resolve: {onEnter: () => window.stop()}
			});
	});