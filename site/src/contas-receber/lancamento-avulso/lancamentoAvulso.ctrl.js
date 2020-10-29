'use strict'
angular.module('ContasReceberModule').controller('LancamentoAvulsoCtrl',
    function ($scope, $http, $filter, config, LancamentoService, BioacessoService,
              UtilsService, BancoService, ConfiguracaoService, HeaderFactory, AuthService, $state) {

        HeaderFactory.setHeader('Receitas', 'Cobranças avulsas');

        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                await $scope.pesquisar();
                await Promise.all(basicData);
                $scope.enableBtnNovo = true;
                $scope.$digest();
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide();
            }
        };
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        let basicData = [
            BioacessoService.getAllFornecedor()
                .then(result => $scope.data.fornecedores = result.data),
            LancamentoService.getAllTipoLancamentos()
                .then(result => {
                    $scope.allPlanoContas = result.data.filter(x => x.fluxo == 'RECEITA');
                    $scope.data.planoContas = result.data.filter(x => x.fluxo == 'RECEITA');
                }),
            BancoService.getAllLayoutRemessa()
                .then(result => $scope.data.layoutArquivos = result.data),
            ConfiguracaoService.getAllSituacaoInadimplencia()
                .then(result => $scope.data.situacoesInadimplencia = result.data),
            BancoService.getAllCarteirasDisponiveis()
                .then(result => $scope.data.carteirasDisponiveis = result.data),
            LancamentoService.getGruposLancamentosTipo('RECEITA')
                .then(result => $scope.grupoLancamentos = result.data),
            AuthService.aclPaginaService($state.current.name, user.id)
                .then(result => $scope.accessPagina = result.data)
        ];
        $scope.data = {
            title: 'Lançamentos avulsos',
            lancamentoFiltro: 'nova',
            lancamentoAvulsoSelecionado: {
                tipo_cobranca: 'nova',
                atribuicao: 'imovel',
                id_configuracao_carteira: '',
                idimovel: '',
                nome_titular: '',
                id_empresa: '',
                id_layout_remessa: '',
                idtipo_lancamento: '',
                descricao: '',
                valor: '',
                percentual_multa: '',
                percentual_juros: '',
                nosso_numero: '',
                numero_documento: '',
                aceite: '',
                especie_doc: '',
                situacao_indimplencia: '',
                lancamentos: []
            },
            objLancamentoAntigo: {
                idtipo_lancamento: '',
                categoria: '',
                descricao: '',
                valor: 0
            },
            layoutArquivosFiltrados: [],
            carteiraSelecionada: null,
            searchImoveis: [],
            searchQuadra: '',
            searchLote: '',
            especies: [
                'DM',
                'NP',
                'NS',
                'REC',
                'CT',
                'CS',
                'DS',
                'LC',
                'ND',
                'CDA',
                'EC',
                'CPS'
            ],
            categorias: [
                "Taxa",
                "Fundo",
                "Outros"
            ]
        };

        let ViewModelLA = (data, isNovo) => {
            if (data && data.length) {
                data.forEach(x => {
                    x.created_at = UtilsService.toDate(x.created_at);
                    /*let d1 = x.data_vencimento;
                    let d2 = x.data_competencia;
                    let d3 = d1.split("/");
                    let d4 = d2.split("/");*/
                    // x.data_vencimento = $filter('date')(x.data_vencimento, "yyyy-MM-dd");
                    // x.data_competencia = $filter('date')(x.data_competencia, "yyyy-MM-dd");
                    x.data_vencimento = UtilsService.toDate(x.data_vencimento);
                    x.data_competencia = UtilsService.toDate(x.data_competencia);
                    // x.data_vencimento = new Date(d3[2],d3[1]-1,d3[0]);
                    // x.data_competencia = new Date(d4[2],d4[1]-1,d4[0]);
                    x.vmImvEmp = x.imovel ? `Qd. ${x.imovel.quadra} Lt. ${x.imovel.lote}` : x.empresa.nome_fantasia;
                    if (isNovo) {
                        x.vmDescricao = x.lancamento.descricao;
                        x.vmValor = x.lancamento.valor;
                    } else {
                        x.vmLancamentos = x.lancamentos.length;
                        x.vmValor = $scope.getTotalValorAntigoLista(x);
                    }
                });
                data.sort((a, b) => b.created_at - a.created_at);
            }
            return data;
        };

        $scope.closeModal = () => $('#novoLancamento').modal('hide');

        $scope.updateLancamentoAvulso = () => $scope.pesquisar();

        $scope.updateCarteiraSelecionada = function () {
            $scope.data.layoutArquivosFiltrados = _.filter($scope.data.layoutArquivos, function (layoutArquivo) {
                return (layoutArquivo.id_carteira === $scope.data.lancamentoAvulsoSelecionado.id_configuracao_carteira);
            })
        }

        $scope.sendBoletoEmail = async () => {
            try {
                await UtilsService.confirmAlert('Enviar email', 'Deseja enviar o boleto por email?', 'Cancelar', 'Enviar');
                await LancamentoService.sendBoletoAvulsoEmail($scope.data.lancamentoAvulsoSelecionado);
            } catch (e) {
                UtilsService.toastError(e.responseJSON && e.responseJSON.message || 'Error');
            } finally {
                $scope.closeModal();
            }
        }

        $scope.createLancamentoAvulso = function () {
            $scope.data.searchQuadra = '';
            $scope.data.searchLote = '';
            $scope.data.objLancamentoAntigo = {
                idtipo_lancamento: '',
                categoria: '',
                descricao: '',
                valor: 0
            };
            $scope.data.lancamentoAvulsoSelecionado = {
                tipo_cobranca: $scope.data.lancamentoFiltro,
                edita: 'nova',
                atribuicao: 'imovel',
                id_configuracao_carteira: _.first($scope.data.carteirasDisponiveis).id_carteira_conta,
                idimovel: '',
                id_empresa: '',
                id_layout_remessa: _.first($scope.data.layoutArquivos).id,
                idtipo_lancamento: '',
                descricao: '',
                valor: '',
                percentual_multa: '',
                percentual_juros: '',
                nosso_numero: '',
                numero_documento: '',
                aceite: '',
                especie_doc: '',
                situacao_inadimplencia: _.first($scope.data.situacoesInadimplencia).id,
                lancamentos: []
            };
            $('#novoLancamento').modal('show');
        }

        $scope.editLancamentoAvulso = function (lancamentoAvulso) {
            if (lancamentoAvulso.idimovel) {

                BioacessoService.getImovel(lancamentoAvulso.idimovel).then(function (result) {
                    $scope.data.searchQuadra = result.data.quadra;
                    $scope.data.searchLote = result.data.lote;
                });
            }
            if ($scope.data.lancamentoFiltro === 'antiga') {
                $scope.data.lancamentoAvulsoSelecionado = {
                    id: lancamentoAvulso.id,
                    cobranca: true,
                    id_lancamento: false,
                    tipo_cobranca: 'antiga',
                    edita: 'antiga',
                    atribuicao: lancamentoAvulso.idimovel ? 'imovel' : 'empresa',
                    id_configuracao_carteira: lancamentoAvulso.id_configuracao_carteira,
                    idimovel: lancamentoAvulso.idimovel,
                    nome_titular: lancamentoAvulso.nome_morador,
                    id_empresa: lancamentoAvulso.id_empresa,
                    id_layout_remessa: lancamentoAvulso.id_layout_remessa,
                    data_vencimento: UtilsService.toDate(lancamentoAvulso.data_vencimento),
                    data_competencia: UtilsService.toDate(lancamentoAvulso.data_competencia),
                    percentual_multa: lancamentoAvulso.percentual_multa,
                    percentual_juros: lancamentoAvulso.percentual_juros,
                    nosso_numero: lancamentoAvulso.nosso_numero,
                    numero_documento: lancamentoAvulso.numero_documento,
                    aceite: lancamentoAvulso.aceite === 1,
                    especie_doc: lancamentoAvulso.especie_doc,
                    lancamentos: lancamentoAvulso.lancamentos,
                    situacao_inadimplencia: lancamentoAvulso.situacao_inadimplencia,
                    idGrupLan: $scope.allPlanoContas.find(x => x.id == lancamentoAvulso.lancamento.idtipo_lancamento).idgrupo_lancamento
                };
            } else {
                $scope.data.lancamentoAvulsoSelecionado = {
                    id_lancamento: lancamentoAvulso.id_lancamento,
                    cobranca: true,
                    tipo_cobranca: 'nova',
                    edita: 'nova',
                    atribuicao: lancamentoAvulso.idimovel ? 'imovel' : 'empresa',
                    id_configuracao_carteira: lancamentoAvulso.id_configuracao_carteira,
                    idimovel: lancamentoAvulso.idimovel,
                    nome_titular: lancamentoAvulso.nome_morador,
                    id_empresa: lancamentoAvulso.id_empresa,
                    id_layout_remessa: lancamentoAvulso.id_layout_remessa,
                    idtipo_lancamento: lancamentoAvulso.lancamento.idtipo_lancamento,
                    descricao: lancamentoAvulso.lancamento.descricao,
                    valor: lancamentoAvulso.lancamento.valor,
                    data_vencimento: UtilsService.toDate(lancamentoAvulso.data_vencimento),
                    cancelamento: lancamentoAvulso.cancelamento,
                    motivo_cancelamento: lancamentoAvulso.motivo_cancelamento,
                    situacao: lancamentoAvulso.lancamento.situacao,
                    idGrupLan: $scope.allPlanoContas.find(x => x.id == lancamentoAvulso.lancamento.idtipo_lancamento).idgrupo_lancamento
                };
            }
            $('#novoLancamento').modal('show');
        }

        $scope.deleteLancamentoAdd = function (lancamentoAntigo) {
            var index = this.itens.indexOf(lancamentoAntigo);
            if (lancamentoAntigo.id) $scope.data.lancamentoAvulsoSelecionado.lancamentos[index].deleted = 1;
            else this.itens.splice(index, 1);
        }

        $scope.cancelaLancamentoAvulso = (lancamento) => {
            UtilsService.deleteMotivo('Cancelar Lançamento', 'Deseja cancelar o lançamento? Digite o motivo:')
                .then( async function (res) {
                    if (!res) {
                        return false;
                    }
                    try {
                        $('#loading').modal('show');
                        let data = await LancamentoService.cancelamentoLancamento(lancamento.id_lancamento,res);
                        if (data.check) {
                            $("#acoes_avulso" + lancamento.id_lancamento).remove();
                            $("#row" + lancamento.id_lancamento).append(`<div class='col-xs-2'>\n<i class='lanc_cancel'>cancelado</i>\n</div>`);
                            UtilsService.openSuccessAlert(data.msg);
                            $scope.updateLancamentoAvulso();
                        } else
                            UtilsService.openAlert(data.msg);
                    } catch (e) {
                        console.error(e);
                        UtilsService.openErrorMsg(e.responseJSON.message || 'Error');
                    } finally {
                        $("#loading").modal('hide');
                    }
                })
                .catch( function (e) {
                    console.error(e);
                    UtilsService.openAlertError('Falha ao cancelar. ')
                });
        };

        /*$scope.cancelaLancamentoAvulso = async (lancamento) => {
            await UtilsService.confirmAlert('Cancelar lançamento', 'Deseja cancelar lançamento?');
            try {
                $('#loading').modal('show');
                let data = await LancamentoService.cancelamentoLancamento(lancamento.id_lancamento);
                if (data.check) {
                    $("#acoes_avulso" + lancamento.id_lancamento).remove();
                    $("#row" + lancamento.id_lancamento).append(`<div class='col-xs-2'>\n<i class='lanc_cancel'>cancelado</i>\n</div>`);
                    UtilsService.openSuccessAlert(data.msg);
                } else
                    UtilsService.openAlert(data.msg);
            } catch (e) {
                console.error(e);
                UtilsService.openErrorMsg(e.responseJSON.message || 'Error');
            } finally {
                $("#loading").modal('hide');
            }
        }*/

        $scope.closeDeleteModal = () => $('#deleteAlert').modal('hide');

        $scope.showDeleteAlert = (lancamentoAntigo) => {
            $scope.data.deleteLancamentoAntigo = lancamentoAntigo;
            $('#deleteAlert').modal('show');
        }
        let canDelLanAvl = true;
        $scope.deleteLancamentoAvulso = async function () {
            try {
                if (!canDelLanAvl) return;
                canDelLanAvl = false;
                $scope.closeDeleteModal();
                $('#loading').modal('show');
                let data = await LancamentoService.deletaLancamento($scope.data.deleteLancamentoAntigo.id);
                if (data.check) {
                    $('#loading').modal('hide');
                    UtilsService.openSuccessAlert(data.msg);
                    $("#lanc_antigo" + $scope.data.deleteLancamentoAntigo.id).fadeOut(2000);
                } else
                    UtilsService.openAlert(data.msg);
            } catch (e) {
                console.error(e);
                UtilsService.openErrorMsg(e.responseJSON.message || 'Error');
            } finally {
                $('#loading').modal('hide');
                canDelLanAvl = true;
            }
        }

        $scope.saveLancamentoAvulso = async function () {
            try {
                let select = JSON.parse(JSON.stringify($scope.data.lancamentoAvulsoSelecionado));
                if (select.tipo_cobranca === 'nova') $scope.validate($scope.data.lancamentoAvulsoSelecionado.data_vencimento);
                select.data_vencimento = UtilsService.utcToDate(select.data_vencimento);
                $('#loading').modal('show');
                if (select.tipo_cobranca === 'antiga') select.valor = $scope.getTotalValorAntigo();
                select.data_competencia = UtilsService.utcToDate(select.data_competencia);
                let data = await LancamentoService.saveLancamentoAvulso(select);
                UtilsService.toastSuccess(data.data);
                $scope.closeModal();
                $scope.updateLancamentoAvulso();
            } catch (e) {
                console.error(e);
                if (e.responseJSON) {
                    UtilsService.openErrorMsg(e.responseJSON.message);
                } else {
                    UtilsService.openErrorMsg(e);
                }
            } finally {
                $('#loading').modal('hide');
            }
        };

        $scope.validate = (data) => {
            let hoje = new Date();
            hoje.setHours(0, 0, 0, 0); //para a comparação é necessário zerar horas minutos e segundos
            if (data < hoje) throw new Error("A data informada é menor que hoje");
        };

        $scope.checkAlteracao = async function (lancamentoAvulso) {
            let data = await LancamentoService.checkEditLancamentoAntigo(lancamentoAvulso.id);
            if (lancamentoAvulso.idimovel) {
                BioacessoService.getImovel(lancamentoAvulso.idimovel)
                    .then(result => {
                        $scope.data.searchQuadra = result.data.quadra;
                        $scope.data.searchLote = result.data.lote;
                    });
            }
            $scope.data.lancamentoAvulsoSelecionado = {
                id: lancamentoAvulso.id,
                cobranca: true,
                tipo_cobranca: 'antiga',
                descricao: lancamentoAvulso.descricao,
                atribuicao: lancamentoAvulso.idimovel ? 'imovel' : 'empresa',
                id_configuracao_carteira: lancamentoAvulso.id_configuracao_carteira,
                idimovel: lancamentoAvulso.idimovel,
                nome_titular: lancamentoAvulso.nome_morador,
                id_empresa: lancamentoAvulso.id_empresa,
                id_layout_remessa: lancamentoAvulso.id_layout_remessa,
                data_vencimento: UtilsService.toDate(lancamentoAvulso.data_vencimento),
                percentual_multa: lancamentoAvulso.percentual_multa,
                percentual_juros: lancamentoAvulso.percentual_juros,
                nosso_numero: lancamentoAvulso.nosso_numero,
                numero_documento: lancamentoAvulso.numero_documento,
                aceite: lancamentoAvulso.aceite === 1,
                especie_doc: lancamentoAvulso.especie_doc,
                lancamentos: lancamentoAvulso.lancamentos,
                situacao_inadimplencia: lancamentoAvulso.situacao_inadimplencia,
                data_competencia: UtilsService.toDate(lancamentoAvulso.data_competencia)
            };
            if (!data.check) {
                UtilsService.toastInfo(data.msg);
                $scope.data.lancamentoAvulsoSelecionado.edita = 'nova';
                $scope.data.lancamentoAvulsoSelecionado.id_lancamento = true;
            } else {
                $scope.data.lancamentoAvulsoSelecionado.edita = 'antiga';
                $scope.data.lancamentoAvulsoSelecionado.id_lancamento = false;
            }
            $('#novoLancamento').modal('show');
        };

        $scope.alterarLancamentoAntigo = async () => {

            $('#loading').modal('show');
            $scope.data.lancamentoAvulsoSelecionado.valor = $scope.getTotalValorAntigo();

            let new_data_venc = $scope.data.lancamentoAvulsoSelecionado.data_vencimento;
            let new_data_compt = $scope.data.lancamentoAvulsoSelecionado.data_competencia;
            $scope.data.lancamentoAvulsoSelecionado.new_data_vencimento = new_data_venc.toLocaleDateString();
            $scope.data.lancamentoAvulsoSelecionado.new_data_competencia = new_data_compt.toLocaleDateString();

            let result = await LancamentoService.editLancamentoAntigo($scope.data.lancamentoAvulsoSelecionado);


            $('#novoLancamento').modal('hide');
            $('#loading').modal('hide');
            UtilsService.toastSuccess(result.data);
            $scope.updateLancamentoAvulso();

            $scope.$digest();
        };

        $scope.getImoveisByQuadraAndLote = async () => {
            try {
                let result = await $http.get(`${config.apiUrl}api/imoveis/busca_titular/${$scope.data.searchQuadra}/${$scope.data.searchLote}`)
                $scope.data.lancamentoAvulsoSelecionado.idimovel = result.data.data[0].id;
                $scope.data.lancamentoAvulsoSelecionado.nome_titular = result.data.data[0].nome;
                $scope.$digest();
            } catch (e) {
                console.error(e);
                UtilsService.openAlert(e.data.message);
                $scope.data.lancamentoAvulsoSelecionado.idimovel = '';
                $scope.data.lancamentoAvulsoSelecionado.nome_titular = '';
            }
        }

        $scope.changeTipoCobranca = function () {
            if ($scope.data.lancamentoAvulsoSelecionado.tipo_cobranca === 'nova')
                $scope.data.lancamentoAvulsoSelecionado.atribuicao = 'imovel';
            $scope.pesquisar();
        }

        $scope.selectImovel = function (imovel) {
            $scope.data.lancamentoAvulsoSelecionado.idimovel = imovel.id;
            $('#escolherImovel').modal('hide');
        }

        $scope.gerarBoleto = function () {
            $("#loadingPDF").modal('show');
            let prom;
            prom = $http.get(`${config.apiUrl}api/lancamento_avulsos/gerar_boleto/` + $scope.data.lancamentoAvulsoSelecionado.id_lancamento, {
                responseType: 'arraybuffer'
            });
            prom.then(
                function success(response) {
                    let blob = new Blob([response.data], {
                        type: 'application/pdf'
                    });

                    $('#showPdf').modal('show');
                    $scope.content = (window.URL || window.webkitURL).createObjectURL(blob);

                }, function error(e) {
                    UtilsService.toastError(e || 'Não foi encontrado nenhum resultado!');

                }
            ).finally(function() {
                $("#loadingPDF").modal('hide');
            })
        };

        $scope.gerarRemessa = function () {
            LancamentoService.downloadRemessa($scope.data.lancamentoAvulsoSelecionado.id_lancamento);
        };

        $scope.validaCampo = function () {
            if ($scope.data.lancamentoAvulsoSelecionado.tipo_cobranca === 'nova') {
                return !($scope.data.lancamentoAvulsoSelecionado.id_configuracao_carteira && $scope.data.lancamentoAvulsoSelecionado.id_layout_remessa &&
                    $scope.data.lancamentoAvulsoSelecionado.descricao && $scope.data.lancamentoAvulsoSelecionado.idtipo_lancamento && ($scope.data.lancamentoAvulsoSelecionado.idimovel || $scope.data.lancamentoAvulsoSelecionado.id_empresa) &&
                    $scope.data.lancamentoAvulsoSelecionado.valor && $scope.data.lancamentoAvulsoSelecionado.data_vencimento);
            } else {
                return !($scope.data.lancamentoAvulsoSelecionado.id_configuracao_carteira && $scope.data.lancamentoAvulsoSelecionado.id_layout_remessa &&
                    ($scope.data.lancamentoAvulsoSelecionado.idimovel || $scope.data.lancamentoAvulsoSelecionado.id_empresa) && $scope.data.lancamentoAvulsoSelecionado.situacao_inadimplencia &&
                    $scope.data.lancamentoAvulsoSelecionado.data_vencimento && $scope.data.lancamentoAvulsoSelecionado.lancamentos.length &&
                    $scope.data.lancamentoAvulsoSelecionado.nosso_numero && $scope.data.lancamentoAvulsoSelecionado.numero_documento && $scope.data.lancamentoAvulsoSelecionado.especie_doc && $scope.data.lancamentoAvulsoSelecionado.data_competencia);
            }
        }

        $scope.enableAdLanAnt = () => {
            var id = $scope.data.objLancamentoAntigo.idtipo_lancamento;
            var categoria = $scope.data.objLancamentoAntigo.categoria;
            var descricao = $scope.data.objLancamentoAntigo.descricao;
            var valor = $scope.data.objLancamentoAntigo.valor;
            return !(id != '' && categoria != '' && descricao != '' && valor != 0);
        }

        $scope.adicionaLancamentoAntigo = function () {
            var id = $scope.data.objLancamentoAntigo.idtipo_lancamento;
            var categoria = $scope.data.objLancamentoAntigo.categoria;
            var descricao = $scope.data.objLancamentoAntigo.descricao;
            var valor = $scope.data.objLancamentoAntigo.valor;
            if (id != '' && categoria != '' && descricao != '' && valor != 0) {
                $scope.data.lancamentoAvulsoSelecionado.lancamentos.push($scope.data.objLancamentoAntigo);
                $scope.data.objLancamentoAntigo = {
                    idtipo_lancamento: '',
                    categoria: '',
                    descricao: '',
                    valor: 0
                };
            }
        }

        $scope.getNamePlanoConta = function (tipoLancamentoId) {
            var planoConta = _.find($scope.data.planoContas, {
                id: tipoLancamentoId
            });
            return planoConta ? planoConta.descricao : '';
        }

        $scope.getTotalValorAntigo = function () {
            return _.sumBy($scope.data.lancamentoAvulsoSelecionado.lancamentos, function (lancamentoAntigo) {
                if (lancamentoAntigo.deleted == 0) return lancamentoAntigo.valor;
            });
        }

        $scope.getTotalValorAntigoLista = function (lancamentoAvulso) {
            return _.sumBy(lancamentoAvulso.lancamentos, function (lancamentoAntigo) {
                return lancamentoAntigo.valor;
            });
        }

        $scope.sort = (prop) => {
            if ($scope.prop == prop)
                $scope.reverse = !$scope.reverse;
            else {
                $scope.reverse = false;
                $scope.prop = prop;
            }
        }

        $scope.pesquisar = async (search) => {
            try {
                $('.loader').show();
                await $scope.updateList(1);
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide();
                $('#loading').modal('hide');
            }
        }

        $scope.filterPC = (id) => $scope.data.planoContas = $scope.allPlanoContas.filter(x => x.idgrupo_lancamento == id);

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            let antigo = $scope.data.lancamentoFiltro === 'antiga';
            if ($scope.search) {
                $scope.search.page = page;
                if ($scope.search.data_inicio == null) {
                    $scope.search = {
                        page: page,
                        type: 'dt_vencimento'
                    }
                }
            } else {
                $scope.search = {
                    page: page
                }
            }

            let srch = UtilsService.serializeQueryString($scope.search);
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result;
            if (antigo) {
                result = await $http.get(`${config.apiUrl}api/lancamento_avulsos/antigos?${srch}`);
                $scope.data.lancamentoAvulsosAntigos = ViewModelLA(result.data.data)
            } else {
                result = await $http.get(`${config.apiUrl}api/lancamento_avulsos?${srch}`);
                $scope.data.lancamentoAvulsos = ViewModelLA(result.data.data, true)
            }
            $scope.arquivosRetorno = result.data.data;
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
        };
    }
)