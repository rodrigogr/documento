'use strict';
angular.module('ContasReceberModule').controller('LancamentoRecorrenteCtrl',
	function ($scope, LancamentoService, UtilsService, ConfiguracaoService, config, $http, HeaderFactory, AuthService, $state) {
        HeaderFactory.setHeader('Receitas', 'Lançamentos Recorrentes');
		$scope.$ = $;

        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
		$scope.ngOnInit = async() => {
			try {
				$('.loader').show();
				$scope.updateList($scope.current_page);
				await Promise.all([
					LancamentoService.getAllLancamentoRecorrente()
					.then(result => $scope.data.lancamentosRecorrentes = result.data),
					LancamentoService.getAllTipoLancamentos()
					.then(result => {
						$scope.allPlanoContas = result.data.filter(x => x.fluxo === 'RECEITA');
						$scope.data.planoContas = result.data.filter(x => x.fluxo === 'RECEITA');
					}),
					ConfiguracaoService.getAllLocalidades()
					.then(result => $scope.data.localidades = result.data),
					LancamentoService.getGruposLancamentosTipo('RECEITA')
					.then(result => $scope.grupoLancamentos = result.data),
                    LancamentoService.getCalulosSimulados()
					.then(result => $scope.calculosSimulados = result.data),
                    AuthService.aclPaginaService($state.current.name,user.id)
                        .then(result => $scope.accessPagina = result.data)
				]);
			} catch (e) {
				console.error(e);
			} finally {
				$('.loader').hide();
			}
		};

		var ano = new Date();
		$scope.data = {
			planoContas: null,
			searchQuadra: '',
			searchLote: '',
			searchImoveis: [],
			stepStatus: 1,
			lancamentoRecorrenteSelecionado: {
				idlocalidade: null,
				descricao: '',
				tipo_associacao: 'IMÓVEIS',
				rateio: false,
				fixo: true,
				idtipo_lancamento: null,
				valor: ''
			},
			anos: [{
					ano: ano.getFullYear()
				},
				{
					ano: (ano.getFullYear() + 1)
				}
			],
			meses: [{
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
			]
		};

		$scope.closeDeleteModal = function () {
			$('#deleteAlert').modal('hide');
		};

		$scope.showDeleteAlert = function (lancamentoRecorrente) {
			$scope.data.deleteLancamentoRecorrente = lancamentoRecorrente;
			$('#deleteAlert').modal('show');
			event.stopPropagation();
		};

		let canDelLanRec = true;
		$scope.deleteLancamentoRecorrente = async() => {
			try {
				if (!canDelLanRec) return;
				canDelLanRec = false;
				await LancamentoService.deleteLancamentoRecorrente($scope.data.deleteLancamentoRecorrente);
				$scope.updateLancamentosRecorrente();
			} catch (e) {
				UtilsService.openAlert(e.responseJSON.message);
				console.error(e);
			} finally {
				$scope.closeDeleteModal();
				canDelLanRec = true;
			}
		};

		$scope.updateLancamentosRecorrente = function () {
			LancamentoService.getAllLancamentoRecorrente().then(function (result) {
				$scope.data.lancamentosRecorrentes = result.data;
			});
		};

		$scope.editLancamentoRecorrente = function (lancamentoRecorrente) {
			$scope.data.lancamentoRecorrenteSelecionado.id_lancamento = lancamentoRecorrente.id_lancamento;
			$scope.data.lancamentoRecorrenteSelecionado.descricao = lancamentoRecorrente.lancamento.descricao;
			$scope.data.lancamentoRecorrenteSelecionado.idlocalidade = lancamentoRecorrente.idlocalidade;
			$scope.data.lancamentoRecorrenteSelecionado.idtipo_lancamento = lancamentoRecorrente.lancamento.idtipo_lancamento;
			$scope.data.lancamentoRecorrenteSelecionado.valor = lancamentoRecorrente.lancamento.valor;
			$scope.data.lancamentoRecorrenteSelecionado.rateio = lancamentoRecorrente.rateio === 1;
			$scope.data.lancamentoRecorrenteSelecionado.mes_ini = lancamentoRecorrente.mes_ini;
			$scope.data.lancamentoRecorrenteSelecionado.ano_ini = lancamentoRecorrente.ano_ini;
			$scope.data.lancamentoRecorrenteSelecionado.mes_fim = lancamentoRecorrente.mes_fim;
			$scope.data.lancamentoRecorrenteSelecionado.ano_fim = lancamentoRecorrente.ano_fim;
			$scope.data.lancamentoRecorrenteSelecionado.tipo_associacao = lancamentoRecorrente.tipo_associacao;
			$('#novoLancamentoRecorrente').modal('show');
		};

		$scope.getNamePlanoConta = function () {
			var planoConta = _.find($scope.data.planoContas, {
				id: $scope.data.lancamentoRecorrenteSelecionado.idtipo_lancamento
			});
			return planoConta ? planoConta.descricao : '';
		};

		$scope.getNameLocalidade = function () {
			var localidade = _.find($scope.data.localidades, {
				id: $scope.data.lancamentoRecorrenteSelecionado.idlocalidade
			});
			return localidade ? localidade.descricao : '';
		};

		$scope.nextStep = function () {
			$scope.data.stepStatus = $scope.data.stepStatus + 1;
		};

		$scope.stepBack = function () {
			$scope.data.stepStatus = $scope.data.stepStatus - 1;
		};

		$scope.closeLancamentoRecorrente = function () {
			$('#novoLancamentoRecorrente').modal('hide');
		};

		$scope.createLancamentoRecorrente = function () {
			$scope.data.stepStatus = 1;
			$scope.data.lancamentoRecorrenteSelecionado = {
				idlocalidade: null,
				descricao: '',
				tipo_associacao: 'IMÓVEIS',
				rateio: false,
				fixo: true,
				idtipo_lancamento: null,
				valor: ''
			};
			$('#novoLancamentoRecorrente').modal('show');
		};
		$scope.saveLancamentoRecorrente = async() => {
			try {
				$('.loader').show();
				if (!$scope.verificaMesAno($scope.data.lancamentoRecorrenteSelecionado)) return false;
				let result;
				if (!$scope.data.lancamentoRecorrenteSelecionado.id_lancamento)
					result = await LancamentoService.createLancamentoRecorrente($scope.data.lancamentoRecorrenteSelecionado);
				else
					result = await LancamentoService.editLancamentoRecorrente($scope.data.lancamentoRecorrenteSelecionado);
				$scope.updateLancamentosRecorrente();
				$scope.closeLancamentoRecorrente();
				UtilsService.openSuccessAlert(result.data);
			} catch (e) {
                console.error(e);
				let msg = e.responseJSON.message;
				let joinedErros = $.map(msg, error => error).join("<br>");
				UtilsService.openAlertError(joinedErros);
				// UtilsService.toastError(e.responseJSON.message);
			} finally {
				$('.loader').hide();
			}
		};

		$scope.validaCampo = function () {
			if ($scope.data.lancamentoRecorrenteSelecionado.fixo) {
				return !($scope.data.lancamentoRecorrenteSelecionado.descricao && $scope.data.lancamentoRecorrenteSelecionado.idtipo_lancamento &&
					$scope.data.lancamentoRecorrenteSelecionado.valor);
			} else {
				return !($scope.data.lancamentoRecorrenteSelecionado.descricao && $scope.data.lancamentoRecorrenteSelecionado.idtipo_lancamento &&
					$scope.data.lancamentoRecorrenteSelecionado.valor && $scope.data.lancamentoRecorrenteSelecionado.mes_ini && $scope.data.lancamentoRecorrenteSelecionado.mes_fim &&
					$scope.data.lancamentoRecorrenteSelecionado.ano_ini && $scope.data.lancamentoRecorrenteSelecionado.ano_fim);
			}
		};

		$scope.closeNovoPreLancamentoModal = function () {
			$('#novoPreLancamento').modal('hide');
		};

		$scope.visualizar = function (lancamentoRecorrente) {
			let objPC = $scope.allPlanoContas.filter(x => x.id === lancamentoRecorrente.lancamento.idtipo_lancamento);
			let id_grupo = objPC[0] && objPC[0].idgrupo_lancamento;
			$scope.data.viewSelecionado = {};
			$scope.data.viewSelecionado.id_grupo_conta = id_grupo;
			$scope.data.viewSelecionado.id_lancamento = lancamentoRecorrente.id_lancamento;
			$scope.data.viewSelecionado.descricao = lancamentoRecorrente.lancamento.descricao;
			$scope.data.viewSelecionado.idlocalidade = lancamentoRecorrente.idlocalidade;
			$scope.data.viewSelecionado.idtipo_lancamento = lancamentoRecorrente.lancamento.idtipo_lancamento;
			$scope.data.viewSelecionado.valor = lancamentoRecorrente.lancamento.valor;
			$scope.data.viewSelecionado.rateio = lancamentoRecorrente.rateio === 1;
			$scope.data.viewSelecionado.fixo = lancamentoRecorrente.fixo === 1;
			$scope.data.viewSelecionado.tipo_associacao = lancamentoRecorrente.tipo_associacao;
			$scope.data.viewSelecionado.mes_ini = lancamentoRecorrente.mes_ini;
			$scope.data.viewSelecionado.ano_ini = lancamentoRecorrente.ano_ini;
			$scope.data.viewSelecionado.mes_fim = lancamentoRecorrente.mes_fim;
			$scope.data.viewSelecionado.ano_fim = lancamentoRecorrente.ano_fim;
			$('#CPLRVisualizar').modal('show');
		};

		$scope.filterPC = (id) => $scope.data.planoContas = $scope.allPlanoContas.filter(x => x.idgrupo_lancamento === id);

		$scope.mesExtenso = (i) => ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
			"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
		][i - 1];

		$scope.verificaMesAno = (item, submit = '') => {
            if (!item.fixo && !(item && item.ano_ini && item.mes_ini && item.ano_fim && item.mes_fim)) return false;
            let periodo_ini = false;
            let periodo_fim = false;
            $scope.calculosSimulados.forEach(x => {
                if ((item.ano_ini === x.ano) && (item.mes_ini === x.mes)) {
                    periodo_ini = true;
                }
                if ((item.ano_fim === x.ano) && (item.mes_fim === x.mes)) {
                    periodo_fim = true;
                }
            });
            if (periodo_ini && periodo_fim) {
                $scope.data.lancamentoRecorrenteSelecionado.mes_ini = null;
                $scope.data.lancamentoRecorrenteSelecionado.ano_ini = null;
                $scope.data.lancamentoRecorrenteSelecionado.mes_fim = null;
                $scope.data.lancamentoRecorrenteSelecionado.ano_fim = null;
                if (submit === '') UtilsService.openAlertAtencao('Esses meses já foram calculados! Escolha novamente.');
                return false;
            }
            if (periodo_ini || periodo_fim) {
                UtilsService.openAlertAtencao('Neste intervalo existe mês(es) que a estimativa já foi calculada. Este(s) serão ignorados!');
            }
            return true;
		};

		$scope.switchOnOff = () => {
            if (!$scope.data.lancamentoRecorrenteSelecionado.fixo) {
                $scope.data.lancamentoRecorrenteSelecionado.mes_ini = null;
                $scope.data.lancamentoRecorrenteSelecionado.ano_ini = null;
                $scope.data.lancamentoRecorrenteSelecionado.mes_fim = null;
                $scope.data.lancamentoRecorrenteSelecionado.ano_fim = null;
            }
        };

		$scope.current_page = 1;
		$scope.updateList = async(page) => {
			if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
			let result = await $http.get(`${config.apiUrl}api/lancamento_recorrentes?page=${page}`);
			$scope.estimados = result.data.data;
			$scope.current_page = result.data.current_page;
			$scope.total = result.data.total;
			$scope.per_page = result.data.per_page;
			$scope.pageCount = Math.ceil(result.data.total / result.data.per_page);
			let pageCount = $scope.pageCount;
			if (pageCount >= 6) {
				if (page > 3 && page < pageCount - 2)
					$scope.pages = [page - 2, page - 1, page, page + 1, page + 2];
				else if (page === pageCount - 1)
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
);