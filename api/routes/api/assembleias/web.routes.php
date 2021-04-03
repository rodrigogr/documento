<?php




Route::get('/assembleias/resumo/{id}', 'assembleia\AssembleiaController@resumo');

Route::get('/assembleias/discussoes/{id}', 'assembleia\AssembleiaController@discussoes');

Route::post('/assembleias/discussoes/topico', 'assembleia\DiscussaoController@createTopico');

Route::post('/assembleias/discussoes/resposta', 'assembleia\DiscussaoController@replyTopico');

Route::get('/assembleias/questoes-ordem/{id}', 'assembleia\AssembleiaController@questoesOrdem');

Route::get('/assembleias/encaminhamentos/{id}', 'assembleia\AssembleiaController@encaminhamentos');

Route::get('/assembleias/pautas/{id}', 'assembleia\AssembleiaController@pautas');

Route::get('/assembleias/participantes/{id}', 'assembleia\AssembleiaController@participantes');

Route::get('/assembleias/get/participantes','assembleia\ParticipanteController@index');

Route::get('/assembleias/search/procurador/{nome}', 'assembleia\ParticipanteController@searchProcurador');

Route::resource('/assembleias', 'assembleia\AssembleiaController');

Route::post('/assembleias/encaminhamentos', 'assembleia\EncaminhamentoController@store');

Route::post('/assembleias/respostas', 'assembleia\PostController@store');


Route::post('/assembleias/questoes-ordem', 'assembleia\QuestaoOrdemController@store');





