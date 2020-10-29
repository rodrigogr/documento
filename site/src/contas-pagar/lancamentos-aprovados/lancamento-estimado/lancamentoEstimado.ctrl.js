'use strict'
angular.module('ContasPagarModule').controller('LancamentoEstimadoCtrl',
    function ($scope, $http, config, LancamentoService, UtilsService, $stateParams, $state, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Despesas', 'Previsão orçamentária');
        $scope.$ = $;
        $scope.grupoLancamentos;
        $scope.resumoLancamentosEstimados;
        let  lancamentoEstimados;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                await Promise.all([
                    LancamentoService.getResumoLancamentoEstimado()
                        .then(result => $scope.resumoLancamentosEstimados = result.data),
                    LancamentoService.getAllTipoLancamentos()
                        .then(
                            result => $scope.tipoLancamentos = result.data
                        ),
                    LancamentoService.getGruposLancamentosTipo('DESPESA')
                        .then(result => $scope.grupoLancamentos = result.data),
                    LancamentoService.getAllLancamentoEstimado()
                        .then(result => {
                            lancamentoEstimados = result.data;
                            $scope.data.lancamentoEstimadosByGroup = _.values(_.groupBy(lancamentoEstimados, 'id_grupolancamento'))
                        }),
                    LancamentoService.getUltimoEstimado()
                        .then(result => $scope.ultimoEstimado = result),
                    AuthService.aclPaginaService('CPCadEstimar', user.id)
                        .then(result => $scope.accessPagina = result.data)
                ])
            } catch (e) {
            } finally {
                $('.loader').hide();
            }
        };

        $scope.data = {
            lancamentoEstimadosByGroup: [],
            tipoLancamentosByGroup: [],
            lancamentoEstimadoSelecionado: {
                id_grupolancamento: '',
                id_tipolancamento: '',
                fundo_reserva: true,
                valor: 0
            },
            aprovaLancamentoEstimados: {
                mes_competencia: null,
                ano_competencia: null,
                lancamentos: []
            },
            meses: [
                {
                    codigo: 1,
                    nome: 'JANEIRO'
                },
                {
                    codigo: 2,
                    nome: 'FEVEREIRO'
                },
                {
                    codigo: 3,
                    nome: 'MARÇO'
                },
                {
                    codigo: 4,
                    nome: 'ABRIL'
                },
                {
                    codigo: 5,
                    nome: 'MAIO'
                },
                {
                    codigo: 6,
                    nome: 'JUNHO'
                },
                {
                    codigo: 7,
                    nome: 'JULHO'
                },
                {
                    codigo: 8,
                    nome: 'AGOSTO'
                },
                {
                    codigo: 9,
                    nome: 'SETEMBRO'
                },
                {
                    codigo: 10,
                    nome: 'OUTUBRO'
                },
                {
                    codigo: 11,
                    nome: 'NOVEMBRO'
                },
                {
                    codigo: 12,
                    nome: 'DEZEMBRO'
                }
            ],
            anos: [
                {
                    ano: '2015'
                }, {
                    ano: '2016'
                }, {
                    ano: '2017'
                }, {
                    ano: '2018'
                }, {
                    ano: '2019'
                },
				{
                    ano: '2020'
                },
				{
                    ano: '2021'
                },
				{
                    ano: '2022'
                }
            ],
            mesReferencia: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
                "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
            ][new Date().getMonth() + 1],
            anoReferencia: new Date().getFullYear().toString()
        }

        $scope.showDeleteAlert = function (lancamentoEstimado) {
            $scope.data.deleteLancamentoEstimado = lancamentoEstimado;
            $('#deleteAlert').modal('show');
        }

        let canDelLanEst = true;
        $scope.deleteLancamentoEstimado = async () => {
            try {
                $('.loader').show();
                if (!canDelLanEst) return;
                canDelLanEst = false;
                let data = await LancamentoService.deleteLancamentoEstimado($scope.data.deleteLancamentoEstimado);
                $scope.updateLancamentoEstimados();
                UtilsService.toastSuccess(data.data);
            } catch (e) {
                console.error(e);
            } finally {
                $scope.closeDeleteModal();
                canDelLanEst = true;
                $('.loader').hide();
            }
        }

		$scope.groupGrupoLancamento = function () {
			return _.values(_.groupBy(lancamentoEstimados, 'id_grupolancamento'));
		}

		$scope.totalByGroup = function (idGrupoLancamento) {
			return _.sumBy(lancamentoEstimados, function (lancamentoEstimado) {
				if (lancamentoEstimado.id_grupolancamento === idGrupoLancamento) {
					return lancamentoEstimado.valor;
				}
			});
		};

		$scope.totalGeral = function () {
			return _.sumBy(lancamentoEstimados, function (lancamentoEstimado) {
				return lancamentoEstimado.valor;
			});
		};

		$scope.updateTipoLancamentoSelecionado = function () {
			$scope.data.tipoLancamentosByGroup = _.filter($scope.tipoLancamentos, function (tipoLancamento) {

				return (tipoLancamento.idgrupo_lancamento === $scope.data.lancamentoEstimadoSelecionado.id_grupolancamento && tipoLancamento.fluxo === 'DESPESA');
			});
			$scope.data.lancamentoEstimadoSelecionado.id_tipolancamento = $scope.data.tipoLancamentosByGroup ? $scope.data.tipoLancamentosByGroup[0].id : null;
		};

		$scope.updateLancamentoEstimados = function () {
			LancamentoService.getAllLancamentoEstimado().then(function (data) {
				lancamentoEstimados = data.data;
				$scope.data.lancamentoEstimadosByGroup = _.values(_.groupBy(lancamentoEstimados, 'id_grupolancamento'));
			});
			LancamentoService.getResumoLancamentoEstimado().then(function (data) {
				$scope.resumoLancamentosEstimados = data.data;
			});
		};

		$scope.createLancamentoEstimado = function () {
			$scope.data.lancamentoEstimadoSelecionado.id = '';
			$scope.data.lancamentoEstimadoSelecionado.id_grupolancamento = '';
			$scope.data.lancamentoEstimadoSelecionado.id_tipolancamento = '';
			$scope.data.lancamentoEstimadoSelecionado.fundo_reserva = true;
			$scope.data.lancamentoEstimadoSelecionado.valor = 0;
			$('#novoLancamento').modal('show');
		};

		$scope.editLancamentoEstimado = function (lancamentoEstimado) {
			$scope.data.lancamentoEstimadoSelecionado.id = lancamentoEstimado.id;
			$scope.data.lancamentoEstimadoSelecionado.id_grupolancamento = lancamentoEstimado.id_grupolancamento;
			$scope.updateTipoLancamentoSelecionado();
			$scope.data.lancamentoEstimadoSelecionado.id_tipolancamento = lancamentoEstimado.id_tipolancamento;
			$scope.data.lancamentoEstimadoSelecionado.fundo_reserva = lancamentoEstimado.fundo_reserva > 0;
			$scope.data.lancamentoEstimadoSelecionado.valor = lancamentoEstimado.valor;
			$('#novoLancamento').modal('show');
		};

		$scope.gerarEstimativaPdf = function () {
			// LancamentoService.openEstimadosPdf();
            let prom;
            prom = $http.get(`${config.apiUrl}api/lancamentos_estimados/pdf/1`, {
                responseType: 'arraybuffer'
            });
            prom.then(
                function success(response) {console.log(response);
                    let blob = new Blob([response.data], {
                        type: 'application/pdf'
                    });

                    $('#showPdf').modal('show');
                    $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);

                }, function error(e) {
                    UtilsService.toastError(e || 'Não foi encontrado nenhum resultado!');

                }
            )
		};

		$scope.gerarEstimativa = function () {
			$('#gerarEstimativa').modal('show');
		};

		$scope.closeGerarEstimativaModal = function () {
			$('#gerarEstimativa').modal('hide');
		};

		$scope.closeNovaEstimativaModal = function () {
			$('#novoLancamento').modal('hide');
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

        $scope.aprovaLancamentosEstimado = async () => {
            try {
                $scope.data.aprovaLancamentoEstimados.mes_competencia = $scope.ultimoEstimado.mes_competencia;
                $scope.data.aprovaLancamentoEstimados.ano_competencia = $scope.ultimoEstimado.ano_competencia;
                $scope.data.aprovaLancamentoEstimados.lancamentos = _.map(lancamentoEstimados, function (lancamentoEstimado) {
                    return {
                        valor: lancamentoEstimado.valor,
                        id_tipolancamento: lancamentoEstimado.id_tipolancamento,
                        id_grupolancamento: lancamentoEstimado.id_grupolancamento,
                        fundo_reserva: lancamentoEstimado.fundo_reserva
                    }
                });
                if (!$scope.data.aprovaLancamentoEstimados.lancamentos.length) return UtilsService.openAlert('Adicione pelo menos uma estimativa');
                let data = await LancamentoService.aprovaLancamentoEstimados($scope.data.aprovaLancamentoEstimados);
                UtilsService.openSuccessAlert('Estimativa aprovada.');
                $('.modal-backdrop').hide();
                $scope.closeGerarEstimativaModal();
                $state.go('CPEstimados');
            } catch (e) {
                console.error(e);
                UtilsService.toastError(e);
            }
        };

        let canSaveEdtLanEst = true;
        $scope.saveEditLancamentoEstimado = async () => {
            try {
                if (!canSaveEdtLanEst) return;
                canSaveEdtLanEst = false;
                $('.loader').show();
                let data;
                if ($scope.data.lancamentoEstimadoSelecionado.id)
                    data = await LancamentoService.editLancamentoEstimado($scope.data.lancamentoEstimadoSelecionado);
                else
                    data = await LancamentoService.saveLancamentoEstimado($scope.data.lancamentoEstimadoSelecionado);
                $scope.updateLancamentoEstimados();
                $scope.closeNovaEstimativaModal();
                UtilsService.toastSuccess(data.data);
            } catch (e) {
                UtilsService.toastError(e.responseJSON.message);
            } finally {
                $('.loader').hide();
                canSaveEdtLanEst = true;
            }
        }
    }
);