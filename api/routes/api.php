<?php

    Route::post('auth/login', 'AuthController@login');
    Route::get('auth/checkAuth','AuthController@checkAuth');
    Route::get('condominio', 'CondominioConfiguracoesController@condominio');
    Route::get('auth/getLogin/{hash}','AuthController@getLogin');

    Route::group(['middleware' => 'jwt.auth'], function () {

    Route::post('aclToFrontEnd', 'AuthController@userPermissoes');
    Route::post('aclPermissoes', 'AuthController@userPermissoesFormata');
    Route::post('aclPagina', 'AuthController@permissaoByPagina');
    Route::post('boxApp','AuthController@boxHeaderAccess');
    Route::get('acessoLoginApps','AuthController@acessoExterno');

    Route::get('imoveis/busca_morador/{quadra}/{lote}', 'ImovelController@pesquisarMoradorPorImovel');
    Route::get('imoveis/busca_titular/{quadra}/{lote}', 'ImovelController@pesquisarTitularPorImovel');
    Route::resource('imoveis', 'ImovelController');
    Route::resource('imovel_permanentes', 'ImovelPermanenteController');

    Route::get('usuarios/pessoas', 'UsuarioController@usuariosPessoas');
    Route::resource('usuarios', 'UsuarioController');
    Route::resource('feriados', 'FeriadoController');

    Route::post('notificacao/enviar_email', 'NotificacaoController@enviarEmail');

});

require_once('api/reservas/reservas.routes.php');
require_once('api/reservas/app.routes.php');

require_once ('api/assembleias/web.routes.php');
require_once ('api/assembleias/app.routes.php');

require_once ('api/documentos/web.routes.php');