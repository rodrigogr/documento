'use strict'
angular.module('AssembleiasModule').controller('AssembleiaAssembleiasCtrl',
    function ($scope, $state, $http, $filter, AssembleiaService, HeaderFactory, AuthService, UtilsService, config) {

        
        HeaderFactory.setHeader('assembleia', 'Assembleias');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.listAssembleias = [];
        AssembleiaService.read().then(responseAssembleias => {
            $scope.listAssembleias = responseAssembleias.data;
        });

        $scope.assembleia = {
            tipo: '',
            titulo: '',
            status: 'agendada',
            data_inicio: '',
            data_fim: '',
            hora_inicio: '',
            hora_fim: '',
            votacao_data_inicio: '',
            votacao_hora_fim: '',
            configuracao: true,
            link_transmissao: '',
            votacao_secreta: false,
            documentos: [],
            pautas: '',
            participantes: ''
        }

        moment.locale('pt-br');
        $scope.converteDateParaPtBR = function(date){
            return moment(date).format('L');
        }

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
            var newItemNo = $scope.assembleia.pautas[index].alternativas.length+1;
            $scope.assembleia.pautas[index].alternativas.push({'id' : 'alternativa' + newItemNo, 'name' : 'Alternativa'});
        };

        $scope.removeNewAlternativas = function(indexPauta) {
            var newItemNo = $scope.assembleia.pautas[indexPauta].alternativas.length-1;
            if (newItemNo !== 0) {
                $scope.assembleia.pautas[indexPauta].alternativas.pop();
            }
        };

        $scope.showAddAlternativa = function(alternativa, indexPauta) {
            return alternativa.id === $scope.assembleia.pautas[indexPauta].alternativas[$scope.assembleia.pautas[indexPauta].alternativas.length-1].id;
            // return pauta[index].alternativa.id === $scope.pautas.alternativas[$scope.pautas.alternativas.length-1].id;
        };

        $scope.assembleia.pautas = [{
            id: 'pauta1',
            perguntas: '',
            alternativas: [{
                id: 'alternativa1',
                name: ''
            },{
                id: 'alternativa2',
                name: ''
            }]
        }];

        $scope.addNewPauta = function(){
            var newItemNo = $scope.assembleia.pautas.length+1;
            $scope.assembleia.pautas.push({
                id : 'pauta' + newItemNo, 
                name : '', 
                alternativas: [{
                    id: 'alternativa1',
                    name: ''
                }]
            });
        }

        $scope.removeNewPauta = function() {
            var newItemNo = $scope.assembleia.pautas.length-1;
            if (newItemNo !== 0) {
                $scope.assembleia.pautas.pop();
            }
        };

        /** List All Participantes  */
        $scope.assembleia.participantes = [
            {
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
        }
    ];

        $scope.validDataCreate = function(){
            let formatDateInicioEn = $filter('formatOtherDate')('yyyy/mm/dd', $scope.assembleia.data_inicio);
            let formatDateFimEn = $filter('formatOtherDate')('yyyy/mm/dd', $scope.assembleia.data_fim);
            let formatDateVotacaoEn = $filter('formatOtherDate')('yyyy/mm/dd', $scope.assembleia.votacao_data_inicio);
            $scope.assembleia.data_inicio = formatDateInicioEn;
            $scope.assembleia.data_fim = formatDateFimEn;
            $scope.assembleia.votacao_data_inicio = formatDateVotacaoEn;
        }

        $scope.salvar = async function () {
            $("#loading").modal("show");
            $scope.validDataCreate();
            $http({
                method: "POST",
                url: `${config.apiUrl}api/assembleias`,
                data: $scope.assembleia,
                headers:{
                    'Authorization': 'Bearer '+ AuthService.getToken()
                }
            })
            .then(function(response) {
                UtilsService.toastSuccess("Assembleia salva com sucesso!");
                $('#cadastroAssembleia').modal('hide');
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( () => { $("#loading").modal("hide") });
        }
    });