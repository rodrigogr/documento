'use strict'
angular.module('ContasReceberModule').controller('PreLancamentoCtrl',
    function ($scope, $http, config, LancamentoService, BioacessoService, UtilsService, HeaderFactory, AuthService, $state) {

        HeaderFactory.setHeader('Receitas', 'Pré-Lançamentos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

        $scope.ngOnInit = () => {
            $scope.pesquisar();
            $http.get(`${config.apiUrl}api/estimados/lista_estimados`)
                .then(result => $scope.estimados = result.data.data);
            LancamentoService.getAllTipoLancamentos()
                .then(result => {
                    $scope.allPlanoContas = result.data.filter(x => x.fluxo == 'RECEITA');
                    $scope.planoContas = result.data.filter(x => x.fluxo == 'RECEITA');
                });
            LancamentoService.getGruposLancamentosTipo('RECEITA')
                .then(result => $scope.grupoLancamentos = result.data);
            AuthService.aclPaginaService($state.current.name, user.id)
                .then(result => $scope.accessPagina = result.data)
        };

        let PreLancViewModal = (data) => {
            data.forEach(x => {
                x.created_at = UtilsService.toDate(x.created_at);
            });
            return data;
        }

        $scope.pesquisar = async (srch) => {
            try {
                $('.loader').show();
                await $scope.updateList(1);
                // srch = UtilsService.serializeQueryString(srch);
                // let result = await $http.get(`${config.apiUrl}api/pre_lancamentos?${srch}`)
                // $scope.preLancamentos = PreLancViewModal(result.data.data);
                // $scope.$digest();
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide();
            }
        }

        $scope.preLancamentoSelecionado = {};
        var ano = new Date();
        $scope.data = {
            searchQuadra: '',
            searchLote: '',
            searchImoveis: [],
            ano: new Date(),
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

        $scope.showDeleteAlert = function (tipoLancamento) {
            $scope.data.deletePreLancamento = tipoLancamento;
            $('#deleteAlert').modal('show');
            event.stopPropagation();
        }

        $scope.deletePreLancamento = async () => {
            try {
                await LancamentoService.deletePreLancamento($scope.data.deletePreLancamento);
                $scope.updatePreLancamentos();
            } catch (e) {
                console.error(e);
                UtilsService.openAlert('Falha ao excluir!');
            } finally {
                $scope.closeDeleteModal();
            }
        }

        $scope.getImoveisByQuadraAndLote = async () => {
            try {
                let result = await BioacessoService.getImoveisByQuadraAndLote($scope.data.search.Quadra, $scope.data.search.Lote);
                $scope.preLancamentoSelecionado.idimovel = result.data[0].id;
                $scope.preLancamentoSelecionado.nome_titular = result.data[0].nome;
                $scope.$digest();
            } catch (e) {
                console.error(e);
                UtilsService.toastError(e.responseJSON.message);
            }
        }

        $scope.updatePreLancamentos = function () {
            $scope.pesquisar();
        }

        $scope.editPreLancamento = function (preLancamento) {
            $scope.preLancamentoSelecionado.id_lancamento = preLancamento.id_lancamento;
            $scope.preLancamentoSelecionado.descricao = preLancamento.lancamento.descricao;
            $scope.preLancamentoSelecionado.idimovel = preLancamento.idimovel;
            $scope.preLancamentoSelecionado.idtipo_lancamento = preLancamento.lancamento.idtipo_lancamento;
            $scope.preLancamentoSelecionado.valor = preLancamento.lancamento.valor;
            $scope.preLancamentoSelecionado.mes = preLancamento.mes;
            $scope.preLancamentoSelecionado.ano = preLancamento.ano;
            $scope.preLancamentoSelecionado.observacao = preLancamento.observacao;
            $scope.preLancamentoSelecionado.desconto = preLancamento.lancamento.categoria == 7 ? true : false;
            $scope.preLancamentoSelecionado.valor_percentual = preLancamento.valor_percentual == 1 ? true : false;

            $scope.data.search = {
                Quadra: preLancamento.imovel.quadra,
                Lote: preLancamento.imovel.lote
            };
            $scope.preLancamentoSelecionado.nome_titular = preLancamento.nome_morador;
            $scope.preLancamentoSelecionado.idGrupoLan =
                $scope.allPlanoContas.find(x => x.id == preLancamento.lancamento.idtipo_lancamento).idgrupo_lancamento;
            $('#novoPreLancamento').modal('show');
        }

        $scope.createPreLancamento = function () {
            $scope.preLancamentoSelecionado = {
                desconto: false,
                valor_percentual: false
            };
            $scope.data.search = {};
            $('#novoPreLancamento').modal('show');
        }

        let canSave = true;
        let valida_data = (mes_form, ano_form) => {
            let data = new Date();
            let mes_hoje = data.getMonth() + 1;
            let ano_hoje = data.getFullYear();
            if (ano_form < ano_hoje || (mes_form < mes_hoje && ano_form <= ano_hoje)) {
                throw 'Verifique o período informado';
            }
        }

        $scope.savePreLancamento = async (evt) => {
            try {
                if (!canSave) return;
                canSave = false;
                var result;
                valida_data($scope.preLancamentoSelecionado.mes, $scope.preLancamentoSelecionado.ano);
                if (!$scope.preLancamentoSelecionado.id_lancamento)
                    result = await LancamentoService.createPreLancamento($scope.preLancamentoSelecionado);
                else
                    result = await LancamentoService.editPreLancamento($scope.preLancamentoSelecionado);
                $scope.updatePreLancamentos();
                $scope.closeNovoPreLancamentoModal();
                UtilsService.toastSuccess(result.data);
            } catch (e) {
                console.error(e);
                UtilsService.toastError(e);
            } finally {
                canSave = true;
            }
        }

        $scope.closeNovoPreLancamentoModal = function () {
            $('#novoPreLancamento').modal('hide');
        }

        $scope.validaCampo = function () {
            return !($scope.preLancamentoSelecionado.descricao && $scope.preLancamentoSelecionado.idtipo_lancamento && $scope.preLancamentoSelecionado.idimovel &&
                $scope.preLancamentoSelecionado.valor && $scope.preLancamentoSelecionado.mes && $scope.preLancamentoSelecionado.ano)
        }

        $scope.openModal = (evt, id) => {
            $(id).modal('show');
            evt.stopPropagation();
        }

        $scope.filterPC = (id) => $scope.planoContas = $scope.allPlanoContas.filter(x => x.idgrupo_lancamento == id);

        $scope.mesExtenso = (i) => ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
            "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
        ][i - 1];


        $scope.verificaMesAno = async (item) => {
            if (item && item.mes && item.ano) {
                let srch = UtilsService.serializeQueryString(item);
                let result = await $http.get(`${config.apiUrl}api/pre_lancamentos/checkCalculados?${srch}`);
                if (result.data.data) {
                    UtilsService.openAlert('Mês já calculado, impossível cadastrar pré-lançamento');
                    $scope.preLancamentoSelecionado.mes = '';
                    $scope.preLancamentoSelecionado.ano = '';
                    item.ano = null;
                    item.mes = null;
                    $scope.$digest();
                }
            }
        };

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if ($scope.search) $scope.search.page = page;
            else $scope.search = {
                page: page
            };
            let srch = UtilsService.serializeQueryString($scope.search);
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/pre_lancamentos?${srch}`);
            $scope.preLancamentos = PreLancViewModal(result.data.data);
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