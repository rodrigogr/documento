<?php

/*
 * Cutomizando returns de verificação de token
 *
 * (c) Rafael Borges 11/01/2018
 *
 * Middleware utilizado ao invés do padrão Tymon\JWTAuth\Middleware::GetUserFromToken
 */

namespace app\Http\Middleware;

use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Middleware\BaseMiddleware;

class CheckToken extends BaseMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, \Closure $next)
    {
        if (! $token = $this->auth->setRequest($request)->getToken()) {
            //return $this->respond('tymon.jwt.absent', 'token_not_provided', 400);
            return $this->response->json(['error' => 'Erro de autenticação. Credenciais não foram encontradas!<br>Faça login.'], 400);
        }

        try {
            $user = $this->auth->authenticate($token);
        } catch (TokenExpiredException $e) {
            //return $this->respond('tymon.jwt.expired', 'token_expired', $e->getStatusCode(), [$e]);
//            return $this->response->json(['error' => 'Autenticação Expirada', 'code' => $e->getStatusCode()], $e->getStatusCode());
            return response()->error('Autenticação Expirada, faça login novamente',$e->getStatusCode());
        } catch (JWTException $e) {
            //return $this->respond('tymon.jwt.invalid', 'token_invalid', $e->getStatusCode(), [$e]);
            return response()->json(['errors' => true, 'message' => 'Token Inválido, faça login novamente.', 'code' => $e->getStatusCode()], $e->getStatusCode());
//            return response()->error('Token Inválido',$e->getStatusCode());
        }

        if (! $user) {
            return $this->respond('tymon.jwt.user_not_found', 'user_not_found', 404);
        }

        $this->events->fire('tymon.jwt.valid', $user);

        return $next($request);
    }
}
