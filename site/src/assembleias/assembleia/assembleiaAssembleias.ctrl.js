'use strict'
angular.module('AssembleiasModule').controller('AssembleiaAssembleiasCtrl',
    function ($scope, $state, $http, HeaderFactory, AuthService, UtilsService, config) {

        
        HeaderFactory.setHeader('assembleia', 'Assembleias');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);



        moment.locale('pt-br');
        $scope.converteDateParaPtBR = function(date){
            return moment(date).format('L');
        }

        /** List All Reservas  */
        $scope.listAssembleias = [{
            titulo: 'Assembleia Geral Ordinária',
            status: 'Agendada',
            date: '2021-01-20',
            hora: '20:00',
            tipo: 'Geral',
            local: 'Somente online'
        }, 
        {
            titulo: 'Assembleia Geral Extraordinária',
            status: 'Em andamento',
            date: '2021-02-16',
            hora: '20:00',
            tipo: 'Geral',
            local: 'Online e presencial'
        },
        {
            titulo: 'Assembleia Interna',
            status: 'Encerrada',
            date: '2021-03-09',
            hora: '20:00',
            tipo: 'Interna',
            local: 'Somente online'
        }];

        //** Modal nova assembleia */
        $scope.createNewAssembleia = function () {
            $scope.step = 1;
            $('#cadastroAssembleia').modal('show');
        }

        $scope.closeModalAssembleia = function () {
            $('#cadastroAssembleia').modal('hide');
        }
    });