<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class UpdateProdutosNiveisTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idarea_foreign, MODIFY idarea integer UNSIGNED; ");
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idarea_foreign FOREIGN KEY (idarea) REFERENCES areas(id);");

       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idcolunas_foreign, MODIFY idcolunas integer UNSIGNED; ");
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idcolunas_foreign FOREIGN KEY (idcolunas) REFERENCES colunas(id);");

       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idniveis_foreign, MODIFY idniveis integer UNSIGNED;");   
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idniveis_foreign FOREIGN KEY (idniveis) REFERENCES nivels(id);");   
    
       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idrua_foreign, MODIFY idrua integer UNSIGNED; ");   
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idrua_foreign FOREIGN KEY (idrua) REFERENCES ruas(id);");   
    
       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idsequencia_foreign, MODIFY idsequencia integer UNSIGNED;"); 
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idsequencia_foreign FOREIGN KEY (idsequencia) REFERENCES sequencias(id); "); 

       DB::statement("ALTER TABLE produtos MODIFY referencia varchar(50); ");   
       DB::statement("ALTER TABLE produtos MODIFY quantidade_maxima integer; ");   


       
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idarea_foreign, MODIFY idarea integer UNSIGNED not null; ");
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idarea_foreign FOREIGN KEY (idarea) REFERENCES areas(id);");

       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idcolunas_foreign, MODIFY idcolunas integer UNSIGNED not null; ");
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idcolunas_foreign FOREIGN KEY (idcolunas) REFERENCES colunas(id);");

       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idniveis_foreign, MODIFY idniveis integer UNSIGNED not null; ");   
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idniveis_foreign FOREIGN KEY (idniveis) REFERENCES nivels(id);");   
    
       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idrua_foreign, MODIFY idrua integer UNSIGNED not null; ");   
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idrua_foreign FOREIGN KEY (idrua) REFERENCES ruas(id);");   
    
       DB::statement("ALTER TABLE produtos DROP FOREIGN KEY produtos_idsequencia_foreign, MODIFY idrua integer UNSIGNED not null;"); 
       DB::statement("ALTER TABLE produtos ADD CONSTRAINT produtos_idsequencia_foreign FOREIGN KEY (idsequencia) REFERENCES sequencias(id); "); 

       DB::statement("ALTER TABLE produtos MODIFY referencia varchar(50) not null; "); 

        DB::statement("ALTER TABLE produtos MODIFY quantidade_maxima integer not null; ");   

    }
}
