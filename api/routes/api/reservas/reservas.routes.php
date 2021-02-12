<?php

Route::group(['middleware' => 'jwt.auth'], function ()
{
    Route::group(['prefix' => 'localreservavel'], function () {
        Route::get('', 'reservas\LocalReservavelController@index');
        Route::post('/', 'reservas\LocalReservavelController@store');
        Route::get('/{id}', 'reservas\LocalReservavelController@show');
        Route::put('/{id}', 'reservas\LocalReservavelController@update');
    });

    Route::group(['prefix' => 'reserva'], function () {
        Route::post('/', 'reservas\ReservaController@store');
        Route::get('/data/{data}', 'reservas\ReservaController@completoByData');
        Route::get('/data/{data}/{id_local_reservavel}', 'reservas\ReservaController@completoByDataLocalReservavel');
        Route::get('/{id}', 'reservas\ReservaController@show');
        Route::put('/{id}', 'reservas\ReservaController@update');
        Route::delete('/{id}', 'reservas\ReservaController@cancelar');
    });

    Route::group(['prefix' => 'aprovacao'], function () {
        Route::get('/pendentes/hoje', 'reservas\AprovacaoController@hoje');
        Route::get('/data/{data}', 'reservas\ReservaController@completoByData');
        Route::get('/{id}', 'reservas\ReservaController@show');
        Route::put('/{id}', 'reservas\ReservaController@update');
        Route::delete('/{id}', 'reservas\ReservaController@cancelar');
    });

    Route::get('localidades/locais_reservaveis', 'LocalidadeController@locaisReservaveis');
});