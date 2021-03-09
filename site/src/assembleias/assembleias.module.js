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
			.state('assembleiaResumo', {
				url: "/assembleias/resumo",
				templateUrl: 'src/assembleias/resumo/resumoAssembleias.ctrl.html',
				controller: 'ResumoAssembleiasCtrl',
				resolve: {onEnter: () => window.stop()}
			});
	});