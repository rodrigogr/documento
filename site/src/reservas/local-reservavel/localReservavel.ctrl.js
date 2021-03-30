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
                regra_local: '',
                foto_local: '',
                visualizar_reversa_usuario: false,
                antecedencia_max_num: 0,
                antecedencia_max_periodo: 'horas',
                antecedencia_min_num: 0,
                antecedencia_min_periodo: 'horas',
                antecedencia_cancel_num: 0,
                antecedencia_cancel_periodo: 'horas',
                limit_reserva: 0,
                restricao: '',
                periodo: {
                    seg: [],
                    ter: [],
                    qua: [],
                    qui: [],
                    sex: [],
                    sab: [],
                    dom: []
                },
                dia_inativo: []
            }
            $scope.periodoAtual = 'seg';
            $scope.objPeriodoAtual = [];
            $scope.arquivoIcon = '';
            $scope.arquivoNome = '';
            $("#inputFoto").val('');
            $("#inputRegra").val('');
            $scope.manterHorarios = false;
        }
        $scope.addNovoPeriodo = 0;
        $scope.search = {
            type: 'nome',
            nome: ''
        }

        $scope.getLocaisReservaveis = function () {
            $(".loader").show();
            var promisse = ($http.get(`${config.apiUrl}api/localreservavel`));
            promisse.then( function (result){
                $scope.locaisReservaveis = result.data.data;
            }).finally(() => $(".loader").hide())
        }
        $scope.getLocaisReservaveis();

        function getLocalidade() {
            var promisse = ($http.get(`${config.apiUrl}api/localidades`));
            promisse.then(function (result) {
                $scope.localidades = result.data.data;
            });
        }

        $scope.createNovoLocal = function () {
            $scope.resetLocal();
            getLocalidade();
            $scope.step = 1;
            $('#cadastroLocal').modal('show');
            $scope.adicionarPeriodo('seg');
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
                if (ele.name == 'foto_local') {
                    $scope.localReservavel.foto = URL.createObjectURL(file);
                } else {
                    $scope.localReservavel.regra = URL.createObjectURL(file);
                    iconArquivo(ele.files[0]);
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
                $scope.localReservavel[el] = e.target.result;
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
            /*if ($scope.localReservavel[variavel] > 0) {
                --$scope.localReservavel[variavel];
            }*/
        }

        $scope.addNum = function (variavel) {
            //++$scope.localReservavel[variavel];
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

        $scope.excluirPeriodo = function (periodo, indexAtual) {
            if ($scope.manterHorarios) {
                angular.forEach($scope.localReservavel.periodo, function (value, key) {
                    if (value[indexAtual].id) {
                        value[indexAtual].deleted = 1;
                    } else {
                        value.splice(indexAtual, 1);
                    }
                });
            } else {
                if (periodo.id) {
                    $scope.localReservavel.periodo[$scope.periodoAtual].map(item => {
                        if (item.id == periodo.id) {
                            item.deleted = 1;
                        }
                        return item;
                    });

                } else {
                    $scope.objPeriodoAtual.splice(indexAtual, 1);
                }
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
            $scope.localReservavel.periodo[diaSemana].push(novo);
            $scope.objPeriodoAtual = $scope.localReservavel.periodo[diaSemana];
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
            $("#loading").modal("show");
            $scope.localReservavel.restricao = $scope.localReservavel.restricao || null;
            $http({
                method: "POST",
                url: `${config.apiUrl}api/localreservavel`,
                data: $scope.localReservavel,
                headers:{
                    'Authorization': 'Bearer '+ AuthService.getToken()
                }
            })
            .then(function(response) {
                UtilsService.toastSuccess("Local salvo com sucesso!");
                $scope.resetLocal();
                $('#cadastroLocal').modal('hide');
                $scope.getLocaisReservaveis();

            }, function(error) {
                UtilsService.openAlert(error.data.message);

            }).finally( () => { $("#loading").modal("hide") });
        }

        $scope.editarLocal = function (id) {
            $("#loading").modal("show");

            getLocalidade();

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

                let periodo = {
                        seg: [],
                        ter: [],
                        qua: [],
                        qui: [],
                        sex: [],
                        sab: [],
                        dom: []
                };
                periodo.seg = $scope.localReservavel.periodo.filter(x => x.dia_semana=='seg');
                periodo.ter = $scope.localReservavel.periodo.filter(x => x.dia_semana=='ter');
                periodo.qua = $scope.localReservavel.periodo.filter(x => x.dia_semana=='qua');
                periodo.qui = $scope.localReservavel.periodo.filter(x => x.dia_semana=='qui');
                periodo.sex = $scope.localReservavel.periodo.filter(x => x.dia_semana=='sex');
                periodo.sab = $scope.localReservavel.periodo.filter(x => x.dia_semana=='sab');
                periodo.dom = $scope.localReservavel.periodo.filter(x => x.dia_semana=='dom');

                delete $scope.localReservavel.periodo;

                $scope.localReservavel.periodo = periodo;
                $scope.localReservavel.visualizar_reversa_usuario = !!$scope.localReservavel.visualizar_reversa_usuario;

                if ($scope.localReservavel.capacidade > 0) {
                    $scope.localReservavel.check_capacidade = true;
                }

                $scope.step = 1;
                $('#cadastroLocal').modal('show');

            }).finally( () => {
                $scope.escolhaDiaSemana('seg');
                $("#loading").modal("hide")
            });
        }

        $scope.update = function () {
            $("#loading").modal("show");
            var promisse = ($http.put(`${config.apiUrl}api/localreservavel/`+$scope.localReservavel.id, $scope.localReservavel));
            promisse.then( function (result){
                let res = result.data.data;
                UtilsService.toastSuccess(res);
                $('#cadastroLocal').modal('hide');
                $scope.resetLocal();
                $scope.getLocaisReservaveis();
            }).catch( function (e) {
                UtilsService.openAlert(e.data.message);
            }).finally( () => $("#loading").modal("hide") )
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
            let file = $scope.localReservavel.regra ? $scope.localReservavel.regra : $scope.localReservavel.regra_local;
            window.open(file,'_blank');
        }

        $scope.pesquisalocalReservavel = function () {
            if ($scope.search.nome.length && $scope.search.nome.length > 2) {
                $(".loader").show();
                var promisse = ($http.get(`${config.apiUrl}api/localreservavel/nome/`+$scope.search.nome));
                promisse.then( function (result){
                    $scope.locaisReservaveis = result.data.data;
                }).finally(() => $(".loader").hide());
            }
        }

        $scope.confirmaExcluir = function (id) {
            var confirm = UtilsService.confirmAlert3('Confirma excluir este local?',' <h4>As reservas deste local também serão excluídas.</h4>','Cancelar', 'Excluir', true, true);
            confirm.then((result) => {
                if (result) {
                    $(".loader").show();
                    var promisse = ($http.delete(`${config.apiUrl}api/localreservavel/`+id));
                    promisse.then( function (result){
                        UtilsService.openSuccessAlert(result.data.data);
                        $scope.getLocaisReservaveis();
                        $('#cadastroLocal').modal('hide');
                    }).catch( function (e) {
                        UtilsService.openAlert(e.data.message)
                    }).finally(() => $(".loader").hide());
                }
            });
        }

    });