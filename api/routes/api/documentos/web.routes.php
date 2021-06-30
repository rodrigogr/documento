<?php

Route::resource('/documentos', 'documento\DocumentoController');
Route::get('/documentos/open/{id}', 'documento\DocumentoController@openDocument');
Route::resource('/categorias', 'documento\CategoriaController');