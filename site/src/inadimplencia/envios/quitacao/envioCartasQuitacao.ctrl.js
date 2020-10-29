'use strict'
angular.module('InadimplanciaModule').controller('envioCartasQuitacaoCtrl',
	function ($scope, $filter, $http, config, $stateParams, UtilsService, BioacessoService, InadimplenciaService, HeaderFactory, AuthService, $state) {

        HeaderFactory.setHeader('inadimplência', 'envio / quitação');
		$scope.InadimplenciaService = InadimplenciaService;
		$scope.isCobranca = $stateParams.isCobranca;
		// VARIABLES
		$scope.titulosList;
		$scope.modelosCarta;
		$scope.modeloSelect = {};
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

		$scope.ngOnInit = () => {
			InadimplenciaService.getModelosCarta($stateParams.isCobranca)
				.then(result => $scope.modelosCarta = result);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
		};

		$scope.teste = (e) => $scope.modeloSelect = e;

		$scope.pesquisar = (search) => {
			if (!search || !search.quadra || !search.lote) {
				UtilsService.openAlert('Informe a Quadra e Lote');
				return;
			}
			InadimplenciaService.getImovelInfoByQeL(search.quadra, search.lote)
				.then(() => {
					this.getTitulosVencidosByIdPessoa(InadimplenciaService.imovelInfo.id)
						.then(result => {
							$scope.titulosList = result;
							$scope.$digest();
						})
						.catch(() => UtilsService.openAlert('error'));
				})
				.catch(() => UtilsService.openAlert('error'));
		}

		this.getTitulosVencidosByIdPessoa = (id) => {
			return new Promise((resolve, reject) => {
				let data = {
					"id_imovel": id,
					"id_empresa": "",
					"id_pessoa": '',
				}
				$http.post(`${config.apiUrl}api/inadimplencia/filtro_parceiro_quitacao`, data)
					.then(result => resolve(result.data))
					.catch(() => reject())
			});
		}

		$scope.btnVisualizar = (titulosSelec) => {
			if (!$scope.modeloSelect.id) {
				UtilsService.openAlert('Selecione um modelo.');
				return;
			};
			let data = {
				"id_modelo": $scope.modeloSelect.id,
				"id_imovel": titulosSelec.id_imovel,
				"id_empresa": ""
			}
			let url = `${config.apiUrl}api/inadimplencia/declaracao_quitacao_emissao_visualizar`;
			let options = {
				responseType: "arraybuffer"
			};
			$http.post(url, data, options)
				.then(result => {
					let blob = new Blob([result.data], {
						type: 'application/pdf'
					});
					let pdfLink = (window.URL || window.webkitURL).createObjectURL(blob);
					var newWin = window.open(pdfLink);
					if (!newWin || newWin.closed || typeof newWin.closed == 'undefined')
						UtilsService.openErrorMsg('Popup bloqueada')
				})
				.catch(() => UtilsService.openAlert('error'));
		}

		$scope.btnEnviarSelec = async () => {
			try {
				if (!$scope.accessPagina.inserir) {
					throw 'Você não tem permissão para enviar declaração de quitação!';
				}
				$('.loader').show();
				let titulosSelec = $scope.titulosList.filter(x => x.select);
				if (!$scope.modeloSelect.id) {
					UtilsService.openAlert('Selecione um modelo.');
					return;
				}
				if (!titulosSelec.length) {
					UtilsService.openAlert('Selecione pelo menos uma pessoa.');
					return;
				}
				let selecionados = titulosSelec.map(x => {
					return {
						"id_imovel": x.id_imovel,
						"id_empresa": ""
					}
				});
				let data = { 'selecionados': selecionados, "id_modelo": $scope.modeloSelect.id };
				let url = `${config.apiUrl}api/inadimplencia/enviarQuitacao`;
				let result = await $http.post(url, data);
				UtilsService.toastSuccess(result.data.data)
			} catch (e) {
				UtilsService.toastError(e || 'Erro ao enviar!');
			} finally {
				$('.loader').hide()
			}
		}
	}
);