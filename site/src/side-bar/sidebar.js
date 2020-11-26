/**
 * Created by rafael on 07/12/2017.
 */
'use strict'
angular.module('appDirectives').directive("sidebar", function () {
	return {
		restrict: 'A',
		replace: true,
		scope: {
			user: '='
		},
		templateUrl: 'src/side-bar/sidebar.html',
		controller: sidebarCtrl
	}
});

function sidebarCtrl($scope, LoginService) {
	var menuSis = [
	    {
	        'menu_principal': {
                'cod': 'reserva',
                'nome': 'Reservas',
                'icon': 'fa-calendar'
            },
            'submenus': [
                {
                    'cod': 'reservaLocal',
                    'nome': 'Locais Reserváveis'
                },
                {
                    'cod': 'reservaCalendario',
                    'nome': 'Calendário de Reservas'
                },
                {
                    'cod': 'reservaAprovacao',
                    'nome': 'Aprovações Pendentes'
                }
            ]
        },
        {
	        'menu_principal': {
                'cod': 'contasPagar',
                'nome': 'Despesas',
                'icon': 'fa-minus-circle'
            },
                'submenus':[{
                    'cod': 'CPLancamentos',
                    'nome': 'Contas a pagar'
                },{
                    'cod': 'CPPagamentos',
                    'nome': 'Pagamentos'
                }
                ]
        }, {
        'menu_principal': {
            'cod': 'cadastrosConfig',
            'nome': 'Cadastros',
            'icon': 'fa-gear'
            },
            'submenus':[{
                'cod': 'CadGrupLanc',
                'nome': 'Grupo de conta'
                },{
                'cod': 'CadTipoLanc',
                'nome': 'Plano de conta'
                },{
                'cod': 'CadConfigCond',
                'nome': 'Configuração condomínio'
                },{
                'cod': 'CadConfigReceit',
                'nome': 'Configuração receita'
                },{
                'cod': 'CadGrupCalc',
                'nome': 'Grupo de cálculo'
                },{
                'submenu_principal': {
                    'cod': 'CadTipoInad',
                    'nome': 'Inadimplência',
                    'submenu': [{
                        'cod': 'CadTipoInad',
                        'nome': 'Tipo'
                    },{
                        'cod': 'CadSitInad',
                        'nome': 'Situação'
                    }]
                    }
                },{
                'cod': 'CadDept',
                'nome': 'Departamento'
                },{
                'cod': 'CadInfo',
                'nome': 'Informativo'
                },{
                'submenu_principal': {
                    'cod': 'cadastrosEstoque',
                    'nome': 'Estoque',
                    'submenu': [{
                        'cod': 'ComprasCadUnidade',
                        'nome': 'Unidades'
                    },{
                        'cod': 'ComprasCadArea',
                        'nome': 'Áreas'
                    },{
                        'cod': 'ComprasCadRua',
                        'nome': 'Ruas'
                    },{
                        'cod': 'ComprasCadColuna',
                        'nome': 'Colunas'
                    },{
                        'cod': 'ComprasCadNivel',
                        'nome': 'Níveis'
                    },{
                        'cod': 'ComprasCadSequencia',
                        'nome': 'Sequências'
                    },{
                        'cod': 'ComprasCadGrupo',
                        'nome': 'Grupo produtos'
                    },{
                        'cod': 'ComprasCadProduto',
                        'nome': 'Produtos'
                    }
                    ]
                }
            }
            ]
        },{
        'menu_principal': {
            'cod': 'relatoriosFinanceiro',
            'nome': 'Relatórios',
            'icon': 'fa-file-text'
        },
        'submenus':[

            {
                'submenu_principal': {
                    'cod': 'relContasPagar',
                    'nome': 'Despesas',
                    'submenu': [
                        {
                            'cod': 'RelContSint',
                            'nome': 'Sintético'
                        },{
                            'cod': 'RelContAnal',
                            'nome': 'Analítico'
                        }
                    ]
                }
            }
        ]
        },{
            'menu_principal': {
                'cod': 'notificacoes',
                'nome': 'Notificações',
                'icon': 'fa-bell'
            },
            'submenus': [{
                'cod': 'NotfEnvEmail',
                'nome': 'Enviar E-mail'
            }]
        }
    ];
	let user = JSON.parse(localStorage.getItem("bioacs-uid"));
    LoginService.userAccess(user.id).then( function(result ) {
        $scope.objAccess = result.data;
        $scope.menuShow = [];
        $scope.acessoRapido = [];
        var arrAccess = [];
        var menuAdd = '';
        var subMenuAdd = '';
        var subMenuAdd2 = '';
        var subMenuAdd2Completo = '';

        angular.forEach($scope.objAccess, function(value){
            arrAccess.push(value.cod);
        });
        angular.forEach(menuSis, function (p) {
            if (arrAccess.indexOf(p.menu_principal.cod) > -1){
                let arrSub = [];
                angular.forEach(p.submenus, function (sub) {
                    if(arrAccess.indexOf(sub.cod) > -1){
                        subMenuAdd = {
                            'cod': sub.cod,
                            'nome': sub.nome
                        };
                        arrSub.push(subMenuAdd);
                    }
                    if(sub.submenu_principal && arrAccess.indexOf(sub.submenu_principal.cod) > -1){
                        let arrSub2 = [];
                        angular.forEach(sub.submenu_principal.submenu, function (sub2) {
                            if(arrAccess.indexOf(sub2.cod) > -1){
                                subMenuAdd2 = {
                                    'cod': sub2.cod,
                                    'nome': sub2.nome
                                };
                                arrSub2.push(subMenuAdd2);
                            }
                        });
                        subMenuAdd2Completo = {
                            'submenu_principal': {
                                'cod': sub.submenu_principal.cod,
                                'nome': sub.submenu_principal.nome,
                                'submenu':arrSub2
                            }
                        };
                        arrSub.push(subMenuAdd2Completo);
                    }
                });
                menuAdd = {
                    'menu_principal': {
                        'cod': p.menu_principal.cod,
                        'nome': p.menu_principal.nome,
                        'icon': p.menu_principal.icon
                    },
                    'submenus': arrSub
                };
                $scope.menuShow.push(menuAdd);

			}
        });
        //menu acesso rápido
        if (arrAccess.indexOf('CPLancamentos') > -1) {
            $scope.acessoRapido.push('CPLancamentos');
        }
    });

    $scope.menuAberto = sessionStorage.getItem("menu");
    $(function(){
        $("#"+$scope.menuAberto).show();
    });


	$scope.acaoMenu = (div) => {
		$(`._menu_:not(#${div})`).hide();
		$(`#${div}`).fadeToggle("fast", "linear");
		sessionStorage.setItem("menu", div);
	};


}