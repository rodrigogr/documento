angular.module('appServices').service('LoginService', ['$q', 'config', LoginService]);

function LoginService($q, config) {

    this.logIn = function (credenciais) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/auth/login',
            header: {
                'Content-Type': 'application/json'
            },
            data: {
                login: credenciais.login,
                pwd: credenciais.password
            }
        }).then(function (data) {
            return data;
        }).catch(function (error) {
            throw error;
        }));
    };

    this.userAccess = function (id) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/aclToFrontEnd',
            header: {
                'Content-Type': 'application/json'
            },
            data: {id:id}
        }).then(function (data) {
            return data;
        }).catch(function (error) {
            throw error;
        }));
    };

    this.getCondominio = function () {
        return $q.when($.ajax({
            type: 'GET',
            url: config.apiUrl + 'api/condominio',
            header: {
                'Content-Type': 'application/json'
            }
        }).then(function (data) {
            return data;
        }).catch(function (error) {
            throw error;
        }));
    };

    this.acessoLoginApps = function () {
        return $q.when($.ajax({
            type: 'GET',
            url: config.apiUrl + 'api/acessoLoginApps',
            header: {
                'Content-Type': 'application/json'
            }
        }).then(function (data) {
            return data;
        }).catch(function (error) {
            throw error;
        }));
    }
}