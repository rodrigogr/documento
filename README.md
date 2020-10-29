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
    * Intl PHP extension

    1.2 SITE - Angular 
    * NODEJS >=6.0.0
2. Ambiente de Desenvolvimento
    
    2.1 Instalação
         
      * Projeto
        
         ```
         #!git
         
         git clone https://NOMEUSUARIO@bitbucket.org/uzertecnologia/financeiro.git
         
         git checkout compras
         ```
      * Site - Acessar pasta "projeto/site"
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
                
                * Executar pelo xampp
                Criar um vhost e servir essa pasta
                // Configurar URL da API. Abra o arquivo
                    projeto/site/app/config/urlConfig.js
                                                
                //informe o endereço da api
                    apiUrl: 'http://localhost:8000/'
         ```
        
      * Api - Acessar pasta "projeto/api"
      
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
            //Criar as tabelas
            php artisan migrate
            
            // Cria conteúdos iniciais. 
            php artisan db:seed
            ```
         *  Servidor de desenvolvimento local 
            ```
             //Executa o servidor incorporado do PHP no terminal
             php artisan serve
             
             * Executando  no xampp
                * mover o arquivo "index.php" para pasta "public" e altrar as seguites partes:
                
                    require __DIR__.'/../bootstrap/autoload.php';
                    //require __DIR__ . '/bootstrap/autoload.php';
             
                    $app = require_once __DIR__.'/../bootstrap/app.php';
                    //$app = require_once __DIR__ . '/bootstrap/app.php';
             
                * criar um arquivo . htaccess e colocar o conteudo 
                     Options +FollowSymLinks
                     RewriteEngine On
                     
                     RewriteCond %{REQUEST_FILENAME} !-d
                     RewriteCond %{REQUEST_FILENAME} !-f
                     RewriteRule ^ index.php [L]
             ```
3. Ambiente de Produção

connect server
chmod 400 Uzer.pem
ssh -i Uzer.pem ubuntu@ec2-13-58-177-226.us-east-2.compute.amazonaws.com