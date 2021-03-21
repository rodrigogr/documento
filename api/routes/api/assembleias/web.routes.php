<?php

Route::resource('/assembleias', 'assembleia\AssembleiaController');
Route::get('/assembleias/resumo/{id}', 'assembleia\AssembleiaController@resumo');
Route::get('/assembleias/get/participantes','assembleia\ParticipanteController@index');
Route::get('/assembleias/search/procurador/{nome}', 'assembleia\ParticipanteController@searchProcurador');