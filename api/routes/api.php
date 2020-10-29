<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/*Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:api');*/
Route::post('auth/login', 'AuthController@login');
Route::get('auth/checkAuth','AuthController@checkAuth');
Route::get('condominio', 'CondominioConfiguracoesController@condominio');
Route::get('receita_calculo/visualizar_boleto/{id}', 'ReceitaCalculoController@visualizarBoletos');
Route::get('receita_calculo/emitir_remessa/{id}', 'ReceitaCalculoController@emitirRemessa');
Route::get('auth/getLogin/{hash}','AuthController@getLogin');
Route::get('recebimento/manual/download_remessa/{id}', 'RecebimentoController@download_remessa');
Route::get('lancamento_avulsos/gerar_remessa/{id}', 'LancamentoAvulsoController@download_remessa');
Route::get('inadimplencia/acordos_efetuados/remessa/{id}', 'AcordoController@download_remessa');

Route::post('export_arquivo/lancamentos/layout_tron', 'ExportArquivoCsvController@exportLancamentosLayoutTron');
Route::get('lancamento_agendar/demonstrativo/{id}', 'LancamentoAgendarController@demonstrativo');

Route::get('import_database/receitasMadri/{ano_competencia}', 'MigrationDatabaseClientController@importCSVReceitasjdsMadri');
Route::get('import_database/associadosMadri/{ano_competencia}', 'MigrationDatabaseClientController@importCSVAssociadojdsMadri');
Route::get('import_database/contasPagar', 'MigrationDatabaseClientController@importCSVContasAPagarJdsMadri');
Route::get('import_database/fornecedoresMadri', 'MigrationDatabaseClientController@importCSVFornecedorHojeDiaADia');
Route::get('import_database/produtosMadri', 'MigrationDatabaseClientController@importCSVProdutosHojeDiaADia');
Route::get('import_database/grupoprodutosMadri', 'MigrationDatabaseClientController@importCSVGrupoProdutoHojeDiaADia');
Route::get('import_database/correcao/associado', 'MigrationDatabaseClientController@correcaoMigracaoReceitasAssociado');
Route::get('import_database/correcao/receitas', 'MigrationDatabaseClientController@correcaoMigracaoReceitas');

