'use strict'
angular.module('InadimplanciaModule', [
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
  .config(function ($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('InadSimuNego', {
        url: "/inadimplencia/simular",
        templateUrl: 'src/inadimplencia/acordo/simular/inadimplenciaSimularNegociar.html',
        controller: 'InadimplenciaSimularNegociarCtrl',
        resolve: { onEnter: () => window.stop() }
      })
      .state('InadAcordEfet', {
        url: "/inadimplencia/acordos",
        templateUrl: 'src/inadimplencia/acordo/efetuados/acordosEfetuados.ctrl.html',
        controller: 'acordosEfetuadosCtrl',
        resolve: { onEnter: () => window.stop() }
      })
      .state('InadClassi', {
        url: "/inadimplencia/classificar",
        templateUrl: 'src/inadimplencia/classificar/inadimplenciaClassificar.ctrl.html',
        controller: 'classificarAcordosCtrl',
        resolve: { onEnter: () => window.stop() }
      })
      .state('InadModeCartaCobr', {
        url: "/inadimplencia/carta/cobranca",
        templateUrl: 'src/inadimplencia/modelos/modeloCartas.ctrl.html',
        controller: 'modeloCartasCtrl',
        params : { isCobranca : true},
        resolve: { onEnter: () => window.stop() }
      })
      .state('InadModeCartaQuit', {
        url: "/inadimplencia/carta/quitacao",
        templateUrl: 'src/inadimplencia/modelos/modeloCartas.ctrl.html',
        controller: 'modeloCartasCtrl',
        params : { isCobranca : false},
        resolve: { onEnter: () => window.stop() }
      })
      .state('InadEnvCartaQuit', {
        url: "/inadimplencia/envio/quitacao",
        templateUrl: 'src/inadimplencia/envios/quitacao/envioCartasQuitacao.ctrl.html',
        controller: 'envioCartasQuitacaoCtrl',
        params : { isCobranca : false},
        resolve: { onEnter: () => window.stop() }
      })
      .state('InadEnvCartCobr', {
        url: "/inadimplencia/envio/cobranca",
        templateUrl: 'src/inadimplencia/envios/cobranca/envioCartasCobranca.ctrl.html',
        controller: 'envioCartasCobrancaCtrl',
        params : { isCobranca : true},
        resolve: { onEnter: () => window.stop() }
      })
  });