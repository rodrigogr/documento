angular.module('appServices').service('CartaCobrancaEnvioService', ['$q', 'config', CartaCobrancaEnvioService]);

function CartaCobrancaEnvioService($q, config) {
    var self = this;

    self.data = {
        user: {}
    };

    self.getTeste = function() {
        return $q.when($.ajax({
            type: 'GET',
            url: config.apiUrl + 'api/pre_lancamentos',
            header: {
                'Content-Type': 'application/json'
            },
            data: {}
        }).then(function(data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };

}
