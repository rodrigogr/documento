<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{

    public function run()
    {
       // $this->call(TipoAreaExternaSeeder::class); //3
        //$this->call(LocalidadeSeeder::class); //1
        //$this->call(SituacaoImovelSeeder::class); //3

        //$this->call(TipoCorrespondenciaSeeder::class); //2
        //$this->call(TipoTelefoneSeeder::class); //4
        //$this->call(RamoAtividadeSeeder::class); //3

        //$this->call(AssociadoSeeder::class); //10 (Associado)
        //$this->call(AssociadoSeeder::class); //10
        //$this->call(DependenteSeeder::class); //30
        //$this->call(EmailSeeder::class); //10
        //$this->call(TelefoneSeeder::class); //10


        //$this->call(ImovelSeeder::class); //10
        //$this->call(DocumentoSeeder::class); //20
        //$this->call(AreaExternaSeeder::class); //20

        //financeiro_base_v1.a
        $this->call(GrupoLancamentoSeeder::class);
        $this->call(TipoLancamentoSeeder::class);
        $this->call(TipoInadimplenciaSeeder::class);
        $this->call(SituacaoInadimplenciaSeeder::class);

        //financeiro_bancario_v1.a
        $this->call(BancoSeeder::class);
        $this->call(CarteiraSeeder::class);
        $this->call(LayoutRetornoSeeder::class);
        $this->call(LayoutRemessaSeeder::class);
        $this->call(ContaBancariaSeeder::class);
        $this->call(ConfiguracaoCarteiraSeeder::class);

        //financeiro_calculo_v1.a
        $this->call(FormulaSeeder::class);
        $this->call(GrupoCalculoSeeder::class);
        $this->call(GrupoCalculoImovelSeeder::class);

        //financeiro_configuracoes_v1.a
        $this->call(CondominioConfiguracoesSeeder::class);
        $this->call(ReceitaSeeder::class);

        //financeiro_estoque_v1.a
        //$this->call(UnidadeProdutoSeeder::class);
        //$this->call(GrupoProdutoSeeder::class);
        //$this->call(ProdutoSeeder::class);

        //financeiro_diversos_v1.a
        $this->call(DepartamentoSeeder::class);
        //$this->call(FeriadoSeeder::class);
        //$this->call(LayoutArquivoSeeder::class);

        //financeiro_receitas_v1.a
        //$this->call(LancamentoAvulsoSeeder::class);
        //$this->call(PreLancamentoSeeder::class);
        //$this->call(LancamentoRecorrenteSeeder::class);
        $this->call(AreaTotalCondominioSeeder::class);
        $this->call(TipoDocumentoSeeder::class);
    }
}
