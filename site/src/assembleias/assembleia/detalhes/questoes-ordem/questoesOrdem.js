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

function assembleiaQuestoesOrdemCtrl($scope, $http, $state, $filter,AuthService, UtilsService, config) {


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


        $scope.processo = [{
                id: 1,
                foto: '../../../../../img/avatar.png',
                nome: 'Leticia',
                titulo: 'Há outras prioridades no momento, como discutido em outra assembleia Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                status: 'indeferida',
                like: '10',
                deslike: '2',
                number: '5',
                anexo: [{
                    file: 'teste'
                }]
            },
            {
                id: 5,
                foto: '../../../../../img/avatar.png',
                nome: 'RAFAEL GONZAGA GONÇALVES',
                titulo: 'Há outras prioridades no momento, como discutido em outra assembleia Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                texto: 'Há outras prioridades no momento, como discutido em outra assembleia\n' +
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac cursus mauris, ut porta tellus. Nulla molestie imperdiet enim vel cursus. Nullam dictum vitae quam ut sollicitudin. Nulla iaculis pharetra orci ut efficitur. Sed ut orci fringilla, sagittis nunc et, consequat neque. Phasellus in dignissim risus, ut laoreet massa. Praesent volutpat, quam eu suscipit volutpat, nulla enim finibus ante, vitae venenatis mauris erat in purus. Nulla facilisi. Donec ut lacinia sapien. Curabitur massa mi, ullamcorper non libero a, accumsan interdum quam. Vestibulum pharetra ipsum eget risus aliquam tristique sed a augue. Aenean ultrices iaculis est auctor tempor. Cras at dui varius, volutpat augue quis, sodales mauris. Vivamus eleifend interdum magna a euismod. In finibus interdum cursus.',

                anexo: [{
                    file: 'teste'
                }]
            },
            {
                id: 7,
                foto: '../../../../../img/avatar.png',
                nome: 'Joaquim Almeida',
                titulo: 'Há outras prioridades no momento, como discutido em outra assembleia Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                like: 10,
                deslike: 2,
                number: 5
            }
        ];

        $('#abreQuestaoOrdem').modal('show');
    }

    function listaQuestoesOrdem()
    {
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/questoes-ordem/`+ $state.params.id));
        promisse.then(function (retorno) {
            $scope.listQuestoes = retorno.data.data;
            console.log($scope.listQuestoes);
        }).finally( () => {
            $(".loader").hide();
        });
    }

    listaQuestoesOrdem();

    $scope.fechaQuestaoOrdem = function () {
        $('#abreQuestaoOrdem').modal('hide');
    }

    $scope.novaDecisao = function (id)
    {
        console.log(id);
        $scope.decisao = {
            'id_questao_ordem': id,
            'funtamentacao': '',
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

}