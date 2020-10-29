angular.module('appServices').service('SituacoesInadimplenciaService', ['$q', 'config', SituacoesInadimplenciaService]);

function SituacoesInadimplenciaService($q, config) {
    var self = this;

    self.data = {
        user: {}
    };

    self.getAllSituacoesInadimplencia = function () {
        return $q.when($.ajax({
            type: 'GET',
            url: config.apiUrl + 'api/situacao_inadimplencias',
            header: {
                'Content-Type': 'application/json'
            },
            data: {}
        }).then(function(data) {
            return data;
        }));
    };

}
