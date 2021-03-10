'use strict'
angular.module('ReservasModule').controller('AprovacaoPendenteCtrl',
    function ($scope, $http, $state, UtilsService, HeaderFactory, AuthService, config) {

        HeaderFactory.setHeader('reservas', 'Aprovações Pendentes');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        moment.locale('pt-br');
        $scope.loadDiaPendente = true;
        $scope.loadLocais = false;
        $scope.idLocalidade = 'todas';
        $scope.idLocalReservavel = '';
        $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
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

        // Disable weekend selection
        function disabled(data) {
            var date = data.date,
                mode = data.mode;
            return mode === 'day' && (date.getDay() === 0 || date.getDay() === 6);
        }

        $scope.contentActive = function(aba) {
            if (aba == 1) {

            } else {

            }
        }

        $http.get(`${config.apiUrl}api/localidades/locais_reservaveis`)
            .then((result) => $scope.locaisReservaveis = result.data.data)
            .finally(() => $scope.loadLocais = true);

        $http.get(`${config.apiUrl}api/aprovacao/pendentes/hoje`).then( function (result) {
            $scope.pendentes = result.data.data;
            $scope.topicoData = {
                dia: moment().format('D'),
                mes: moment().format('MMMM'),
                semana: moment().format('dddd')
            }
        }).finally( () => $scope.loadDiaPendente = false);

        $scope.escolhaDia = function () {
            $http.get(`${config.apiUrl}api/aprovacao/pendentes/hoje`).then(function (result) {
                $scope.pendentes = result.data.data;
                $scope.topicoData = {
                    dia: moment().format('D'),
                    mes: moment().format('MMMM'),
                    semana: moment().format('dddd')
                }
            }).finally(() => $scope.loadDiaPendente = false);
        }

        $scope.analisar = function (index) {
            let reserva = $scope.pendentes[index];
            $("#analisarReserva").modal('show');
        }

    });