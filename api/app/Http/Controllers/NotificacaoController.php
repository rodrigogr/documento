<?php

namespace App\Http\Controllers;

use App\Http\Requests\NotificacaoRequest;
use App\Mail\SendMail;
use App\Models\Condominio;
use App\Models\PessoaPermanente;
use App\Models\SendEmail;
use Illuminate\Http\Request;
use League\Flysystem\Exception;
use Respect\Validation\Validator;

class NotificacaoController extends Controller
{
    public function enviarEmail(NotificacaoRequest $request)
    {
        try {
            set_time_limit(0);
            $data = $request->all();
            if (!$data['assunto']) {
                return response()->error('Título obrigatorio!');
            }
            if (!$data['mensagem']) {
                return response()->error('Mensagem obrigatoria!');
            }
            $content = [
                "mensagem" => $data['mensagem']
            ];
            $anexos = !empty($data["anexos"]) ? $data["anexos"]: null ;

            if(\App::environment('production')) {
                $pessoa_permanentes = PessoaPermanente::whereNotNull('email')->where('associado', 's')->where('ativo', 's')->get();
                foreach ($pessoa_permanentes as $pessoa_permanente) {
                    if (!empty($pessoa_permanente->email) && $pessoa_permanente->email != null) {
                        $emails = explode(";", $pessoa_permanente->email);
                        if (count($emails)) {
                            foreach ($emails as $email) {
                                if ($email) {
                                    if (Validator::email()->validate($email)) {
                                        $sent = \Mail::to($email)->send(new SendMail($content, 'emails.email', $data['assunto'], null, $anexos));
                                        if ($sent) {
                                            SendEmail::create([
                                                'id_pessoa' => $pessoa_permanente->id_pessoa,
                                                'email_enviado' => $email,
                                                'status' => 'Não Enviado'
                                            ]);
                                        } else {
                                            SendEmail::create([
                                                'id_pessoa' => $pessoa_permanente->id_pessoa,
                                                'email_enviado' => $email,
                                                'status' => 'Enviado'
                                            ]);
                                        }
                                    } else {
                                        SendEmail::create([
                                            'id_pessoa' => $pessoa_permanente->id_pessoa,
                                            'email_enviado' => $email,
                                            'status' => 'Não Enviado'
                                        ]);
                                    }
                                }
                            }
                        }
                    } else {
                        SendEmail::create([
                            'id_pessoa' => $pessoa_permanente->id_pessoa,
                            'email_enviado' => "Email invalido",
                            'status' => 'Não Enviado'
                        ]);
                    }
                }
            } else {
                $sent = \Mail::to('desenvolvimento@uzer.com.br')->send(new SendMail($content, 'emails.email', $data['assunto'], null, $anexos));
                if ($sent) {
                    SendEmail::create([
                        'id_pessoa' => 1,
                        'email_enviado' => 'desenvolvimento@uzer.com.br',
                        'status' => 'Não Enviado'
                    ]);
                } else {
                    SendEmail::create([
                        'id_pessoa' => 1,
                        'email_enviado' => 'desenvolvimento@uzer.com.br',
                        'status' => 'Enviado'
                    ]);
                }
            }
            set_time_limit(30);
            return response()->success("Email enviado com sucesso!");
        } catch (Exception $e) {
            return response()->error("Problemas ao enviar e-mail");
        } catch (\Swift_TransportException $swift_TransportException )
        {
            return response()->error("Problemas com o servidor de e-mail! " . $swift_TransportException->getMessage());
        }
    }
}
