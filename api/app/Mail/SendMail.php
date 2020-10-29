<?php

namespace App\Mail;

use App\Models\Condominio;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendMail extends Mailable
{
    use Queueable, SerializesModels;

    protected $content;
    protected $view_name;
    protected $assunto;
    protected $attach;
    protected $attachData;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(array $content, $view_name, $assunto, array $attach = null, array $attachData = null)
    {
        $this->content = $content;
        $this->view_name = $view_name;
        $this->assunto = $assunto;
        $this->attach = $attach;
        $this->attachData = $attachData;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $condominio = Condominio::first();
        $buildMail = $this->from($condominio->email,$condominio->nome_fantasia)
            ->view($this->view_name)
            ->with($this->content)
            ->subject($this->assunto);

        if(!empty($this->attachData)){
            foreach ($this->attachData as $anexo){
                foreach ($anexo as $item){
                    $file = explode(',',$item["base64"]);
                    $file = base64_decode($file[1]);
                    $buildMail = $buildMail->attachData($file,$item["nome"],[
                        'mime' => $item["tipo"]
                    ]);
                }
            }
        }
        return $buildMail;
    }
}
