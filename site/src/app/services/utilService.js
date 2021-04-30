'use strict'
angular.module('appServices').service('UtilsService',
    function (toastr, toastrConfig, $state) {
        toastrConfig.positionClass = 'toast-top-center';
        toastrConfig.allowHtml = true;
        toastrConfig.progressBar = true;

        this.openAlert = (msg) => swal('Ops!', msg || '', 'warning');

        this.openErrorMsg = (msg) => swal('Erro', msg || 'erro', 'error');

        this.openAlertError = (msg) =>
            swal({
                html: true,
                title: 'Erro!',
                text: msg,
                type: 'error'
            });

        this.openAlertAtencao = (msg) =>
            swal({
                html: true,
                title: 'Atenção!',
                text: msg,
                type: 'warning'
            });

        this.openSuccessAlert = (msg) => swal('Sucesso!', msg || '', 'success');

        this.confirmAlert = function (title, text, buttonCancel, buttonSuccess) {
            return new Promise(resolve => {
                swal({
                    html: true,
                    title: title,
                    text: text,
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: buttonSuccess,
                    cancelButtonText: buttonCancel,
                    closeOnConfirm: true,
                    closeOnCancel: true
                }, (isConfirm) => {
                    resolve(isConfirm);
                });
            })
        };

        this.confirmAlert2 = function (title, text, buttonCancel, buttonSuccess, closeOnConfirm, closeOnCancel, callback) {
            swal({
                html: true,
                title: title,
                text: text,
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: buttonSuccess,
                cancelButtonText: buttonCancel,
                closeOnConfirm: closeOnConfirm,
                closeOnCancel: closeOnCancel
            }, function (isConfirm) {
                callback(isConfirm)
            });
        };

        this.confirmAlert3 = function (title, text, buttonCancel, buttonSuccess, closeOnConfirm, closeOnCancel) {
            return new Promise(resolve => {
                swal({
                    html: true,
                    title: title,
                    text: text,
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: buttonSuccess,
                    cancelButtonText: buttonCancel,
                    closeOnConfirm: closeOnConfirm,
                    closeOnCancel: closeOnCancel
                }, function (isConfirm) {
                    resolve(isConfirm);
                })
            });
        };

        this.deleteMotivo = function (title, text) {
            return new Promise(resolve => {
                swal({
                    title: title,
                    text: text,
                    type: "input",
                    inputType: "text",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: 'Deletar',
                    cancelButtonText: 'Cancelar',
                    closeOnConfirm: false,
                    closeOnCancel: true
                }, function (texto) {
                    if (texto === ''){
                        alert('Digite o motivo')
                    } else {
                        resolve(texto);
                        swal.close();
                    }
                })
            })
        };

        this.toDate = (x) => {
            if (!x) return;
            else if (x instanceof Date) return x;
            else if (x.includes('/')) {
                let dateParts = x.split("/");
                return new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);
            } else return new Date(x);
        };

        this.getTimeData = (data) => {
            let d = data.getDate();
            let m = (data.getMonth()+1);
            let a = data.getFullYear();
            let newdata = new Date(a+'-'+m+'-'+d);
            return newdata.getTime();
        };

        this.serializeQueryString = (obj) => {
            if (!obj) return '';
            let str = [];
            for (let p in obj) {
                if (obj.hasOwnProperty(p)) {
                    if (obj[p] instanceof Date) str.push(p + "=" + obj[p].toISOString());
                    else str.push(p + "=" + obj[p]);
                }
            }
            return str.join("&");
        };

        this.utcToDate = (d) => {
            if (!d) return;
            d = this.toDate(d);d
            return d.toLocaleDateString();
        };

        this.toastSuccess = (msg) => toastr.success(msg, 'Feito!');

        this.toastInfo = (msg) => toastr.warning(msg);

        this.toastError = (msg) => toastr.error(msg, 'Atenção!');

        this.toastSessaoExpirada = (msg) => toastr.error(msg, 'Atenção!', {
            onHidden: function () {
                $state.go('login');
            }
        });

        this.closeAllModal = () => {
            let modals = Array.from($('.modal.ng-scope.in'));
            modals.forEach(x => $(x).modal('hide'));
        }
    }
);