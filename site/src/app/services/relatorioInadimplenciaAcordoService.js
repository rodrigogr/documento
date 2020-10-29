angular.module('appServices').service('RelatorioInadimplenciaAcordoService', ['$q', 'config', RelatorioInadimplenciaAcordoService]);

function RelatorioInadimplenciaAcordoService($q, config) {
    var self = this;

    self.data = {
        user: {}
    };

    self.consultaGeralPdf = function(data) {


        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/relatorios/receitas/titulos_provisionados',
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
