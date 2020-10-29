angular.module('appServices').service('AuthService', ['$q', 'config', AuthService]);

function AuthService($q, config) {

    this.data = {
        user: {}
    };

    this.getToken = function () {
        return localStorage.getItem('bioacs-crtk');
    };

    this.aclPaginaService = function (pg,id) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/aclPagina',
            header: {
                'Content-Type': 'application/json'
            },
            data: {pg:pg, id:id}
        }).then(function (data) {
            return data;
        }).catch(function (error) {
            throw error;
        }));
    };

    this.boxAppHeader = function (user) {
        return $q.when($.ajax({
            type: 'POST',
            url: config.apiUrl + 'api/boxApp',
            header: {
                'Content-Type': 'application/json'
            },
            data: {dados:user}
        }).then(function (data) {
            return data;
        }).catch(function (error) {
            throw error;
        }));
    }
}