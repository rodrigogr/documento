'use strict'
angular.module('CadastrosModule').controller('InformativoCtrl',
    function ($scope, config, $http, UtilsService, HeaderFactory, $state, AuthService) {

        HeaderFactory.setHeader('Cadastros', 'informativo');
        let user = JSON.parse(localStorage.getItem("bioacs-uid"));
        $scope.$ = $;
        let getInformativos = () => $http.get(`${config.apiUrl}api/informativo`);
        let deleteInformativo = (id) => $http.delete(`${config.apiUrl}api/informativo/${id}`);
        let postInformativo = (data) => $http.post(`${config.apiUrl}api/informativo`, data);
        let putInformativo = (data) => $http.patch(`${config.apiUrl}api/informativo/${data.id}`, data);

        $scope.validBtn = (info) => {
            if (!info || !info.conteudo || !info.datafinal || !info.datainicial) return false;
            else return true;
        };

        $scope.ngOnInit = () => {
            $scope.updateList($scope.current_page);
            AuthService.aclPaginaService($state.$current.name, user.id)
                .then(result => $scope.accessPagina = result.data);
        };

        $scope.save = async (informativo) => {
            try {
                if (informativo.tipo === 'Mensagem') {
                    informativo.image = '';
                } else {
                    let type = informativo.image.split(';')[0].split('/')[1];
                    let img_permitidas = ['jpeg','jpg','gif','png'];
                    if (img_permitidas.indexOf(type) < 0) {
                        UtilsService.toastError('Os tipos permitidos de imagens são: "JPEG,JPG,PNG ou GIF"');
                        return false;
                    }
                }
                if (!informativo.id) {
                    if (!$scope.accessPagina.inserir) {
                        throw 'Você não tem permissão para cadastrar este informativo!';
                    }
                    await postInformativo(informativo);
                } else {
                    if (!$scope.accessPagina.editar) {
                        throw 'Você não tem permissão para editar este informativo!';
                    }
                    await putInformativo(informativo);
                }
                $('#novoInformativo').modal('hide');
                UtilsService.toastSuccess(`Informativo ${informativo.id ? 'alterado' : 'adicionado'}`);
                $scope.ngOnInit();
            } catch (e) {
                UtilsService.toastError(e);
            }
        };

        $scope.edit = (x) => {
            let obj = JSON.parse(JSON.stringify(x));
            obj.datainicial = new Date(obj.datainicial);
            obj.datafinal = new Date(obj.datafinal);
            $scope.informativo = obj;
            $http.get(`${config.apiUrl}api/informativo/${x.id}/image64`)
                .then(result => $scope.informativo.image = result.data);
        };

        $scope.delete = async (id) => {
            try {
                if (!$scope.accessPagina.excluir) {
                    throw 'Você não tem permissão para excluir este informativo!';
                }
                await UtilsService.confirmAlert('Excluir registro?');
                await deleteInformativo(id);
                UtilsService.toastSuccess('Informativo removido.');
                $scope.ngOnInit();
            } catch (e) {
                UtilsService.openErrorMsg();
            }
        };

        $scope.novo = () => {
            $scope.informativo = {
                tipo: 'Mensagem',
                image: ''
            };
            $('#novoInformativo').modal('show');
        };

        $scope.changeImage = (input) => {
            let fr = new FileReader();
            new Promise(resolve => fr.onload = resolve)
                .then(() => {
                    $scope.informativo.image = fr.result;
                    $scope.$digest();
                });
            fr.readAsDataURL(input);
        };

        // $scope.linkPdf = (x) => `${config.apiUrl}api/informativo/${x.id}/visualizar`;
        $scope.linkPdf = function (x) {
            $('#loadingPdf').modal('show');
            let prom;
            prom = $http.get(`${config.apiUrl}api/informativo/${x.id}/visualizar`, {
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
            ).catch( (e) => {
                console.log(e);
            }).finally( () => {
                $('#loadingPdf').modal('hide');
            })
        };

        $scope.tinymceOptions = {
            menubar: false,
            toolbar: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent'
        };

        $scope.current_page = 1;
        $scope.updateList = async (page) => {
            if (($scope.pageCount && $scope.pageCount < page) || page <= 0) return;
            let result = await $http.get(`${config.apiUrl}api/informativo?page=${page}`);
            $scope.Itens = result.data.data;
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