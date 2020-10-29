<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddAndAlterColumnsContaBancariasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('conta_bancarias', function (Blueprint $table) {
            $table->enum('tipo_banco', ['bancária','caixa'])->after('idbanco');
            $table->string('descricao')->after('tipo')->nullable();
            $table->dropForeign('conta_bancarias_idbanco_foreign');
            DB::statement("ALTER TABLE conta_bancarias CHANGE COLUMN idbanco idbanco int(10) unsigned");
            DB::statement("ALTER TABLE conta_bancarias CHANGE COLUMN agencia agencia VARCHAR(10)");
            DB::statement("ALTER TABLE conta_bancarias CHANGE COLUMN conta conta VARCHAR(10)");
            DB::statement("ALTER TABLE conta_bancarias CHANGE COLUMN relatorio relatorio TINYINT(1) UNSIGNED");
            DB::statement("ALTER TABLE conta_bancarias MODIFY tipo enum('CONTA CORRENTE', 'POUPANÇA', 'CONTA INVESTIMENTO', 'CAIXA')" );
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
