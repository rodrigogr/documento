'use strict'
angular.module('appDirectives').directive("assembleiaencaminhamentos", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/encaminhamentos/encaminhamentos.html',
        controller: assembleiaEncaminhamentosCtrl
    }
});

function assembleiaEncaminhamentosCtrl ($scope,$http, $state, $filter, AuthService, UtilsService, config)
{
    function listaQuestoesOrdem()
    {
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/encaminhamentos/`+ $state.params.id));
        promisse.then(function (retorno) {
            $scope.listEncaminhamentos = retorno.data.data;
            console.log($scope.listEncaminhamentos);
        }).finally( () => {
            $(".loader").hide();
        });
    }

    listaQuestoesOrdem();

    $scope.abreEncaminhamento = function (id)
    {
        console.log(id);
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/encaminhamento/detalhar/`+ id));

        promisse.then(function (retorno)
        {
            $scope.encaminhamento = retorno.data.data;
        }).finally( () =>
        {
            $(".loader").hide();
        });

        $('#abreEncaminhamento').modal('show');
    }

    $scope.fechaEncaminhamento = function () {
        $('#abreEncaminhamento').modal('hide');
    }

    $scope.responderEncaminhamento = function (id)
    {
        $scope.respostaEncaminhamento = {
            'id_encaminhamento' : id,
            'resposta': ''
        }

        $('#respostaEncaminhamento').modal('show');
    }

    $scope.fecharRespotaEncaminhamento = function ()
    {
        $scope.respostaEncaminhamento = {};
        $('#respostaEncaminhamento').modal('hide');
    }

    $scope.salvarRepostaEncaminhamento = function()
    {
        $("#loading").modal("show");

        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.respostaEncaminhamento.id_pessoa = user.id_pessoa;

        $http({
            method: "POST",
            url: `${config.apiUrl}api/assembleias/encaminhamento/resposta`,
            data: $scope.respostaEncaminhamento,
            headers:{
                'Authorization': 'Bearer '+ AuthService.getToken()
            }
        }).then(function(response) {
            UtilsService.toastSuccess("Resposta Realizada!");
            $('#respostaEncaminhamento').modal('hide');
            $scope.abreEncaminhamento($scope.respostaEncaminhamento.id_encaminhamento);
            $scope.respostaEncaminhamento = {};
        }, function(error) {
            UtilsService.openAlert(error.data.message);
        }).finally( () => { $("#loading").modal("hide") });
    }

    $scope.encerraEnviosEncaminhamento = function ()
    {
        $("#loading").modal("show");
        var promisse = ($http.get(`${config.apiUrl}api/assembleias/encaminhamento/encerrar/`+ $state.params.id));
        promisse.then( function (result) {
            UtilsService.toastSuccess("Envios Encerrados!");
        }, function (error) {
            UtilsService.openAlert(error.data.message);
        }).finally( () => {
            $("#loading").modal("hide")
        });
    }
}