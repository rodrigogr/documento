'use strict'
angular.module('appDirectives').directive("assembleiadiscussoes", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/discussoes/discussoes.html',
        controller: assembleiaDiscussoesCtrl
    }
});

function assembleiaDiscussoesCtrl($scope, $http, $state, $filter, UtilsService, config)
{

    $scope.listaDeDiscussoesAuxiliar = [{
            id: 1,
            pauta: '01',
            titulo: 'Qual empresa de segurança devemos contratar?',
            topicos: 5,
            count_comentarios: 32,
            interacao_hora: '18:33',                                                  
            interacao_data: '2021-03-10',
            comentarios: [{
                    id: 1,
                    foto: '../../../../../img/avatar.png',
                    nome: 'Joaquim Almeida',
                    titulo: 'Há outras prioridades no momento, como discutido em outra assembleia Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    like: '10',
                    deslike: '2',
                    number: '5'
                },
                {
                    id: 5,
                    foto: '../../../../../img/avatar.png',
                    nome: 'Joaquim Almeida',
                    titulo: 'Há outras prioridades no momento, como discutido em outra assembleia Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    like: 10,
                    deslike: 2,
                    number: 5
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
            ]                                                    
        },
        {
            id: 2,
            pauta: '03',
            titulo: 'Devemos reformar o parquinho imediatamente?',
            topicos: 2,
            count_comentarios: 9,
            interacao_hora: '13:00',                                                  
            interacao_data: '2021-04-03',
            comentarios: []                                                      
        },
        {
            id: 3,
            pauta: '03',
            titulo: 'Qual empresa de segurança devemos contratar?',
            topicos: 8,
            count_comentarios: 101,
            interacao_hora: '09:13',                                                  
            interacao_data: '2021-04-22',
            comentarios: []                                                    
    }];



    $scope.listaDeDiscussoes = [];

    function buscaDiscussoes()
    {
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/discussoes/`+ $state.params.id));
        promisse.then(function (retorno) {
            $scope.listaDeDiscussoes = retorno.data.data;
            console.log($scope.listaDeDiscussoes);
        }).finally( () => {
            $(".loader").hide();
        });
    }

    buscaDiscussoes();

    moment.locale('pt-br');

    $scope.converteDateParaPtBR = function(date){
        return moment(date).format('L');
    }

    $scope.extractHorario = function(horario){
        let time = (moment(horario).hour()+":"+moment(horario).minute());
        return time;
    }

    //** Modal Discussão */
    $scope.abreDiscussao = function (id) {
        console.log('id discussão', id);
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/discussoes/topicos/pauta/`+ id));

        promisse.then(function (retorno)
        {
            $scope.discussaoPauta = retorno.data.data;

        }).finally( () =>
        {
            $(".loader").hide();
        });

        $('#abreDiscussao').modal('show');
    }

    $scope.fechaDiscussao = function () {
        $scope.discussaoPauta = [];
        $('#abreDiscussao').modal('hide');
    }
    //** Modal Discussão */


    //** Modal Detalhe do tópico */
    $scope.detalheTopico = function (id) {
        console.log(id);
        $(".loader").show();

        var promisse = ($http.get(`${config.apiUrl}api/assembleias/discussoes/topicos/`+ id));

        promisse.then(function (retorno)
        {
            $scope.topico = retorno.data.data;

        }).finally( () =>
        {
            $(".loader").hide();
        });

        $('#detalheTopico').modal('show');
    }

    $scope.fechaDetalheTopico = function ()
    {
        $scope.topico = '';
        $('#detalheTopico').modal('hide');
    }
    //** Modal Detalhe do tópico */


    //** Modal Detalhe do tópico */
    $scope.responderComentario = function (id) {
        console.log(id);
        
        $scope.respostaDoComentario = '';
        $('#responderComentario').modal('show');
    }

    $scope.comentar = function (id) {
        console.log(id);

        $scope.respostaDoComentario = '';
        $('#responderComentario').modal('show');
    }

    $scope.fechaResponderComentario = function () {
        $('#responderComentario').modal('hide');
    }
    //** Modal Detalhe do tópico */

    /** Cadastrar comentario */
    $scope.cadastrarComentario = function(idComentario){
        console.log(`id: ${idComentario}, comentario: ${$scope.respostaDoComentario}`);
        $scope.fechaResponderComentario();
    }
    /** Cadastrar comentario */


}