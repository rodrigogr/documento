<?php

namespace App\Observers;

use App\Models\Imovel;

class ImovelObserver
{
    /**
     * Listen to the Imovel created event.
     *
     * @param  Imovel $data
     * @return void
     */
    public function created(Imovel $data)
    {
        //
    }

    /**
     * Listen to the Imovel deleting event.
     *
     * @param  Imovel $data
     * @return void
     */
    public function deleting(Imovel $data)
    {
        $data->documentos()->delete(); //deleting documentos
        $data->areas_externas()->delete(); //deleting areas_externas
    }
}