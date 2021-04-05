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
            comentarios: 32,
            interacao_hora: '18:33',                                                  
            interacao_data: '2021-03-10'                                                    
        },
        {
            id: 2,
            pauta: '03',
            titulo: 'Devemos reformar o parquinho imediatamente?',
            topicos: 2,
            comentarios: 9,
            interacao_hora: '13:00',                                                  
            interacao_data: '2021-04-03'                                                      
        },
        {
            id: 3,
            pauta: '03',
            titulo: 'Qual empresa de segurança devemos contratar?',
            topicos: 8,
            comentarios: 101,
            interacao_hora: '09:13',                                                  
            interacao_data: '2021-04-22'                                                     
    }];

    moment.locale('pt-br');
    $scope.converteDateParaPtBR = function(date){
        return moment(date).format('L');
    }

    //** Modal Discussão */
    $scope.abreDiscussao = function (index) {
        console.log('id discussão', index);
        $('#abreDiscussao').modal('show');
    }

    $scope.fechaDiscussao = function () {
        $('#abreDiscussao').modal('hide');
    }
    //** Modal Discussão */

}