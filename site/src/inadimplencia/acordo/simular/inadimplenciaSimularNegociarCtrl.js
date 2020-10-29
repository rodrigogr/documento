'use strict'
angular.module('InadimplanciaModule').controller('InadimplenciaSimularNegociarCtrl',
    function ($scope, $filter, UtilsService, InadimplenciaService, HeaderFactory, AuthService, $state) {

        HeaderFactory.setHeader('inadimplência', 'acordo / simular');
        $scope.InadimplenciaService = InadimplenciaService;
        $scope.data_consultaCalculoParcela;
        $scope.titulosList;
        $scope.acrescimosList;
        $scope.tipoLancamentosFormated; // lista formata para não repetir titulos em acrescimos
        $scope.tabIndex = 0;
        $scope.pagamentoForma = {};
        $scope.data = {
            tiposPagamentosIni: ['À Vista', 'Depósito', 'Boleto', 'Cheque', 'DOC', 'TED']
        };
        $scope.descontosList = [];
        $scope.parcelasList = [];
        $scope.OPTIONSCATEGORIA = InadimplenciaService.OPTIONSCATEGORIA.filter(x => x.value != 7);

        let isNorE = (value) => (value === undefined || value === null);
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        AuthService.aclPaginaService($state.$current.name, user.id)
            .then(result => $scope.accessPagina = result.data);

        $scope.cancelarTab = function () {
            $scope.tabIndex = 0;
            $('.tab__').hide('fast');
            $('#forma_de_pagamento').show('fast');
        };

        $scope.voltarTab = function () {
            $('.ba__modal-body-contas-a-pagar').scrollTop(0);
            $scope.tabIndex--;
            switch ($scope.tabIndex) {
                case 0:
                    $('.tab__').hide('fast');
                    $('#forma_de_pagamento').show('fast');
                    break;
                case 1:
                    $('.tab__').hide('fast');
                    $('#acrescimos_tab').show('fast');
                    break;
                case 2:
                    $('.tab__').hide('fast');
                    $('#descontos_tab').show('fast');
                    break;
                case 3:
                    $('.tab__').hide('fast');
                    $('#parcelamento_tab').show('fast');
                    break;
                case 4:
                    $('.tab__').hide('fast');
                    $('#confirmacao_tab').show('fast');
                    break;
            }
        }

        $scope.proximoTab = function () {
            $('.ba__modal-body-contas-a-pagar').scrollTop(0);
            $scope.tabIndex++;
            switch ($scope.tabIndex) {
                case 0:
                    $('.tab__').hide('fast');
                    $('#forma_de_pagamento').fadeIn('slow');
                    break;
                case 1:
                    $('.tab__').hide('fast');
                    $('#acrescimos_tab').fadeIn('slow');
                    break;
                case 2:
                    $('.tab__').hide('fast');
                    $('#descontos_tab').fadeIn('slow');
                    break;
                case 3:
                    $('.tab__').hide('fast');
                    $('#parcelamento_tab').fadeIn('slow');
                    $scope.checkValoresAlterados();
                    break;
                case 4:
                    if(!$scope.valoresFinais()) {
                        $scope.tabIndex--;
                        break;
                    }
                    $('.tab__').hide('fast');
                    $('#confirmacao_tab').fadeIn('slow');
                    break;
            }
        };

        $scope.checkValoresAlterados = function () {
            //verifica se o cliente voltou no formulário e alterou valores adicionais ou descontos
            if ($scope.parcelasList.length > 0 && $scope.valorProvisionado !== $scope.saldoReceber())
                UtilsService.openAlertAtencao('Houve alguma alteração de valores.<br>Clique novamente em Gerar Parcelas*');

        };

        $scope.valoresFinais = function () {
            // verifica se foram alterados valores de entrada ou das parcelas depois de geradas
            let saldo_receber = $scope.saldoReceber();
            if ($scope.valorProvisionado !== saldo_receber) {
                UtilsService.openAlertAtencao('Houve alguma alteração de valores.<br>Clique novamente em Gerar Parcelas*');
                return false;
            }
            let soma_parcelas = 0;
            $scope.parcelasList.forEach(x => {
                soma_parcelas = (parseFloat(soma_parcelas) + parseFloat(x.valor_parcela));
            });
            if (saldo_receber.toFixed(0) != soma_parcelas.toFixed(0)) {
                let dif = saldo_receber - soma_parcelas;
                UtilsService.openAlertAtencao('O valor das parcelas não correspondem ao valor total gerado!' +
                    '<br>Valor do acordo: '+$filter('currency')(saldo_receber, 'R$ ')+'<br>Valor das parcelas: '+$filter('currency')(soma_parcelas, 'R$ ')+''+
                    '<br>Diferença: '+$filter('currency')(dif, 'R$ ')+'</i>');
                return false;
            }
            return true;
        };

        $scope.checkSelected = () => $scope.calculaDadosParcela($scope.titulosList.filter(x => x.selected == true));

        $scope.calculaDadosParcela = function (titulos) {
            if (titulos.length <= 0) {
                $scope.data_consultaCalculoParcela = null;
                return;
            }
            if ($scope.accessPagina.inserir) {
                let data = {
                    'selecionados': titulos.map(x => {
                        return {
                            'id_boleto': x.id_boleto,
                            'vencimento': $filter('date')(x.data_vencimento, 'dd/MM/yyyy')
                        }
                    })
                };
                InadimplenciaService.postCalcularTitulos(data)
                    .then(result => {
                        $scope.data_consultaCalculoParcela = result;
                        $scope.$digest();
                    }).catch(() => UtilsService.openErrorMsg());
            }
        };

        $scope.mudaFormaPgto = () => {
            if ($scope.data.forma_pagamento === 'À Vista') {
                $scope.parcela.dt_entrada = new Date();
                $scope.parcelasList = [];
                $scope.parcela.avista = $scope.saldoReceber();
                $scope.parcela.entrada = 0;
            } else {
                $scope.parcelasList = [];
                $scope.parcela.entrada = 0;
                $scope.parcela.avista = 0;
                $scope.parcela.dt_entrada = null;
            }
        };

        let defaultValues = () => {
            $scope.pagamentoForma.carteira = InadimplenciaService.CarteirasBancarias.length > 0 ? InadimplenciaService.CarteirasBancarias[0] : null;
            $scope.pagamentoForma.layout = InadimplenciaService.layoutsRemessa.length > 0 ? InadimplenciaService.layoutsRemessa[0] : null;
            $scope.descontosList = [];
            $scope.parcelasList = [];
            $scope.parcela = [];
            $scope.parcela.avista = 0;
            $scope.parcela.entrada = "";
            $scope.parcela.dt_entrada = "";
            $scope.parcela.n_comprovante = "";
            $scope.parcela.qtd_parcela = "";
            $scope.parcela.dt_primeira = "";
            $scope.valorProvisionado = 0;
        };

        $scope.simularAcordo = function () {
            let multa = InadimplenciaService.tiposLancamentos.find(x => x.descricao.toLowerCase() === 'multa');
            let juros = InadimplenciaService.tiposLancamentos.find(x => x.descricao.toLowerCase() === 'juros');
            $scope.acrescimosList = [];
            $scope.acrescimosList.push({
                "idtipo_lancamento": multa.id,
                "descricao": multa.descricao,
                "categoriaDesc": 'MULTA',
                "valor": $scope.data_consultaCalculoParcela.total_multas,
                "categoria": 5
            }, {
                "idtipo_lancamento": juros.id,
                "descricao": juros.descricao,
                "categoriaDesc": 'JUROS',
                "valor": $scope.data_consultaCalculoParcela.total_juros,
                "categoria": 6
            });
            let tipoLancamentosFormated = JSON.parse(JSON.stringify(InadimplenciaService.tiposLancamentos));
            tipoLancamentosFormated.splice(tipoLancamentosFormated.indexOf(multa), 1);
            tipoLancamentosFormated.splice(tipoLancamentosFormated.indexOf(juros), 1);
            $scope.tipoLancamentosFormated = tipoLancamentosFormated;
            $('#negociarDebitos').modal('show');
            defaultValues();
        };

        $scope.abreModalEditaValores = function (acrescimo) {
            $scope.tituloModal = {};
            $scope.tituloModal.titulo = acrescimo.descricao;
            $scope.tituloModal.valor = acrescimo.valor;
            $scope.modalObj = acrescimo;
            $('#modalEditaValores').modal('show');
        };

        $scope.abreModalEditaValoresAbatimento = function (desconto) {
            $scope.tituloModaldes = {};
            $scope.tituloModaldes.titulo = desconto.descricao;
            $scope.tituloModaldes.valor = desconto.valor;
            $scope.modalObjdesc = desconto;
            $('#modalEditaValoresDescontos').modal('show');
        }

        $scope.fechaModalEditaValores = function () {
            $('#modalEditaValores').modal('hide');
            $('#modalEditaValoresDescontos').modal('hide');
        }

        $scope.salvaEditaValoresDesc = function () {
            $scope.modalObjdesc.valor = decimalParse($scope.tituloModaldes.valor);
            $('#modalEditaValoresDescontos').modal('hide');
        }

        $scope.salvaEditaValores = function () {
            $scope.modalObj.valor = decimalParse($scope.tituloModal.valor);
            $('#modalEditaValores').modal('hide');
        }

        $scope.deletaAcrescimo = function (acrescimo) {
            let find = InadimplenciaService.tiposLancamentos.find(x => x.id === acrescimo.idtipo_lancamento);
            $scope.acrescimosList.splice($scope.acrescimosList.indexOf(acrescimo), 1);
            $scope.tipoLancamentosFormated.push(find);
        }

        $scope.deletaDescontos = (desconto) => $scope.descontosList.splice($scope.descontosList.indexOf(desconto), 1);

        $scope.addAcrescimos = function (acrescimo) {
            if (!acrescimo || !acrescimo.categoria || !acrescimo.planoConta || !acrescimo.valor) {
                UtilsService.openAlert('Prencha os Campos: Plano de Conta, Categoria e Valor!');
                return;
            }
            $scope.acrescimosList.push({
                "idtipo_lancamento": acrescimo.planoConta.id,
                "descricao": acrescimo.planoConta.descricao,
                "categoriaDesc": acrescimo.categoria.label,
                "categoria": acrescimo.categoria.value,
                "valor": acrescimo.valor
            });
            let find = $scope.tipoLancamentosFormated.find(x => x.id === acrescimo.planoConta.id);
            $scope.tipoLancamentosFormated.splice($scope.tipoLancamentosFormated.indexOf(find), 1);

            let scrollFim = $(".ba__modal-body-contas-a-pagar")[0].scrollHeight;
            $(".ba__modal-body-contas-a-pagar").animate({scrollTop: scrollFim}, 1000);

        };

        $scope.addDescontos = function (desconto) {
            if (!desconto || !desconto.planoConta || !desconto.valor) {
                UtilsService.openAlert('Prencha os Campos: Plano de Conta,  e Valor!');
                return;
            }
            $scope.descontosList.push({
                "idtipo_lancamento": desconto.planoConta.id,
                "descricao": desconto.planoConta.descricao,
                "categoria": 7,
                "valor": desconto.valor
            });
        };

        $scope.gerarParcelas = function (parcela) {
            if (parcela.entrada && !parcela.dt_entrada) {
                $(function(){
                    $(".ba__modal-body-contas-a-pagar").scrollTop(0);
                });
                UtilsService.openAlertError('Você tem um valor de entrada, defina a data dessa entrada.');
                return false;
            }
            $scope.valorProvisionado = parseFloat($scope.saldoReceber().toString());
            $scope.parcelasList = [];
            if ($scope.data.forma_pagamento === 'À Vista') {
                parcela.qtd_parcela = 1;
                parcela.dt_primeira = parcela.dt_entrada;
                $scope.parcela.avista = parcela.avista;
                // $scope.parcela.entrada = parcela.entrada;
                /*$scope.parcela.entrada = $scope.saldoReceber();
                $scope.parcela.dt_entrada = new Date();
                $scope.parcelasList = [];*/
            }
            if ((!parcela.qtd_parcela || !parcela.dt_primeira) || !$scope.data.forma_pagamento && $scope.data.forma_pagamento !=='À Vista') {
                UtilsService.openAlertError('Verifique os campos obrigatórios');
                return false;
            }
            let entrada = parcela.entrada ? parcela.entrada : 0;
            let valorParcela = ($scope.data.forma_pagamento !== 'À Vista') ? $scope.saldoReceber().toFixed(2) / parcela.qtd_parcela : $scope.saldoReceber().toFixed(2);
            let dt_primeira = new Date(parcela.dt_primeira.toString());
            let month = dt_primeira.getMonth();
            for (let x = 0; x < parseInt(parcela.qtd_parcela); x++) {
                let obj = {
                    "valor_parcela": valorParcela,
                    "data_vencimento": dt_primeira,
                    "forma_pagamento": $scope.data.forma_pagamento,
                    "numero_documento": ''
                };
                $scope.parcelasList.push(obj);
                dt_primeira = new Date(dt_primeira.setMonth(month));
                month = dt_primeira.getMonth() + 1;
            }
            let scrollFim = $(".ba__modal-body-contas-a-pagar")[0].scrollHeight;
            $(".ba__modal-body-contas-a-pagar").animate({scrollTop: scrollFim}, 1000);
        };

        $scope.pesquisarTitulos = async (end) => {
            try {
                $('.loader').show();
                if (!end || !end.quadra || !end.lote) return UtilsService.openAlert('Informe a Quadra e Lote');
                await InadimplenciaService.getImovelInfoByQeL(end.quadra, end.lote);
                $scope.titulosList = await InadimplenciaService.getTitulosInadimplentsByIdImovel(InadimplenciaService.imovelInfo.id);
                $scope.data_consultaCalculoParcela = null;
                $scope.$digest();
            } catch (e) {
                UtilsService.openAlert(e.responseJSON && e.responseJSON.message)
            } finally {
                $('.loader').hide();
            }
        };

        let vmTitulos = (data) => {
            if (data && data.length) {
                data.forEach(x => {
                    x.data_vencimento = UtilsService.toDate(x.data_vencimento);
                });
                data.sort((a, b) => b.data_vencimento - a.data_vencimento);
            }
            return data;
        };

        $scope.confirmar = async () => {
            try {
                if (!$scope.accessPagina.inserir) {
                    throw 'Você não tem permissão para negociar débitos!';
                }
                $('.loader').show();

                let data_entrada = $scope.parcela.dt_entrada ? $filter('date')(new Date($scope.parcela.dt_entrada.toString()), 'dd/MM/yyyy') : "";
                let data = {
                    "boletos_negociados": $scope.data_consultaCalculoParcela.boletos_negociados,
                    "valor_divida": $scope.data_consultaCalculoParcela.total_divida,
                    "valor_acordo": $scope.data.forma_pagamento === 'À Vista' ? $scope.parcela.avista : $scope.saldoReceber(),
                    "forma_pagamento": $scope.data.forma_pagamento,
                    "layout": $scope.pagamentoForma.layout.id,
                    "id_config_carteira": $scope.pagamentoForma.carteira.id_carteira_conta,
                    "pessoa_id": InadimplenciaService.imovelInfo.pessoa_id,
                    "nome_parceiro": InadimplenciaService.imovelInfo.nome,
                    "id_imovel": InadimplenciaService.imovelInfo.id,
                    "quadra": InadimplenciaService.imovelInfo.quadra,
                    "lote": InadimplenciaService.imovelInfo.lote,
                    "acrescimos": $scope.acrescimosList,
                    "descontos": $scope.descontosList,
                    "valor_entrada": $scope.parcela.entrada,
                    "pgto_avista": $scope.parcela.avista,
                    "data_recebimento_entrada": data_entrada,
                    "comprovante_entrada": $scope.parcela.n_comprovante | "",
                    "qtd_parcelas": $scope.parcela.qtd_parcela,
                    "parcelas": $scope.parcelasList
                };
                let result = await InadimplenciaService.postAcordoInadimplencia(data);
                $scope.cancelarTab();
                $('#negociarDebitos').modal('hide');
                UtilsService.toastSuccess(result.data);
                $scope.pesquisarTitulos($scope.end);
                $scope.$digest();
            } catch (e) {
                UtilsService.toastError(e || 'Erro. Atualize a página e tente novamente!');
            } finally {
                $('.loader').hide();
            }
        };


        $scope.saldoReceber = function () {
            if (!$scope.data_consultaCalculoParcela || !$scope.acrescimosList) return;
            let saldoTotal = $scope.data_consultaCalculoParcela.total_divida;
            let valorAdicionado = $scope.valorAddCalc();
            let juros = $scope.jurosCalc();
            let multa = $scope.multaCalc();
            let descontos = $scope.descontoCalc();
            let entrada = $scope.parcela.entrada;
            return saldoTotal + ((((valorAdicionado + juros + multa) - descontos))-entrada);
        };

        $scope.atualizaSaldo = function () {
            let parcelas = 0;
            angular.forEach($scope.parcelasList, function (itm) {
                parcelas = parcelas + itm.valor_parcela;
            });
            let sub = ($scope.saldoReceber().toFixed(2) - $scope.parcela.entrada);
            return $scope.data.forma_pagamento !== 'À Vista' ? (sub - parcelas) : false;
        };

        $scope.jurosCalc = function () {
            if (!$scope.data_consultaCalculoParcela || !$scope.acrescimosList) return;
            let value = $scope.acrescimosList.find(x => x.descricao.toLowerCase() === 'juros');
            if (!value) return 0;
            else return value.valor;
        };

        $scope.multaCalc = function () {
            if (!$scope.data_consultaCalculoParcela || !$scope.acrescimosList) return;
            let value = $scope.acrescimosList.find(x => x.descricao.toLowerCase() === 'multa');
            if (!value) return 0;
            else return value.valor;
        };

        $scope.valorAddCalc = function () {
            if (!$scope.data_consultaCalculoParcela || !$scope.acrescimosList) return;
            let values = $scope.acrescimosList.filter(x => x.descricao.toLowerCase() !== 'multa' && x.descricao.toLowerCase() !== 'juros');
            return values.length <= 0 ? 0 : values.map(x => x.valor).reduce((x, y) => x + y);
        };

        $scope.descontoCalc = function () {
            if (!$scope.data_consultaCalculoParcela || !$scope.acrescimosList) return;
            return $scope.descontosList.length <= 0 ? 0 : $scope.descontosList.map(x => x.valor).reduce((x, y) => x + y);
        };

        let decimalParse = function (value) {
            if (isNorE(value)) return 0;
            value = value.toString();
            if (value.includes(',')) {
                value = parseFloat(parseFloat(value.replace(',', '.')).toFixed(2));
            } else {
                value = parseFloat(parseFloat(value).toFixed(2));
            }
            return value;
        }
    }
);