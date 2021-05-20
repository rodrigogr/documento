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

        $http.get(`${config.apiUrl}api/localidades/locais_reservaveis`)
            .then((result) => $scope.locaisReservaveis = result.data.data)
            .finally(() => $scope.loadLocais = true);

        $(document).ready( function () {
            setTimeout( montaCalendario, 1000);

            function montaCalendario() {
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
                        let start = moment(info.start.valueOf()).format('YYYY-MM-DD');
                        let end = moment(info.end.valueOf()).format('YYYY-MM-DD');
                        $http.get(`${config.apiUrl}api/reserva/calendario/eventos` + "?start=" + start + "&end=" + end)
                            .then((result) => successCallback(result.data.data))
                            .catch( function (e) { UtilsService.openAlert(e.data.message) })
                            .finally(() => failureCallback('Erro'));
                        /*$.ajax({
                            url: "api/assignments/?event_id=" + vm.eventId +  '&start='+ start + "&end=" + end,
                            type: 'GET',
                            headers: {
                                'X-CSRF-TOKEN': window.csrf_token
                            }, success: function (response) {
                                successCallback(response);
                            }
                        });*/
                    },
                    /*events: {
                        url: `${config.apiUrl}api/reserva/eventos_calendario`
                        /!*extraParams: {
                            mes: d.getMonth(),
                            ano: d.getFullYear()
                        }*!/
                    }*/
                    /*events: [
                        {
                            title: 'Day Event',
                            start: '2021-05-16T12:30:00',
                            allDay : false
                        },
                        {
                            title: 'Outro',
                            start: '2021-05-17'
                        },
                        {
                            title: 'mais um',
                            start: '2021-05-17'
                        },
                        {
                            title: 'xxxx',
                            start: '2021-05-18'
                        },
                        {
                            title: 'Long Event',
                            start: '2021-05-01',
                            end: '2021-05-02'
                        },
                        {
                            groupId: 999,
                            title: 'Repeating Event',
                            start: '2020-09-09T16:00:00'
                        },
                        {
                            groupId: 999,
                            title: 'Repeating Event',
                            start: '2020-09-16T16:00:00'
                        },
                        {
                            title: 'Conference',
                            start: '2021-05-05',
                            end: '2021-05-06'
                        },
                        {
                            title: 'Conference',
                            start: '2021-05-05',
                            end: '2021-05-06'
                        },
                        {
                            title: 'Conference',
                            start: '2021-05-05',
                            end: '2021-05-06'
                        },
                        {
                            title: 'Conference',
                            start: '2021-05-05',
                            end: '2021-05-06'
                        },
                        {
                            title: 'Meeting',
                            start: '2020-09-12T10:30:00',
                            end: '2020-09-12T12:30:00'
                        },
                        {
                            title: 'Lunch',
                            start: '2021-05-19T12:00:00'
                        },
                        {
                            title: 'Meeting',
                            start: '2021-05-19T14:30:00'
                        },
                        {
                            title: 'Happy Hour',
                            start: '2021-05-19T17:30:00'
                        },
                        {
                            title: 'Dinner',
                            start: '2021-05-12T20:15:00'
                        },
                        {
                            title: 'Dinner 2',
                            start: '2021-05-12T20:30:00'
                        },
                        {
                            title: 'Dinner 2',
                            start: '2021-05-12T20:30:00'
                        },
                        {
                            title: 'Dinner 2',
                            start: '2021-05-12T20:30:00'
                        },
                        {
                            title: 'Dinner 2',
                            start: '2021-05-12T20:30:00'
                        },
                        {
                            title: 'Dinner 2',
                            start: '2021-05-12T20:30:00'
                        },
                        {
                            title: 'Dinner 2',
                            start: '2021-05-12T20:30:00'
                        },
                        {
                            title: 'Birthday Party',
                            start: '2021-05-19T07:00:00'
                        },
                        {
                            title: 'Click for Google',
                            url: 'http://google.com/',
                            start: '2021-05-26'
                        },
                        {
                            title: 'Click for Google',
                            url: 'http://google.com/',
                            start: '2021-05-26'
                        },
                        {
                            title: 'Click for Google',
                            url: 'http://google.com/',
                            start: '2021-05-26'
                        },
                        {
                            title: 'Click for Google',
                            url: 'http://google.com/',
                            start: '2021-05-26'
                        },
                        {
                            title: 'Evento',
                            start: '2021-06-02'
                        }
                    ]*/
                });

                calendar.render();
                // calendar.refetchEvents();
            }
        });
    });