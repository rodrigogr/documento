'use strict'
angular.module('InadimplanciaModule')
    .controller('envioCartasCobrancaCtrl',
        function ($scope, $http, $filter, config, $stateParams, UtilsService, BioacessoService, InadimplenciaService, HeaderFactory, AuthService, $state) {

            HeaderFactory.setHeader('inadimplência', 'envio / cobrança');
            $scope.InadimplenciaService = InadimplenciaService;
            $scope.isCobranca = $stateParams.isCobranca;
            // VARIABLES
            $scope.titulosList;
            $scope.modelosCarta;
            $scope.modeloSelect;
            let user = JSON.parse(localStorage.getItem("bioacs-uid"));

            $scope.ngOnInit = () => {
                InadimplenciaService.getModelosCarta($stateParams.isCobranca)
                    .then(result => $scope.modelosCarta = result);
                AuthService.aclPaginaService($state.$current.name, user.id)
                    .then(result => $scope.accessPagina = result.data);
            };

            $scope.pesquisar = (search) => {
                if (!search || !search.quadra || !search.lote) {
                    UtilsService.openAlert('Informe a Quadra e Lote');
                    return;
                }
                InadimplenciaService.getImovelInfoByQeL(search.quadra, search.lote)
                    .then(() => {
                        this.getIndividuo(InadimplenciaService.imovelInfo.id)
                            .then(result => {
                                $scope.titulosList = result;
                                $scope.$digest();
                            })
                        // .catch(() => UtilsService.openAlert('error'));
                    })
                // .catch(() => UtilsService.openAlert('error'));
            }

            this.getIndividuo = (idImovel) => {
                return new Promise((resolve, reject) => {
                    let data = {
                        "mes": "",
                        "ano": "",
                        "data_ini": "",
                        "data_fim": "",
                        "id_empresa": "",
                        "id_imovel": idImovel
                    }
                    $http.post(`${config.apiUrl}api/inadimplencia/carta_emissao_filtro`, data)
                        .then(result => resolve(result.data.data))
                    // .catch(() => reject())
                });
            }

            $scope.btnEnviar = (idModelo) => {
                if (!$scope.accessPagina.inserir) {
                    UtilsService.toastError('Você não tem permissão para enviar cobrança!');
                    return false;
                }
                let titulosSelec = $scope.titulosList.filter(x => x.select);
                if (!idModelo) {
                    UtilsService.openAlert('selecione um modelo de carta');
                    return;
                } else if (titulosSelec.length === 0) {
                    UtilsService.openAlert('selecione um titulo');
                    return;
                }
                let data = {
                    id_modelo: idModelo,
                    selecionados: []
                };
                titulosSelec.forEach(x => {
                    data.selecionados.push({
                        "id_boleto": x.id_boleto,
                        "nome": x.nome_cli,
                        "endereco": x.endereco,
                        "logradouro": x.logradouro,
                        "vencimento": x.data_vencimento,
                        "valor": x.valor,
                        "email": x.email,
                        "id_empresa": x.id_empresa | "",
                        "id_imovel": x.idimovel
                    });
                });
                $("#loading").modal("show");
                let url = `${config.apiUrl}api/inadimplencia/carta_cobranca_enviar`;
                $http.post(url, data)
                    .then(result => UtilsService.openSuccessAlert(result.data.data))
                    .catch((e) => UtilsService.openAlertAtencao(e.data.message))
                    .finally(() => $("#loading").modal("hide"));
            };

            $scope.visualizar = (titulo) => {
                if (!$scope.modeloSelect) {
                    UtilsService.openAlert('selecione um modelo');
                    return;
                }
                let data = {
                    "nome": titulo.nome_cli,
                    "vencimento": titulo.data_vencimento,
                    "endereco": titulo.endereco,
                    "logradouro": titulo.logradouro,
                    "id_modelo": $scope.modeloSelect.id,
                    "valor": titulo.valor
                };
                let url = `${config.apiUrl}api/inadimplencia/carta_visualizar`;
                let options = {
                    responseType: "arraybuffer"
                };
                $http.post(url, data, options)
                    .then(result => {
                        let blob = new Blob([result.data], {
                            type: 'application/pdf'
                        });
                        let pdfLink = (window.URL || window.webkitURL).createObjectURL(blob);
                        var newWin = window.open(pdfLink);
                        if (!newWin || newWin.closed || typeof newWin.closed == 'undefined')
                            UtilsService.openErrorMsg('Popup bloqueada')
                    })
                    .catch(() => UtilsService.openAlert('error'));
            };

            $scope.modeloChange = (modelo) => $scope.modeloSelect = modelo;
        }
    );