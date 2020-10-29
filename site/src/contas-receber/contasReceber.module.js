'use strict'
angular.module('ContasReceberModule', [
  'ngSanitize',
  'ui.router',
  'appDirectives',
  'appFilters',
  'ngAria',
  'ui.utils.masks',
  'ngAnimate',
  'toastr',
  'ngMask',
  'oitozero.ngSweetAlert',
  'ui.tinymce'
]).config(function ($stateProvider) {
  $stateProvider
    .state('RecbConsArqRet', {
      url: "/receber/consultaArquivoRetorno",
      templateUrl: 'src/contas-receber/consulta-arq-retorno/consultaArqRetorno.ctrl.html',
      controller: 'ConsultaArquivoRetornoCtrl',
      resolve: { onEnter: () => window.stop() }
    })
    .state('RecbPreLanc', {
      url: "/receber/preLancamento",
      templateUrl: 'src/contas-receber/pre-lancamentos/preLancamentos.ctrl.html',
      controller: 'PreLancamentoCtrl',
      resolve: { onEnter: () => window.stop() }
    })
    .state('RecbLancAvul', {
      url: "/receber/lancamentoAvulso",
      templateUrl: 'src/contas-receber/lancamento-avulso/lancamentoAvulso.ctrl.html',
      controller: 'LancamentoAvulsoCtrl',
      resolve: { onEnter: () => window.stop() }
    })
    .state('RecbSimuCalcReceita', {
      url: "/receber/simulacaoCalculoReceita",
      templateUrl: 'src/contas-receber/simular-calcular/simularCalcular.ctrl.html',
      controller: 'SimulacaoCalculoReceitaCtrl',
      resolve: { onEnter: () => window.stop() }
    })
    .state('RecbManual', {
      url: "/receber/recebimentoManual",
      templateUrl: 'src/contas-receber/recebimentos-manuais/recebimentoManual.ctrl.html',
      controller: 'RecebimentoManualCtrl',
      resolve: { onEnter: () => window.stop() }
    })
    .state('RecbLancReco', {
      url: "/receber/lancamentoRecorrente",
      templateUrl: 'src/contas-receber/lancamento-recorrente/lancamentoRecorrente.ctrl.html',
      controller: 'LancamentoRecorrenteCtrl',
      resolve: { onEnter: () => window.stop() }
    })
    .state('RecbAuto', {
      url: "/receber/recebimentoAutomatico",
      templateUrl: 'src/contas-receber/recebimento-automatico/recebimentoAutomatico.ctrl.html',
      controller: 'RecebimentoAutomaticoCtrl',
      resolve: { onEnter: () => window.stop() }
    })
});