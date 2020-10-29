'use strict'
angular.module('BancoCaixaModule', [])
    .config(function ($stateProvider) {
        $stateProvider
            .state('BncCxContas', {
                url: "/banco-caixa/contas",
                templateUrl: 'src/banco-caixa/contas/contas.ctrl.html',
                controller: 'ContasCtrl',
                resolve: { onEnter: () => window.stop() }
            })
            .state('BncCxFluxo', {
                url: "/banco-caixa/fluxo",
                templateUrl: 'src/banco-caixa/fluxo/fluxo.ctrl.html',
                controller: 'FluxoCtrl',
                resolve: { onEnter: () => window.stop() }
            })
    });