'use strict'
angular.module('ReservasModule').controller('LocalReservavelCtrl',
    function ($scope, $state, $http, HeaderFactory, AuthService, UtilsService, config) {
        HeaderFactory.setHeader('reservas', 'Locais reserváveis');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        $scope.resetLocal = function () {
            $scope.localReservavel = {
                id_localidade: 1,
                nome: '',
                descricao: '',
                check_capacidade: false,
                capacidade: 0,
                regra: '',
                foto: '',
                dadosVisiveis: false,
                antecedenciaMaxReserva: 0,
                antecedenciaMaxReservaTempo: 'horas',
                antecedenciaMinReserva: 0,
                antecedenciaMinReservaTempo: 'horas',
                antecedenciaMinCancelamento: 0,
                antecedenciaMinCancelamentoTempo: 'horas',
                numMaxReserva: 0,
                periodo: [{
                    seg: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: '',
                        deleted: 0
                    }],
                    ter: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: '',
                        deleted: 0
                    }],
                    qua: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: '',
                        deleted: 0
                    }],
                    qui: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: '',
                        deleted: 0
                    }],
                    sex: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: '',
                        deleted: 0
                    }],
                    sab: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: '',
                        deleted: 0
                    }],
                    dom: [{
                        hora_ini: '',
                        hora_fim: '',
                        valor: '',
                        deleted: 0
                    }]
                }],
                dia_inativo: []
            }
            $scope.periodoAtual = 'seg';
            $scope.objPeriodoAtual = $scope.localReservavel.periodo[0].seg[0];
        }
        $scope.manterHorarios = false;
        $scope.addNovoPeriodo = 0;

        $scope.getLocais = function () {
            $(".loader").show();
            var promisse = ($http.get(`${config.apiUrl}api/localreservavel/`));
            promisse.then( function (result){
                $scope.locaisReservaveis = result.data.data;
            }).finally(() => $(".loader").hide())
        }
        $scope.getLocais();

        function getLocalidade() {
            var promisse = ($http.get(`${config.apiUrl}api/localidades/`));
            promisse.then(function (result) {
                $scope.localidades = result.data.data;
            });
        }

        $scope.createNovoLocal = function () {
            $scope.resetLocal();
            getLocalidade();
            $scope.step = 1;
            $('#cadastroLocal').modal('show');
        }

        $scope.fecharModalLocalReserva = function () {
            $('#cadastroLocal').modal('hide');
        }

        $scope.addFotoLocal = function () {
            $("#inputFoto").click();
        }

        $scope.changeInputField = function (ele) {
            var file = ele.files[0];

            if (ele.files.length > 0) {
                if (file > 10485760) {
                    return UtilsService.openAlert('Tamanho máximo de anexos permitido foi atingido: 10MB');

                }
                if (ele.name == 'foto') {
                    $scope.localReservavel.foto = { url: URL.createObjectURL(file) };
                } else {
                    $scope.localReservavel.regra = { url: URL.createObjectURL(file) };
                }

                $scope.getbase64(file, ele.name);

            }

            // let toMB = (file.size / 1048576).toFixed(2);
            // $("#tamanho").html('arquivos adicionados: tamanho total: ' + toMB + 'MB');

        }

        $scope.getbase64 = function (file, el) {
            let f = file;
            let r = new FileReader();

            r.onloadend = function (e) {
                $scope.localReservavel[el].base64 = e.target.result;
                $scope.$apply();
            };
            r.readAsDataURL(f);
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
            $scope.objPeriodoAtual = $scope.localReservavel.periodo.filter(x => x.dia_semana == diaSemana);
        }

        $scope.excluirPeriodo = function (periodo, indexAtual) {
            if (periodo.id) {
                $scope.localReservavel.periodo.map(item => {
                    if (item.id == periodo.id) {
                        item.deleted = 1;
                    }
                    return item;
                });

            } else {
                let indexArrPrincipal = $scope.localReservavel.periodo.findIndex(item => item.addNew == periodo.addNew);
                $scope.localReservavel.periodo.splice(indexArrPrincipal, 1);
                $scope.objPeriodoAtual.splice(indexAtual, 1);
            }
        }

        $scope.adicionarPeriodo = function (diaSemana) {
            let novo = {
                dia_semana: diaSemana,
                hora_ini: '',
                hora_fim: '',
                valor: '',
                deleted: 0,
                addNew: $scope.addNovoPeriodo++
            }
            $scope.localReservavel.periodo.push(novo);
            $scope.objPeriodoAtual.push(novo);
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
            $scope.localReservavel.dia_inativo.push({
                data: diaInativo.data,
                descricao: diaInativo.descricao,
                repetir: diaInativo.repetir,
                deleted: 0
            });
            $scope.fecharModalDiaInativo();
        }

        $scope.excluirDiaInativo = function (index) {
            $scope.localReservavel.dia_inativo[index].deleted = 1;
        }

        $scope.abreEditarDiaInativo = function (index) {
            $scope.diaInativo = {
                id: $scope.localReservavel.dia_inativo[index].id,
                data: $scope.localReservavel.dia_inativo[index].data,
                descricao: $scope.localReservavel.dia_inativo[index].descricao,
                repetir: $scope.localReservavel.dia_inativo[index].repetir,
                deleted: 0
            }
            $scope.editandoDiaInativo = true;
            $scope.editandoIndex = index;

            $("#cadastroDiaInativo").modal('show');
        }

        $scope.updateDiaInativo = function (index) {
            $scope.localReservavel.dia_inativo[index].id = $scope.diaInativo.id;
            $scope.localReservavel.dia_inativo[index].data = $scope.diaInativo.data;
            $scope.localReservavel.dia_inativo[index].descricao = $scope.diaInativo.descricao;
            $scope.localReservavel.dia_inativo[index].repetir = $scope.diaInativo.repetir;
            $scope.localReservavel.dia_inativo[index].deleted = $scope.diaInativo.deleted;

            $scope.fecharModalDiaInativo();
        }

        $scope.salvar = function () {
            $http({
                method: "POST",
                url: `${config.apiUrl}api/localreservavel/`,
                data: $scope.localReservavel,
                headers:{
                    'Authorization': 'Bearer '+ AuthService.getToken()
                }
            }).
            then(function(response) {
                alert('ok');
            }, function(response) {
                alert('!!ERROR');
            });
            //$http.post(`${config.apiUrl}api/localreservavel/post/`, {"nome": 'valor'});
            /*$http.get(`${config.apiUrl}api/localreservavel`)
                .then( function (dados) {
                    UtilsService.toastSuccess('teste');
                }).catch(function (e) {
                    UtilsService.toastError(e.responseJSON.message);
                });*/

        }

        $scope.editarLocal = function (id) {
            $("#loading").modal("show");
            var promisse = ($http.get(`${config.apiUrl}api/localreservavel/`+id));
            promisse.then( function (result){
                $scope.localReservavel = result.data.data;
                $scope.localReservavel.periodo.map(function (item) {
                    item.deleted = 0;
                    return item;
                });

                $scope.localReservavel.dia_inativo.map(function (item) {
                    item.deleted = 0;
                    return item;
                });

                $scope.periodoAtual = 'seg';
                $scope.objPeriodoAtual = $scope.localReservavel.periodo.filter(x => x.dia_semana=='seg');

                $scope.step = 1;
                getLocalidade();
                $('#cadastroLocal').modal('show');
            }).finally( () => $("#loading").modal("hide") )
        }

        $scope.update = function (id) {
            $("#loading").modal("show");
            var promisse = ($http.put(`${config.apiUrl}api/localreservavel/`+id, $scope.localReservavel));
            promisse.then( function (result){
                let res = result.data.data;
                $scope.getLocais();
                $('#cadastroLocal').modal('show');
            }).finally( () => $("#loading").modal("hide") )
        }

    });