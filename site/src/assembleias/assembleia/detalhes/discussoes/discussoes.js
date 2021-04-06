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

function assembleiaDiscussoesCtrl($scope, $state, $filter, UtilsService, config)
{

    $scope.listaDeDiscussoes = [{
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

    moment.locale('pt-br');
    $scope.converteDateParaPtBR = function(date){
        return moment(date).format('L');
    }

    //** Modal Discussão */
    $scope.abreDiscussao = function (id) {
        console.log('id discussão', id);

        $scope.selectDiscussao = []
        $scope.listaDeDiscussoes.find((item, index) => {
            if(item.id === id){
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

}