'use strict'
angular.module('AssembleiasModule').controller('AssembleiaAssembleiasCtrl',
    function ($scope, $state, $http, HeaderFactory, AuthService, UtilsService, config) {

        
        HeaderFactory.setHeader('assembleia', 'Assembleias');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);


        $scope.assembleia = {
            reuniao: '',
            titulo: 'Mais um teste',
            data_inicio: '',
            data_fim: '',
            hora_inicio: '',
            hora_fim: '',
            voto_data_inicio: '',
            voto_hora_fim: '',
            configuracao: true,
            link_transmissao: '',
            votacao_secreta: false
        }


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
        //** Modal nova assembleia */


        $scope.goStep = function (step) {
            $('.ba__modal-body-assembleia').scrollTop(0);
            if (typeof step == 'number') {
                $scope.step = step;
            } else if (step === '+') {
                $scope.step = $scope.step + 1;
            } else {
                $scope.step = $scope.step - 1;
            }
        }

        $scope.addNewAlternativa = function(index) {            
            var newItemNo = $scope.pautas[index].alternativas.length+1;
            $scope.pautas[index].alternativas.push({'id' : 'alternativa' + newItemNo, 'name' : 'Alternativa'});
        };

        $scope.removeNewAlternativas = function(indexPauta) {
            debugger
            var newItemNo = $scope.pautas[indexPauta].alternativas.length-1;
            if (newItemNo !== 0) {
                $scope.pautas[indexPauta].alternativas.pop();
            }
        };

        $scope.showAddAlternativa = function(alternativa, indexPauta) {
            return alternativa.id === $scope.pautas[indexPauta].alternativas[$scope.pautas[indexPauta].alternativas.length-1].id;
            // return pauta[index].alternativa.id === $scope.pautas.alternativas[$scope.pautas.alternativas.length-1].id;
        };

        $scope.pautas = [
            {
            id: 'pauta1',
            name: 'pauta1',
            alternativas: [{
                    id: 'alternativa1',
                    name: 'Alternativa'
                },{
                    id: 'alternativa2',
                    name: 'Alternativa'
                }]
            },
            {
            id: 'pauta2',
            name: 'pauta2',
                alternativas: [{
                    id: 'alternativa1',
                    name: 'Alternativa'
                }]
            }
        ];

        $scope.addNewPauta = function(){
            debugger
            var newItemNo = $scope.pautas.length+1;
            $scope.pautas.push({
                id : 'pauta' + newItemNo, 
                name : 'pauta', 
                alternativas: [{
                    id: 'alternativa1',
                    name: 'Alternativa'
                }]
            });
        }

        $scope.removeNewPauta = function() {
            var newItemNo = $scope.pautas.length-1;
            if (newItemNo !== 0) {
                $scope.pautas.pop();
            }
        };

        /** List All Participantes  */
        $scope.listParticipantes = [{
                participar: true,
                unidade: 'Qd 01 / Lt 03',
                peso: 'x2',
                status: 'Participando',
                procurador: '5455 - Antônio Fonseca Salles de Abreu',
            },{
                participar: false,
                unidade: 'Qd 01 / Lt 04',
                peso: 'x1',
                status: 'Impedido',
                procurador: '',
            },{
                participar: true,
                unidade: 'Qd 01 / Lt 03',
                peso: 'x2',
                status: 'Participando',
                procurador: '',
            },{
                participar: false,
                unidade: 'Qd 01 / Lt 06',
                peso: 'x2',
                status: 'Participando',
                procurador: '',
            },{
                participar: false,
                unidade: 'Qd 01 / Lt 12',
                peso: 'x2',
                status: 'Participando',
                procurador: '',
        }];
        
    });