'use strict'
angular.module('ContasPagarModule').controller('ContasAprovadosCtrl',
    function ($scope, config, $http, HeaderFactory, AuthService) {
        HeaderFactory.setHeader('Despesas', 'Previsões orçamentárias');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                await $scope.updateList($scope.current_page);
                AuthService.aclPaginaService('CPCadEstimar',user.id)
                    .then(result => $scope.accessPagina = result.data)
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide();
            }
        }

        $scope.mesExtenso = (i) => {
            return ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
                "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
            ][i - 1];
        }

        let vmLanAprv = (data) => {
            if (data && data.length) {
                data.reverse();
            }
            return data;
        }

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/estimados/lista_estimados?page=${page}`);
            $scope.Itens = vmLanAprv(result.data.data);
            $scope.current_page = result.data.current_page;
            $scope.total = result.data.total;
            $scope.per_page = result.data.per_page;
            $scope.pageCount = Math.ceil(result.data.total / result.data.per_page);
            let pageCount = $scope.pageCount;
            if (pageCount >= 6) {
                if (page > 3 && page < pageCount - 2)
                    $scope.pages = [page - 2, page - 1, page, page + 1, page + 2];
                else if (page == pageCount - 1)
                    $scope.pages = [page - 4, page - 3, page - 2, page - 1, page];
                else if (page <= 3)
                    $scope.pages = [1, 2, 3, 4, 5];
            } else {
                $scope.pages = [];
                for (let i = 1; i <= pageCount; i++) {
                    $scope.pages.push(i);
                }
            }
            $scope.$digest();
        }

    }
)