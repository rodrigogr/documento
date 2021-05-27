'use strict'
angular.module('appDirectives').directive("assembleiapautas", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/pautas/pautas.html',
        controller: assembleiaPautasCtrl
    }
});

function assembleiaPautasCtrl ($scope, $state, $filter, UtilsService, AuthService, config, $http)
{
    $scope.resumoPautas = [];
    $scope.detalhesPautas = [];
    $scope.ultimaAlternativa = 0;
    $scope.motivoSuspender = '';
    $scope.pautaSelecao = {};
    $scope.suspender = false;
    $scope.votacaoIniciada = false;
    $scope.totalVotos = 8;

    function getPautasAssembleia(id = 0)
    {
        var promisse = ($http.get(`${config.apiUrl}api/assembleias/pautas/`+$state.params.id));
        promisse.then(function (retorno) {
            $scope.resumoPautas = retorno.data.data;
        }).finally( () => {
        });
    }

    function getDetalhesPautas(id_pauta)
    {
        $scope.pautaSelecao = {};
        var promisse = ($http.get(`${config.apiUrl}api/pautas/`+id_pauta));
        promisse.then(function (retorno) {
            $scope.pautaSelecao = retorno.data.data[0];
            //console.log($scope.pautaSelecao);
        }).finally( () => {
            $scope.ultimaAlternativa = $scope.pautaSelecao.alternativas.length;
        });
    }

    getPautasAssembleia();

    $scope.abrePauta = function (idPauta){
        getDetalhesPautas(idPauta);
        $('#abrePauta').modal('show');
    }

    $scope.fechaPauta = function () {
        $('#abrePauta').modal('hide');
    }

    $scope.abreSuspenderPauta = function (){
        $('#suspenderPauta').modal('show');
    }

    $scope.fechaSuspenderPauta = function () {
        $('#suspenderPauta').modal('hide');
        $scope.motivoSuspender = '';
    }

    $scope.addNewAlternativa = function(index) {
        $scope.ultimaAlternativa++;
        $scope.pautaSelecao.alternativas.push({'id' : $scope.ultimaAlternativa, 'opcao' : ''});
    };

    $scope.removeNewAlternativas = function(index) {
        $scope.ultimaAlternativa--;
        $scope.pautaSelecao.alternativas.splice(index,1);
    };

    $scope.salvarAlteracoesPauta = function(){
        $("#loading").modal("show");
        $http({
            method: "PUT",
            url: `${config.apiUrl}api/pautas/`+ $scope.pautaSelecao.id,
            data: JSON.stringify($scope.pautaSelecao.id),
            headers:{
                'Authorization': 'Bearer '+ AuthService.getToken()
            },
        }).then(function successCallback(response) {
                UtilsService.toastSuccess("Pauta salva com sucesso!");
                getPautasAssembleia();
                $('#abrePauta').modal('hide');
            }, function errorCallback(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( () => { $("#loading").modal("hide") });
    }

    $scope.suspenderPauta = function(){
        $scope.suspender = true;
        console.log($scope.motivoSuspender);
    }

}