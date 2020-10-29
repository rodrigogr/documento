'use strict'
angular.module('PatrimonioModule').controller('PatrimonioApolicePatrimonioCtrl',
    function ($scope, PatrimonioApolicePatrimonioService, PatrimonioApoliceService, PatrimonioBensService, UtilsService)
    {
        var self = this;

        var mApolicePatrimonioSrv = PatrimonioApolicePatrimonioService;
        var mBensSrv = PatrimonioBensService;
        var mUtilSrv = UtilsService;

        $scope.mApoliceSrv = PatrimonioApoliceService;

        $scope.data = {
            'model': {},
            'list': {}
        };

        $scope.init = function()
        {
            mBensSrv.read().then(e => $scope.data.list.patrimonios = e.data);
        };

        $scope.bensSemPendencia = function()
        {
            mBensSrv.readSemPendente().then(e => $scope.data.list.patrimonios = e.data);
        };

        window.addEventListener('apolice-edited',
            function(e)
            {
                $scope.data.model = e.detail;
                $scope.data.rows = e.detail.patrimonios;
            });

        $scope.newRow = function(patrimonio)
        {
            var srv = function()
            {
                var data = $scope.data;

                var patrimonio = data.patrimonioSelecionado;
                var id = data.model.id;

                return mApolicePatrimonioSrv.create(patrimonio, id);
            };

            self.save(srv);
        };

        $scope.deleteRow = function(e, row)
        {
            e.preventDefault();

            if ($scope.mApoliceSrv.getStatus() != 'Ativo') {
                return;
            }

            var model = $scope.data.model;

            mUtilSrv.confirmAlert(
                'Atenção',
                'Você está prestes a desvincular o bem patrimonial "'
                    + row.produto.descricao + '" da apólice "'
                    + model.descricao + '".\nConfirma a ação?',
                'Não',
                'Sim'
                ).then(function()
                    {
                        var srv = function()
                        {
                            return mApolicePatrimonioSrv.delete(row, model.id);
                        };

                        self.save(srv);
                    });
        };

        this.save = function (callback)
        {
            callback()
                .then(function(ret) {
                    mUtilSrv.openSuccessAlert(ret.data);

                    // Lança o evento para que a controller superior atualize
                    // os dados.
                    var event = new CustomEvent('apolice-patrimonios-edited', { 'detail': $scope.data.model });
                    window.dispatchEvent(event);
                })
                .catch(function(error) {
                    if (error.responseJSON) {
                        mUtilSrv.openErrorMsg(error.responseJSON.message);
                    } else {
                        mUtilSrv.openErrorMsg(error.statusText);
                    }
                });
        };
    });
