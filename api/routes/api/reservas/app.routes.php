<?php



    Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/localreservavel'], function () {
        Route::get('/', 'reservas\LocalReservavelController@index');
        Route::post('/', 'reservas\LocalReservavelController@store');
        Route::get('/{id}', 'reservas\LocalReservavelController@show');
        Route::put('/{id}', 'reservas\LocalReservavelController@update');
    });

    Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/reserva'], function () {
        Route::get('/', 'reservas\ReservaController@index');
        Route::post('/', 'reservas\ReservaController@store');
        Route::get('/data/{data}', 'reservas\ReservaController@completoByData');
        Route::get('/data/{data}/{id_local_reservavel}', 'reservas\ReservaController@completoByDataLocalReservavel');
        Route::get('/{id}', 'reservas\ReservaController@show');
        Route::put('/{id}', 'reservas\ReservaController@update');
        Route::post('/cancelar', 'reservas\ReservaController@cancelar');
        Route::get('/imovel/{id_imovel}', 'reservas\ReservaController@completoByImovel');
        Route::get('/status/{status}', 'reservas\ReservaController@completoByStatus');
        Route::get('/completo/{id}', 'reservas\ReservaController@completoById');
        Route::patch('/status/{id}', 'reservas\ReservaController@updateStatus');
    });

    Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/aprovacao'], function () {
        Route::get('/pendentes/hoje', 'reservas\AprovacaoController@hoje');
    });

    Route::group(['prefix' => '5eec33a37ed64e42575b84f1abc8a27843b1a050/localidades'], function () {
        Route::get('/', 'LocalidadeController@index');
        Route::get('/locais_reservaveis', 'LocalidadeController@locaisReservaveis');
    });