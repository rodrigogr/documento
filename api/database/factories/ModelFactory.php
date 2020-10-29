<?php

/*
|--------------------------------------------------------------------------
| Model Factories
|--------------------------------------------------------------------------
|
| Here you may define all of your model factories. Model factories give
| you a convenient way to create models for testing and seeding your
| database. Just tell the factory how a default model should look.
|
*/

/*
|--------------------------------------------------------------------------
| User Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\User::class, function (Faker\Generator $faker) {
    static $password;
    return [
        'name' => $faker->name,
        'email' => $faker->safeEmail,
        'password' => $password ?: $password = bcrypt('secret'),
        'remember_token' => str_random(10),
    ];
});
/*
|--------------------------------------------------------------------------
| TipoAreaExterna Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\TipoAreaExterna::class, function (Faker\Generator $faker) {
    return [
        'descricao' => $faker->sentence($nbWords = 6, $variableNbWords = true),
    ];
});
/*
|--------------------------------------------------------------------------
| Localidade Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Localidade::class, function (Faker\Generator $faker) {
    return [
        'descricao' => $faker->sentence($nbWords = 6, $variableNbWords = true)
    ];
});
/*
|--------------------------------------------------------------------------
| SituacaoImovel Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\SituacaoImovel::class, function (Faker\Generator $faker) {
    return [
        'descricao' => $faker->sentence($nbWords = 6, $variableNbWords = true),
        'percentual_desconto' => $faker->randomFloat($nbMaxDecimals = 2, $min = 50, $max = 10000)
    ];
});
/*
|--------------------------------------------------------------------------
| TipoCorrespondencia Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\TipoCorrespondencia::class, function (Faker\Generator $faker) {
    return [
        'descricao' => $faker->sentence($nbWords = 6, $variableNbWords = true),
    ];
});
/*
|--------------------------------------------------------------------------
| TipoTelefone Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\TipoTelefone::class, function (Faker\Generator $faker) {
    return [
        'descricao' => $faker->sentence($nbWords = 6, $variableNbWords = true),
    ];
});
/*
|--------------------------------------------------------------------------
| RamoAtividade Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\RamoAtividade::class, function (Faker\Generator $faker) {
    return [
        'descricao' => $faker->sentence($nbWords = 6, $variableNbWords = true)
    ];
});
/*
|--------------------------------------------------------------------------
| Associado Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Associado::class, function (Faker\Generator $faker) {
    return [
        'idramo_atividades' => $faker->numberBetween($min = 1, $max = 3),
        'idcontato' => function () {
            return factory(App\Models\Contato::class)->create()->id;
        },
        'nome' => $faker->name,
        'cpf' => $faker->randomNumber($nbDigits = 7) . $faker->randomNumber($nbDigits = 4),
        'rg' => $faker->randomNumber($nbDigits = 7) . $faker->randomNumber($nbDigits = 2),
        'natureza' => 'Pessoa Física',
        'nome_mae' => $faker->name,
        'nome_pai' => $faker->name,
        'data_nascimento' => $faker->dateTimeThisCentury($max = 'now')->format('d/m/Y'),
    ];
});
/*
|--------------------------------------------------------------------------
| Dependente Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Dependente::class, function (Faker\Generator $faker) {
    return [
        'idassociado' => $faker->numberBetween($min = 1, $max = 10),
        'nome' => $faker->name,
        'cpf' => $faker->randomNumber($nbDigits = 7) . $faker->randomNumber($nbDigits = 4),
        'rg' => $faker->randomNumber($nbDigits = 7) . $faker->randomNumber($nbDigits = 2),
        'genero' => $faker->randomElement($array = array('Masculino', 'Feminino')),
        'telefone' => $faker->randomNumber($nbDigits = 6) . $faker->randomNumber($nbDigits = 4)
    ];
});
/*
|--------------------------------------------------------------------------
| Contato Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Contato::class, function (Faker\Generator $faker) {
    return [
        'idtipo_correspondencia' => $faker->numberBetween($min = 1, $max = 2),
        'endereco_padrao' => $faker->boolean(),
        'cep' => $faker->randomNumber($nbDigits = 8),
        'estado' => $faker->word,
        'cidade' => $faker->word,
        'bairro' => $faker->streetName,
        'logradouro' => $faker->streetName,
        'numero' => $faker->randomNumber($nbDigits = 4),
        'complemento' => $faker->word
    ];
});
/*
|--------------------------------------------------------------------------
| Email Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Email::class, function (Faker\Generator $faker) {
    return [
        'idcontato' => $faker->numberBetween($min = 1, $max = 10),
        'email' => $faker->safeEmail,
        'notificacao' => $faker->boolean(),
    ];
});
/*
|--------------------------------------------------------------------------
| Telefone Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Telefone::class, function (Faker\Generator $faker) {
    return [
        'idcontato' => $faker->numberBetween($min = 1, $max = 10),
        'idtipo_telefone' => $faker->numberBetween($min = 1, $max = 4),
        'numero' => $faker->randomNumber($nbDigits = 6) . $faker->randomNumber($nbDigits = 4)
    ];
});
/*
|--------------------------------------------------------------------------
| Imovel Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Imovel::class, function (Faker\Generator $faker) {
    return [
        'idlocalidade' => 1,
        'idsituacao_imovel' => $faker->numberBetween($min = 1, $max = 3),
        'cep' => $faker->randomNumber($nbDigits = 8),
        'quadra' => $faker->randomNumber($nbDigits = 1),
        'lote' => $faker->randomNumber($nbDigits = 4),
        'logradouro' => $faker->streetName,
        'obs' => $faker->sentence($nbWords = 6, $variableNbWords = true),
        'status' => $faker->boolean(),
        'area_imovel' => $faker->randomFloat($nbMaxDecimals = 2, $min = 50, $max = 10000),
        'area_construida' => $faker->randomFloat($nbMaxDecimals = 2, $min = 50, $max = 10000),
        'area_ajardinada' => $faker->randomFloat($nbMaxDecimals = 2, $min = 50, $max = 10000),
    ];
});
/*
|--------------------------------------------------------------------------
| Documento Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\Documento::class, function (Faker\Generator $faker) {
    return [
        'idimovel' => $faker->numberBetween($min = 1, $max = 10),
        'documento' => $faker->image($dir = storage_path('uploads/documentos/'), $width = 640, $height = 480, 'technics', false),
        'descricao' => $faker->sentence($nbWords = 6, $variableNbWords = true)
    ];
});
/*
|--------------------------------------------------------------------------
| AreaExterna Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\AreaExterna::class, function (Faker\Generator $faker) {
    return [
        'idimovel' => $faker->numberBetween($min = 1, $max = 10),
        'idtipo_area_externa' => $faker->numberBetween($min = 1, $max = 3),
        'quantidade' => $faker->randomFloat($nbMaxDecimals = 2, $min = 50, $max = 10000),
        'area_construida' => $faker->randomFloat($nbMaxDecimals = 2, $min = 50, $max = 10000),
    ];
});
/*
|--------------------------------------------------------------------------
| Imovel Parmanente Factories
|--------------------------------------------------------------------------
 */
$factory->define(App\Models\ImovelPermanente::class, function (Faker\Generator $faker) {
    return [
        'id_pessoa' => $faker->numberBetween($min = 1, $max = 10),
        'id_imovel' => $faker->numberBetween($min = 1, $max = 10),
        'data_mudanca' => $faker->dateTimeThisCentury($max = 'now')->format('d-m-Y'),
        'tipo' => $faker->boolean(),
        'imovel_principal' => $faker->boolean(),
    ];
});