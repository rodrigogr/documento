'use strict'
angular.module('appDirectives').directive("assembleiaquestoes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/questoes-ordem/questoesOrdem.html',
        controller: assembleiaQuestoesOrdemCtrl
    }
});

function assembleiaQuestoesOrdemCtrl($scope, $http, $state, $filter, AuthService, UtilsService, config) {
    $scope.novaVotacaoSelecao = {};
    $scope.ultimaAlternativa = 1;
    $scope.questoesPendentes = [];

    //#######Retorna normal#########
    // $scope.filterPendentes = function () {
    //     return function (questao) {
    //         for (let i in $scope.questoesPendentes) {
    //             if (!$scope.questoesPendentes[i] || questao.status === 'Pendente de decisão') {
    //                 return true;
    //             }
    //         }
    //     }
    // }
    //#########Retorna vazio############
    $scope.filterPendentes = function () {
        return function (questao) {
            for (let i in $scope.questoesPendentes) {
                if (!$scope.questoesPendentes[i] || questao.status === 'Pendente de decisão') {
                    return true;
                } else {
                    return false;
                }
            }
        }
    }

    $scope.addNewAlternativa = function (index) {
        $scope.ultimaAlternativa++;
        $scope.novaVotacaoSelecao.alternativas.push({'id': '', 'opcao': ''});
    };

    $scope.removeNewAlternativas = function (index) {
        $scope.ultimaAlternativa--;
        $scope.novaVotacaoSelecao.alternativas.splice(index, 1);
    };

    //** Modal Questão de ordem */
    $scope.abreQuestaoOrdem = function (id) {
        console.log(id);
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/questoes-ordem/detalhar/`+ id));

        promisse.then(function (retorno)
        {
            $scope.questaoOrdem= retorno.data.data;
        }).finally( () =>
        {
            $(".loader").hide();
        });

        $('#abreQuestaoOrdem').modal('show');
    }

    function listaQuestoesOrdem()
    {
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/questoes-ordem/`+ $state.params.id));
        promisse.then(function (retorno) {
            $scope.listQuestoes = retorno.data.data;
        }).finally( () => {
            $(".loader").hide();
        });
    }

    listaQuestoesOrdem();

    $scope.fechaQuestaoOrdem = function ()
    {
        $scope.questaoOrdem = {};
        $('#abreQuestaoOrdem').modal('hide');
        listaQuestoesOrdem();
    }

    $scope.novaDecisao = function (id)
    {
        console.log(id);
        $scope.decisao = {
            'id_questao_ordem': id,
            'fundamentacao': '',
            'status': 'indeferida'
        };

        $('#novaDecisao').modal('show');
    }

    $scope.fecharDecisao = function ()
    {
        $scope.decisao = {};
        $('#novaDecisao').modal('hide');
    }

    $scope.cadastrarDecisao = function()
    {
        $("#loading").modal("show");

        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.decisao.id_pessoa = user.id_pessoa;

        $http({
            method: "POST",
            url: `${config.apiUrl}api/assembleias/questoes-ordem/decisao`,
            data: $scope.decisao,
            headers:{
                'Authorization': 'Bearer '+ AuthService.getToken()
            }
        }).then(function(response) {
            UtilsService.toastSuccess("Decisão Realizada!");
            $('#novaDecisao').modal('hide');
            $scope.abreQuestaoOrdem($scope.decisao.id_questao_ordem);
            $scope.decisao = {};
        }, function(error) {
            UtilsService.openAlert(error.data.message);
        }).finally( () => { $("#loading").modal("hide") });
    }

    $scope.encerraEnviosQuestaoOrdem = function ()
    {
        $("#loading").modal("show");
        var promisse = ($http.get(`${config.apiUrl}api/assembleias/questoes-ordem/encerrar/`+ $state.params.id));
        promisse.then( function (result) {
            UtilsService.toastSuccess("Envios Encerrados!");
        }, function (error) {
            UtilsService.openAlert(error.data.message);
        }).finally( () => {
            $("#loading").modal("hide")
        });
    }
    $scope.abreNovaVotacao = function ()
    {
        $('#novaVotacao').modal('show');
    }
    $scope.fechaNovaVotacao = function ()
    {
        $('#novaVotacao').modal('hide');
    }


    // function noFilter(filterObj) {
    //      return Object.
    //      keys(filterObj).
    //      every(function (key) { return !filterObj[key]; });
    //  }
};
