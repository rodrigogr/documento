<?php
/**
 * Created by PhpStorm.
 * User: Leonardo
 * Date: 09/11/2016
 * Time: 13:49
 */

namespace App\Providers;

use Illuminate\Support\Facades\Response;
use Illuminate\Support\ServiceProvider;

class ResponseMacroServiceProvider extends ServiceProvider
{
    public function boot()
    {
        Response::macro('success', function ($data) {
            return Response::json([
                'errors' => false,
                'data' => $data,
            ]);
        });

        Response::macro('error', function ($message, $status = 400) {
            return Response::json([
                'errors' => true,
                'message' => $message,
            ], $status);
        });
    }
}