'use strict'
angular.module('InadimplanciaModule').controller('classificarAcordosCtrl',
	function ($scope, $filter, $state, UtilsService, BioacessoService, InadimplenciaService, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('inadimplência', 'classificação');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

        $scope.InadimplenciaService = InadimplenciaService;
		// VARIABLES
		$scope.titulosList;
		$scope.titulosListOriginal;

		$scope.pesquisar = async (search) => {
			try {
				$('.loader').show();
				if (!search || !search.quadra || !search.lote) {
					UtilsService.openAlert('Informe a Quadra e Lote');
					return;
				}
				// await InadimplenciaService.getImovelInfoByQeL(search.quadra, search.lote)
				// let result = await InadimplenciaService.getTitulosInadimplentsByIdImovel(InadimplenciaService.imovelInfo.id)
                let result = await InadimplenciaService.getTitulosInadimplentsByQeL(search);
				$scope.titulosListOriginal = JSON.parse(JSON.stringify(result));
				$scope.titulosList = result;
				$scope.$digest();
				$('#acaoMassa').on('change', (e) => {
					$scope.changeAllTipos(parseInt(e.target.value));
				})
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		}
		$scope.changeAllTipos = (id) => {
			if (id == 0) return;
			$scope.titulosList.forEach(x => x.id_situacao_inadimplencia = id);
			$scope.$digest();
		}

		$scope.salvarAlteracoes = async () => {
			try {
				$('.loader').show();
				let titulosParaAlterar = [];
				for (let i = 0; i < $scope.titulosListOriginal.length; i++) {
					if ($scope.titulosListOriginal[i].id_situacao_inadimplencia != $scope.titulosList.id_situacao_inadimplencia) {
						let titulo = $scope.titulosList[i];
						titulosParaAlterar.push({
							"id_boleto": titulo.id_boleto,
							"id_situacao_inadimplencia": titulo.id_situacao_inadimplencia
						})
					}
				}
				if (titulosParaAlterar.length > 0)
					await InadimplenciaService.postClassificarInadimplencias(titulosParaAlterar);
				UtilsService.toastSuccess('Alteração efetuado com sucesso')
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide()
			}
		}
	}
)