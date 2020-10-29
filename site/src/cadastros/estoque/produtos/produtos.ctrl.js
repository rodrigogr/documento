'use strict'
angular.module('CadastrosModule').controller('ProdutoCtrl',
    function ($scope, ProdutoService, GrupoProdutoService, UnidadeProdutoService, RuaService,
              AreaService, ColunaService, NivelService, SequenciaService, UtilsService, $http, config, HeaderFactory, AuthService, $state) {

        HeaderFactory.setHeader('Cadastros', 'Produtos');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.ngOnInit = async () => {
            try {
                $('.loader').show();
                await $scope.updateList($scope.current_page);
                await Promise.all(basicData);
            } catch (e) {
                console.error(e);
            } finally {
                $('.loader').hide()
            }
        };

        let basicData = [
            GrupoProdutoService.getAllGrupoProduto()
                .then(result => $scope.grupos = result.data.filter(x => x.status === 1)),
            UnidadeProdutoService.getAllUnidadeProduto()
                .then(result => $scope.unidades = result.data),
            RuaService.getAllRuas()
                .then(result => $scope.ruas = result.data),
            AreaService.getAllAreas()
                .then(result => $scope.areas = result.data),
            ColunaService.getAllColunas()
                .then(result => $scope.colunas = result.data),
            NivelService.getAllNivels()
                .then(result => $scope.niveis = result.data),
            SequenciaService.getAllSequencias()
                .then(result => $scope.sequencias = result.data),
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data)
        ];

        $scope.origens = [{
            id: '0XX – NACIONAL',
            descricao: 'Nacional'
        },
            {
                id: '1XX – ESTRANGEIRA IMPORTAÇÃO DIRETA',
                descricao: 'Estrangeira importação Direta'
            },
            {
                id: '2XX – ESTRANGEIRA ADQUIRIDA NO MERCADO INTERNO',
                descricao: 'Estrangeira adquirida no Mercado Interno'
            }
        ]
        $scope.status = [{
                id: 0,
                descricao: 'Inativo'
            },
            {
                id: 1,
                descricao: 'Ativo'
            }
        ];
        $scope.tipo = [{
                id: '0',
                descricao: 'Consumo'
            },
            {
                id: '1',
                descricao: 'Patrimônio'
            }
        ];

        $scope.pesquisar = function (text) {
            let _filter = x => x.produto.referencia.toLowerCase().indexOf(text.toLowerCase()) > -1;
            if (!text || !text.length) $scope.produtos = $scope.produtosCopy;
            else $scope.produtos = $scope.produtosCopy.filter(_filter);
        }

        $scope.closeModal = () => $('#novoProduto').modal('hide');

        $scope.closeModalError = () => $('#errorProduto').modal('hide');

        $scope.closeDeleteModal = () => $('#deleteAlert').modal('hide');

        $scope.createProduto = function () {
            $scope.produtoSelecionado = {
                tipo: '0',
                status: '1',
                origem: '0XX – NACIONAL',
                quantidade_minima: 1,
                quantidade_maxima: 1
            };
            for (let i = 0; i < 5; i++) $scope[`img${i}`] = null;
            $('#novoProduto').modal('show');
        };

        // $scope.updateProdutos = async() => {
        // 	$scope.produtos = null;
        // 	let result = await ProdutoService.getAllProduto();
        // 	$scope.produtos = vmProdutos(result.data);
        // 	$scope.produtosCopy = vmProdutos(result.data);
        // 	$scope.$digest();
        // }

        let vmProdutos = (data) => {
            if (data && data.length) {
                data.forEach(x => {
                    x.created_at = UtilsService.toDate(x.created_at)
                });
            }
            return data;
        };

        $scope.closeModalError = () => $('#errorProduto').modal('hide');

        $scope.editProduto = async (id) => {
            try {
                $('.loader').show();
                let produto = (await $http.get(`${config.apiUrl}api/produtos/${id}`)).data.data;
                for (let i = 0; i < 5; i++) $scope[`img${i}`] = null;
                $scope.produtoSelecionado = produto;
                $('#novoProduto').modal('show');
                let imgs = produto.imagens;
                for (let i = 0; i < imgs.length; i++) {
                    $scope[`img${i}`] = {load: true};
                    $http.get(`${config.apiUrl}api/produtos/getImage64/${imgs[i]}`)
                        .then(result => $scope[`img${i}`] = result.data)
                }
                $scope.$digest();
            } catch (e) {
                UtilsService.toastError(e.responseJSON.message);
            } finally {
                $('.loader').hide();
            }
        };

        $scope.showDeleteAlert = function (produto) {
            $scope.deleteProdutoItem = produto;
            $('#deleteAlert').modal('show');
            event.stopPropagation();
        };

        $scope.deleteProduto = function () {
            if (!$scope.accessPagina.excluir) {
                UtilsService.toastError('Você não tem permissão para excluir!');
                return false;
            }
            ProdutoService.deleteProdutos($scope.deleteProdutoItem).then(function (data) {
                if (!data.errors) {
                    $scope.updateList($scope.current_page);
                    $scope.closeDeleteModal();
                } else {
                    console.log(data);
                    $scope.errors = data.data;
                    $('#errorProduto').modal('show');
                }
            });
        };

        $scope.submit = async (produtoSelecionado) => {
            try {
                let prod;
                produtoSelecionado.quantidade_atual = (!produtoSelecionado.quantidade_atual ? 0 : produtoSelecionado.quantidade_atual);
                produtoSelecionado.quantidade_minima = (!produtoSelecionado.quantidade_minima ? 0 : produtoSelecionado.quantidade_minima);
                produtoSelecionado.quantidade_maxima = (!produtoSelecionado.quantidade_maxima ? 1 : produtoSelecionado.quantidade_maxima);

                if (produtoSelecionado.id) {
                    if (!$scope.accessPagina.editar) {
                        throw 'Você não tem permissão para editar!';
                        return false;
                    }
                    prod = await ProdutoService.editProdutos(produtoSelecionado);
                } else {
                    if (!$scope.accessPagina.inserir) {
                        throw 'Você não tem permissão para cadastrar!';
                        return false;
                    }
                    prod = await ProdutoService.saveProdutos(produtoSelecionado);
                }
                if (prod.errors) {
                    let err;

                    if (prod.data.idgrupo_produto) {
                        err = JSON.stringify(prod.data.idgrupo_produto[0]);
                    } else if (prod.data.origem) {
                        err = JSON.stringify(prod.data.origem[0]);
                    } else if (prod.data.idunidade_produto) {
                        err = JSON.stringify(prod.data.idunidade_produto[0]);
                    } else if (prod.data.descricao) {
                        err = JSON.stringify(prod.data.descricao[0]);
                    }
                    throw err;
                }

                if (!prod.errors) {
                    for (let i = 0; i < 5; i++) {
                        if (!$scope[`img${i}`] || !$scope[`img${i}`].edit) continue;
                        $scope[`img${i}`].idprodutos = prod.id;
                        $http.post(`${config.apiUrl}api/produtos/saveImage`, $scope[`img${i}`]);
                    }
                    $scope.updateList($scope.current_page);
                    $('#novoProduto').modal('hide');
                } else {
                    $('#novoProduto').modal('hide');
                    throw prod.data;
                }
            } catch (e) {
                UtilsService.toastError(e);
            }
        };

        $scope.selectFile = (id) => {
            $(`#${id}`).val('');
            $(`#${id}`).click();
        };

        $scope.deleteFile = async (id) => {
            await UtilsService.confirmAlert('Confirmação', 'Excluir imagem?');
            if ($scope[id].id)
                await $http.delete(`${config.apiUrl}api/produtos/deleteImage/${$scope[id].id}`);
            $scope[id] = null;
            $scope.$digest();
        };

        $scope.getImage = async (input) => {
            if (!$scope[input.id]) $scope[input.id] = {};
            var reader = new FileReader();
            reader.onload = async (e) => {
                $scope[input.id].imagem = e.target.result;
                $scope[input.id].edit = true;
                $scope.$digest();
            }
            reader.readAsDataURL(input.files[0]);
        }

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/produtos?page=${page}`);
            $scope.produtos = vmProdutos(result.data.data);
            $scope.produtosCopy = vmProdutos(result.data.data);
            // $scope.Itens = result.data.data;
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