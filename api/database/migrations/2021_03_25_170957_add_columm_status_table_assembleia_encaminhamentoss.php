<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColummStatusTableAssembleiaEncaminhamentoss extends Migration
{
    public function up()
    {
        Schema::connection('portal')->table('assembleia_encaminhamentos', function (Blueprint $table) {
            $table->enum('status', ['respondido', 'pendente']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
