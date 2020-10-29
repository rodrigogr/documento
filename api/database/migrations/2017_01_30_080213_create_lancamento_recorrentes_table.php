<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLancamentoRecorrentesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('lancamento_recorrentes')) {
            Schema::create('lancamento_recorrentes', function (Blueprint $table) {
                $table->unsignedInteger('id_lancamento')->primary();
                $table->foreign('id_lancamento')->references('id')->on('lancamentos')->onDelete('cascade');
                $table->unsignedInteger('idlocalidade')->nullable();
                $table->foreign('idlocalidade')->references('id')->on('localidades')->onDelete('cascade');
                $table->enum('tipo_associacao', ['IMÓVEIS', 'PARCEIROS', 'LOCALIZAÇÃO']);
                $table->date('data_expiracao')->nullable();
                $table->boolean('fixo')->default(0);
                $table->softDeletes();
                $table->timestamps();
                //$table->primary('id');
            });
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lancamento_recorrentes');
    }
}
