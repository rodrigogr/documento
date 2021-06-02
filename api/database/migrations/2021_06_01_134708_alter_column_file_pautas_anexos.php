<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterColumnFilePautasAnexos extends Migration
{
    public function up()
    {
        DB::statement('ALTER TABLE assembleia_pautas_anexos MODIFY COLUMN file LONGBLOB NOT NULL;');
    }

    public function down()
    {
        DB::statement('ALTER TABLE assembleia_pautas_anexos MODIFY COLUMN file BLOB NOT NULL;');
    }
}
