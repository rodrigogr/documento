'use strict'
angular.module('CadastrosModule').controller('SituacaoInadimplenciaCadCtrl',
    function ($scope, UtilsService, $state, $http, config, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'inadimplência / situação');
        $scope.$ = $;
        $scope.select = {};
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

		$scope.saveOrUpdate = async(situacao) => {
			if (situacao.id) await putSituacao(situacao);
			else await postSituacao(situacao);
			$scope.updateList($scope.current_page);
		};

		$scope.situacaiById = (id) => {
			if (!InadimplenciaCadService.Tipos || !id) return;
			return InadimplenciaCadService.Tipos.find(x => x.id == id).descricao;
		};

        $scope.ngOnInit = () => {
            this.selectLitsTipos().then(result => $scope.tipos_inadimplencia = result.data);
            $scope.updateList($scope.current_page);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        this.selectLitsTipos = () => $http.get(`${config.apiUrl}api/tipo_inadimplencias/select_list`);
		let postSituacao = (data) => $http.post(`${config.apiUrl}api/situacao_inadimplencias`, data);
		let putSituacao = (data) => $http.patch(`${config.apiUrl}api/situacao_inadimplencias/${data.id}`, data);
		let deleteSituacao = (id) => $http.delete(`${config.apiUrl}api/situacao_inadimplencias/${id}`)

        $scope.setSelect = (x) => $scope.select = Object.assign({}, x);

        $scope.delete = async (situacao) => {
            await UtilsService.confirmAlert('Excluir registro?')
            await deleteSituacao(situacao.id);
            $scope.updateList($scope.current_page);
        };

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/situacao_inadimplencias?page=${page}`);
            $scope.Situacoes = result.data.data;
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