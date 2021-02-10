<?php

Route::group(['middleware' => 'jwt.auth'], function ()
{
    /*Route::group(['prefix' => 'app'], function () {
        //Route::any('5eec33a37ed64e42575b84f1abc8a27843b1a050/{??}', function () {
        //    echo 'teste';
        //});
        Route::pattern('path', '[a-zA-Z0-9-/]+');
        Route::get('5eec33a37ed64e42575b84f1abc8a27843b1a050/{path}', function(){});
    });*/

    Route::group(['prefix' => 'localreservavel'], function () {
        Route::get('', 'reservas\LocalReservavelController@index');
        Route::post('/', 'reservas\LocalReservavelController@store');
        Route::get('/{id}', 'reservas\LocalReservavelController@show');
        Route::put('/{id}', 'reservas\LocalReservavelController@update');
    });

    Route::group(['prefix' => 'reserva'], function () {
        Route::post('/', 'reservas\ReservaController@store');
        Route::get('/data/{data}', 'reservas\ReservaController@completoByData');
        Route::get('/{id}', 'reservas\ReservaController@show');
        Route::put('/{id}', 'reservas\ReservaController@update');
        Route::delete('/{id}', 'reservas\ReservaController@cancelar');
    });

    Route::group(['prefix' => 'aprovacao'], function () {
        Route::post('/aprovacao/pendentes/inicio', 'reservas\Aprovacao@inicio');
        Route::get('/data/{data}', 'reservas\ReservaController@completoByData');
        Route::get('/{id}', 'reservas\ReservaController@show');
        Route::put('/{id}', 'reservas\ReservaController@update');
        Route::delete('/{id}', 'reservas\ReservaController@cancelar');
    });

    Route::get('localidades/locais_reservaveis', 'LocalidadeController@locaisReservaveis');
});