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

    $scope.suspender = false;
    $scope.votacaoIniciada = false;
    $scope.totalVotos = 8;

    function getPautasAssembleia(id = 0)
    {
        var promisse = ($http.get(`${config.apiUrl}api/assembleias/pautas/`+$state.params.id));
        promisse.then(function (retorno) {
            $scope.resumoPautas = retorno.data.data;
        }).finally( () => {
        });
    }

    function getDetalhesPautas(id_pauta)
    {
        var promisse = ($http.get(`${config.apiUrl}api/pautas/`+id_pauta));
        promisse.then(function (retorno) {
            $scope.pautaSelecao = retorno.data.data;
            $scope.getPautaAnexos($scope.pautaSelecao.id_pauta);
        }).finally( () => {
            $scope.ultimaAlternativa = $scope.pautaSelecao.alternativas.length;
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

    $scope.abreSuspenderPauta = function (){
        $('#suspenderPauta').modal('show');
    }

    $scope.fechaSuspenderPauta = function () {
        $('#suspenderPauta').modal('hide');
        $scope.motivoSuspender = '';
    }

    $scope.addNewAlternativa = function(index) {
        var newItemNo = $scope.pautaSelecao.alternativas.length+1;
        $scope.pautaSelecao.alternativas.push({'id' : 'newOpcao' + newItemNo, 'opcao' : '', 'name' : 'Alternativa'});
    };

    $scope.removeNewAlternativas = function(index, id) {
        $scope.ultimaAlternativa--;
        $scope.pautaSelecao.alternativas.splice(index,1);

        $http.delete(`${config.apiUrl}/api/opcoes/` + id)
            .then(function(response) {
                getPautasAssembleia();
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( () => { $("#loading").modal("hide") });
    };

    $scope.salvarAlteracoesPauta = async function(){
        $("#loading").modal("show");
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
                $('#abrePauta').modal('hide');
                getPautasAssembleia();
            }, function(error) {
                UtilsService.openAlert(error.data.message);
            }).finally( () => { $("#loading").modal("hide") });
    }
    $scope.suspenderPauta = function(){
        $scope.suspender = true;
        console.log($scope.motivoSuspender);
    }

    $scope.abreDocumento = function (idDoc)
    {
        window.open(config.apiUrl + 'api/assembleias/documento/open/' + idDoc, '_blank');
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
            //$scope.assembleia[el].push(infoArquivo);
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
}