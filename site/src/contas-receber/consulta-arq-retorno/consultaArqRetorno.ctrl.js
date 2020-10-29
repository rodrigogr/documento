'use strict'
angular.module('ContasReceberModule').controller('ConsultaArquivoRetornoCtrl',
    function ($scope, ReceitaService, UtilsService, $http, config, HeaderFactory, AuthService, $state) {
        HeaderFactory.setHeader('Receitas', 'consultar arquivo retorno');
        $scope.arquivosRetorno;
        $scope.originalTitulos;

        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.ngOnInit = () => {
            $scope.pesquisar();
        };

        var ano = new Date();
        $scope.data = {
            titulosProcessados: [],
            tituloProcessadoDemonstrativo: {},
            recebimentoTitulo: {
                valor_titulo: 0,
                valor_pago: 0,
                valor_juros: 0,
                valor_multa: 0,
                data_pagamento: '',
                data_compensacao: '',
                nosso_numero: '',
                valor_juros_calculado: 0,
                valor_multa_calculado: 0,
                valor_total_calculado: 0,
                valor_abatimento: 0,
                valor_desconto: 0,
                valor_juridico: 0,
                valor_correcao: 0,
                valor_receber: 0,
                id_titulo_processado:0,
                numero_documento:0
            },
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
            ],
            preLancamento: {
                valor: 0,
                ano: ano.getFullYear(),
                mes: '',
                desconto: 0,
                nosso_numero: '',
                numero_documento:'',
            }
        }

        $scope.pesquisar = async (search) => {
            try {
                $('.loader').show();
                await $scope.updateList(1);
                AuthService.aclPaginaService($state.current.name, user.id)
                    .then(result => $scope.accessPagina = result.data);
                // let result = await ReceitaService.consultaArquivosRetorno(search);
                // $scope.arquivosRetorno = result.data.data;
                // $scope.$digest();
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide();
            }
        };

        $scope.showTitulosProcessados = function (arquivoConsultaId) {
            $scope.data.titulosProcessados = [];
            ReceitaService.getAllTitulosProcessados(arquivoConsultaId)
                .then(function (result) {
                    $scope.optionsFilter = ['Todos'].concat(Array.from(new Set(result.data.map(x => x.status))));
                    $scope.data.titulosProcessados = result.data;
                    $scope.originalTitulos = Array.from(result.data);
                    $('#retorno').modal('show');
                });
        }

        $scope.filterProcessos = (text) => {
            text = text.toLowerCase();
            if (text == 'todos') $scope.data.titulosProcessados = Array.from($scope.originalTitulos);
            else $scope.data.titulosProcessados = Array.from($scope.originalTitulos.filter(x => x.status.toLowerCase() == text));
        }

        $scope.closeTitulosProcessados = function () {
            $('#retorno').modal('hide');
        }

        $scope.openDemonstrativo = function (tituloProcessado) {
            $scope.data.tituloProcessadoDemonstrativo = tituloProcessado;
            $('#demonstrativo').modal('show');
        }

        $scope.closeDemonstrativo = function () {
            $('#demonstrativo').modal('hide');
        }

        $scope.receberTodosTitulos = function () {
            ReceitaService.receberTodosTitulos().then(function (result) {
                UtilsService.openSuccessAlert(result.data);
                $scope.closeTitulosProcessados();
            }).catch(function (error) {
                UtilsService.openAlert(error.responseJSON.message);
            });
        }

        $scope.receberTitulo = function () {
            if (!$scope.accessPagina.inserir) {
                UtilsService.toastError('Você não tem permissão para receber esse título');
                return false;
            }
            UtilsService.confirmAlert2('Receber título', 'Confirmar o recebimento', 'Cancelar', 'Sim', true, true, function (isConfirmed) {
                if (isConfirmed) {
                    $scope.data.recebimentoTitulo.id_titulo_processado =  $scope.data.tituloProcessadoDemonstrativo.id;
                    ReceitaService.baixarTitulo($scope.data.recebimentoTitulo).then(function (result) {
                        UtilsService.toastSuccess(result.data);
                        $scope.closeReceberTitulo();
                        $scope.data.tituloProcessadoDemonstrativo.status = 'Aprovado';
                        if ($scope.data.recebimentoTitulo.valor_pago > parseFloat($scope.data.recebimentoTitulo.valor_receber.toFixed(2))) {
                            UtilsService.confirmAlert2('Recebimento a maior', 'Gerar um desconto futuro?', 'Não', 'Sim', true, true, function (isConfirmed) {
                                if (isConfirmed) {
                                    $scope.data.preLancamento.desconto = 1;
                                    $scope.data.preLancamento.nosso_numero = $scope.data.recebimentoTitulo.nosso_numero;
                                    $scope.data.preLancamento.numero_documento = $scope.data.recebimentoTitulo.numero_documento;
                                    $scope.data.preLancamento.valor = $scope.data.recebimentoTitulo.valor_pago - $scope.data.recebimentoTitulo.valor_total_calculado;
                                    $('#preLancamento').modal('show');
                                }
                            });
                        } else if ($scope.data.recebimentoTitulo.valor_pago < parseFloat($scope.data.recebimentoTitulo.valor_receber.toFixed(2))) {
                            UtilsService.confirmAlert2('Recebimento a menor', 'Gerar um lançamento a receber futuro?', 'Não', 'Sim', true, true, function (isConfirmed) {
                                if (isConfirmed) {
                                    $scope.data.preLancamento.desconto = 0;
                                    $scope.data.preLancamento.nosso_numero = $scope.data.recebimentoTitulo.nosso_numero;
                                    $scope.data.preLancamento.numero_documento = $scope.data.recebimentoTitulo.numero_documento;
                                    $scope.data.preLancamento.valor = $scope.data.recebimentoTitulo.valor_total_calculado - $scope.data.recebimentoTitulo.valor_pago;
                                    $('#preLancamento').modal('show');
                                }
                            });
                        }
                        ;
                    }).catch(function (error) {
                        UtilsService.openAlert(error.responseJSON.message);
                    });
                }
            });
        };

        $scope.closeReceberTitulo = function () {
            $('#receberTitulo').modal('hide');
        }

        $scope.openReceberTitulo = function () {
            if (!$scope.accessPagina.inserir) {
                UtilsService.toastError('Você não tem permissão para receber esse título');
                return false;
            }
            $scope.data.recebimentoTitulo = {
                valor_titulo: _.ceil($scope.data.tituloProcessadoDemonstrativo.valor_titulo_origem, 2),
                valor_pago: _.ceil($scope.data.tituloProcessadoDemonstrativo.valor_recebido, 2),
                valor_multa: _.ceil($scope.data.tituloProcessadoDemonstrativo.valor_mora, 2),
                valor_juros: _.ceil($scope.data.tituloProcessadoDemonstrativo.valor_multa, 2),
                data_pagamento: $scope.data.tituloProcessadoDemonstrativo.dt_ocorrencia ? $scope.data.tituloProcessadoDemonstrativo.dt_pagamento : new Date().toLocaleDateString('pt-BR'),
                data_compensacao: $scope.data.tituloProcessadoDemonstrativo.dt_credito ? $scope.data.tituloProcessadoDemonstrativo.dt_credito : new Date().toLocaleDateString('pt-BR'),
                nosso_numero: $scope.data.tituloProcessadoDemonstrativo.nosso_numero,
                numero_documento: $scope.data.tituloProcessadoDemonstrativo.numero_documento,
                valor_juros_calculado: $scope.data.tituloProcessadoDemonstrativo.valor_juros_calculado,
                valor_multa_calculado: $scope.data.tituloProcessadoDemonstrativo.valor_multa_calculado,
                valor_total_calculado: $scope.data.tituloProcessadoDemonstrativo.valor_total_calculado,
                valor_receber: $scope.data.tituloProcessadoDemonstrativo.valor_total_calculado,
                valor_desconto: $scope.data.tituloProcessadoDemonstrativo.valor_desconto,
                valor_abatimento: $scope.data.tituloProcessadoDemonstrativo.valor_abatimento,
                valor_juridico: 0,
                valor_correcao: 0
            };
            $('#receberTitulo').modal('show');
        };

        $scope.cancelarProcessamento = function (tituloId) {
            ReceitaService.cancelarProcessamento(tituloId).then(function (result) {
                UtilsService.openSuccessAlert(result.data);
            }).catch(function (error) {
                UtilsService.openAlert(error.responseJSON.message);
            });
            event.stopPropagation();
        }

        $scope.sort = (prop) => {
            if ($scope.prop == prop)
                $scope.reverse = !$scope.reverse;
            else {
                $scope.reverse = false;
                $scope.prop = prop;
            }
        }

        $scope.preLancamento = async () => {
            try {
                $('#preLancamento').modal('hide');
                let result = await ReceitaService.programarPreLancamento($scope.data.preLancamento);
                UtilsService.toastSuccess(result.data);
            } catch (e) {
                UtilsService.openErrorMsg(e.responseJSON.message || 'Erro');
            }
        }

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if ($scope.search) $scope.search.page = page;
            else $scope.search = {page: page};
            let srch = UtilsService.serializeQueryString($scope.search);
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/recebimento/consultar_arquivo?${srch}`);
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
        }
    }
)