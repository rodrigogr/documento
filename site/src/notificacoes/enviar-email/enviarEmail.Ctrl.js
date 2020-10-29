'use strict'
angular.module('NotificacoesModules').controller('EnvioEmailCtrl',
	function ($scope, UtilsService, EnvioEmailService, HeaderFactory) {

        HeaderFactory.setHeader('notificações', 'envio de e-mails');
		$scope.data = {
			assunto: '',
			mensagem: '',
			anexos: [],
			totalanexo: [],
			tamanhoanexo: 0
		};
		$scope.local = {
			total_arquivos: [],
			max_upload: 26214400
		};

		$scope.tinymceOptions = {
			skin_url: '/css/lib',
			lang: 'pt_BR',
			menubar: false,
			statusbar: false,
			height: 300,
			plugins: [
				"advlist link imagetools lists hr print preview code fullscreen",
				"table contextmenu emoticons textcolor"
			],
			toolbar: "undo redo | styleselect hr table | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | forecolor backcolor emoticons | link | print preview fullscreen code",
			fullpage_default_fontsize: "14px",
			filemanager_title: "Gerenciador de arquivos",
			external_filemanager_path: "/filemanager/",
			external_plugins: {
				"filemanager": "/filemanager/plugin.min.js"
			}
		};

		$scope.cancelarOEnvioEmail = function () {
			$('#loadingEnviaEmail').modal('hide');
			return false;
		};
		$scope.goToEnvioEmails = function () {
			if ($scope.data.tamanhoanexo > $scope.local.max_upload) {
				return UtilsService.openAlert('Tamanho máximo de anexos permitido é de: 25MB');
			}
			if ($scope.data.assunto != '' && $scope.data.mensagem != '') {
				$('#loadingEnviaEmail').modal('show');
				EnvioEmailService.postEnviaEmail($scope.data).then(function () {
					$scope.data.assunto = '';
					$scope.data.mensagem = "";
					$scope.data.anexos = [];
					$scope.data.files = [];
					$scope.data.tamanhoanexo = '';
					$scope.data.totalanexo = [];
					$scope.local.total_arquivos = [];
					$scope.local.total_files = '';
					$('#tamanho').html('');

					$scope.cancelarOEnvioEmail();
					$('#valida-send-mail').fadeOut();
					$('#sucess-send-mail').fadeIn();

				}).catch(function (error) {
					UtilsService.openAlert(error.responseJSON.message);
					$scope.cancelarOEnvioEmail();
					$('#sucess-send-mail').fadeOut();
					$('#valida-send-mail').fadeOut();
				});
			} else {

				$('#sucess-send-mail').fadeOut();
				$('#valida-send-mail').fadeIn();
			}
		};

		$scope.addFile = function () {
			if ($scope.data.tamanhoanexo > $scope.local.max_upload) return UtilsService.openAlert('Tamanho máximo de anexos permitido foi atingido: 25MB');
			$scope.data.anexos.push({});
		};
		$scope.changeInputField = function (ele) {
			var index = angular.element(ele).scope().$index;
			var files = ele.files;
			var l = files.length;
			var total_size = 0;
			var tamanhototal = 0;
			var totalfiles = 0;

			for (var i = 0; i < l; i++) {
				total_size += files[i].size;
				if ($scope.data.tamanhoanexo > $scope.local.max_upload) {
					return UtilsService.openAlert('Tamanho máximo de anexos permitido foi atingido: 25MB');
				}
				$scope.data.anexos[index][i] = {
					nome: files[i].name,
					tipo: files[i].type,
					size: files[i].size,
					url: URL.createObjectURL(files[i])
				};
				$scope.getbase64(files[i], index, i);
			}
			$scope.data.totalanexo[index] = total_size;
			angular.forEach($scope.data.totalanexo, function (value, key) {
				tamanhototal += value;
			});
			$scope.data.tamanhoanexo = tamanhototal;

			$scope.local.total_arquivos[index] = i;
			angular.forEach($scope.local.total_arquivos, function (value, key) {
				totalfiles += value;
			});
			$scope.local.total_files = totalfiles;

			let toMB = ($scope.data.tamanhoanexo / 1048576).toFixed(2);
			$("#tamanho").html('arquivos adicionados: ' + $scope.local.total_files + ' tamanho total: ' + toMB + 'MB');
		};

		$scope.removeAnexo = function (index) {
			var num_arquivos = 0;
			var tamanho = 0;
			angular.forEach($scope.data.anexos[index], function (item, key) {
				if (!isNaN(key)) {
					tamanho += item.size;
					num_arquivos++;
				}
			});
			$scope.data.anexos.splice(index, 1);
			$scope.data.totalanexo.splice(index, 1);
			$scope.local.total_arquivos.splice(index, 1);
			$scope.data.tamanhoanexo = $scope.data.tamanhoanexo - tamanho;
			toMB = ($scope.data.tamanhoanexo / 1048576).toFixed(2);
			$scope.local.total_files = $scope.local.total_files - num_arquivos;
			if ($scope.local.total_files == 0) {
				$("#tamanho").html('');
			} else {
				$("#tamanho").html('arquivos adicionados: ' + $scope.local.total_files + ' tamanho total: ' + toMB + 'MB');
			}
		};

		$scope.getbase64 = function (file, index, i) {
			let f = file;
			let r = new FileReader();

			r.onloadend = function (e) {
				$scope.data.anexos[index][i]["base64"] = e.target.result;
				$scope.$apply();
			};
			r.readAsDataURL(f);
		}
	}
)