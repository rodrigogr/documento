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

function assembleiaPautasCtrl ($scope, $state, $filter, UtilsService, config)
{
    $scope.resumoPautas = [];
    $scope.detalhesPautas = [];

    function getPautasAssembleia(id = 0)
    {
        $scope.resumoPautas = [
            {
                idPauta:'1',
                tituloPauta:'Qual empresa de segurança devemos contratar?',
                totalAlternativas:'3',
                status:'Aguardando inicio',
                totalVotos:'0'
            },
            {
                idPauta: '2',
                tituloPauta:'Devemos mudar o serviço de jardinagem do residencial?',
                totalAlternativas:'2',
                status:'Aberta para votação',
                totalVotos:'32'
            },
            {
                idPauta: '3',
                tituloPauta:'Devemos reformar o parquinho imediatamente?',
                totalAlternativas:'2',
                status:'Suspensa',
                totalVotos:'19'
            }
        ];

        /*forEach(pauta in $scope.resumoPautas)
        {
            getDetalhesPautas(pauta.idPauta);
        }*/

        getDetalhesPautas();
    }

    function getDetalhesPautas()
    {
        $scope.detalhesPautas = [
            {
                idPauta:'1',
                descricaoPergunta:'Qual empresa de segurança devemos contratar?',
                alternativas:[
                    {
                        idAlternativa:'1',
                        descAlternativa:'Sim, eu concordo.'
                    },
                    {
                        idAlternativa:'2',
                        descAlternativa:'Não, eu discordo.'
                    },
                    {
                        idAlternativa:'3',
                        descAlternativa:'Não concordo nem discordo, muito pelo contrário.'
                    },
                ],
                anexos:[
                    {
                        idAnexo:'1',
                        anexo:'anexo-1.jpg'
                    },
                    {
                        idAnexo:'2',
                        anexo:'anexo-2.jpg'
                    },
                ]
            },
            {
                idPauta:'2',
                descricaoPergunta:'Devemos mudar o serviço de jardinagem do residencial?',
                alternativas:[
                    {
                        idAlternativa:'1',
                        descAlternativa:'Sim, eu concordo.'
                    },
                    {
                        idAlternativa:'2',
                        descAlternativa:'Não, eu discordo.'
                    }
                ],
                anexos:[]
            },
            {
                idPauta:'3',
                descricaoPergunta:'Devemos reformar o parquinho imediatamente?',
                alternativas:[
                    {
                        idAlternativa:'1',
                        descAlternativa:'Sim, eu concordo.'
                    },
                    {
                        idAlternativa:'2',
                        descAlternativa:'Não, eu discordo.'
                    }
                ],
                anexos:[]
            }
        ]
        console.log($scope.detalhesPautas);
    }

    $scope.pautaSelecao = {};
    getPautasAssembleia();

    $scope.abrePauta = function (idPauta){
        angular.forEach($scope.detalhesPautas,
            function (value, key){
                if(idPauta === value.idPauta)
                {
                    $scope.pautaSelecao = value;
                    console.log($scope.pautaSelecao);
                    return true;
                }
                console.log (key + ' '+ value.idPauta);
            }
            );
        $('#abrePauta').modal('show');
    }

    $scope.fechaPauta = function () {
        $('#abrePauta').modal('hide');
    }

}