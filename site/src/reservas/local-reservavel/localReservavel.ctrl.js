'use strict'
angular.module('ReservasModule').controller('LocalReservavelCtrl',
    function ($scope, $state, HeaderFactory, AuthService, $http, config) {
        HeaderFactory.setHeader('reservas', 'Locais reserváveis');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.resetLocal = function () {
            $scope.localReservavel = {
                idLocalidade: 1,
                nome: '',
                descricao: '',
                capacidade: false,
                capacidade_num: 0,
                regras: null,
                fotos: null,
                dadosVisiveis: false,
                antecedenciaMaxReserva: 0,
                antecedenciaMaxReservaTempo: 'horas',
                antecedenciaMinReserva: 0,
                antecedenciaMinReservaTempo: 'horas',
                antecedenciaMinCancelamento: 0,
                antecedenciaMinCancelamentoTempo: 'horas',
                numMaxReserva: 0,
                periodo: {
                    seg: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: ''
                    }],
                    ter: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: ''
                    }],
                    qua: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: ''
                    }],
                    qui: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: ''
                    }],
                    sex: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: ''
                    }],
                    sab: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: ''
                    }],
                    dom: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: ''
                    }]
                },
                diasInativos: []
            }
            $scope.periodoAtual = 'seg';
            $scope.objPeriodoAtual = $scope.localReservavel.periodo.seg;
        }
        $scope.manterHorarios = false;

        $scope.createNovoLocal = function () {
            $scope.resetLocal();
            var promisse = ($http.get(`${config.apiUrl}api/localidades/`));
            promisse.then( function (result){
                $scope.localidades = result.data.data;
            })
            $scope.step = 1;
            $('#cadastroLocal').modal('show');
        }

        $scope.fecharModalLocalReserva = function () {
            $('#cadastroLocal').modal('hide');
        }

        $scope.addFotoLocal = function () {
            $("#inputFoto").click();
        }

        $scope.goStep = function (step) {
            $('.ba__modal-body-tipo-lancamento').scrollTop(0);
            if (typeof step == 'number') {
                $scope.step = step;
            } else if (step === '+') {
                $scope.step = $scope.step + 1;
            } else {
                $scope.step = $scope.step - 1;
            }
        }

        $scope.subNum = function (variavel) {
            if ($scope.localReservavel[variavel] > 0) {
                --$scope.localReservavel[variavel];
            }
        }

        $scope.addNum = function (variavel) {
            ++$scope.localReservavel[variavel];
        }

        $('.reservaDiasSemana li').click(function() {
            $(this).siblings('li').removeClass('activeDia');
            $(this).addClass('activeDia');

            return false;
        });

        $scope.escolhaDiaSemana = function (diaSemana) {
            $scope.periodoAtual = diaSemana;
            $scope.objPeriodoAtual = $scope.localReservavel.periodo[diaSemana];
        }

        $scope.excluirPeriodo = function (index) {
            $scope.localReservavel.periodo[$scope.periodoAtual].splice(index,1);
        }

        $scope.adicionarPeriodo = function (diaSemana) {
            $scope.localReservavel.periodo[diaSemana].push(
                {
                    hora_ini: '',
                    hora_fim: '',
                    valor: ''
                }
            );
        }

        $scope.$watch('manterHorarios', function(value, oldValue) {
            if (value && !oldValue) {
                $scope.localReservavel.periodo.seg = $scope.localReservavel.periodo[$scope.periodoAtual];
                $scope.localReservavel.periodo.ter = $scope.localReservavel.periodo[$scope.periodoAtual];
                $scope.localReservavel.periodo.qua = $scope.localReservavel.periodo[$scope.periodoAtual];
                $scope.localReservavel.periodo.qui = $scope.localReservavel.periodo[$scope.periodoAtual];
                $scope.localReservavel.periodo.sex = $scope.localReservavel.periodo[$scope.periodoAtual];
                $scope.localReservavel.periodo.sab = $scope.localReservavel.periodo[$scope.periodoAtual];
                $scope.localReservavel.periodo.dom = $scope.localReservavel.periodo[$scope.periodoAtual];

            } else if (!value && oldValue) {
                let seg = angular.copy($scope.localReservavel.periodo.seg);
                let ter = angular.copy($scope.localReservavel.periodo.ter);
                let qua = angular.copy($scope.localReservavel.periodo.qua);
                let qui = angular.copy($scope.localReservavel.periodo.qui);
                let sex = angular.copy($scope.localReservavel.periodo.sex);
                let sab = angular.copy($scope.localReservavel.periodo.sab);
                let dom = angular.copy($scope.localReservavel.periodo.dom);

                delete $scope.localReservavel.periodo;

                $scope.localReservavel.periodo = [];
                $scope.localReservavel.periodo.seg = seg;
                $scope.localReservavel.periodo.ter = ter;
                $scope.localReservavel.periodo.qua = qua;
                $scope.localReservavel.periodo.qui = qui;
                $scope.localReservavel.periodo.sex = sex;
                $scope.localReservavel.periodo.sab = sab;
                $scope.localReservavel.periodo.dom = dom;

                $scope.escolhaDiaSemana($scope.periodoAtual);

            }
        });

        function resetDiaInativo () {
            $scope.diaInativo = {
                id: '',
                data: '',
                descricao: '',
                repetir: '',
                deleted: 0
            }
            $scope.editandoDiaInativo = false;
        }

        $scope.adicionarDiaInativo = function () {
            resetDiaInativo();
            $("#cadastroDiaInativo").modal("show");
        }

        $scope.fecharModalDiaInativo = function () {
            resetDiaInativo();
            $("#cadastroDiaInativo").modal("hide");
        }

        $scope.inserirDiaInativo = function () {
            let diaInativo = angular.copy($scope.diaInativo);
            $scope.localReservavel.diasInativos.push({
                id: '',
                data: diaInativo.data,
                descricao: diaInativo.descricao,
                repetir: diaInativo.repetir,
                deleted: 0
            });
            $scope.fecharModalDiaInativo();
        }

        $scope.excluirDiaInativo = function (index) {
            $scope.localReservavel.diasInativos[index].deleted = 1;
        }

        $scope.abreEditarDiaInativo = function (index) {
            $scope.diaInativo = {
                id: $scope.localReservavel.diasInativos[index].id,
                data: $scope.localReservavel.diasInativos[index].data,
                descricao: $scope.localReservavel.diasInativos[index].descricao,
                repetir: $scope.localReservavel.diasInativos[index].repetir,
                deleted: 0
            }
            $scope.editandoDiaInativo = true;
            $scope.editandoIndex = index;

            $("#cadastroDiaInativo").modal('show');
        }

        $scope.updateDiaInativo = function (index) {
            $scope.localReservavel.diasInativos[index].id = $scope.diaInativo.id;
            $scope.localReservavel.diasInativos[index].data = $scope.diaInativo.data;
            $scope.localReservavel.diasInativos[index].descricao = $scope.diaInativo.descricao;
            $scope.localReservavel.diasInativos[index].repetir = $scope.diaInativo.repetir;
            $scope.localReservavel.diasInativos[index].deleted = $scope.diaInativo.deleted;

            $scope.fecharModalDiaInativo();
        }

        $scope.save = function () {
            $http.post(`${config.apiUrl}api/situacao_inadimplencias`, data);
        }

    });