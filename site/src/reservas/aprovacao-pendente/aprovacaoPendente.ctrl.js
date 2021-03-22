'use strict'
angular.module('ReservasModule').controller('AprovacaoPendenteCtrl',
    function ($scope, $http, $state, UtilsService, HeaderFactory, AuthService, config) {

        HeaderFactory.setHeader('reservas', 'Aprovações Pendentes');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        moment.locale('pt-br');

        $scope.loadLocais = false;
        $scope.idLocalidade = 'todas';
        $scope.idLocalReservavel = '';
        $scope.formats = ['dd-MM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
        $scope.format = $scope.formats[0];
        $scope.altInputFormats = ['M!/d!/yyyy'];
        $scope.dt = new Date();
        $scope.dateOptions = {
            formatYear: 'yy',
            showWeeks:'false',
            startingDay: 0
        };
        $scope.popup1 = { opened: false }

        $scope.open1 = function() {
            $scope.popup1.opened = true;
        };
        $scope.analisandoReserva = [];
        $scope.pendentes = [];
        $scope.recusados = [];

        // Disable weekend selection
        function disabled(data) {
            var date = data.date,
                mode = data.mode;
            return mode === 'day' && (date.getDay() === 0 || date.getDay() === 6);
        }

        $scope.contentActive = function(aba) {
            if (aba == 1) {
                $scope.escolhaDia();
                $scope.busca = 'pendentes';
            } else {
                $scope.busca = 'recusados';
                recusados();
            }
        }

        $http.get(`${config.apiUrl}api/localidades/locais_reservaveis`)
            .then((result) => $scope.locaisReservaveis = result.data.data)
            .finally(() => $scope.loadLocais = true);

        $scope.pendentesHoje = function (localReservavel = false, localidade = false, item = '') {
            $(".list-localidade").removeClass("itemSelecionado");
            $(".list-locaisReservaveis").removeClass("itemSelecionado");

            $scope.loadPendente = true;
            $scope.busca = 'pendentes';

            var url = `${config.apiUrl}api/aprovacao/pendentes/hoje`;

            if (localidade) {
                url = `${config.apiUrl}api/aprovacao/pendentes/localidade/`+localidade;
            } else if (localReservavel) {
                url = `${config.apiUrl}api/aprovacao/pendentes/local/`+localReservavel;
            }

            $http.get(url).then(function (result) {
                $scope.pendentes = result.data.data;
                $scope.topicoData = {
                    dia: moment().format('D'),
                    mes: moment().format('MMMM'),
                    semana: moment().format('dddd')
                }
            }).finally(() => {
                $scope.loadPendente = false;

                if (!item) {
                    $("#itemTodos").addClass("itemSelecionado");
                } else {
                    $("#" + item).addClass("itemSelecionado");
                }
            });
        }

        $scope.pendentesHoje();

        $scope.escolhaDia = function (localReservavel = false, localidade = false, item = '') {
            $scope.loadPendente = true;
            $(".list-localidade").removeClass("itemSelecionado");
            $(".list-locaisReservaveis").removeClass("itemSelecionado");
            if (!item) {
                $("#itemTodos").addClass("itemSelecionado");
            } else {
                $("#" + item).addClass("itemSelecionado");
            }
            var url = '';

            if ($scope.busca == 'pendentes') {
                url = `${config.apiUrl}api/aprovacao/pendentes/hoje`;

                if (localidade) {
                    url = `${config.apiUrl}api/aprovacao/pendentes/localidade/`+localidade;
                } else if (localReservavel) {
                    url = `${config.apiUrl}api/aprovacao/pendentes/local/`+localReservavel;
                }
            } else {
                url = config.apiUrl+'api/aprovacao/recusados';
            }

            $http.get(url).then(function (result) {
                if ($scope.busca == 'pendentes') {
                    $scope.pendentes = result.data.data;
                } else {
                    $scope.recusados = result.data.data;
                }

                $scope.topicoData = {
                    dia: moment().format('D'),
                    mes: moment().format('MMMM'),
                    semana: moment().format('dddd')
                }
            }).finally(() => {
                $scope.loadPendente = false;
            });
        }

        $scope.analisar = function (index) {
            $scope.analisandoReserva = $scope.pendentes[index];
            $("#analisarReserva").modal('show');
        }

        $scope.fecharAnalisando = function () {
            $scope.analisandoReserva = [];
            $("#analisarReserva").modal('hide');
        }
        
        $scope.aprovarReserva = function (id) {
            var promisse = ($http.patch(`${config.apiUrl}api/aprovacao/`+id, 1));
            promisse.then( function (result) {
                let res = result.data.data;
                $scope.escolhaDia();
                $("#analisarReserva").modal('hide');
                UtilsService.toastSuccess(res);
            }).catch( function (e) {
                UtilsService.openAlert(e.data.message);
            });
        }

        $scope.motivoRecusar = function (id) {
            $scope.idRecusar = id;
            $scope.motivoRecusaReserva = '';
            $scope.disabledText = false;
            $("#analisarReserva").modal('hide');
            $("#motivoRecusar").modal('show');
        }

        $scope.verMotivo = function (index) {
            $scope.motivoRecusaReserva = $scope.recusados[index].obs;
            $scope.dataRecusa = moment($scope.recusados[index].updated_at).format('L')+' às '+ moment($scope.recusados[index].updated_at).format('HH:mm');
            $scope.autor = $scope.recusados[index].autor;
            $scope.disabledText = true;
            $("#motivoRecusar").modal('show');
        }

        $scope.fecharMotivo = function () {
            $("#motivoRecusar").modal('hide');
        }

        $scope.recusarReserva = function (id) {
            $('.btnRecSalvar').prop('disabled', true);
            $('#btnRecusar').button('loading');

            var dados = {
                id: id,
                motivo: $scope.motivoRecusaReserva
            }
            var promisse = ($http.put(`${config.apiUrl}api/aprovacao/recusar/`, dados));
            promisse.then( function (result) {
                let res = result.data.data;
                $("#motivoRecusar").modal('hide');
                UtilsService.toastSuccess(res);
                $scope.pendentesHoje();
            }).catch( function (e) {
                UtilsService.openAlert(e.data.message);
            }).finally( () => {
                $('.btnRecSalvar').prop('disabled', false);
                $('#btnRecusar').button('reset');
            });
        }

        function recusados() {
            $scope.pendentes = [];
            $scope.loadPendente = true;

            $http.get(`${config.apiUrl}api/aprovacao/recusados/todos`).then( function (result) {
                $scope.recusados = result.data.data;
            }).finally( () => $scope.loadPendente = false);
        }

        $scope.dataFormatTitulo = function (data) {
            let dia = moment(data).format('D');
            let mes = moment(data).format('MMMM');
            return "Dia "+dia+" de "+mes;
        }

    });