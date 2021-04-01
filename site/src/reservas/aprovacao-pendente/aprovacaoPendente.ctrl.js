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

        $scope.dt = new Date();

        $scope.analisandoReserva = [];
        $scope.pendentes = [];
        $scope.recusados = [];
        $scope.busca = 'pendente';
        $scope.localReservavelSelecionado = false;
        $scope.localidadeSelecionado = false;

        $scope.contentActive = function(aba) {
            if (aba == 1) {
                $scope.busca = 'pendente';
            } else {
                $scope.busca = 'recusado';
            }
            $scope.listaAprovacao('todos');
        }

        $http.get(`${config.apiUrl}api/localidades/locais_reservaveis`)
            .then((result) => $scope.locaisReservaveis = result.data.data)
            .finally(() => $scope.loadLocais = true);

        $scope.listaAprovacao = function (data = false, localReservavel = false, localidade = false, item = '') {
            $scope.loadPendente = true;
            $(".list-localidade").removeClass("itemSelecionado");
            $(".list-locaisReservaveis").removeClass("itemSelecionado");

            var dataBusca = 'todos';

            if (!data && data != 'todos') {
                $scope.topicoData = {
                    dia: moment().format('D'),
                    mes: moment().format('MMMM'),
                    semana: moment().format('dddd')
                }
                dataBusca = moment(moment.now()).format("YYYY-MM-DD")

            } else if (data && data != 'todos') {
                $scope.topicoData = {
                    dia: moment($scope.dt).format('D'),
                    mes: moment($scope.dt).format('MMMM'),
                    semana: moment($scope.dt).format('dddd')
                }
                dataBusca = moment($scope.dt).format("YYYY-MM-DD");
            }

            $scope.localReservavelSelecionado = localReservavel;
            $scope.localidadeSelecionado = localidade;

            var dados = {
                data: dataBusca,
                localReservavel: localReservavel,
                localidade: localidade,
                status: $scope.busca
            }

            $http.post(`${config.apiUrl}api/aprovacao`, dados).then(function (result) {
                if ($scope.busca == 'pendente') {
                    $scope.pendentes = result.data.data;
                } else {
                    $scope.recusados = result.data.data;
                }
            }).catch( function (e) {
                UtilsService.openAlert(e.data.message);
            }).finally(() => {
                if (!item) {
                    $("#itemTodos").addClass("itemSelecionado");
                    $(".list-localidade-locaisReservaveis").scrollTop(0);
                } else {
                    $("#" + item).addClass("itemSelecionado");
                }
                $scope.loadPendente = false;
            });
        }

        $scope.listaAprovacao('todos');

        $scope.analisar = function (indexParent,index) {
            $scope.analisandoReserva = $scope.pendentes[indexParent][index];
            $("#analisarReserva").modal('show');
        }

        $scope.fecharAnalisando = function () {
            $scope.analisandoReserva = [];
            $("#analisarReserva").modal('hide');
        }
        
        $scope.aprovarReserva = function (id) {
            $('.btnAprovSalvar').prop('disabled', true);
            $('#btnAprovar').button('loading');

            var promisse = ($http.patch(`${config.apiUrl}api/aprovacao/`+id, 1));
            promisse.then( function (result) {
                let res = result.data.data;
                $scope.listaAprovacao('todos');
                $("#analisarReserva").modal('hide');
                UtilsService.toastSuccess(res);
            }).catch( function (e) {
                UtilsService.openAlert(e.data.message);
            }).finally( () => {
                $('.btnAprovSalvar').prop('disabled', false);
                $('#btnAprovar').button('reset');
                $scope.analisandoReserva = [];
            });
        }

        $scope.motivoRecusar = function (id) {
            $scope.motivoRecusaReserva = '';
            $scope.disabledText = false;
            $("#analisarReserva").modal('hide');
            $("#motivoRecusar").modal('show');
        }

        $scope.verMotivo = function (indexParent, index) {
            $scope.motivoRecusaReserva = $scope.recusados[indexParent][index].obs;
            $scope.dataRecusa = moment($scope.recusados[indexParent][index].updated_at).format('L')+' às '+ moment($scope.recusados[indexParent][index].updated_at).format('HH:mm');
            $scope.autor = $scope.recusados[indexParent][index].autor;
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
            var promisse = ($http.put(`${config.apiUrl}api/aprovacao/recusar`, dados));
            promisse.then( function (result) {
                let res = result.data.data;
                $("#motivoRecusar").modal('hide');
                UtilsService.toastSuccess(res);
                $scope.listaAprovacao('todos');
            }).catch( function (e) {
                UtilsService.openAlert(e.data.message);
            }).finally( () => {
                $('.btnRecSalvar').prop('disabled', false);
                $('#btnRecusar').button('reset');
                $scope.analisandoReserva = [];
            });
        }

        $scope.dataFormatTitulo = function (data) {
            let dia = moment(data).format('D');
            let mes = moment(data).format('MMMM');
            return "Dia "+dia+" de "+mes;
        }

        $("#dataBusca").on("change", function() {
            $scope.listaAprovacao(this.value);
        });

    });