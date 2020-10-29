angular.module('appServices').service('PatrimonioApoliceService',
    function ($q, config)
    {
        var self = this ;
        var mURL = config.apiUrl + 'api/patrimonios/apolices';

        var mStatus;

        this.getStatus = function()
        {
            return mStatus;
        }

        this.setStatus = function(v)
        {
            mStatus = v;
        }

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

        this.create = function(model)
        {
            var method = 'POST';
            var url = mURL;

            return self.save(model, method, url);
        };

        this.update = function(model, id)
        {
            var method = 'PATCH';
            var url = mURL + '/' + id;

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
