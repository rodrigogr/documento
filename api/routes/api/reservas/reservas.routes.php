<?php


Route::group(['middleware' => 'jwt.auth'], function ()
{
    Route::group(['prefix' => 'localreservavel'], function () {
        Route::get('/', 'reservas\LocalReservavelController@index');
        Route::post('/', 'reservas\LocalReservavelController@store');
        Route::get('/{id}', 'reservas\LocalReservavelController@show');
        Route::put('/{id}', 'reservas\LocalReservavelController@update');
        Route::get('/nome/{nome_local}', 'reservas\LocalReservavelController@nomeLocalReservavel');
    });

    Route::group(['prefix' => 'reserva'], function () {
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

    Route::group(['prefix' => 'aprovacao'], function () {
        Route::get('/pendentes/hoje', 'reservas\AprovacaoController@pendentesHoje');
        Route::get('/pendentes/data/{data}', 'reservas\AprovacaoController@pendentesHoje');
        Route::get('/pendentes/local/{local}', 'reservas\AprovacaoController@pendentesHojeLocalReservavel');
        Route::get('/pendentes/localidade/{localidade}', 'reservas\AprovacaoController@pendentesHojeLocalidade');
        Route::patch('/{id}', 'reservas\AprovacaoController@aprovacao');
        Route::put('/recusar', 'reservas\AprovacaoController@recusar');
        Route::get('/recusados/{data}', 'reservas\AprovacaoController@recusados');
        Route::get('/recusados/local/{local}', 'reservas\AprovacaoController@recusadosLocalReservavel');
        Route::get('/recusados/localidade/{localidade}', 'reservas\AprovacaoController@recusadosLocalidade');
    });

    Route::group(['prefix' => 'localidades'], function () {
        Route::get('/', 'LocalidadeController@index');
        Route::get('/locais_reservaveis', 'LocalidadeController@locaisReservaveis');
        Route::get('/locais_reservaveis/pessoa/{id_pessoa}', 'LocalidadeController@locaisPermitidos');
    });

});