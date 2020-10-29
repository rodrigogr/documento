angular.module('ContasReceberModule').controller('RecebimentoAutomaticoCtrl',
	function ($scope, ReceitaService, UtilsService, BancoService, HeaderFactory) {
        HeaderFactory.setHeader('Receitas', 'Recebimento automático');
		$scope.$ = $;

		$scope.ngOnInit = async () => {
			try {
				$('.loader').show();
				await Promise.all([
					ReceitaService.getAllLayoutRemessa().then(function (result) {
						$scope.data.layoutsRemessa = result.data;
						$scope.data.baixaAutomatica.id_layout = result.data[0].id;
					}),
					BancoService.getAllCarteirasDisponiveis().then(function (result) {
						$scope.data.carteirasDisponiveis = result.data;
						$scope.data.baixaAutomatica.id_configuracao_carteira = result.data[0].id_carteira_conta;
					})]);
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		};

		$scope.data = {
			baixaAutomatica: {
				file: '',
				file_name: ''
			}
		};

		$scope.realizarBaixaAutomatica = async function () {
			try {
				$scope.data.baixaAutomatica.file_name = $('#file-1')[0].files[0].name;
				let result = await ReceitaService.realizaBaixaAutomatica($scope.data.baixaAutomatica);
				UtilsService.openSuccessAlert(result.data);
                // Recarrega todos os dados
				$scope.ngOnInit();
				// Limpa o input file, para conseguir processar o mesmo novamente
                angular.forEach(
                    angular.element("input[type='file']"),
                    function(inputElem) {
                        angular.element(inputElem).val(null);
                    });
			} catch (e) {
				console.error(e);
				UtilsService.openErrorMsg();
			} finally {
				$('#loading').modal('hide');
			}
		};
	}
);