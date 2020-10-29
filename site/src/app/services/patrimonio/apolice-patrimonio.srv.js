angular.module('appServices').service('PatrimonioApolicePatrimonioService',
    function ($q, config)
    {
        var self = this ;
        var mURL = config.apiUrl + 'api/patrimonios/apolices/bens';

        this.create = function(model, idApolice)
        {
            var method = 'PATCH';
            var url = mURL + '/' + idApolice;

            return self.save(model, method, url);
        };

        this.delete = function(model, idApolice)
        {
            var method = 'DELETE';
            var url = mURL + '/' + idApolice;

            return self.save(model, method, url);
        };

        this.save = function (model, method, url)
        {
            return $q.when($.ajax({
                'type': method,
                'url': url,
                'header': {
                    'Content-Type': 'application/json'
                },
                'data': model
            }).then(function (data) {
                return data;
            }).catch(function (data) {
                throw data;
            }));
        };
    });
