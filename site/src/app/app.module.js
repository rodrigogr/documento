'use strict'
angular.module('AppModule', [
        'ContasPagarModule',
        'ReservasModule',
        'AssembleiasModule',
        'DocumentosModule',
        'ui.router',
        'appServices',
        'appDirectives',
        'appFilters',
        'ngAria',
        'ui.utils.masks',
        'ngAnimate',
        'toastr',
        'ngMask',
        'oitozero.ngSweetAlert',
        'ui.tinymce',
        'ui.bootstrap',
        'chart.js'
    ])
    .factory('AuthInterceptor', AuthInterceptor)
    .config(function ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider) {
        $locationProvider.hashPrefix('');
        // $locationProvider.html5Mode(true);
        $httpProvider.interceptors.push('AuthInterceptor');
        $stateProvider
            .state('index', {
                url: '/',
                templateUrl: 'src/app/home/home.ctrl.html',
                controller: 'IndexCtrl'
            })
            .state('login', {
                url: '/login',
                templateUrl: 'src/app/login/login.ctrl.html',
                controller: 'LoginCtrl'
            })
            .state('403', {
                url: '/403',
                templateUrl: 'src/app/erros/403.html',
                controller: 'LoginCtrl'
            })
            .state('getLogin', {
                url:'/getLogin/',
                templateUrl: 'src/app/login/getLogin.ctrl.html',
                controller: 'LoginCtrl'
            });
        $urlRouterProvider.otherwise('/');

    })
    .factory('HeaderFactory', function() {
        function setHeader(modulo, tela) {
            sessionStorage.setItem("modulo",modulo);
            sessionStorage.setItem("tela",tela);
        }
        // Funções públicas
        return {
            setHeader: setHeader
        };
    })
    .run(function ($rootScope, $location, AuthService, $http, config, $state, UtilsService, $timeout) {

        $rootScope.$on('$locationChangeStart', function (event, next, current) {
            if ($location.$$search.uid_bioacesso) { // controle de acesso via system
                $http.get(config.apiUrl + 'api/auth/getLogin/'+$location.$$search.uid_bioacesso).then( function(res) {
                    if (res.data.data.usr.id) {
                        $timeout(() => {
                            $('.boas-vindas-text p').html('Bem vindo ao Bioacesso Sistema Comunicação<br>Aguarde...');
                        }, 2000);
                        localStorage.setItem('bioacs-crtk', res.data.data.token);
                        localStorage.setItem('bioacs-uid', JSON.stringify(res.data.data.usr));
                        $timeout(() => {$state.go('index')}, 2000);
                    }
                }).catch( function (e) {
                    $('.boas-vindas-text p').html(e.data.message);
                });
                return false;
            } else if (!AuthService.getToken()) {
                $location.url('/login');
                return false;
            } else {
                $http.get(config.apiUrl + 'api/auth/checkAuth').then( function(res) {
                    if ((res.data.code === 400 || res.data.code === 429 || res.data.code === 401) && $location.$$url !== '/login') {
                        UtilsService.toastSessaoExpirada(res.data.error+'<br> Fazer login novamente, aguarde...');
                        return false;
                    }
                    let permissoes = res.data.data.permissoes;
                    let modulo_corrente = $state.$current.name;

                    if (modulo_corrente !== 'login' && modulo_corrente !== 'index') {
                        if (permissoes.indexOf(modulo_corrente) < 0) $state.go('403');
                    }
                });
            }
        });

    });

    function AuthInterceptor ($location, AuthService) {

        return {
            request: function(config) {
                $.ajaxSetup({
                    cache:false,
                    headers: {
                        'Authorization': 'Bearer '+ AuthService.getToken()
                    }
                });
                config.headers = config.headers || {};

                if (AuthService.getToken()) {
                    config.headers['Authorization'] = 'Bearer ' + AuthService.getToken();
                }

                return config;
            }
        }
    }