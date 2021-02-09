<?php

    Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/localreservavel'], function () {
        Route::get('', 'reservas\LocalReservavelController@index');
        Route::post('/', 'reservas\LocalReservavelController@store');
        Route::get('/{id}', 'reservas\LocalReservavelController@show');
        Route::put('/{id}', 'reservas\LocalReservavelController@update');
    });

    Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/reserva'], function () {
        Route::post('/', 'reservas\ReservaController@store');
        Route::get('/data/{data}', 'reservas\ReservaController@completoByData');
        Route::get('/{id}', 'reservas\ReservaController@show');
        Route::put('/{id}', 'reservas\ReservaController@update');
        Route::delete('/{id}', 'reservas\ReservaController@cancelar');
    });

    Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/aprovacao'], function () {
        Route::post('/aprovacao/pendentes/inicio', 'reservas\Aprovacao@inicio');
        Route::get('/data/{data}', 'reservas\ReservaController@completoByData');
        Route::get('/{id}', 'reservas\ReservaController@show');
        Route::put('/{id}', 'reservas\ReservaController@update');
        Route::delete('/{id}', 'reservas\ReservaController@cancelar');
    });