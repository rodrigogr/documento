angular.module('appServices').service('ValorService',
    function ($q, config)
    {
        var self = this;

        this.depreciacao = function (patrimonio, produtoSelecionado)
        {
            // Aplicação da fórmula de juro composto invertida para encontrar a
            // depreciação: M = C(1 - i) ^ t

            // Capital.
            var c = patrimonio.valor;

            // Taxa.
            var i = produtoSelecionado.grupo_produto.depreciacao;

            var dataAtual = new Date();

            var dataCompra;
            if (typeof patrimonio.data_compra == 'string') {
                dataCompra = Date.parse(patrimonio.data_compra);
            } else {
                dataCompra = patrimonio.data_compra.getTime();
            }

            var datediff = dataAtual - dataCompra;

            // Período.
            var t = datediff / (86400 * 1000 * 365);

            // Montante.
            var m = c * Math.pow((1 - i), t);

            // Retorna a depreciacao com duas casas decimais.
            return Math.round((c - m) * 100) / 100;
        };
    });
