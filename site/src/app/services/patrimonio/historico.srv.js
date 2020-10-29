angular.module('appServices').service('PatrimonioHistoricoService',
    function ($q, config)
    {
        var self = this;
        var mURL = config.apiUrl + 'api/patrimonios/historicos';

        this.read = function ()
        {
            return $q.when($.ajax({
                'type': 'GET',
                'url': mURL,
                'header': {
                    'Content-Type': 'application/json'
                }
            }));
        };
    });
