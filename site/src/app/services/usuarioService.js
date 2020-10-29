angular.module('appServices').service('UsuarioService', ['$q', 'config', UsuarioService]);

function UsuarioService($q, config) {
    var self = this;

    self.data = {
        user: {}
    };

    self.getAllUsuarios = function () {
        return $q.when($.ajax({
            type: 'GET',
            url: config.apiUrl + 'api/usuarios',
            header: {
                'Content-Type': 'application/json'
            },
            data: {}
        }).then(function (data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };

    self.getAllUsuarios2 = function () {
        return $q.when($.ajax({
            type: 'GET',
            url: config.apiUrl + 'api/usuarios/pessoas',
            header: {
                'Content-Type': 'application/json'
            },
            data: {}
        }).then(function (data) {
            return data;
        }).catch(function (data) {
            throw data;
        }));
    };

    function handleSuccess(res) {
        return res.data;
    }

    function handleError(res) {
        throw res.data.message;
    };


}
