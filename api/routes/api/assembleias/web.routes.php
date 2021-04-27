<?php




Route::get('/assembleias/resumo/{id}', 'assembleia\AssembleiaController@resumo');

Route::get('/assembleias/iniciar/{id}', 'assembleia\AssembleiaController@iniciarAssembleia');

Route::post('/assembleias/iniciar/votacao/', 'assembleia\VotacaoController@iniciarVotacao');

Route::get('/assembleias/discussoes/{id}', 'assembleia\AssembleiaController@discussoes');

Route::get('/assembleias/discussoes/topicos/pauta/{id}', 'assembleia\DiscussaoController@listTopicosPorPauta');

Route::get('/assembleias/discussoes/topicos/{idTopico}', 'assembleia\DiscussaoController@detalharTopico');

Route::post('/assembleias/discussoes/topico', 'assembleia\DiscussaoController@createTopico');

Route::post('/assembleias/discussoes/resposta', 'assembleia\DiscussaoController@replyTopico');

Route::get('/assembleias/questoes-ordem/{id}', 'assembleia\AssembleiaController@questoesOrdem');

Route::get('/assembleias/questoes-ordem/detalhar/{id}', 'assembleia\QuestaoOrdemController@detalhar');

Route::post('/assembleias/questoes-ordem/decisao/', 'assembleia\QuestaoOrdemController@createDecisao');

Route::post('/assembleias/questoes-ordem/recorrer/', 'assembleia\QuestaoOrdemController@recorrerDecisao');

Route::get('/assembleias/encaminhamentos/{id}', 'assembleia\AssembleiaController@encaminhamentos');

Route::get('/assembleias/pautas/{id}', 'assembleia\AssembleiaController@pautas');

Route::get('/assembleias/participantes/{id}', 'assembleia\AssembleiaController@participantes');

Route::get('/assembleias/get/participantes','assembleia\ParticipanteController@index');

Route::get('/assembleias/search/procurador/{nome}', 'assembleia\ParticipanteController@searchProcurador');

Route::resource('/assembleias', 'assembleia\AssembleiaController');

Route::get( '/assembleias/pauta/get/{id}', 'assembleia\PautaController@show');

Route::put( '/assembleias/pauta', 'assembleia\PautaController@update' );

Route::resource('/pautas', 'assembleia\PautaController');

Route::resource('/pauta_anexos', 'assembleia\PautaAnexoController');

Route::post('/assembleias/encaminhamentos', 'assembleia\EncaminhamentoController@store');

Route::get('/assembleias/encaminhamento/detalhar/{id}', 'assembleia\EncaminhamentoController@detalhar');

Route::post('/assembleias/encaminhamento/resposta', 'assembleia\EncaminhamentoController@reply');

Route::post('/assembleias/respostas', 'assembleia\PostController@store');

Route::post('/assembleias/questoes-ordem', 'assembleia\QuestaoOrdemController@store');

Route::get('/assembleias/documentos/{id}', 'assembleia\DocumentoController@index');

Route::delete('/assembleias/documentos/{id}', 'assembleia\DocumentoController@destroy');






