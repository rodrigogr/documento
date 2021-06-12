'use strict'
angular.module('appDirectives').directive("assembleiapautas", function () {
    return {
        restrict: 'A',
        replace: true,
        scope: {
            user: '='
        },
        templateUrl: 'src/assembleias/assembleia/detalhes/pautas/pautas.html',
        controller: assembleiaPautasCtrl
    }
});

function assembleiaPautasCtrl ($scope, $state, $filter, UtilsService, AuthService, config, $http)
{
    $scope.resumoPautas = [];
    $scope.detalhesPautas = [];
    $scope.ultimaAlternativa = 0;
    $scope.motivoSuspender = '';
    $scope.totalVotos = 8;
    $scope.pautas = [{
        id: 'pauta1',
        pergunta: '',
        alternativas: [{
            id: 'alternativa1',
            opcao: ''
        }, {
            id: 'alternativa2',
            opcao: ''
        }]
    }];

    function limpaNovaPauta()
    {
        $scope.pautas[0].pergunta = ''
        for (let i = 0; i < $scope.pautas[0].alternativas.length; i++){
            $scope.pautas[0].alternativas[i].opcao = ''
        }
        $scope.pautas[0].alternativas.length = 2
    }

    function getPautasAssembleia(id = 0)
    {
        var promisse = ($http.get(`${config.apiUrl}api/assembleias/pautas/`+$state.params.id));
        promisse.then(function (retorno) {
            $scope.resumoPautas = retorno.data.data;
        });
    }

    function getDetalhesPautas(id_pauta)
    {
        var promisse = ($http.get(`${config.apiUrl}api/pautas/`+id_pauta));
        promisse.then(function (retorno) {
            $scope.pautaSelecao = retorno.data.data;
            $scope.getPautaAnexos($scope.pautaSelecao.id_pauta);
        });
    }

    getPautasAssembleia();

    $scope.abrePauta = function (idPauta){
        getDetalhesPautas(idPauta);
        $('#abrePauta').modal('show');
    }

    $scope.fechaPauta = function () {
        $('#abrePauta').modal('hide');
    }

    $scope.abreNovaPauta = function (){
        $('#novaPauta').modal('show');
    }

    $scope.fechaNovaPauta = function () {
        limpaNovaPauta()
        $('#novaPauta').modal('hide');
    }

    $scope.abreSuspenderPauta = function (){
        $('#suspenderPauta').modal('show');
        $('#abrePauta').modal('hide');
    }

    $scope.fechaSuspenderPauta = function () {
        $('#suspenderPauta').modal('hide');
        $scope.motivoSuspender = '';
    }

    $scope.addNewAlternativa = function() {
        var newItemNo = $scope.pautaSelecao.alternativas.length+1;
        $scope.pautaSelecao.alternativas.push({'id' : 'newOpcao' + newItemNo, 'opcao' : '', 'name' : 'Alternativa'});
    };

    $scope.addNewAlternativaNewPauta = function(index) {
        var newItemNo = $scope.pautas[index].alternativas.length+1;
        $scope.pautas[index].alternativas.push({'id' : 'newOpcao' + newItemNo, 'opcao' : '', 'name' : 'Alternativa'});
    };

    $scope.removeAlternativa = function(index, id) {
        $scope.ultimaAlternativa--;
        $scope.pautaSelecao.alternativas.splice(index,1);

        $http.delete(`${config.apiUrl}/api/opcoes/` + id)
            .then(function(response) {
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            });
    };

    $scope.removeAlternativasNewPauta = function (indexPauta) {
        var newItemNo = $scope.pautas[indexPauta].alternativas.length - 1;
        if (newItemNo !== 0) {
            $scope.pautas[indexPauta].alternativas.pop();
        }
    };

    $scope.salvarPauta = async function () {
        await UtilsService.confirmAlert('Salvar nova pauta?');
        $http({
            method: "POST",
            url: `${config.apiUrl}api/pautas/`+$state.params.id,
            data: $scope.pautas[0],
            headers: {
                'Authorization': 'Bearer ' + AuthService.getToken()
            }
        })
            .then(function(response) {
                UtilsService.toastSuccess("Pauta salva com sucesso!");
                limpaNovaPauta();
                getPautasAssembleia();
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( ()=> {$('#novaPauta').modal('hide')});

    };

    $scope.salvarAlteracoesPauta = async function(){
        await UtilsService.confirmAlert('Atualizar pauta?');
        $http({
            method: "PUT",
            url: `${config.apiUrl}api/pautas/`+ $scope.pautaSelecao.id_pauta,
            data: $scope.pautaSelecao,
            headers:{
                'Authorization': 'Bearer '+ AuthService.getToken()
            },
        })
            .then(function(response) {
                UtilsService.toastSuccess("Pauta salva com sucesso!");
                getPautasAssembleia();
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( ()=> {$('#abrePauta').modal('hide')});
    }

    $scope.excluiPauta = async function(){
        await UtilsService.confirmAlert('Excluir Pauta?');
        $http({
            method: 'DELETE',
            url: `${config.apiUrl}api/pautas/`+ $scope.pautaSelecao.id_pauta,
            data: $scope.pautaSelecao,
            headers: {
                'Authorization': 'Bearer '+ AuthService.getToken()
            }
        }).then(function(response) {
                UtilsService.toastSuccess("Pauta excluída com sucesso!");
                getPautasAssembleia();
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            });
    }

    $scope.suspenderPauta = async function(){
        await UtilsService.confirmAlert('Suspender Pauta?');
        $scope.pautaSelecao.status = 'Suspensa';
        $http({
            method: "PUT",
            url: `${config.apiUrl}api/pauta/status/`+ $scope.pautaSelecao.id_pauta,
            data: $scope.pautaSelecao,
            headers:{
                'Authorization': 'Bearer '+ AuthService.getToken()
            },
        })
            .then(function(response) {
                UtilsService.toastSuccess("Pauta suspensa com sucesso!");
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( ()=> {
                $('#abrePauta').modal('hide');
                $('#suspenderPauta').modal('hide');
                getPautasAssembleia();
            });
    }

    $scope.abreDocumento = function (idDoc)
    {
        if(idDoc)
        {
            window.open(config.apiUrl + 'api/assembleias/pauta/documento/open/' + idDoc, '_blank');
        }
    };

    $scope.changeInputField = function (ele) {
        var file = ele.files[0];
        if (ele.files.length > 0) {
            if (file > 10485760) {
                return UtilsService.openAlert('Tamanho máximo de anexos permitido foi atingido: 10MB');
            }
            $scope.pautaSelecao.documentos_regras = URL.createObjectURL(file);
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
            $scope.pautaSelecao[el].push(infoArquivo);
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

    $scope.getPautaAnexos = function(idPauta)
    {
        $scope.pautaSelecao.documentos  = [];
        var promisse = ($http.get(`${config.apiUrl}api/pauta/anexos/`+idPauta));
        promisse.then( function (result) {
            $scope.pautaSelecao.documentos =  result.data.data;
        });
    }

    // $scope.showAddAlternativa = function (alternativa) {
    //     return alternativa.id === $scope.pautaSelecao.alternativas[$scope.pautaSelecao.alternativas.length - 1].id;
    // };
}