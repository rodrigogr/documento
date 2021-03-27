<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DropColummIdAssembleiaTableAssembleiaTheadsAnexos extends Migration
{
    public function up()
    {
        Schema::table('assembleia_theads_anexos', function (Blueprint $table) {
            $table->dropForeign('assembleia_theads_anexos_id_assembleia_foreign');
            $table->dropColumn('id_assembleia');
        });
    }

    public function down()
    {
        //
    }
}
