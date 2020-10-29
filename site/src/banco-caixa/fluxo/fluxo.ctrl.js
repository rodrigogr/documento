'use strict'
angular.module('BancoCaixaModule').controller('FluxoCtrl',
    function ($rootScope, $scope, UtilsService, FluxoService, HeaderFactory) {

        HeaderFactory.setHeader('banco-caixa', 'Fluxo de caixa');
        $scope.fluxoCaixa = null;
        $scope.soma = 0;
        $scope.filtro = {
            'situacao': 'TODAS_SITUACOES',
            'tipo_fluxo' : 'TODOS_FLUXOS',
            'conta' : '',
            'data_inicio' : new Date(moment().startOf('month').format("YYYY-M-D 00:00:00")),
            'data_fim' : new Date(moment().endOf('month').format("YYYY-M-D 00:00:00"))
        };
        $scope.ngOnInit = () => {
            Promise.all([
                $scope.pesquisar($scope.filtro),
                FluxoService.getBancoContas().then(result => $scope.contasBancarias = result.data)
            ]);
        };
        $scope.pesquisar = async (srch) => {
            try {
                $("#loading").show();
                if (!srch.data_inicio || !srch.data_fim) throw 'Por favor, informe o período correto!';
                await FluxoService.getFluxo(srch).then(result => $scope.fluxoCaixa = result.data);
            } catch (e) {
                console.error(e);
                UtilsService.toastError(e.message ? e.message : e);
            } finally {
                $("#loading").hide();
            }
        };

        $scope.saldo = function (valor,index) {
            let soma_ini = (index > 0) ? parseFloat($("#saldo"+(index-1)).val()) : parseFloat($scope.fluxoCaixa.saldo_inicial);
            let result = soma_ini + parseFloat(valor);
            $scope.soma = result;
            return result;
        };
        $scope.createTransferencia = function () {

            $('#transferencia').modal('show');
        };
    }
);