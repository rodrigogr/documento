'use strict'
angular.module('EstoqueModule', [
    'ui.router',
    'appDirectives',
    'appFilters',
    'ngAria',
    'ui.utils.masks',
    'toastr',
    'ngMask',
    'oitozero.ngSweetAlert',
    'ui.tinymce',
    'ui.bootstrap'
  ])
  .config(function ($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('estoqueEstoque', {
        url: "/estoque/estoque",
        templateUrl: 'src/estoque/estoque/estoque.ctrl.html',
        controller: 'EstoqueCtrl',
        resolve: { onEnter: () => window.stop() }
      })
      .state('estoqueMovimentacoes', {
        url: "/estoque/movimentacao",
        templateUrl: 'src/estoque/movimentacoes/estoqueMovi.ctrl.html',
        controller: 'EstoqueMoviCtrl',
        resolve: { onEnter: () => window.stop() }
      })
  });