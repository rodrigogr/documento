<?php

Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/assembleias'], function () {
    Route::get('/', 'assembleia\AssembleiaController@listaAssembleiasUsuario');
    Route::get('/{id}', 'assembleia\AssembleiaController@getAssembleiaDetalhadaUsuario');
});