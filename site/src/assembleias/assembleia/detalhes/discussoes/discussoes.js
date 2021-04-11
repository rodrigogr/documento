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


    let url_api = 'http://localhost:8001/';
    $scope.listaDeDiscussoes = [];
    let idAssembleia = '2'; //Verificar como vou pegar o id da assembleia aberta

    function buscaDiscussoes()
    {
        console.log(idAssembleia);
        var promise = $http.get(url_api+'api/assembleias/discussoes/'+idAssembleia);
        promise.then(function (retorno) {
            $scope.listaDeDiscussoes = retorno.data.data;
            console.log($scope.listaDeDiscussoes);
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

        $scope.selectDiscussao = []
        $scope.listaDeDiscussoes.find((item, index) => {
            console.log(item);
            console.log(index);
            if(item.id_pauta === id){
                console.log("entrou no if");
                $scope.selectDiscussao = $scope.listaDeDiscussoes[index].comentarios;
                return $scope.selectDiscussao;
            } 
        })

        console.log($scope.selectDiscussao);
        $('#abreDiscussao').modal('show');
    }

    $scope.fechaDiscussao = function () {
        $('#abreDiscussao').modal('hide');
    }
    //** Modal Discussão */


    //** Modal Detalhe do tópico */
    $scope.detalheTopico = function (id) {
        console.log(id);

        $scope.listDetalheTopico = {        
            id: 1,
            foto: '../../../../../img/avatar.png',
            nome: 'Joaquim Almeida',
            titulo: 'Há outras prioridades no momento, como discutido em outra assembleia Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            descricao: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac cursus mauris, ut porta tellus. Nulla molestie imperdiet enim vel cursus. Nullam dictum vitae quam ut sollicitudin. Nulla iaculis pharetra orci ut efficitur. Sed ut orci fringilla, sagittis nunc et, consequat neque. Phasellus in dignissim risus, ut laoreet massa. Praesent volutpat, quam eu suscipit volutpat, nulla enim finibus ante, vitae venenatis mauris erat in purus. Nulla facilisi.',
            like: '12',
            comentarios: [{
                id: 64,
                foto: '../../../../../img/avatar.png',
                nome: 'Joaquim Almeida',
                comentario: 'Pellentesque a ultrices neque, in facilisis ipsum. Vestibulum rutrum nisl nec purus malesuada vehicula. Phasellus nec lobortis nisi. Curabitur id nulla consequat felis lacinia auctor. Sed sed lorem purus. Nulla facilisi.'
            },{
                id: 65,
                foto: '../../../../../img/avatar.png',
                nome: 'Joaquim Almeida',
                comentario: 'Pellentesque a ultrices neque, in facilisis ipsum. Vestibulum rutrum nisl nec purus malesuada vehicula. Phasellus nec lobortis nisi. Curabitur id nulla consequat felis lacinia auctor. Sed sed lorem purus. Nulla facilisi.'
            },{
                id: 66,
                foto: '../../../../../img/avatar.png',
                nome: 'Joaquim Almeida',
                comentario: 'Pellentesque a ultrices neque, in facilisis ipsum. Vestibulum rutrum nisl nec purus malesuada vehicula. Phasellus nec lobortis nisi. Curabitur id nulla consequat felis lacinia auctor. Sed sed lorem purus. Nulla facilisi.'
            }],
        }

        $('#detalheTopico').modal('show');
    }

    $scope.fechaDetalheTopico = function () {
        $('#detalheTopico').modal('hide');
    }
    //** Modal Detalhe do tópico */


    //** Modal Detalhe do tópico */
    $scope.responderComentario = function (id) {
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