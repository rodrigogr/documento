'use strict'
angular.module('AssembleiasModule', [
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
				url: "/assembleia",
				templateUrl: 'src/assembleias/assembleia/assembleiaAssembleias.ctrl.html',
				controller: 'AssembleiaAssembleiasCtrl',
				resolve: {onEnter: () => window.stop()}
			});
	});