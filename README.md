# README #
1. Requisitos

    1.1 API - Laravel
    * PHP >= 5.6.4
    * OpenSSL PHP Extension
    * PDO PHP Extension
    * Mbstring PHP Extension
    * Tokenizer PHP Extension
    * XML PHP Extension
    * GD PHP Extension

    1.2 SITE - Angular 
    * NODEJS >=6.0.0
2. Ambiente de Desenvolvimento
    
    2.1 Instalação
        O projeto é arquitetado por duas estrutura de pastas
            
            API  - Concentra todo back-end
            SITE - Concetra todo front-end
            
      * Intalando e configurando front-end"
        
        * Acessar pasta "projeto/site
        * Download das dependencias.
         ```
                // Instalar o bower
                npm i -g bower
                 
                // Dentro do  diretorio "projeto/site" executar
                bower install     
          ```
        * Servidor de desenvolvimento local
         ```
                // Configurar URL da API. Abra o arquivo
                projeto/site/app/config/urlConfig.js
                                
                //informe o endereço da api
                apiUrl: 'http://localhost:8000/'
                
                // Instalar o http-server
                npm i -g http-server
         
                
                // Dentro do  diretorio "projeto/site" executar
                http-server
         
         ```
        
      * Intalando e configurando back-end 
        
        * Acessar pasta "projeto/api"
      
        * Download das dependencias
         ```
                // Executar o Composer dentro do diretorio "projeto/api"
                  php composer.phar install
                
                // ou caso tenha o composer instalado executar dentro do diretorio "projeto/api"
                  composer install
         ```
        * Configuração do arquivo .env 
         ```
            // Copie o arquivo ".env.example" e cole como ".env" dentro da pasta "api"
         
            
            Abra o arquivo ".env" e configure os seguintes paramentros:
            
            // Configurar o APP_KEY
            php artisan  key:generate 
            
            // Configurar o APP_URL
            APP_URL=http://localhost
            
            // Configurar o DB_CONNECTION
            DB_CONNECTION=mysql
            
            // Configurar o DB_HOST
            DB_HOST=127.0.0.1
            
            // Configurar o DB_DATABASE
            DB_DATABASE=bioacesso
            
            // Configurar o DB_USERNAME
            DB_USERNAME=root
            
            // Configurar o DB_PASSWORD
            DB_PASSWORD=root
         ```
        * Base de dados - Necessario base de dados do portaria com suas tabelas
            ```
            1 - Restaurar dump do banco de dados do portaria (mysql) 
                
                projeto/database/dump/dbBioacesso_portaria.sql
          
            2 - Restaurar dump do banco de dados do portal (mysql)
                projeto/database/dump/dbBioacesso_portal.sql
            
            ```
         *  Servidor de desenvolvimento local 
            ```
             //Executa o servidor incorporado do PHP no terminal
             php artisan serve
             
 
             ```
3. Ambiente de Produção

