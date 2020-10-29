'use strict'
angular.module('ComprasModule', [
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
  .config(function ($stateProvider) {
    $stateProvider
      .state('ComprasAprovador', {
        url: "/compras/aprovador",
        templateUrl: 'src/compras/aprovadores/comprasAprovadores.ctrl.html',
        controller: 'AprovadorCtrl',
        resolve: { onEnter: () => window.stop() }
      })
      .state('ComprasPedido', {
        url: "/pedido",
        templateUrl: 'src/compras/pedidos/comprasPedidos.ctrl.html',
        controller: 'PedidoCtrl',
        resolve: { onEnter: () => window.stop() }
      })
      .state('ComprasSolicitacoes', {
        url: "/solicitacao",
        templateUrl: 'src/compras/solicitacoes/comprasSolicitacoes.ctrl.html',
        controller: 'SolicitacaoCtrl',
        resolve: { onEnter: () => window.stop() }
      })
      .state('ComprasPainel', {
        url: "/painel-aprovacao",
        templateUrl: 'src/compras/painel-aprovacao/comprasPainelAprovacao.ctrl.html',
        controller: 'PainelAprovacaoCtrl',
        resolve: { onEnter: () => window.stop() }
      })
  });