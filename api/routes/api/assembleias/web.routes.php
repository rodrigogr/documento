<?php




Route::get('/assembleias/resumo/{id}', 'assembleia\AssembleiaController@resumo');

Route::get('/assembleias/status/{id}', 'assembleia\AssembleiaController@getStatusAssembleia');

Route::get('/assembleias/iniciar/{id}', 'assembleia\AssembleiaController@iniciarAssembleia');

Route::post('/assembleias/iniciar-votacao', 'assembleia\AssembleiaController@iniciarVotacao');

Route::get('/assembleias/encerrar/{id}', 'assembleia\AssembleiaController@encerrarAssembleia');

Route::get('/assembleias/discussoes/{id}', 'assembleia\AssembleiaController@discussoes');

Route::get('/assembleias/discussoes/topicos/pauta/{id}', 'assembleia\DiscussaoController@listTopicosPorPauta');

Route::get('/assembleias/discussoes/topicos/{idTopico}', 'assembleia\DiscussaoController@detalharTopico');

Route::post('/assembleias/discussoes/topico', 'assembleia\DiscussaoController@createTopico');

Route::post('/assembleias/discussoes/resposta', 'assembleia\DiscussaoController@replyTopico');

Route::get('/assembleias/questoes-ordem/{id}', 'assembleia\AssembleiaController@questoesOrdem');

Route::get('/assembleias/questoes-ordem/detalhar/{id}', 'assembleia\QuestaoOrdemController@detalhar');

Route::get('/assembleias/questoes-ordem/encerrar/{id}', 'assembleia\QuestaoOrdemController@encerrarEnviosQuestaoOrdem');

Route::post('/assembleias/questoes-ordem/decisao/', 'assembleia\QuestaoOrdemController@createDecisao');

Route::post('/assembleias/questoes-ordem/recorrer/', 'assembleia\QuestaoOrdemController@recorrerDecisao');

Route::get('/assembleias/encaminhamentos/{id}', 'assembleia\AssembleiaController@encaminhamentos');

Route::get('/assembleias/pautas/{id}', 'assembleia\AssembleiaController@pautas');

Route::get('/assembleias/participantes/{id}', 'assembleia\AssembleiaController@participantes');

Route::post('/assembleias/participantes/salvar', 'assembleia\ParticipanteController@salvar');

Route::get('/assembleias/get/participantes','assembleia\ParticipanteController@index');

Route::get('/assembleias/search/procurador/{nome}', 'assembleia\ParticipanteController@searchProcurador');

Route::resource('/assembleias', 'assembleia\AssembleiaController');

Route::get( '/assembleias/pauta/get/{id}', 'assembleia\PautaController@show');

Route::get('/pautas/{id}', 'assembleia\PautaController@show');

Route::post('/pautas/{id}', 'assembleia\PautaController@store');

Route::put('/pautas/{id}', 'assembleia\PautaController@update');

Route::put('/pauta/status/{id}', 'assembleia\PautaController@updateStatus');

Route::delete('/pautas/{id}', 'assembleia\PautaController@destroy');

Route::resource('/opcoes', 'assembleia\OpcaoController');

Route::delete('/pauta/anexos/{id}', 'assembleia\PautaAnexoController@detroy');

Route::get('/pauta/anexos/{id}', 'assembleia\PautaAnexoController@show');

Route::get('/pauta/anexos/{id}', 'assembleia\PautaAnexoController@index');

Route::post('/assembleias/encaminhamentos', 'assembleia\EncaminhamentoController@store');

Route::get('/assembleias/encaminhamento/detalhar/{id}', 'assembleia\EncaminhamentoController@detalhar');

Route::get('/assembleias/encaminhamento/encerrar/{id}', 'assembleia\EncaminhamentoController@encerrarEnviosEncaminhamento');

Route::post('/assembleias/encaminhamento/resposta', 'assembleia\EncaminhamentoController@reply');

Route::post('/assembleias/respostas', 'assembleia\PostController@store');

Route::post('/assembleias/questoes-ordem', 'assembleia\QuestaoOrdemController@store');

Route::get('/assembleias/documentos/{id}', 'assembleia\DocumentoController@index');

Route::delete('/assembleias/documentos/{id}', 'assembleia\DocumentoController@destroy');

Route::get('/assembleias/listapresenca/{id}', 'RelatorioController@listaDePresencaAssembleia');

Route::get('/assembleias/relatoriovotacoes/{id}', 'RelatorioController@resultadoVotacoesAssembleia');

Route::get('/assembleias/documento/open/{id}', 'assembleia\DocumentoController@abrirDocumento');

Route::get('/assembleias/questoes-ordem-votacoes/{id}', 'assembleia\QuestaoOrdemPerguntaController@index');

Route::get('/assembleias/questoes-ordem-votacoes/verifica-votacao-aberta/{id}', 'assembleia\QuestaoOrdemPerguntaController@verificaVotacaoAberta');

Route::get('/assembleias/questoes-ordem-votacoes/encerrar-votacoes/{id}', 'assembleia\QuestaoOrdemPerguntaController@encerrarVotacaoQuestaoOrdem');

Route::post('/assembleias/questoes-ordem-votacoes/', 'assembleia\QuestaoOrdemPerguntaController@store');

Route::get('/assembleias/pauta/documento/open/{id}', 'assembleia\PautaAnexoController@abrirDocumento');