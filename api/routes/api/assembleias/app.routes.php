<?php

Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/assembleias'], function () {
    Route::get('/', 'assembleia\AssembleiaController@listaAssembleiasUsuario');
    Route::get('/{id}/pessoa/{idPessoa}', 'assembleia\AssembleiaController@getAssembleiaDetalhadaUsuario');
    Route::get('/questoes-ordem/{id}', 'assembleia\QuestaoOrdemController@listQuestaoOrdemAplicativoPorAssembleia');
    Route::get('/questoes-ordem/detalhar/{id}', 'assembleia\QuestaoOrdemController@detalhar');
    Route::post('/questoes-ordem', 'assembleia\QuestaoOrdemController@store');
    Route::post('/questoes-ordem/recorrer', 'assembleia\QuestaoOrdemController@recorrerDecisao');
    Route::get('/encaminhamentos/{id}', 'assembleia\AssembleiaController@encaminhamentos');
    Route::get('/encaminhamento/detalhar/{id}', 'assembleia\EncaminhamentoController@detalhar');
    Route::post('/encaminhamentos', 'assembleia\EncaminhamentoController@store');
    Route::get('/discussoes/topicos/pauta/{id}', 'assembleia\DiscussaoController@listTopicosPorPauta');
    Route::post('/discussoes/topico', 'assembleia\DiscussaoController@createTopico');
    Route::get('/discussoes/topico/{idTopico}', 'assembleia\DiscussaoController@detalharTopico');
    Route::post('/discussoes/comentartopico', 'assembleia\DiscussaoController@replyTopico');
    Route::post('/votacao', 'assembleia\VotacaoController@registrarVoto');
    Route::get('/anexos/{id}', 'assembleia\DocumentoController@index');
    Route::get('/pautas/assembleia/{id}', 'assembleia\PautaController@listPautasAssembleia');
    Route::get('/getdocumento/{id}', 'assembleia\DocumentoController@getDocumento');
    Route::get('/questoesordemvotacoes/assembleia/{id}/pessoa/{idPessoa}', 'assembleia\QuestaoOrdemPerguntaController@listQuestoesOrdensVotacoesPessoa');
    Route::post('/questoesordemvotacoes', 'assembleia\QuestaoOrdemVotacaoController@registrarVoto');
    Route::get('pauta/{id}/anexos', 'assembleia\PautaAnexoController@index');
});