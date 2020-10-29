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
            'cod': 'contasReceber',
            'nome': 'Receitas',
            'icon': 'fa-plus-circle'
            },
            'submenus': [{
                'cod': 'RecbLancAvul',
                'nome': 'Cobranças avulsas'
                },{
                'cod': 'RecbPreLanc',
                'nome': 'Pré-lançamentos'
                },{
                'cod': 'RecbLancReco',
                'nome': 'Lançamentos recorrentes'
                },{
                'cod': 'RecbSimuCalcReceita',
                'nome': 'Simulação e cálculo'
                },{
                'cod': 'RecbManual',
                'nome': 'Recebimento manual'
                },{
                'cod': 'RecbAuto',
                'nome': 'Recebimento automático'
                },{
                'cod': 'RecbConsArqRet',
                'nome': 'Consulta de arquivo retorno'
                }
            ]
        },{
        'menu_principal': {
            'cod': 'contasPagar',
            'nome': 'Despesas',
            'icon': 'fa-minus-circle'
            },
            'submenus':[{
                'cod': 'CPEstimados',
                'nome': 'Previsão orçamentária'
                },{
                'cod': 'CPLancamentos',
                'nome': 'Contas a pagar'
                },{
                'cod': 'CPPagamentos',
                'nome': 'Pagamentos'
                }
            ]
        },{
        'menu_principal': {
            'cod': 'BancoCaixa',
            'nome': 'Banco/Caixa',
            'icon': 'fa-money'
            },
            'submenus':[{
                'cod': 'BncCxFluxo',
                'nome': 'Fluxo de caixa'
                },{
                'cod': 'BncCxContas',
                'nome': 'Contas'
                }
            ]
        },{
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
                    'cod': 'relContasReceber',
                    'nome': 'Receitas',
                    'submenu': [{
                        'cod': 'RelTitProv',
                        'nome': 'Títulos provisionados'
                    },{
                        'cod': 'RelTitReceb',
                        'nome': 'Títulos recebidos'
                    }
                    ]
                }
            },
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
            },
            {
                'submenu_principal': {
                    'cod': 'RelInadimplencia',
                    'nome': 'Inadimplência',
                    'submenu': [
                        {
                            'cod': 'RelInadAcord',
                            'nome': 'Acordo'
                        },{
                            'cod': 'RelInad',
                            'nome': 'Inadimplentes'
                        },{
                            'cod': 'RelInadAnal',
                            'nome': 'Analítico'
                        }
                    ]
                }
            },
            {
                'cod': 'RelPrevReal',
                'nome': 'Previsto/Realizado'
            }
        ]
        },{
            'menu_principal': {
                'cod': 'inadimplencia',
                'nome': 'Inadimplentes',
                'icon': 'fa-exclamation-circle'
            },
            'submenus':[{
                'cod': 'InadClassi',
                'nome': 'Classificar'
                },{
                    'submenu_principal': {
                        'cod': 'acordo',
                        'nome': 'Acordo',
                        'submenu': [{
                            'cod': 'InadSimuNego',
                            'nome': 'Simular'
                        }, {
                            'cod': 'InadAcordEfet',
                            'nome': 'Efetuados'
                        }]
                    }
                },{
                    'submenu_principal': {
                        'cod': 'modelos',
                        'nome': 'Modelos',
                        'submenu': [{
                            'cod': 'InadModeCartaCobr',
                            'nome': 'Cobrança'
                        }, {
                            'cod': 'InadModeCartaQuit',
                            'nome': 'Quitação'
                        }]
                    }
                },{
                    'submenu_principal': {
                        'cod': 'enviosInadimplencia',
                        'nome': 'Envios',
                        'submenu': [{
                            'cod': 'InadEnvCartCobr',
                            'nome': 'Cobrança'
                        }, {
                            'cod': 'InadEnvCartaQuit',
                            'nome': 'Quitação'
                        }]
                    }
                }
            ]
        }, {
            'menu_principal': {
                'cod': 'compras',
                'nome': 'Compras',
                'icon': 'fa-shopping-cart'
            },
            'submenus': [{
                'cod': 'ComprasSolicitacoes',
                'nome': 'Solicitações'
                },{
                'cod': 'ComprasPainel',
                'nome': 'Painel de Aprovação'
                },{
                'cod': 'ComprasPedidos',
                'nome': 'Pedidos'
                },{
                'cod': 'ComprasAprovador',
                'nome': 'Permissões'
                },{
                'cod': 'ComprasPedido',
                'nome': 'Pedidos'
            }]
        },{
            'menu_principal': {
                'cod': 'patrimonio',
                'nome': 'Patrimônio',
                'icon': 'fa-bank'
            },
            'submenus': [{
                'cod': 'PatrimonioBens',
                'nome': 'Bens patrimoniais'
                }, {
                'cod': 'PatrimonioManutencao',
                'nome': 'Manutenção'
                }, {
                'cod': 'PatrimonioBaixa',
                'nome': 'Baixa'
                },{
                'cod': 'PatrimonioApolice',
                'nome': 'Apólices'
            }]
        },{
            'menu_principal': {
                'cod': 'estoque',
                'nome': 'Estoque',
                'icon': 'fa-cubes'
            },
            'submenus': [{
                'cod': 'estoqueEstoque',
                'nome': 'Estoque atual'
                },{
                'cod': 'estoqueMovimentacoes',
                'nome': 'Movimentações'
            }]
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
        },{
            'menu_principal': {
                'cod': 'integracoes',
                'nome': 'Integrações',
                'icon': 'fa-clipboard'
            },
            'submenus': [{
                'cod': 'arquivoContabil',
                'nome': 'Arquivo Contábil'
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
        if (arrAccess.indexOf('CPEstimados') > -1) {
            $scope.acessoRapido.push('CPEstimados');
        }
        if (arrAccess.indexOf('RecbSimuCalcReceita') > -1) {
            $scope.acessoRapido.push('RecbSimuCalcReceita');
        }
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