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
                fotos: null
            }
        }

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

        $scope.subNum = function () {
            if ($scope.localReservavel.capacidade_num > 0) {
                --$scope.localReservavel.capacidade_num;
            }
        }

        $scope.addNum = function () {
            ++$scope.localReservavel.capacidade_num;
        }

        $('.reservaDiasSemana li').click(function() {
            $(this).siblings('li').removeClass('activeDia');
            $(this).addClass('activeDia');

            return false;
        });


    });