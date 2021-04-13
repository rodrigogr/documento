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

function assembleiaQuestoesOrdemCtrl($scope, $state, $filter, UtilsService, config) {


    //** Modal Questão de ordem */
    $scope.abreQuestaoOrdem = function (id) {
        console.log(id);

        $scope.selectDiscussao = [{
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
        ];

        $('#abreQuestaoOrdem').modal('show');
    }

    $scope.fechaQuestaoOrdem = function () {
        $('#abreQuestaoOrdem').modal('hide');
    }
    //** Modal Questão de ordem */

}