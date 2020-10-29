'use strict'
angular.module('CadastrosModule').controller('DepartamentoCtrl',
    function ($scope, UtilsService, $state, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'Departamento');
        $scope.$ = $;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                await $scope.updateList($scope.current_page);
                AuthService.aclPaginaService($state.$current.name, user.id)
                    .then(result => $scope.accessPagina = result.data);
                $scope.$digest();
            } catch (e) {
                console.error(e)
            } finally {
                $('.loader').hide();
            }
        };

        $scope.saveOrUpdate = async (tipo) => {
            try {
                $('.loader').show();
                if (tipo.id) await putDepartamento(tipo);
                else await postDepartamento(tipo);
                $('#novoTipo').modal('hide');
                await $scope.updateList($scope.current_page);
            } catch (e) {
                console.error(e);
                UtilsService.openErrorMsg(e.data.message.descricao["0"]);
            } finally {
                $('.loader').hide();
            }
        };

        let postDepartamento = (data) => $http.post(`${config.apiUrl}api/departamentos`, data);

        let putDepartamento = (data) => $http.patch(`${config.apiUrl}api/departamentos/${data.id}`, data);

        let deleteDepartamento = async (id) => {
            await $http.delete(`${config.apiUrl}api/departamentos/${id}`);
            $scope.updateList($scope.current_page);
        };

        $scope.setSelect = (x) => $scope.select = JSON.parse(JSON.stringify(x));

        $scope.delete = async (tipo) => {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir esse item!');
                return false;
            }
            await UtilsService.confirmAlert('Excluir registro?');
            deleteDepartamento(tipo.id);
        };

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/departamentos?page=${page}`);
            $scope.Itens = result.data.data;
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