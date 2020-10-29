angular.module('appServices').service('TipoDocumentoService', ['$q', 'config', TipoDocumentoService]);

function TipoDocumentoService($q, config) {
    var self = this;

    self.data = {
        user: {}
    };

    self.getAllTiposDocumento = function () {
        return $q.when($.ajax({
            type: 'GET',
            url: config.apiUrl + 'api/tipo_documentos',
            header: {
                'Content-Type': 'application/json'
            },
            data: {}
        }).then(function(data) {
            return data;
        }));
    };

}
