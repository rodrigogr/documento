<?php

namespace App\Mail;

use App\Models\Lancamento;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class BoletoMail extends Mailable
{
    use Queueable, SerializesModels;

    protected $data;
    protected $pdf_path;
    protected $content_estimado;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(array $data, $boleto_pdf, $content_estimado = null)
    {
        $this->data = $data;
        $this->boleto_pdf = $boleto_pdf;
        $this->content_estimado = $content_estimado;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $email = $this->from($this->data['email_condominio'],$this->data['nome_condominio'])
            ->view('emails.boletoemail')
            ->with($this->data)
//            ->attach($this->pdf_path, [
//                'as' => 'Boleto.pdf',
//                'mime' => 'application/pdf',
//            ])
            ->attachData($this->boleto_pdf, 'boleto_pagamento.pdf', [
                'mime' => 'application/pdf',
            ])
            ->subject($this->data['nome_condominio'] . ' - Aviso de boleto gerado');

        if (!is_null($this->content_estimado)){
             $email->attachData($this->content_estimado, 'lancamento_estimados.pdf', [
                 'mime' => 'application/pdf',
             ]);
        }
        return $email;
    }
}
