'use strict'
angular.module('AssembleiasModule').controller('AssembleiaDetalhesCtrl',
    function ($scope, $state, $http, HeaderFactory, UtilsService, config) {


        HeaderFactory.setHeader('assembleia', 'Detalhes');

    });