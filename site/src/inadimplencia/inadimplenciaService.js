'use strict'
angular.module('InadimplanciaModule').service('InadimplenciaService',
	function ($http, $q, config, BioacessoService) {
		//SHARED
		this.tiposLancamentos;
		this.imovelInfo;
		this.layoutsRemessa;
		this.CarteirasBancarias;
		this.TipoSituacoes;
		this.OPTIONSCATEGORIA = [{ label: 'TAXA', value: 1 }, { label: 'FUNDO', value: 2 }, { label: 'OUTROS', value: 3 }, { label: 'CUSTAS', value: 4 }, { label: 'MULTA', value: 5 }, { label: 'JUROS', value: 6 }, { label: 'JURIDICO', value: 8 }, { label: 'CORRECOES', value: 9 }, { label: 'OUTROS', value: 3 }, { label: 'DESCONTOS', value: 7 }];
		this.STATUS = [{ id: 0, descricao: 'cancelado' }, { id: 1, descricao: 'ativo' }, { id: 2, descricao: 'compensado' }];
		this.tipoInadimplenciaById = (id) => this.TipoSituacoes && id && this.TipoSituacoes.find(x => x.id == id).descricao;
		this.statusById = (id) => { if (id == undefined) return; else return this.STATUS.find(x => x.id == id).descricao; }
		this.optionByValue = (value) => this.OPTIONSCATEGORIA.find(x => x.value == value).label;

		this.ngOnInit = () => {
			// COISAS GENERICAS
			if (!this.tiposLancamentos) this.getTipoLancamentos();
			if (!this.layoutsRemessa) this.getLayoutsRemessa();
			if (!this.CarteirasBancarias) this.getCarteirasBancarias();
			if (!this.TipoSituacoes) this.getTipoSituacoes();
		}

		this.getCarteirasBancarias = function () {
			$http.get(`${config.apiUrl}api/conta_bancarias/carteiras_disponiveis`)
				.then(result => this.CarteirasBancarias = result.data.data)
		}

		this.getLayoutsRemessa = function () {
			$http.get(`${config.apiUrl}api/layout_remessa`)
				.then(data => this.layoutsRemessa = data.data.data)
		}

		this.postCalcularTitulos = function (data) {
			return new Promise((resolve, reject) => {
				$http.post(`${config.apiUrl}api/inadimplencia/calculo_selecionados`, data)
					.then(result => resolve(result.data.data))
					.catch(() => reject())
			});
		}

		this.enviaBoletoEmail = (id) => {
			return new Promise((resolve, reject) => {
				$http.get(`${config.apiUrl}api/inadimplencia/acordos_efetuados/envia_boleto/${id}`)
					.then(result => resolve(riesult.data))
					.catch(() => reject())
			});
		}

		this.downloadRemessa = (id) => {
			return new Promise((resolve, reject) => {
				$http.get(`${config.apiUrl}api/inadimplencia/acordos_efetuados/remessa/${id}`)
					.then(result => resolve(result.data))
					.catch(() => reject())
			});
		}


		this.consultaGeralPdf = function (data) {
			return $http.post(`${config.apiUrl}api/relatorios/receitas/titulos_provisionados`, data, {
				responseType: 'arraybuffer'
			});
		}

		this.getImovelInfoByQeL = function (quadra, lote) {
			return new Promise((resolve, reject) => {
				BioacessoService.getImoveisByQuadraAndLote(quadra, lote)
					.then(result => {
						this.imovelInfo = result.data[0];
						resolve()
					})
					.catch(e => reject(e))
			})
		}

		this.getTitulosInadimplentsByIdImovel = (id) => {
			return new Promise((resolve, reject) => {
				$http.post(`${config.apiUrl}api/inadimplencia/pesquisar`, {
					id_pessoa: '',
					id_empresa: '',
					id_imovel: id,
				})
					.then(result => resolve(result.data.data))
					.catch(e => reject(e))
			})
		};

        this.getTitulosInadimplentsByQeL = (search) => {
            return new Promise((resolve, reject) => {
                $http.post(`${config.apiUrl}api/inadimplencia/pesquisar`, {
                    quadra: search.quadra,
					lote: search.lote
                })
                    .then(result => resolve(result.data.data))
                    .catch(e => reject(e))
            })
        };

		this.getTipoLancamentos = function () {
			$http.get(`${config.apiUrl}api/tipo_lancamentos`)
				.then(result => this.tiposLancamentos = result.data.data)
		}

		this.postAcordoInadimplencia = function (data) {
			return new Promise((resolve, reject) => {
				$http.post(`${config.apiUrl}api/inadimplencia/acordo`, data)
					.then(result => resolve(result.data))
					.catch(() => reject())
			});
		}

		this.getAcordosEfetuadosQeL = (quadra, lote) => {
			return new Promise((resolve, reject) => {
				$http.get(`${config.apiUrl}api/inadimplencia/acordos_efetuados/filtro/${quadra}/${lote}`)
					.then(result => resolve(result.data.data))
					.catch(() => reject())
			});
		}

		this.getAcordoById = (id) => {
			return new Promise((resolve, reject) => {
				$http.get(`${config.apiUrl}api/inadimplencia/acordos_efetuados/${id}`)
					.then(result => resolve(result.data.data[0]))
					.catch(() => reject())
			});
		}

		this.postCancelarAcordo = (data) => {
			return new Promise((resolve, reject) => {
				$http.post(config.apiUrl + 'api/inadimplencia/cancelar_acordo', data)
					.then(result => resolve(result.data))
					.catch((e) => reject(e))
			});
		}

		this.getTipoSituacoes = () => {
			$http.get(`${config.apiUrl}api/inadimplencia/situacao_tipo`)
				.then(result => this.TipoSituacoes = result.data.data);
		}

		this.postClassificarInadimplencias = (data) => {
			return new Promise((resolve, reject) => {
				$http.post(config.apiUrl + 'api/inadimplencia/classificar', data)
					.then(result => resolve(result.data.data))
					.catch((e) => reject(e))
			});
		}

		this.getModelosCarta = (isCobranca) => {
			return new Promise((resolve, reject) => {
				$http.get(`${config.apiUrl}api/inadimplencia/${isCobranca ? 'carta_cobranca' : 'declaracao_quitacao'}`)
					.then(result => resolve(result.data.data))
					.catch(() => resolve([]));
			})
		}
	}
)