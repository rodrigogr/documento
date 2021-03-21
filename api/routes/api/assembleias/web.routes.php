<?php

Route::resource('/assembleias', 'assembleia\AssembleiaController');
Route::get('/assembleias/resumo/{id}', 'assembleia\AssembleiaController@resumo');