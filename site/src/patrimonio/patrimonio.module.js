'use strict'
angular.module('PatrimonioModule', ['ui.utils.masks'])
    .config(function ($stateProvider, $urlRouterProvider)
    {
        $stateProvider
            .state('PatrimonioBens', {
                url: '/patrimonio/bens',
                templateUrl: 'src/patrimonio/bens/bens.ctrl.html',
                controller: 'PatrimonioBensCtrl',
                resolve: { onEnter: stop.bind() }
            })
            .state('PatrimonioManutencao', {
                url: '/patrimonio/manutencao',
                templateUrl: 'src/patrimonio/manutencao/manutencao.ctrl.html',
                controller: 'PatrimonioManutencaoCtrl',
                resolve: { onEnter: stop.bind() }
            })
            .state('PatrimonioBaixa', {
                url: '/patrimonio/baixa',
                templateUrl: 'src/patrimonio/baixa/baixa.ctrl.html',
                controller: 'PatrimonioBaixaCtrl',
                resolve: { onEnter: stop.bind() }
            })
            .state('PatrimonioApolice', {
                url: '/patrimonio/apolice',
                templateUrl: 'src/patrimonio/apolice/apolice.ctrl.html',
                controller: 'PatrimonioApoliceCtrl',
                resolve: { onEnter: stop.bind() }

            })
    });