Route::group(['middleware' => 'jwt.auth'], function () {

    Route::post('aclToFrontEnd', 'AuthController@userPermissoes');
    Route::post('aclPagina', 'AuthController@permissaoByPagina');
    Route::post('boxApp','AuthController@boxHeaderAccess');
    Route::get('acessoLoginApps','AuthController@acessoExterno');

    Route::get('areas/{descricao?}', 'AreaController@index');
    Route::get('ruas/{descricao?}', 'RuaController@index');
    Route::get('colunas/{descricao?}', 'ColunaController@index');
    Route::get('niveis/{descricao?}', 'NivelController@index');
    Route::get('sequencias/{descricao?}', 'SequenciaController@index');

    /*
    |--------------------------------------------------------------------------
    | API Supplementing Resource Routes
    |--------------------------------------------------------------------------
    */
    Route::get('tipo_lancamentos/litar_por_fluxo', 'TipoLancamentoController@listarPorFluxo');
    Route::get('receita_calculo/informacao', 'ReceitaCalculoController@informacao');
    Route::get('receita_calculo/informacao/{mes}/{ano}', 'ReceitaCalculoController@informacao');
    Route::get('receita_calculo/previsao_orcamentaria', 'ReceitaCalculoController@preisaoOrcamentaria');
    Route::post('receita_calculo/simular', 'ReceitaCalculoController@simulacao');
    Route::post('receita_calculo/aprovar_simulacao', 'ReceitaCalculoController@aprovarSimulacao');

    Route::get('receita_calculo/visualizar_boleto_nao_enviado/{id}', 'ReceitaCalculoController@visualizarBoletosNaoEnviado');

    Route::get('receita_calculo/enviar_email/{id}', 'ReceitaCalculoController@enviarEmail');
    Route::get('receita_calculo/update_nosso_numero', 'ReceitaCalculoController@update_nosso_numero');

    Route::get('lancamento_avulsos/gerar_boleto/{id}', 'LancamentoAvulsoController@gerarBoleto');
    Route::get('lancamento_avulsos/enviar_email/{id}', 'LancamentoAvulsoController@enviarEmail');
    Route::get('lancamento_avulsos/antigos', 'LancamentoAvulsoController@antigos');
    Route::post('lancamento_avulsos/cancela_lancamento_avulso', 'LancamentoAvulsoController@cancelaLancamentoAvulso');
    Route::get('lancamento_avulsos/deleta_lancamento_antigo/{id}', 'LancamentoAvulsoController@deletaLancamentoAntigo');
    Route::get('lancamento_avulsos/check_edit_lancamento_antigo/{id}', 'LancamentoAvulsoController@checkLancamentoAntigo');
    Route::post('lancamento_avulsos/update_lancamento_antigo', 'LancamentoAvulsoController@updateLancamentoAntigo');
    Route::post('lancamento_avulsos/busca', 'LancamentoAvulsoController@search');
    Route::get('conta_bancarias/carteiras_disponiveis', 'ContaBancariaController@carteirasDisponiveis');
    Route::get('conta_bancarias/select', 'ContaBancariaController@select');

    Route::get('imoveis/busca_morador/{quadra}/{lote}', 'ImovelController@pesquisarMoradorPorImovel');
    Route::get('imoveis/busca_titular/{quadra}/{lote}', 'ImovelController@pesquisarTitularPorImovel');

    Route::get('lancamento_agendar/contas_vencidas', 'LancamentoAgendarController@contasVencidas');
    Route::post('pagamento/pagar', 'PagamentoController@pagar');
    Route::post('pagamento/estornar', 'PagamentoController@estornar');
    Route::get('pagamento/filtro', 'PagamentoController@filtroByDataVencimento');

    Route::post('recebimento/processar_arquivo_retorno', 'RecebimentoController@processar_arquivo');
    Route::get('recebimento/cancelar_processamento/{id}', 'RecebimentoController@cancelar_processamento');
    Route::post('recebimento/print_pendencias_simular_calcular', 'RecebimentoController@printPendenciasSC');
    Route::get('recebimento/consultar_arquivo', 'RecebimentoController@consultar_arquivo');
    Route::post('recebimento/receber_todos', 'RecebimentoController@receber_todos');
    Route::get('recebimento/titulos_processados/{id_arquivo_retorno}', 'RecebimentoController@titulos_processados');
    Route::get('recebimento/titulos_processados_status/{status}/{id_arquivo_retorno}', 'RecebimentoController@titulosProcessadosByStatus');
    Route::get('recebimento/demonstrativo_titulo/{id}', 'RecebimentoController@demonstrativo_titulo');
    Route::post('recebimento/manual', 'RecebimentoController@recebimento_manual');
    Route::get('recebimento/manual/saldo_receber/{id}', 'RecebimentoController@saldo_receber');
    Route::get('recebimento/manual/debitos/{id}', 'RecebimentoController@debitos');
    Route::get('recebimento/manual/ordem_pagamentos/{id}', 'RecebimentoController@ordem_pagamentos');
    Route::post('recebimento/manual/atualizar_boleto', 'RecebimentoController@atualizar_boleto');
    Route::post('recebimento/manual/atualizar_juros_multa', 'RecebimentoController@resultJurosMulta');
    Route::get('recebimento/manual/visualizar_boleto/{id_parcela}', 'RecebimentoController@visualizar_boleto');
// Route::get('recebimento/manual/visualizar_fatura/{id_parcela}/{mes}/{ano}','RecebimentoController@visualizarFatura');

    Route::get('recebimento/manual/enviar_email/{id}', 'RecebimentoController@enviar_email');
    Route::get('recebimento/manual/cancelar_titulo/{id}', 'RecebimentoController@cancelar_titulo');
    Route::post('recebimento/manual/receber_titulo', 'RecebimentoController@receber_titulo');
    Route::post('recebimento/manual/receber_titulo/programar_lancamento', 'RecebimentoController@programarPreLancamento');
    Route::post('recebimento/automatico/baixar_titulo', 'RecebimentoController@baixar_titulo');

    Route::get('lancamentos/update_categoria', 'RecebimentoController@update_categoria');
    Route::get('lancamentos/update_valor_origem', 'RecebimentoController@update_valor_origem');
    Route::get('lancamentos/update_data_vencimento_origem', 'RecebimentoController@update_data_vencimento_origem');

    Route::get('taxa/gerar', 'RecebimentoController@gerarBoletoMensal');

    Route::get('lancamentos_estimados/resumo', 'LancamentosEstimadosController@resumo');
    Route::get('lancamentos_estimados/pdf/{download}', 'LancamentosEstimadosController@geraPdfEstimados');

    Route::get('estimados/ultima_estimativa', 'EstimadoController@ultimaEstimativa');
    Route::get('estimados/lista_estimados', 'EstimadoController@listaEstimados');
    Route::get('estimados/lista_estimados_sem_calculo', 'EstimadoController@listaEstimadosSemCalculo');
    Route::get('estimados/{mes}/{ano}', 'EstimadoController@estimadosByData');
    Route::get('estimados/pdf/{mes}/{ano}', 'EstimadoController@geraPdfEstimadosEfetuados');

//financeiro relatórios
    Route::group(['prefix' => 'relatorios'], function () {
        Route::post('receitas/boletos', 'RelatorioController@receitaBoletos');
        Route::post('receitas/titulos_provisionados', 'RelatorioController@titulosProvisionados');
        Route::post('receitas/titulos_recebidos', 'RelatorioController@titulosRecebidos');
        Route::post('receitas/inadimplencia', 'RelatorioController@inadimplencia');
        Route::post('receitas/inadimplencia_situacao', 'RelatorioController@inadimplenciaSituacao');
        Route::post('receitas/acordos', 'RelatorioController@acordosEfetuados');
        Route::post('receitas/acordos_consolidados', 'RelatorioController@acordosEfetuadosConsolidados');
        Route::post('despesas/contas_a_pagar', 'RelatorioController@contasAPagar');
        Route::post('despesas/contas_a_pagar/sintetico', 'RelatorioController@contasAPagarSintetico');
        Route::post('despesas/previsto_realizado', 'RelatorioController@previstoRealizado');
    });

//financeiro inadimplências
    Route::group(['prefix' => 'inadimplencia'], function () {
        Route::get('situacao_tipo', 'SituacaoInadimplenciaController@situacao_tipo');
        Route::get('acordos_efetuados/filtro/{associado}', 'AcordoController@filtro');
        Route::post('acordos_efetuados/filtro', 'AcordoController@filtro');
        Route::get('acordos_efetuados/boleto/{id}', 'AcordoController@visualizar_boleto');
        Route::get('acordos_efetuados/envia_boleto/{id}', 'AcordoController@enviar_email');
        Route::post('pesquisar', 'InadimplenciaController@listaInadimplentes');
        Route::post('classificar', 'InadimplenciaController@classificar');
        Route::post('calculo_selecionados', 'NegociarInadimplenciaController@calculoSelecionados');
        Route::post('acordo', 'NegociarInadimplenciaController@negociarInadimplencia');
        Route::post('cancelar_acordo', 'AcordoController@cancelarAcordo');
        Route::post('carta_emissao_filtro', 'CartaCobrancaController@filtro_envio_carta');
        Route::post('carta_visualizar', 'CartaCobrancaController@visualizarCarta');
        Route::post('carta_cobranca_enviar', 'CartaCobrancaController@enviarCobranca');
        Route::post('registro_cobranca_filtro', 'CartaCobrancaController@filtro_registro_cobranca');
        Route::post('filtro_parceiro_quitacao', 'QuitacaoDocumentoController@filtro_emissao_declaracao');
        Route::post('declaracao_quitacao_emissao_visualizar', 'QuitacaoDocumentoController@emissao_quitacao_visualizar');
        Route::post('enviarQuitacao', 'QuitacaoDocumentoController@enviarQuitacao');
        Route::resource('acordos_efetuados', 'AcordoController');
        Route::resource('carta_cobranca', 'CartaCobrancaController');
        Route::resource('declaracao_quitacao', 'QuitacaoDocumentoController');
    });

    /*
    |--------------------------------------------------------------------------
    | API Basic Routes
    |--------------------------------------------------------------------------
    */
//Route::resource('ramo_atividades', 'RamoAtividadeController');
//Route::resource('tipo_correspondencias', 'TipoCorrespondenciaController');
    Route::resource('tipo_telefones', 'TipoTelefoneController');
    Route::resource('localidades', 'LocalidadeController');
    Route::resource('situacao_imovels', 'SituacaoImovelController');
    Route::resource('tipo_area_externas', 'TipoAreaExternaController');
    Route::resource('associados', 'AssociadoController');
    Route::resource('telefones', 'TelefoneController');
    Route::resource('emails', 'EmailController');
//Route::resource('dependentes', 'DependenteController');

    Route::resource('imoveis', 'ImovelController');
    Route::resource('empresas', 'EmpresaController');
    Route::get('empresas_get', 'EmpresaController@filter');
    Route::resource('documentos', 'DocumentoController');
    Route::resource('area_externas', 'AreaExternaController');
    Route::resource('imovel_permanentes', 'ImovelPermanenteController');
    Route::resource('tipo_documentos', 'TipoDocumentoController');

//Route::resource('contatos', 'ContatoController');
//Route::resource('telefones', 'TelefoneController');
//Route::resource('emails', 'EmailController');
    /*
    |--------------------------------------------------------------------------
    | API Basic Routes - FINANCEIRO
    |--------------------------------------------------------------------------
    */
//financeiro_base_v1.a
    Route::resource('grupo_lancamentos', 'GrupoLancamentoController');
    Route::get('grupo_lancamentos_by_tipo', 'GrupoLancamentoController@gruposLancamentoPorTipo');
    Route::resource('tipo_lancamentos', 'TipoLancamentoController');
    Route::get('tipo_inadimplencias/select_list', 'TipoInadimplenciaController@selectList');
    Route::resource('tipo_inadimplencias', 'TipoInadimplenciaController');
    Route::resource('situacao_inadimplencias', 'SituacaoInadimplenciaController');

//financeiro_bancario_v1.a
    Route::resource('bancos', 'BancoController');
    Route::resource('conta_bancarias', 'ContaBancariaController');
    Route::resource('configuracao_carteira', 'ConfiguracaoCarteiraController');
    Route::resource('carteiras', 'CarteiraController');
    Route::resource('layout_retorno', 'LayoutRetornoController');
    Route::resource('layout_remessa', 'LayoutRemessaController');
    Route::resource('unidade_produtos', 'UnidadeProdutoController');
    Route::resource('grupo_produtos', 'GrupoProdutoController');
    Route::resource('departamentos', 'DepartamentoController');
    Route::resource('areas', 'AreaController');
    Route::resource('ruas', 'RuaController');
    Route::resource('colunas', 'ColunaController');
    Route::resource('niveis', 'NivelController');
    Route::resource('sequencias', 'SequenciaController');
    Route::resource('aprovadores', 'AprovadorController');
    Route::get('usuarios/pessoas', 'UsuarioController@usuariosPessoas');
    Route::resource('usuarios', 'UsuarioController');
    Route::resource('feriados', 'FeriadoController');
    Route::resource('layout_arquivos', 'LayoutArquivoController');

    Route::get('lancamento_recorrentes/calculos_simulados', 'LancamentoRecorrenteController@simulacoesCalculadas');
    Route::resource('lancamento_recorrentes', 'LancamentoRecorrenteController');

    Route::resource('lancamento_avulsos', 'LancamentoAvulsoController');
//Route::resource('lancamentos', 'LancamentoController'); // não existe.
    Route::resource('recebimentos', 'RecebimentoController');
    Route::resource('grupo_calculo', 'GrupoCalculoController');
    Route::resource('receita_calculo', 'ReceitaCalculoController');
    Route::resource('lancamentos_estimados', 'LancamentosEstimadosController');
    Route::resource('lancamento_agendar', 'LancamentoAgendarController');
    Route::resource('pagamento', 'PagamentoController');
    Route::resource('estimados', 'EstimadoController');
    Route::resource('condominio_configuracoes', 'CondominioConfiguracoesController');
    Route::resource('parametros_receita', 'ReceitaController');
    Route::post('notificacao/enviar_email', 'NotificacaoController@enviarEmail');

    /** Rotas para migração de banco de dados */
    Route::get('import_database/verona', 'MigrationDatabaseClientController@importDabaseVerona');


// routes pre-lançamento
    Route::get('pre_lancamentos/checkCalculados', 'PreLancamentoController@checkCalculados');
    Route::resource('pre_lancamentos', 'PreLancamentoController');
// routes infomativo/
    Route::resource('informativo', 'InformativoController');
    Route::get('informativo/{id}/image64', 'InformativoController@getImage64');
    Route::get('informativo/{id}/image', 'InformativoController@getImage');
    Route::get('informativo/{id}/visualizar', 'InformativoController@getVisualizar');

// patrimonio
    Route::group(['prefix' => 'patrimonios'], function () {
        Route::resource('bens', 'PatrimoniosBensController');
        Route::resource('bensSemPendencia', 'PatrimoniosBensController@bensSemPendencia');
        Route::resource('manutencoes', 'PatrimoniosManutencoesController');
        Route::resource('baixas', 'PatrimoniosBaixasController');
        Route::get('historicos', 'PatrimoniosHistoricosController@index');
        Route::resource('apolices', 'PatrimoniosApolicesController');
        Route::resource('apolices/bens', 'PatrimoniosApolicesPatrimoniosController');
    });

    Route::group(['prefix' => 'produtos'], function () {
        Route::get('getImage64/{id}', 'ProdutoController@getImage64');
        Route::get('consumo', 'ProdutoController@getProdAtivoConsumo');
        Route::get('detail/{id}', 'ProdutoController@detail');
        Route::get('search/', 'ProdutoController@searchEstoque');
        Route::get('produtos_get', 'ProdutoController@getBuscaProduto');
        Route::post('saveImage', 'ProdutoController@saveImage');
        Route::delete('deleteImage/{id}', 'ProdutoController@deleteImage');
    });
    Route::resource('produtos', 'ProdutoController');


    Route::group(['prefix' => 'estoque'], function () {
        Route::get('movimentacoes', 'EstoqueMovimentacaoController@movimentacoes');
        Route::post('movimentacoes', 'EstoqueMovimentacaoController@store');
        Route::delete('movimentacoes/{id}', 'EstoqueMovimentacaoController@delete');
    });

    Route::group(['prefix' => 'pedidos'], function () {
        Route::post('movprodutos/{idPedido}', 'PedidoController@movProdutos');
        Route::post('pedidoDeleteItens', 'PedidoController@deleteItensByPedido');
        Route::get('getinfomov/{idPedido}', 'PedidoController@getInfoMov');
        Route::get('solicitacao', 'PedidoController@solicitacao');
        Route::get('aprovacao', 'PedidoController@aprovacao');
        Route::post('search', 'PedidoController@solicitacao');
        Route::post('imprimir_solicitacao', 'PedidoController@imprimirSolicitacao');
        Route::post('imprimir_cotacao', 'PedidoController@imprimirCotacao');
        Route::post('notificacao_aprovador', 'PedidoController@notificacaoAprovador');

    });
    Route::resource('pedidos', 'PedidoController');

//FLUXO
    Route::post('fluxo', 'FluxoCaixaController@filtroFluxo');
    Route::post('fluxo/saldo_contas', 'FluxoCaixaController@saldoContas');

// FORMULAS
    Route::resource('formulas', 'FormulasController');
//    INTEGRAÇÕES
    Route::post('exporta_arquivo_contabil','ExportArquivoCsvController@exportLancamentosLayoutTron');
});