<?php

namespace App\Mail;

use App\Models\Lancamento;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class CartaCobrancaMail extends Mailable
{
    use Queueable, SerializesModels;

    protected $data;
    protected $pdf_path;
    protected $pdf;

    public function __construct(array $data, $pdf)
    {
        $this->data = $data;
        $this->content = $pdf;
    }

    public function build()
    {
        return $this->from($this->data['email_condominio'],$this->data['condominio'])
            ->view('emails.cartacobrancaemail')
            ->with($this->data)
            ->attachData($this->content, 'carta_cobranca.pdf', [
                'mime' => 'application/pdf',
            ])
            ->subject($this->data['condominio'] . ' - Carta de Cobrança');
    }
}
