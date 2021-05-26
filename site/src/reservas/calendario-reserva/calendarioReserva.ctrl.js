'use strict'
angular.module('ReservasModule').controller('CalendarioReservaCtrl',
    function ($scope, $http, $state, UtilsService, HeaderFactory, AuthService, config) {

        HeaderFactory.setHeader('reservas', 'Calendário de reservas');

        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);

        moment.locale('pt-br');

        $scope.loadLocais = false;
        $scope.idLocalidade = 'todas';
        $scope.idLocalReservavel = '';
        $scope.aba = 1;

        $http.get(`${config.apiUrl}api/localidades/locais_reservaveis`)
            .then((result) => $scope.locaisReservaveis = result.data.data)
            .finally(() => $scope.loadLocais = true);


        setTimeout( montaCalendario, 1000);

        function montaCalendario() {
            $(document).ready( function () {
                var d = new Date();
                var calendarEl = document.getElementById('calendar');

                var calendar = new FullCalendar.Calendar(calendarEl, {
                    locale: 'pt-br',
                    initialDate: d.toISOString(),
                    // editable: true,
                    //selectable: true,
                    // businessHours: true,
                    dayMaxEvents: 2, // allow "more" link when too many events
                    headerToolbar: {
                        left: 'prev title next today',
                        center: '',
                        right: ''
                    },
                    events: function (info, successCallback, failureCallback) {
                        // let start = moment(info.start.valueOf()).format('YYYY-MM-DD');
                        let start = info.startStr;
                        // let end = moment(info.end.valueOf()).format('YYYY-MM-DD');
                        let end = info.endStr;
                        $("#loadingDiaCalendario").modal("show");
                        $http.get(`${config.apiUrl}api/reserva/calendario/eventos` + "?start=" + start + "&end=" + end)
                            .then((result) => successCallback(result.data.data))
                            .catch( function (e) { UtilsService.openAlert(e.statusText) })
                            .finally(() => {
                                $("#loadingDiaCalendario").modal("hide");
                                $(".fc-daygrid-day.fc-day").click(function(el) {});
                                setTimeout(function (ev) {
                                    $(".fc-daygrid-day.fc-day").click(function(el) {
                                        alert(el.currentTarget.dataset.date);
                                        ev.stopEventPropagation();
                                    })
                                },1000);
                                failureCallback('Erro');
                            });
                    },
                    /*dateClick: function(info) {
                        // console.log(info);
                        // alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
                        // alert('Current view: ' + info.view.type);
                        // change the day's background color just for fun
                        info.dayEl.style.backgroundColor = 'red';
                    }*/
                    /*eventClick: function(info) {
                        alert('Event: ' + info.event.title);
                        alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
                        alert('View: ' + info.view.type);

                        // change the border color just for fun
                        info.el.style.borderColor = 'red';
                    }*/

                });

                calendar.render();
                // calendar.refetchEvents();
            });
        }

        $scope.contentChange = function (aba) {
            $scope.aba = aba;
            if (aba == 1) {
                montaCalendario();
            } else {
                let data = new Date();
                $scope.dataAtual = data;
                setDiaCalendario(data);
            }
        }

        $scope.voltarHoje = function () {
            let data = new Date();
            setDiaCalendario(data);
        }

        function setDiaCalendario(data) {
            let dia = moment(data).format('D');
            let mes = moment(data).format('MMMM');
            $scope.dataTitulo = "Dia "+dia+" de "+mes;
            $scope.dataSemana = moment(data).format('dddd');
        }

        $scope.alterarDia = function (alt) {
            data = angular.copy($scope.dataAtual);
            var novaData = alt === '-'
                ? moment(data).subtract(1,"day")
                : moment(data).add(1, "day");
            setDiaCalendario(novaData);
            $scope.dataAtual = novaData;
        }
    });