<?php

Route::group(['middleware' => 'jwt.auth'], function ()
{
    Route::group(['prefix' => 'localreservavel'], function () {
        Route::get('getImage64/{id}', 'ProdutoController@getImage64');
        Route::get('consumo', 'ProdutoController@getProdAtivoConsumo');
        Route::get('detail/{id}', 'ProdutoController@detail');
        Route::get('search/', 'ProdutoController@searchEstoque');
        Route::get('produtos_get', 'ProdutoController@getBuscaProduto');
        Route::post('saveImage', 'ProdutoController@saveImage');
        Route::post('/', 'ProdutoController@saveImage');
        Route::delete('deleteImage/{id}', 'ProdutoController@deleteImage');
    });
});

Route::resource('localteste', 'LocalReservavelController');