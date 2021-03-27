'use strict'
angular.module('AssembleiasModule').controller('AssembleiaAssembleiasCtrl',
    function ($scope, $state, $http, $filter, AssembleiaService, HeaderFactory, AuthService, UtilsService, config) {

        
        HeaderFactory.setHeader('assembleia', 'Assembleias');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.listAssembleia = function(){
            $scope.listAssembleias = [];
            $(".loader").show();
            var promisse = ($http.get(`${config.apiUrl}api/assembleias`));
                promisse.then(function(result){
                $scope.listAssembleias = result.data.data;
            }).finally(() => $(".loader").hide());
        }
        $scope.listAssembleia();

        $scope.assembleia = {
            tipo: 'geral',
            titulo: '',
            status: 'agendada',
            data_inicio: '',
            data_fim: '',
            hora_inicio: '',
            hora_fim: '',
            votacao_data_inicio: '',
            votacao_hora_fim: '',
            configuracao: false,
            link_transmissao: '',
            votacao_secreta: false,
            documentos: [{
                id: 10,
                file: "data:application/pdf;base64,JVBERi0xLjQNJeLjz9MNCj",
                icon: "img/icons/icon_pdf.png",
                name: "pdf_de_teste.pdf",
            }],
            pautas: '',
            participantes: [],
        }

        //Download
        $scope.arquivoIcon = '';
        $scope.arquivoNome = '';

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
            pergunta: '',
            alternativas: [{
                id: 'alternativa1',
                opcao: ''
            },{
                id: 'alternativa2',
                opcao: ''
            }]
        }];

        $scope.addNewPauta = function(){
            var newItemNo = $scope.assembleia.pautas.length+1;
            $scope.assembleia.pautas.push({
                id : 'pauta' + newItemNo, 
                pergunta : '',
                alternativas: [{
                    id: 'alternativa1',
                    opcao: ''
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
                id_imovel:1,
                id_procurador: 0
            },{
                participar: false,
                unidade: 'Qd 01 / Lt 04',
                peso: 'x1',
                status: 'Impedido',
                procurador: '',
                id_imovel:2,
                id_procurador: 0
            },{
                participar: true,
                unidade: 'Qd 01 / Lt 03',
                peso: 'x2',
                status: 'Participando',
                procurador: '',
                id_imovel:3,
                id_procurador: 0
            },{
                participar: false,
                unidade: 'Qd 01 / Lt 06',
                peso: 'x2',
                status: 'Participando',
                procurador: '',
                id_imovel:4,
                id_procurador: 0
            },{
                participar: false,
                unidade: 'Qd 01 / Lt 12',
                peso: 'x2',
                status: 'Participando',
                procurador: '',
                id_imovel:5,
                id_procurador: 0
            }
        ];

        $scope.validDataCreate = function(){
            let formatDateInicioEn = $filter('formatOtherDate')('yyyy/mm/dd', $scope.assembleia.data_inicio);
            let formatDateFimEn = $filter('formatOtherDate')('yyyy/mm/dd', $scope.assembleia.data_fim);
            let formatDateVotacaoEn = $filter('formatOtherDate')('yyyy/mm/dd', $scope.assembleia.votacao_data_inicio);
            $scope.assembleia.data_inicio = formatDateInicioEn;
            $scope.assembleia.data_fim = formatDateFimEn;
            $scope.assembleia.votacao_data_inicio = formatDateVotacaoEn;

            $scope.assembleia.participantes = $scope.listParticipanteCheckTrue($scope.assembleia.participantes);
        }

        $scope.listParticipanteCheckTrue = function(listParticipantes){  
            let listParticipantesTrue = [];
            listParticipantes.filter((item) => {
                if(item.participar === true){
                    listParticipantesTrue.push(item);
                }
            });
            return listParticipantesTrue;
        }

        $scope.salvar = async function () {
            $("#loading").modal("show");
            $scope.validDataCreate();

            console.log($scope.assembleia);
            
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
                $scope.listAssembleia();
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( () => { $("#loading").modal("hide") });
        }


        //Save PDF
        $scope.changeInputField = function (ele) {
            var file = ele.files[0];

            if (ele.files.length > 0) {
                if (file > 10485760) {
                    return UtilsService.openAlert('Tamanho máximo de anexos permitido foi atingido: 10MB');
                }
                
                $scope.assembleia.documentos_regras = URL.createObjectURL(file);
                iconArquivo(ele.files[0]);

                $scope.getbase64(file, ele.name);

            }
        }

        $scope.getbase64 = function (file, el) {
            let f = file;
            let r = new FileReader();

            r.onloadend = function (e) {

                let infoArquivo = {
                    name:  $scope.arquivoNome,
                    icon: $scope.arquivoIcon,
                    file: e.target.result
                }

                $scope.assembleia[el].push(infoArquivo);
                $scope.$apply();
            };
            $("#inputDocumentos").val('');
            r.readAsDataURL(f);
        }

        function iconArquivo(file) {
            var tipoFile = file.name.split('.')[1];
            var icon = 'file';
            switch (tipoFile) {
                case "jpeg":
                case "jpg":
                    icon = 'jpeg';
                    break;
                case "png":
                    icon = 'png';
                    break;
                case "doc":
                case "docx":
                    icon = 'word';
                    break;
                case "xml":
                case "xls":
                case "xlsx":
                    icon = 'excel';
                    break;
                case "pdf":
                    icon = 'pdf';
                    break;
                case "txt":
                    icon = 'txt'
                    break;
            }
            $scope.arquivoIcon = 'img/icons/icon_'+icon+'.png';
            $scope.arquivoNome = file.name;
        }

        $scope.abreDocumento = function () {
            let file = $scope.assembleia.documentos_regras ? $scope.assembleia.documentos_regras : $scope.assembleia.documentos;
            window.open(file,'_blank');
        }

        $scope.excluirArquivo = function(file, index){
            console.log(file, index);
            $scope.assembleia.documentos.splice(index, 1);
        }

    });