'use strict'
angular.module('CadastrosModule').controller('TipoInadimplenciaCadCtrl',
    function ($scope, UtilsService, $http, config, HeaderFactory, AuthService, $state) {
        HeaderFactory.setHeader('Cadastros', 'inadimplência / tipos');
        $scope.$ = $;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

        $scope.ngOnInit = () => {
            $scope.updateList($scope.current_page);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        $scope.saveOrUpdate = async (tipo) => {
            if (tipo.id) await putTipo(tipo);
            else await postTipo(tipo);
            $scope.updateList(1);
        };

        let postTipo = (data) => $http.post(`${config.apiUrl}api/tipo_inadimplencias`, data);
        let putTipo = (data) => $http.patch(`${config.apiUrl}api/tipo_inadimplencias/${data.id}`, data);
        let deleteTipo = (id) => $http.delete(`${config.apiUrl}api/tipo_inadimplencias/${id}`);

        $scope.setSelect = (x) => $scope.select = Object.assign({}, x);

        $scope.delete = async (tipo) => {
            await UtilsService.confirmAlert('Excluir registro?');
            await deleteTipo(tipo.id);
            $scope.updateList(1);
        };

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/tipo_inadimplencias?page=${page}`);
            $scope.tipos = result.data.data;
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