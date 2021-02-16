<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Messages Language Lines
    |--------------------------------------------------------------------------
    | Model - Procedure Type - Message Type
    | Example 1: Fans (S)tore (S)uccess
    | Example 2: Fans (U)pdate (E)rror
    */
    'crud' => [
        //STORE
        'MSS' => ':name cadastrado com sucesso!',
        'MSE' => 'Erro ao cadastrar o :name.',
        'FSS' => ':name cadastrada com sucesso!',
        'FSE' => 'Erro ao cadastrar a :name.',

        //UPDATE
        'MUS' => ':name atualizado com sucesso!',
        'MUE' => 'Erro ao atualizar o :name!',
        'FUS' => ':name atualizada com sucesso!',
        'FUE' => 'Erro ao atualizar a :name!',

        //DELETE
        'MDS' => ':name removido com sucesso!',
        'MDE' => 'Erro ao remover o :name!',
        'FDS' => ':name removida com sucesso!',
        'FDE' => 'Erro ao remover a :name!',

        //CANCEL
        'MCS' => ':name cancelado com sucesso!',
        'MCE' => 'Erro ao cancelar o :name!',
        'FCS' => ':name cancelada com sucesso!',
        'FCE' => 'Erro ao cancelar a :name!',

        //GET
        'MGS' => ':name encontrado com sucesso!',
        'MGE' => 'Erro. Não foi possível encontrar este :name.',
        'FGS' => ':name encontrada com sucesso!',
        'FGE' => 'Erro. Não foi possível encontrar esta :name.',

        //GETALL
        'MAE' => 'Nenhum :name cadastrado ainda.',
        'FAE' => 'Nenhuma :name cadastrada ainda.',
        'FGAE' => 'Erro ao buscar as :name'.'s',
    ]

];
