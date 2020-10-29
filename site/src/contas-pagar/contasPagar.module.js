'use strict'
angular.module('ContasPagarModule', [
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
            .state('CPCadEstimar', {
                url: "/pagar/estimar",
                templateUrl: 'src/contas-pagar/lancamentos-aprovados/lancamento-estimado/lancamentoEstimado.ctrl.html',
                controller: 'LancamentoEstimadoCtrl',
                resolve: {onEnter: () => window.stop()}
            })
            .state('CPLancamentos', {
                url: "/pagar/lancamentos",
                templateUrl: 'src/contas-pagar/lancamentos/lancamentosContasPagar.ctrl.html',
                controller: 'ContasPagarCtrl',
                resolve: { onEnter: () => window.stop() }

            })
            .state('CPPagamentos', {
                url: "/pagar/pagamentos",
                templateUrl: 'src/contas-pagar/pagamento/pagamentoContasPagar.ctrl.html',
                controller: 'PagamentoCtrl',
                resolve: {onEnter: () => window.stop()}
            })
            .state('CPEstimados', {
                url: "/pagar/lacamentos/estimados",
                templateUrl: 'src/contas-pagar/lancamentos-aprovados/lancamentosAprovados.ctrl.html',
                controller: 'ContasAprovadosCtrl',
                resolve: {onEnter: () => window.stop()}
            })
            .state('CPDetalEstimado', {
                url: "/pagar/estimado/:mes/:ano",
                templateUrl: 'src/contas-pagar/lancamentos-aprovados/detail/detailEstimado.ctrl.html',
                controller: 'LancamentoAprovadoDetalheCtrl',
                resolve: {onEnter: () => window.stop()}
            })
            .state('CPLancamentosCompra', {
                url: "/pagar/lancamentos/compra/:id",
                templateUrl: 'src/contas-pagar/lancamentos/lancamentosContasPagar.ctrl.html',
                controller: 'ContasPagarCtrl',
                params: {compras: true},
                resolve: {onEnter: () => window.stop()}
            })
    });