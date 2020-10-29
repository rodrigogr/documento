angular.module('appServices').service('RelatorioContasPagarSinteticoService', ['$q', 'config', RelatorioContasPagarSinteticoService]);

function RelatorioContasPagarSinteticoService($q, config) {
    var self = this;

    self.data = {
        user: {}
    };

    self.consultaGeralPdf = function(data) {


        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/relatorios/despesas/contas_a_pagar',
            header: {
                'Content-Type': 'application/pdf'
            },
            data:data
        }).then(function(data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };

}
