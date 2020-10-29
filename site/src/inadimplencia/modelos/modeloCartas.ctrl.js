'use strict'
angular.module('InadimplanciaModule').controller('modeloCartasCtrl',
    function ($scope, $http, config, $stateParams, UtilsService, InadimplenciaService, HeaderFactory, AuthService, $state) {

        HeaderFactory.setHeader('inadimplência', 'modelos / ' + ($stateParams.isCobranca ? 'cobrança' : 'quitação'));
        $scope.isCobranca = $stateParams.isCobranca;
        $scope.$ = $;

        $scope.Items;
        $scope.select;

        this.url = `${config.apiUrl}api/inadimplencia/${$stateParams.isCobranca ? 'carta_cobranca' : 'declaracao_quitacao'}`;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

        $scope.ngOnInit = async () => {
            $scope.Items = await InadimplenciaService.getModelosCarta($stateParams.isCobranca);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
            $scope.$digest();
        };

        $scope.btnEdit = x => $scope.select = x;

        $scope.btnGravar = async () => {
            try {
                let data = {titulo: $scope.select.titulo, conteudo: $scope.select.conteudo};
                if ($scope.select.id) {
                    if (!$scope.accessPagina.editar) {
                        throw 'Você não tem permissão para editar esse modelo!';
                    }
                    if (!data.titulo || !data.conteudo) {
                        throw "O título e conteúdo não podem estar vazios."
                    }
                    await this.putModeloCarta($scope.select.id, data);
                } else {
                    if (!$scope.accessPagina.inserir) {
                        throw 'Você não tem permissão para criar modelos!';
                    }
                    if (!data.titulo || !data.conteudo) {
                        throw "O título e conteúdo não podem estar vazios."
                    }
                    await this.postModeloCarta(data);
                }
                $('#novoModelo').modal('hide');
                UtilsService.toastSuccess('Modelo cadatrado com sucesso!');
                $scope.ngOnInit();
            } catch (e) {
                UtilsService.toastError(e || 'Erro ao gravar!');
            }
        };

        $scope.tinymceOptions = {
            menubar: false,
            toolbar: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent'
        };

        $scope.btnDelete = async (x) => {
            try {
                if (!$scope.accessPagina.excluir) {
                    throw 'Você não tem permissão para excluir esse modelo!';
                }
                await this.deleteModeloCarta(x.id);
                $scope.ngOnInit();
            } catch (e) {
                UtilsService.toastError(e || 'Erro ao deletar');
            }
        };

        this.putModeloCarta = (id, data) => $http.patch(`${this.url}/${id}`, data);

        this.postModeloCarta = (data) => $http.post(this.url, data);

        this.deleteModeloCarta = (id) => $http.delete(`${this.url}/${id}`);

        $scope.novo = () => {
            if (!$scope.accessPagina.inserir){
                UtilsService.toastError('Você não tem permissão para criar modelos!');
                return false;
            }
            $scope.select = {};
            $('#novoModelo').modal('show');
        }
    }
);