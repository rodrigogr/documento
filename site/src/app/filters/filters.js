'use strict';
angular.module('appFilters', [])
	.filter('formatTelephone', function () {
		return function (input) {
			var str = input + '';
			str = str.replace(/\D/g, '');
			if (str.length === 11) {
				str = str.replace(/^(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
			} else {
				str = str.replace(/^(\d{2})(\d{4})(\d{4})/, '($1) $2-$3');
			}
			return str;
		};
	})
	.filter('formatOtherDate', function () {
		return function (formatIn, dateTime) {
			if (!dateTime) {
				return '';
			}
			var day = '';
			var month = '';
			var year = '';
			var arrayDate = [];
			if (formatIn === 'yyyy-mm-dd') {
				arrayDate = dateTime.split('-');
				day = arrayDate[2];
				month = arrayDate[1];
				year = arrayDate[0]
				return new Date(month + '-' + day + '-' + year).toLocaleDateString('pt-BR');
			} else {
				arrayDate = dateTime.split('/');
				day = arrayDate[0];
				month = arrayDate[1];
				year = arrayDate[2]
				return year + '-' + month + '-' + day;
			}
		};
	})
	.filter('formataData', function () {
		return function (val) {
			return new Date(val+' 00:00:00').toLocaleDateString('pt-BR')
		}
	})
	.filter('formatQuadraLote', function () {
		return function (object) {
			return 'Qd. ' + object.quadra + ' Lt. ' + object.lote;
		};
	})
	.filter('formatTelephone', function () {
		return function (input) {
			var str = input + '';
			str = str.replace(/\D/g, '');
			if (str.length === 11) {
				str = str.replace(/^(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
			} else {
				str = str.replace(/^(\d{2})(\d{4})(\d{4})/, '($1) $2-$3');
			}
			return str;
		};
	});