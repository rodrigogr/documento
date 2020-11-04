<?php

namespace App\Http\Controllers;

use App\Http\Requests\AuthenticateRequest;
use App\Models\AcessoLogin;
use App\Models\Usuario;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    public function login (AuthenticateRequest $request = null, $getLogin = null)
    {
        $credentials = $getLogin ? $getLogin : $request->only('login','pwd'); //verifica se login vem do acesso direto($request) ou de outro sistema($getLogin)

        $usuario = Usuario::select('usuario.id','usuario.senha','usuario.ativo','p.nome','c.nome as funcao')
                        ->join('pessoa as p','p.id','usuario.id_pessoa_funcionario')
                        ->join('categoria_usuario as c','c.id','usuario.id_categoria')
                        ->where('login',$credentials["login"])->first();

        if (!$usuario) {
            return response()->error('Login inválido!',401);
        }
        if ($usuario->ativo != 's') {
            return response()->error('Usuário está desativado!',401);
        }
        if ($credentials['pwd'] !== sha1($usuario->senha)) {
            return response()->error('Senha Inválida!',401);
        }
        $permissao_financeiro = \DB::connection('portaria')->table('permissao_usuario as p')
            ->join('modulo_sistema as m','p.id_modulo','=','m.id')
            ->where('p.id_usuario',$usuario->id)
            ->where('visualizar',1)
            ->select('m.nome')
            ->get();

        $check_modulo = false;
        foreach ($permissao_financeiro as $modulo) {
            if ($modulo->nome === 'acesso_financeiro') {
                $check_modulo = true;
            }
        }
        if (!$check_modulo) {
            return response()->error('Você não tem permissão de acesso,<br>verifique com o administrador!',401);
        }

        $token = JWTAuth::fromUser($usuario);
        //$objectToken = JWTAuth::setToken($token);
        //$expiration = JWTAuth::decode($objectToken->getToken())->get('exp');

        return response()->success([
            'token' => $token,
            'usr' => [
                'id' => sha1($usuario->id),
                'nome' => $usuario->nome
            ]
        ]);
    }
    public function checkAuth(\Illuminate\Http\Request $request)
    {
        /*$payload = JWTAuth::parseToken()->getPayload();
        return $payload;*/
        $token = JWTAuth::setRequest($request)->getToken();
        try
        {
            if (! $user = JWTAuth::parseToken()->authenticate() )
            {
                return response()->json([
                    'code'   => 400,
                    'error' => 'Erro de autenticação. Credenciais não foram encontradas!<br>Faça login novamente.'
                 ]);
            }
            $payload = JWTAuth::parseToken()->getPayload();

            $permissoes = \DB::connection('portaria')->table('permissao_usuario as p')
                ->join('modulo_sistema as m','p.id_modulo','=','m.id')
                ->where('p.id_usuario',$payload["sub"])
                ->where('visualizar',1)
                ->select('m.nome')
                ->get();
            $arr = [];
            foreach ($permissoes as $value){
                $arr[] = $value->nome;
            }
            $user = ['permissoes' => $arr];
        }
        catch (\Tymon\JWTAuth\Exceptions\TokenExpiredException $e)
        {
            return response()->json([
                'code'   => $e->getStatusCode(), // means not refreshable
                'error' => 'Sessão expirada!' // nothing to show
            ]);
            // por enquanto não renovar token expirado
            /*try
            {
                $refreshed = JWTAuth::parseToken()->refresh($token);
                $userAuth = JWTAuth::setToken($refreshed)->toUser();
                JWTAuth::fromUser($userAuth);
                $user = true;
                header('Authorization: Bearer ' . $refreshed);
            }
            catch (\Tymon\JWTAuth\Exceptions\JWTException $e)
            {
                return response()->json([
                    'code'   => $e->getStatusCode(), // means not refreshable
                    'error' => $e->getMessage() // nothing to show
                 ]);
            }*/
        } catch (\Tymon\JWTAuth\Exceptions\TokenInvalidException $e) {
            return response()->json([
                'code'   => $e->getStatusCode(), // means auth error in the api,
                'error' => 'Autenticação inválida.'
            ]);
        }
        catch (\Tymon\JWTAuth\Exceptions\JWTException $e)
        {
            return response()->json([
                'code'   => $e->getStatusCode(), // means auth error in the api,
                'error' => $e->getMessage() // nothing to show
            ]);
        }

        return response()->success($user);
    }

    public function userPermissoes (Request $request)
    {
        $usuario = $request->all();
        $permissoes = \DB::connection('portaria')->table('permissao_usuario as p')
            ->join('modulo_sistema as m','p.id_modulo','=','m.id')
            ->whereRaw("sha1(p.id_usuario) = '".$usuario["id"]."'")
            ->where('visualizar',1)
            ->select('m.nome as cod','m.desc as nome', 'p.visualizar','p.inserir','p.editar','p.excluir')
            ->get();
        return response()->success($permissoes);
    }

    public function permissaoByPagina (Request $request)
    {
        $dados = $request->All();
        $permissaoPg = \DB::connection('portaria')->table('permissao_usuario as p')
            ->join('modulo_sistema as m','p.id_modulo','=','m.id')
            ->whereRaw("sha1(p.id_usuario) = '".$dados["id"]."'")
            ->where('m.nome',$dados["pg"])
            ->select('p.visualizar','p.editar','p.excluir','p.inserir')
            ->first();
        return response()->success($permissaoPg);
    }

    public function boxHeaderAccess (Request $request)
    {
        $dados = $request->all();
        $permissaoAppsBox = \DB::connection('portaria')->table('permissao_usuario as p')
            ->join('modulo_sistema as m','p.id_modulo','=','m.id')
            ->whereRaw("sha1(p.id_usuario) = '".$dados["dados"]["id"]."'")
            ->where(function($q){
                $q->orWhere('m.nome','admin')->orWhere('nome','acesso_portal');
                $q->orWhere('nome','portaria')->orWhere('nome','sistema');
            })
            ->select('p.visualizar','m.nome')
            ->get();
        return response()->success($permissaoAppsBox);
    }

    public function getLogin($uid)
    {
        $decript1 = urldecode($uid);
        $decript1 = base64_decode($decript1);
        $decript2 = explode('.',$decript1);
        $decript = [
            "hash" => $decript2[0],
            "id_pessoa" => $decript2[1],
            "id_tabela" => $decript2[2]
        ];
       
        if (true) {
            //$validaUsuario->update(['ativo' => 'n']);
            $usuario = Usuario::find($decript["id_pessoa"]);
            $dados = array('login' => $usuario->login, 'pwd' => sha1($usuario->senha));
            $result =  $this->login(null, $dados);
            return $result;
        } else {
            return response()->error('Essa url não é válida!',401);
        }
    }

    public function acessoExterno()
    {
        try {
            $user = JWTAuth::parseToken()->authenticate();
            $userId = $user->id;
            $cript_hash = hash('SHA256','getLoginBioacesso'.Date('d-m-Y H:i:s').$userId);

            AcessoLogin::where('id_pessoa', $userId)->update(['ativo' => 'n']);

            $acessLogin = new AcessoLogin();
            $acessLogin->hash = $cript_hash;
            $acessLogin->id_pessoa = $userId;
            $acessLogin->ativo = 's';
            $acessLogin->save();

            $cript = base64_encode($cript_hash.'.'.$userId.'.'.md5($acessLogin->id));

        } catch (\Exception $e) {
            return response()->error('Erro '.$e->getMessage());
        }
        return response()->success(urlencode($cript));
    }

}
