angular.module('appServices').service('DateService',
    function ($q, config)
    {
        this.isoToDateObj = function (iso)
        {
            if (iso) {
                let date = new Date(iso);
                return new Date(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate());
            }

            return;
        };

        this.gmtToISO = function(gmt)
        {
            if (gmt) {
                return (new Date(gmt)).toISOString().substring(0, 10);
            }

            return;
        };
    });
