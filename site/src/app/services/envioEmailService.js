angular.module('appServices').service('EnvioEmailService', ['$q', 'config', EnvioEmailService]);

function EnvioEmailService($q, config) {
    var self = this;

    self.data = {
        user: {}
    };

    self.postEnviaEmail = function(data) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/notificacao/enviar_email',
            header: {
                'Content-Type': 'application/json'
            },
            data:data
        }).then(function(data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };

}
