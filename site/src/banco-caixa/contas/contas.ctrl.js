'use strict'
angular.module('BancoCaixaModule').controller('ContasCtrl',
    function ($scope, $state, BancoService, UtilsService, LancamentoService, HeaderFactory, AuthService) {
        HeaderFactory.setHeader('banco-caixa','bancos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                await Promise.all([
                    BancoService.getAllContasBancariasCadastro()
                        .then(result => $scope.data.contasBancarias = result.data),
                    BancoService.getAllConfiguracaoCateira()
                        .then(result => $scope.data.configuracoesCarteira = result.data),
                    BancoService.getAllBancos()
                        .then(result => $scope.data.bancos = result.data),
                    BancoService.getAllCarteiras()
                        .then(result => $scope.data.allCarteiras = result.data),
                    BancoService.getAllLayoutRemessa()
                        .then(result => $scope.data.layoutRemessas = result.data),
                    BancoService.getAllLayoutRetorno()
                        .then(result => $scope.data.layoutRetornos = result.data),
                    AuthService.aclPaginaService($state.$current.name, user.id)
                        .then(result => $scope.accessPagina = result.data)
                ]);
            } catch (e) {
                if (e.responseJSON.error) {
                    UtilsService.toastError(e.responseJSON.error);
                } else {
                    UtilsService.toastError(e.responseJSON.message);
                }
            } finally {
                $('.loader').hide();
            }
        };

        $scope.data = {
            deleteContaBancaria: null,
            deleteConfiguracaoCarteira: null,
            contaBancariaSelecionado: {
                id: '',
                descricao: '',
                codigo: '',
                url: '',
                configuracoesCarteira: []
            },
            configuracaoCarteiraSelecionado: {
                id_conta_bancaria: null,
                id_carteira: null,
                id_layout_remessa: null,
                id_layout_retorno: null,
                agencia: null,
                conta_corrente: null,
                codigo_cedente: "",
                primeiro_dado_config: "",
                segundo_dado_config: null,
                instru_cobranca_um: "",
                instru_cobranca_dois: "",
                instru_cobranca_tres: "",
                nosso_numero_inicio: null,
                nosso_numero_fim: null,
                configuracoesCarteira: []
            },
            status: 'carteiras'
        };

        $scope.closeContaBancariaModal = function () {
            $('#novaContaBancaria').modal('hide');
        };

        $scope.closeContaBancariaDeleteModal = function () {
            $('#contaBancariaDeleteAlert').modal('hide');
        };

        $scope.showContaBancariaDeleteAlert = function (contaBancaria) {
            $scope.data.deleteContaBancaria = contaBancaria;
            $('#contaBancariaDeleteAlert').modal('show');

            event.stopPropagation();
        };

        $scope.deleteContaBancaria = function () {
            BancoService.deleteContaBancaria($scope.data.deleteContaBancaria).then(function (data) {
                if (!data.errors) {
                    $scope.updateContaBancaria();
                    $scope.closeContaBancariaDeleteModal();

                } else {
                    $scope.closeContaBancariaDeleteModal();
                    alert('Falha ao excluir');
                }
            }).catch(function (error) {
                $scope.closeContaBancariaDeleteModal();
                UtilsService.openAlert(error.responseJSON.message);
            });
        };

        $scope.updateContaBancaria = function () {
            return BancoService.getAllContasBancariasCadastro().then(result => {
                $scope.data.contasBancarias = result.data;
            });
        };

        $scope.saveContaBancaria = function () {
            $scope.data.contaBancariaSelecionado.data_saldo_inicial = moment($scope.data.contaBancariaSelecionado.data_saldo_inicial).format("YYYY-M-D");
            if (!$scope.data.contaBancariaSelecionado.id) {
                BancoService.saveContaBancaria($scope.data.contaBancariaSelecionado).then(function (resp) {
                    $scope.updateContaBancaria();
                    $('#novaContaBancaria').modal('hide');
                    UtilsService.toastSuccess(resp.data);
                }).catch(function (error) {
                    UtilsService.toastError(error.responseJSON.message);
                });
            } else {
                BancoService.editContaBancaria($scope.data.contaBancariaSelecionado).then(function (resp) {
                    $scope.updateContaBancaria();
                    $('#novaContaBancaria').modal('hide');
                    UtilsService.toastSuccess(resp.data);
                }).catch(function (error) {
                    UtilsService.toastError(error.responseJSON.message);
                });
            }
        };

        $scope.editContaBancaria = function (contaBancaria, openModal) {
            if ( $scope.accessPagina.editar) {
                let data_ini = contaBancaria.data_saldo_inicial ? new Date(contaBancaria.data_saldo_inicial + ' 00:00:00') : "";
                let str = contaBancaria.saldo.toString();
                let saldo_valor = str.replace("-", "");
                $scope.data.contaBancariaSelecionado = {
                    id: contaBancaria.id,
                    tipo_banco: contaBancaria.tipo_banco,
                    idbanco: contaBancaria.idbanco,
                    agencia: contaBancaria.agencia,
                    conta: contaBancaria.conta,
                    tipo: contaBancaria.tipo,
                    relatorio: contaBancaria.relatorio,
                    descricao: contaBancaria.descricao,
                    saldo: saldo_valor,
                    data_saldo_inicial: data_ini,
                    operacao: contaBancaria.operacao,
                    configuracoesCarteira: _.filter($scope.data.configuracoesCarteira, {
                        id_conta_bancaria: contaBancaria.id
                    })
                };
            }

            contaBancaria.saldo < 0 ? $scope.data.contaBancariaSelecionado.saldoValue = "-" : $scope.data.contaBancariaSelecionado.saldoValue = "+";
            $scope.saldo();
            if (openModal) {
                $('#novaContaBancaria').modal('show');
            }
        };

        $scope.createContaBancaria = function () {
            $scope.data.contaBancariaSelecionado = {
                tipo_banco: 'bancária',
                idbanco: null,
                agencia: '',
                conta: '',
                tipo: '',
                descricao: '',
                saldo: 0,
                data_saldo_inicial: new Date(),
                operacao: '',
                relatorio: false,
                id: '',
                saldoValue: '+'
            };
            $scope.saldo();
            $('#novaContaBancaria').modal('show');
        };

        $scope.validateContaBancaria = function () {
            if ($scope.data.contaBancariaSelecionado.tipo_banco === 'bancária') {
                return ($scope.data.contaBancariaSelecionado.idbanco && $scope.data.contaBancariaSelecionado.agencia && $scope.data.contaBancariaSelecionado.conta &&
                    $scope.data.contaBancariaSelecionado.tipo && $scope.data.contaBancariaSelecionado.data_saldo_inicial)
            } else {
                return ($scope.data.contaBancariaSelecionado.descricao && $scope.data.contaBancariaSelecionado.data_saldo_inicial)
            }
        };

        /*CONFIGURAÇÃO CARTEIRA*/

        $scope.closeConfiguracaoCarteiraModal = function () {
            $('#novaConfiguracaoCarteira').modal('hide');
        };

        $scope.closeConfiguracaoCarteiraDeleteModal = function () {
            $('#configuracaoCarteiraDeleteAlert').modal('hide');
        };

        $scope.showConfiguracaoCarteiraDeleteAlert = function (configuracaoCarteira) {
            $scope.data.deleteConfiguracaoCarteira = configuracaoCarteira;
            $('#configuracaoCarteiraDeleteAlert').modal('show');
        };

        $scope.deleteConfiguracaoCarteira = function () {
            BancoService.deleteConfiguracaoCateira($scope.data.deleteConfiguracaoCarteira).then(function (data) {
                if (!data.errors) {
                    $scope.updateConfiguracaoCarteira();
                    $scope.closeConfiguracaoCarteiraDeleteModal();

                } else {
                    $scope.closeConfiguracaoCarteiraDeleteModal();
                    alert('Falha ao excluir');
                }
            }).catch(function (error) {
                $scope.closeConfiguracaoCarteiraDeleteModal();
                UtilsService.openAlert(error.responseJSON.message);
            });
        };

        $scope.updateConfiguracaoCarteira = function () {
            return BancoService.getAllConfiguracaoCateira().then(result => {
                $scope.data.configuracoesCarteira = result.data;
                $scope.data.contaBancariaSelecionado.configuracoesCarteira = _.filter($scope.data.configuracoesCarteira, {
                    id_conta_bancaria: $scope.data.contaBancariaSelecionado.id
                })
            });
        };

        $scope.saveConfiguracaoCarteira = function () {
            if (!$scope.data.configuracaoCarteiraSelecionado.id) {
                BancoService.saveConfiguracaoCarteira($scope.data.configuracaoCarteiraSelecionado).then(function (data) {
                    $scope.updateConfiguracaoCarteira();
                    $scope.limpaConfiguracaoCarteira($scope.data.configuracaoCarteiraSelecionado);
                    UtilsService.openSuccessAlert('Carteira cadastrada!');
                });
            } else {
                BancoService.editConfiguracaoCarteira($scope.data.configuracaoCarteiraSelecionado).then(function (data) {
                    $scope.updateConfiguracaoCarteira();
                    $scope.limpaConfiguracaoCarteira($scope.data.configuracaoCarteiraSelecionado);
                    UtilsService.openSuccessAlert('Atualizado!');
                });
            }
        };

        $scope.editConfiguracaoCarteira = function (configuracaoCarteira) {
            $scope.data.configuracaoCarteiraSelecionado = {
                id: configuracaoCarteira.id,
                id_conta_bancaria: configuracaoCarteira.id_conta_bancaria,
                id_carteira: configuracaoCarteira.id_carteira,
                id_layout_remessa: configuracaoCarteira.id_layout_remessa,
                id_layout_retorno: configuracaoCarteira.id_layout_retorno,
                agencia: configuracaoCarteira.agencia,
                conta_corrente: configuracaoCarteira.conta_corrente,
                codigo_cedente: configuracaoCarteira.codigo_cedente,
                primeiro_dado_config: configuracaoCarteira.primeiro_dado_config,
                segundo_dado_config: configuracaoCarteira.segundo_dado_config,
                instru_cobranca_um: configuracaoCarteira.instru_cobranca_um,
                instru_cobranca_dois: configuracaoCarteira.instru_cobranca_dois,
                instru_cobranca_tres: configuracaoCarteira.instru_cobranca_tres,
                nosso_numero_inicio: configuracaoCarteira.nosso_numero_inicio,
                nosso_numero_fim: configuracaoCarteira.nosso_numero_fim
            };
        };

        $scope.createConfiguracaoCarteira = function (contaBancaria) {
            $scope.editContaBancaria(contaBancaria, false);
            $scope.data.carteiras = $scope.data.allCarteiras.filter(x => x.id_banco === contaBancaria.idbanco);
            $scope.data.configuracaoCarteiraSelecionado = {
                id_conta_bancaria: contaBancaria.id,
                id_carteira: null,
                id_layout_remessa: null,
                id_layout_retorno: null,
                agencia: contaBancaria.agencia,
                conta_corrente: contaBancaria.conta,
                codigo_cedente: "",
                primeiro_dado_config: "",
                segundo_dado_config: null,
                instru_cobranca_um: "",
                instru_cobranca_dois: "",
                instru_cobranca_tres: "",
                nosso_numero_inicio: null,
                nosso_numero_fim: 9999999999
            };
            $('#novaConfiguracaoCarteira').modal('show');
        };

        $scope.limpaConfiguracaoCarteira = function (carteiraSelecionada) {
            $scope.data.configuracaoCarteiraSelecionado = {
                id_conta_bancaria: null,
                id_carteira: null,
                id_layout_remessa: null,
                id_layout_retorno: null,
                agencia: carteiraSelecionada.agencia,
                conta_corrente: carteiraSelecionada.conta_corrente,
                codigo_cedente: "",
                primeiro_dado_config: "",
                segundo_dado_config: null,
                instru_cobranca_um: "",
                instru_cobranca_dois: "",
                instru_cobranca_tres: "",
                nosso_numero_inicio: null,
                nosso_numero_fim: 9999999999
            };
        };

        $scope.checkCarteira = function (carteira,retorno) {
            // let id = carteira;
            let carteiras_cadastradas = $scope.data.contaBancariaSelecionado.configuracoesCarteira;
            let check = false;
            angular.forEach(carteiras_cadastradas, function (value) {
                if (value.id_carteira === carteira.id_carteira && value.id != carteira.id) check = true;
            });
            if (retorno) {
                return !check;
            } else {
                if (check) UtilsService.openAlert('Essa carteira "'+$scope.getNomeCarteira(id)+'" já está configurada.')
            }
        };

        $scope.validateConfiguracaoCarteira = function () {
            return ($scope.checkCarteira($scope.data.configuracaoCarteiraSelecionado,true) && $scope.data.configuracaoCarteiraSelecionado.id_conta_bancaria &&
                $scope.data.configuracaoCarteiraSelecionado.id_carteira &&
                $scope.data.configuracaoCarteiraSelecionado.id_layout_remessa &&
                $scope.data.configuracaoCarteiraSelecionado.id_layout_retorno &&
                $scope.data.configuracaoCarteiraSelecionado.nosso_numero_inicio)
        };

        $scope.getNomeCarteira = function (carteiraId) {
            var nomeCarteira = _.find($scope.data.carteiras, {
                id: carteiraId
            });

            return nomeCarteira ? nomeCarteira.descricao : '';
        };

        $scope.getNomeBanco = function (bancoId) {
            var banco = _.find($scope.data.bancos, {
                id: bancoId
            });

            return banco ? banco.descricao : '';
        };
        $scope.getLogoBanco = function (bancoId) {
            var logo_banco = _.find($scope.data.bancos, {
                id: bancoId
            });

            return logo_banco ? logo_banco.img : 'img/bancos/caixa_reg.png';
        };
        $scope.menuCard = function (id) {
            $("#acao"+id).toggle();
        };
        $scope.menuContextoLeave = function (id) {
            $("#acao"+id).hide();
        };
        $scope.getStatusSaldo = function (id,saldo) {
            if(saldo > 0){
                $("#saldo"+id).css('color','green');
            }
            if(saldo < 0){
                $("#saldo"+id).css('color','red');
            }
        };
        $scope.saldo = function () {
            let color = $scope.data.contaBancariaSelecionado.saldoValue === "+" ? "#8a939c" : "#cd5c5c";
            $(".banco-saldo select, .banco-saldo input").css("color",color);
        }
    }
);