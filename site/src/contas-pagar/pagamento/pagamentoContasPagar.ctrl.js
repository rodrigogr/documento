'use strict'
angular.module('ContasPagarModule').controller('PagamentoCtrl',
    function ($scope, $filter, $state, config, UtilsService, PagamentoService, BancoService, $http, HeaderFactory, AuthService) {

        HeaderFactory.setHeader('Contas a Pagar', 'Pagamentos');
        $scope.contasBancarias;
        $scope.pagamentos;
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));

        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                let result = await BancoService.getAllContasBancarias();
                $scope.contasBancarias = result.data;
                await $scope.consultaPagamentos({tipo: 'Provisão'});
                AuthService.aclPaginaService($state.$current.name, user.id).then(result => $scope.accessPagina = result.data);
                $scope.$digest();
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide();
            }
        };

        $scope.data = {
            tipoBuscaStatusPagamento: "Provisão",
            tiposPagamentos: ['Dinheiro', 'TED', 'DOC'],
            pagamentosSelecionado: {
                data_pagamento: new Date().toLocaleDateString(),
                data_compensacao: new Date().toLocaleDateString(),
                forma_pagamento: "",
                id_conta_bancaria: "",
                parcelas: []
            },
            parcelasEstorno: [],
            parcelaObj: {
                id: "",
                valor: "",
                numero_comprovante: "",
                multa: "",
                juros: ""
            }
        };

		$scope.closePagarModal = function () {
			$('#pagar').modal('hide');
		};

		$scope.cancelarConsultaPgto = function () {
			$('#consultandoPgtos').modal('hide');
		}

		$scope.consultaPagamentos = async(search) => {
			$(".loader").show();
			$scope.search = search;
			$scope.data.tipoBuscaStatusPagamento = search.tipo;
			await $scope.updateList(1);
			// let result = await PagamentoService.consultaPagamentos(search);
			// $scope.pagamentos = result.data.data;
			$('#consultandoPgtos').modal('hide');
			$(".loader").hide();
			$scope.$digest();
		};

		let vmPgamento = (data) => {
			if (data && data.length) {
				data.forEach(x => {
					x.data_pagamento = UtilsService.toDate(x.data_pagamento);
				})
			}
			return data;
		};

		$scope.showPagarModal = function () {
			$scope.data.pagamentosSelecionado = {
				data_pagamento: new Date().toLocaleDateString(),
				data_compensacao: new Date().toLocaleDateString(),
				forma_pagamento: "",
				id_conta_bancaria: "",
				parcelas: []
			};
			$scope.getParcelasSelecionadasPagamento();
			$('#pagar').modal('show');
		};

		$scope.showEstornoModal = function () {
			$scope.getParcelasSelecionadasEstorno();
			$('#confirmacaoEstorno').modal('show');
		};

		$scope.closeEstornoModal = function () {
			$('#confirmacaoEstorno').modal('hide');
		};

		$scope.showConfirmaPagamentoModal = function () {
			$('#confirmacaoPagamento').modal('show');
		};

		$scope.closeConfirmaPagamentoModal = function () {
			$('#confirmacaoPagamento').modal('hide');
		};

		$scope.toggleAll = function () {
			angular.forEach($scope.pagamentos, function (itm) {
				itm.selecionada = false;
			});
		};

		$scope.getParcelasSelecionadasPagamento = function () {
			$scope.data.pagamentosSelecionado.parcelas = $filter('filter')(angular.copy($scope.pagamentos), {
				selecionada: true
			});
		};

		$scope.getParcelasSelecionadasEstorno = function () {
			$scope.data.parcelasEstorno = $filter('filter')(angular.copy($scope.pagamentos), {
				selecionada: true
			});
		};

        $scope.updatePagamento = function () {
            PagamentoService.getAllPagamentos().then(function (result) {
                if (result.data.length) {
                    $scope.pagamentos = result.data;
                }
            });
        };
        let canSvPg = true;
        $scope.savePagamento = async () => {
            $(".loader").show();
            try {
                if (!$scope.accessPagina.inserir){
                    throw 'Você não tem permissão para estornar';
                }
                if (!canSvPg) return;
                canSvPg = false;
                let parcelas = $scope.data.pagamentosSelecionado.parcelas;
                if (parcelas) {
                    parcelas.forEach(function (itm) {
                        itm.data_pagamento = $scope.data.pagamentosSelecionado.data_pagamento;
                        itm.data_compensacao = $scope.data.pagamentosSelecionado.data_compensacao;
                        itm.forma_pagamento = $scope.data.pagamentosSelecionado.forma_pagamento;
                        itm.id_conta_bancaria = $scope.data.pagamentosSelecionado.id_conta_bancaria;
                    });
                    let result = await PagamentoService.savePagamento(parcelas);
                    UtilsService.openSuccessAlert(result.data);
                    $scope.consultaPagamentos($scope.search);
                }
            } catch (e) {
                if (e.status && e.status === 500) {
                    UtilsService.openAlert(e.statusText);
                } else {
                    UtilsService.openAlert(e.responseJSON && e.responseJSON.message || e);
                }
            } finally {
                $scope.closePagarModal();
                $scope.closeConfirmaPagamentoModal();
                canSvPg = true;
                $(".loader").hide();
                $("#list").scrollTop(0);
            }
        };

        $scope.saveEstorno = function () {
            if (!$scope.accessPagina.inserir){
                UtilsService.openAlertError('Você não tem permissão para estornar');
                return false;
            }
            angular.forEach(
                $scope.data.parcelasEstorno,
                function (itm) {
                    itm.id_conta_bancaria = $scope.data.parcelasEstorno.id_conta_bancaria;
                }
            );
            if ($scope.data.parcelasEstorno) {
                $(".loader").show();
                PagamentoService.estornoPagamento($scope.data.parcelasEstorno).then(function (result) {
                    $scope.consultaPagamentos($scope.search);
                    UtilsService.openSuccessAlert(result.data);
                    $scope.closeEstornoModal();
                }).catch(function (error) {
                    UtilsService.openAlert(error.responseJSON.message);
                }).finally(function () {
                    $(".loader").hide();
                    $("#list").scrollTop(0);
                });
            }
        };

		$scope.getNameContaBancaria = function (parcela) {
			let contaBancaria = _.find($scope.contasBancarias, {
				id_conta_bancaria: parcela.id_conta_bancaria
			});
			return contaBancaria ? contaBancaria.descricao : '';
		};

		$scope.marcaConta = function (parcela) {
			parcela.selecionada = !parcela.selecionada;
		};

		$scope.sort = (prop) => {
			if ($scope.prop == prop)
				$scope.reverse = !$scope.reverse;
			else {
				$scope.reverse = false;
				$scope.prop = prop;
			}
		}

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if ($scope.search) $scope.search.page = page;
            else $scope.search = {page: page};
            let srch = UtilsService.serializeQueryString($scope.search);
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/pagamento/filtro?${srch}`);
            $scope.pagamentos = result.data.data;
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
);