angular.module('appServices').service('FluxoService', ['$q', 'config','$http', FluxoService]);

function FluxoService($q, config, $http) {

    this.data = {
        user: {}
    };
    this.getFluxo = function(filtros) {
        return $http.post(config.apiUrl + 'api/fluxo',filtros).then(handleSuccess, handleError);
    };
    this.getBancoContas = function() {
        return $http.get(config.apiUrl + 'api/conta_bancarias/select').then(handleSuccess, handleError);
    };
    function handleSuccess(res) { return res.data; }
    function handleError(res) {
        return {success:false,data:res.data.message};
    }
}
