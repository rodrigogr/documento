<?php

use Illuminate\Database\Seeder;

class TesteSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->call(TipoAreaExternaSeeder::class); //3
        $this->call(LocalidadeSeeder::class); //1
        $this->call(SituacaoImovelSeeder::class); //3

        $this->call(TipoCorrespondenciaSeeder::class); //2
        $this->call(TipoTelefoneSeeder::class); //4
        $this->call(RamoAtividadeSeeder::class); //3

        $this->call(AssociadoSeeder::class); //10 (Associado)
//        $this->call(AssociadoSeeder::class); //10
        $this->call(DependenteSeeder::class); //30
        $this->call(EmailSeeder::class); //10
        $this->call(TelefoneSeeder::class); //10

        $this->call(ImovelSeeder::class); //10
        $this->call(DocumentoSeeder::class); //20
        $this->call(AreaExternaSeeder::class); //20

        $this->call(GrupoLancamentoSeeder::class);
        $this->call(TipoLancamentoSeeder::class);
        $this->call(TipoCorrespondenciaSeeder::class);
        $this->call(SituacaoInadimplenciaSeeder::class);
    }
}
