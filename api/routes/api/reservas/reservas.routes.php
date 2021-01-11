<?php

Route::group(['middleware' => 'jwt.auth'], function ()
{
    Route::post('saveImage', 'LocalReservavelController@saveImage');
});
