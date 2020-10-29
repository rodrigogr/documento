angular.module('appServices').service('ConfiguracaoService', ['$q', 'config', ConfiguracaoService]);

function ConfiguracaoService($q, config) {
	var self = this;

	self.data = {
		user: {}
	};

	self.getAllLocalidades = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/localidades',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.getAllDepartamentos = function() {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/departamentos',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.getAllGrupoCalculos = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/grupo_calculo',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.saveGrupoCalculos = function (grupoCalculo) {
		return $q.when($.ajax({
			type: 'POST',
			url: config.apiUrl + 'api/grupo_calculo',
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				descricao: grupoCalculo.descricao,
				id_formula: grupoCalculo.id_formula,
				percentualfundoreserva: grupoCalculo.percentualfundoreserva,
				id_tipolancamento_taxaassociativa: grupoCalculo.id_tipolancamento_taxaassociativa,
				id_tipolancamento_fundoreserva: grupoCalculo.id_tipolancamento_fundoreserva
			}
		}).then(function(data) {
			return data;
		}));
	};

	self.editGrupoCalculos = function (grupoCalculo) {
		return $q.when($.ajax({
			type: 'PATCH',
			url: config.apiUrl + 'api/grupo_calculo/' + grupoCalculo.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				descricao: grupoCalculo.descricao,
				id_formula: grupoCalculo.id_formula,
				percentualfundoreserva: grupoCalculo.percentualfundoreserva,
				id_tipolancamento_taxaassociativa: grupoCalculo.id_tipolancamento_taxaassociativa,
				id_tipolancamento_fundoreserva: grupoCalculo.id_tipolancamento_fundoreserva
			}
		}).then(function(data) {
			return data;
		}));
	};

	self.deleteGrupoCalculos = function (grupoCalculo) {
		return $q.when($.ajax({
			type: 'DELETE',
			url: config.apiUrl + 'api/grupo_calculo/' + grupoCalculo.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.getConfiguracaoCondominio = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/condominio_configuracoes',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.saveConfiguracaoCondominio = function (configuracaoCondominio) {
		return $q.when($.ajax({
			type: 'PATCH',
			url: config.apiUrl + 'api/condominio_configuracoes/' + configuracaoCondominio.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				calculomessubsequente: configuracaoCondominio.calculomessubsequente ? 1 : 0,
				compensarabatimento: configuracaoCondominio.compensarabatimento ? 1 : 0,
				diavencimento: configuracaoCondominio.diavencimento,
				diaapuracao: configuracaoCondominio.diaapuracao,
				periododaapuracao: configuracaoCondominio.periododaapuracao,
				tipodeapuracao: configuracaoCondominio.tipodeapuracao
			}
		}).then(function(data) {
			return data;
		}));
	};

	self.getAllTipoInadiplencia = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/tipo_inadimplencias',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.getAllSituacaoInadimplencia = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/inadimplencia/situacao_tipo',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.getConfiguracaoReceita = function () {
		return $q.when($.ajax({
			type: 'GET',
			url: config.apiUrl + 'api/parametros_receita',
			header: {
				'Content-Type': 'application/json'
			},
			data: {}
		}).then(function(data) {
			return data;
		}));
	};

	self.saveConfiguracaoReceita = function (configuracaoReceita) {
		return $q.when($.ajax({
			type: 'PATCH',
			url: config.apiUrl + 'api/parametros_receita/' + configuracaoReceita.id,
			header: {
				'Content-Type': 'application/json'
			},
			data: {
				percentualmulta: configuracaoReceita.percentualmulta,
				percentualjuros: configuracaoReceita.percentualjuros,
				modalidadejuro: configuracaoReceita.modalidadejuro,
				periodicidadedojuro: configuracaoReceita.periodicidadedojuro,
				incidircorrecao: configuracaoReceita.incidircorrecao ? 1 : 0,
				indicecorrecao: configuracaoReceita.indicecorrecao,
				visualizarinstrucao: configuracaoReceita.visualizarinstrucao ? 1 : 0,
				instrucaosacado: configuracaoReceita.instrucaosacado,
				localdepagamento: configuracaoReceita.localdepagamento,
				anexarprestacaodecontas: configuracaoReceita.anexarprestacaodecontas ? 1 : 0,
				mesprestacaodeconta: configuracaoReceita.mesprestacaodeconta,
				versoboleto: configuracaoReceita.versoboleto ? 1 : 0,
				tempoinadimplencia: configuracaoReceita.tempoinadimplencia,
				valortolerancia: configuracaoReceita.valortolerancia,
                id_configuracao_carteira: configuracaoReceita.id_configuracao_carteira,
				id_tipolancamentomulta: configuracaoReceita.id_tipolancamentomulta,
				id_tipolancamentojuros: configuracaoReceita.id_tipolancamentojuros,
				id_tipolancamentocorrecao: configuracaoReceita.id_tipolancamentocorrecao,
				id_tipolancamentocustasadicionais: configuracaoReceita.id_tipolancamentocustasadicionais,
				id_tipolancamentodesconto: configuracaoReceita.id_tipolancamentodesconto,
				id_tipoinadimplenciapadrao: configuracaoReceita.id_tipoinadimplenciapadrao,
				id_tipolancamentoabatimento: configuracaoReceita.id_tipolancamentoabatimento,
				id_tipolancamentojuridico: configuracaoReceita.id_tipolancamentojuridico
			}
		})
			.then(function(data) {
				return data;
		})
			.catch(function (error) {
				alert(error);
				throw error;
			}));
	};

}
