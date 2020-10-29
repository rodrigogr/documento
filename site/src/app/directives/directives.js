angular.module('appDirectives', [])
	.directive("headerBio", function () {
		return {
			restrict: 'A',
			// replace: true,
			transclude: true,
			scope: {
				title: '@'
			},
			templateUrl: '../tmpl/headerBio/view.html'
			// controller: ['$scope', '$state', function ($scope, $state) {
			// 	$scope.directiveHeaderData = {
			// 		user: 'Administrador'
			// 	}
			// }]
		}
	}).directive("fileread", [function () {
		return {
			scope: {
				fileread: "="
			},
			link: function (scope, element, attributes) {
				element.bind("change", function (changeEvent) {
					var reader = new FileReader();
					reader.onload = function (loadEvent) {
						scope.$apply(function () {
							scope.fileread = loadEvent.target.result;
						});
					};
					reader.readAsDataURL(changeEvent.target.files[0]);
				});
			}
		}
	}]);