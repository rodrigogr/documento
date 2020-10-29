<!DOCTYPE html>
<html lang="en" ng-app="app">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Bioacesso - Financeiro</title>

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,600" rel="stylesheet" type="text/css">

        <!--Stylee-->
        <!--	    <link rel="stylesheet" href="css/lib.css">-->
        <link rel="stylesheet" href="css/lib/overlay.css">
        <link rel="stylesheet" href="css/lib/bootstrap.css">
        <link rel="stylesheet" href="css/lib/bootstrap-theme.css">
        <link rel="stylesheet" href="css/lib/angular-material.min.css">
        <link rel="stylesheet" href="css/lib/font-awesome.css">
        <link rel="stylesheet" href="css/lib/styles.css">
        <link rel="stylesheet" href="css/lib/dialog.css">
        <link rel="stylesheet" href="css/lib/webcam.css">
        <link rel="stylesheet" href="css/lib/ba-icons.css">
        <link rel="stylesheet" href="css/lib/autocomplete.css">
        <link rel="stylesheet" href="css/lib/bootstrap-datetimepicker.css">
        <link rel="stylesheet" href="css/lib/angular-toastr.css">
        <link rel="stylesheet" href="css/email.css">

    </head>
    <body>
    <div ui-view>
        <div id="logo">
            <row>
                {{--<img src="img/logo.jpg">--}}
            </row>
        </div>
        <div id="corpo">
            <div class="content">
                {!!html_entity_decode($mensagem)!!}
            </div>
        </div>
        <div id="footer">
            <row>
                {{--<img src="img/bioacessoLogo.png">--}}

            </row>
        </div>
    </div>
    </body>

    <!--bower_components-->
    <script src="js/generated/vendor.js"></script>

    <!--app-->
    <script src="js/generated/controllers.js"></script>
    <script src="js/generated/directives.js"></script>
    <script src="js/generated/services.js"></script>
    <script src="js/generated/filters.js"></script>

    <script type="text/javascript" src="js/app/config/ngConfig.js"></script>

</html>
