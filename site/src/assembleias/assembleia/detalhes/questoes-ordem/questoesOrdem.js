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

    $scope.filterPendentes = function () {
        return function (questao) {
            for (let i in $scope.questoesPendentes) {
                if (!$scope.questoesPendentes[i] || questao.status === 'Pendente de decisão') {
                    return true;
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

    $scope.novaVotacao = {
        id_assembleia: null,
        votacao_data_fim: '',
        votacao_hora_fim: '',
        pergunta: '',
        alternativas: [{
            id: 'alternativa1',
            opcao: ''
        },{
            id: 'alternativa2',
            opcao: ''
        }]
    }

    function listaVotacoesQuestoesOrdem()
    {
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/questoes-ordem-votacoes/`+ $state.params.id));
        promisse.then(function (retorno) {
            $scope.listVotacoesQuestoes = retorno.data.data;
        }).finally( () => {
            $(".loader").hide();
        });
    }

    listaVotacoesQuestoesOrdem();

    $scope.abreNovaVotacao = function ()
    {
        var promisse = ($http.get(`${config.apiUrl}api/assembleias/questoes-ordem-votacoes/verifica-votacao-aberta/`+ $state.params.id));
        promisse.then(function (retorno) {
            if (retorno.data)
            {
                UtilsService.openAlert("Só é possível uma votação por vez. Necessário encerrar a votação atual.");
                return;
            }
            $scope.novaVotacao.id_assembleia = $state.params.id;
            $('#novaVotacao').modal('show');
        }).finally( () => {
            $(".loader").hide();
        });

    }

    $scope.fechaNovaVotacao = function ()
    {
        $('#novaVotacao').modal('hide');
    }

    $scope.createNovaVotacao = async function ()
    {
        $("#loading").modal("show");

        console.log($scope.novaVotacao);

        $http({
            method: "POST",
            url: `${config.apiUrl}api/assembleias/questoes-ordem-votacoes`,
            data: $scope.novaVotacao,
            headers:{
                'Authorization': 'Bearer '+ AuthService.getToken()
            }
        })
            .then(function(response) {
                UtilsService.toastSuccess("Nova votacão criada com sucesso!");
                $('#novaVotacao').modal('hide');

                 listaVotacoesQuestoesOrdem();
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( () => { $("#loading").modal("hide") });
    }

    $scope.encerraVotacaoQuestaoOrdem = function ()
    {
        var promisse = ($http.get(`${config.apiUrl}api/assembleias/questoes-ordem-votacoes/encerrar-votacoes/`+ $state.params.id));

        promisse.then(function (retorno) {
          
        }).finally( () => {
            $(".loader").hide();
        });

    }
}
