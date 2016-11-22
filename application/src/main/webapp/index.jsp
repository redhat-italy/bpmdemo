<%@ page import="java.security.Principal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="images/favicon.ico">

    <title>Demo BPM Suite</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/jumbotron.css" rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="">Applicazione <b>bpmweb</b></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <%
                Principal principal = request.getUserPrincipal();
                if ( principal != null ){
                    String username = principal.getName().toString();
            %>
              <div class="navbar-right navbar-brand">welcome <%= username %> <button type="button" class="btn btn-primary btn-xs" id="logoutButton">esci</button></div>
            <%
                }
            %>
        </div><!--/.navbar-collapse -->
    </div>
</nav>

<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron">
    <div class="container">
        <p><img src="images/jb_logo.png"></p>
        <h3>Demo Red Hat BPM Suite 6</h3>
        <p>Applicazione demo da utilizzata per mostrare l'integrazione tra una applicazione di terze parti (scritta in ambiente J2E), e la piattaforma BPM Suite 6 di Red Hat.</p>
        <p>Le funzionalita' esposte da questa applicazione sono spiegata di seguito dove e' anche possibile accedere agli specifici servizi.</p>
    </div>
</div>

<div class="container">
    <!-- Example row of columns -->
    <div class="row">
        <div class="col-md-4">
            <h2>Simple Process</h2>
            <p>E' possibile avviare un processo tramite una applicazione esterna. In particolare da questa interfaccia è possibile avviare il <b>simple</b>
                process definito tramite l'applicazione <i>business Central</i> e rilasciato sul server stesso.</p>
            <p><a class="btn btn-default" id="startSimpleProcess" role="button">Start</a></p>
        </div>
        <div class="col-md-4">
            <h2>Dynamic process</h2>
            <p>Tramite le core API e' possibile creare e modificare i processi a runtime. Premesso che questo e' un pattern non consigliato (o <i>anti-pattern</i>)
            in questa sezione e' possibile verificare che il processo viene creato in base a regole esetrne (in questo caso semplicemente spuntando l'opzione <i>Review</i>).</p>
            <div class="checkbox">
                <label>
                    <input id="addReviewCheck" type="checkbox">Add Review Step
                </label>
            </div>
            <p><a class="btn btn-default" id="startDynamicProcess" role="button">Start</a></p>
        </div>
        <div class="col-md-4">
            <h2>Sistema Paghe</h2>
            <p>Questa sezione permette di accedere al sistema pagamenti e rappresenta l'interfaccia grafica di una applicazione terze parti che interagisce con l'<i>Engine</i> del BPM.</p>
            <p><a class="btn btn-default" href="sec_main.jsp" role="button">Open</a></p>
        </div>
    </div>

    <hr>

    <footer>
        <p>&copy; 2016 Red Hat Italy</p>
    </footer>
</div> <!-- /container -->

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/demo.js"></script>

<script type="text/javascript">
    $(document).ready(function(){
        $("#startSimpleProcess").click(function(){
            var theUrl = '/business-central/rest/runtime/it.mef.demo:bpmdemo:1.0/withvars/process/bpmdemo.simple/start';
            $.ajax({
                url: theUrl,
                type: 'POST',
                data: {},
                dataType: 'json',
                complete: function(response, status, xhr){
                    //alert(response.responseText);
                    var data = jQuery.parseJSON(response.responseText);
                    var result = 'Please take note of the ID of the process: ' + data.processInstance.id;
                    alert(result);
                }
            })
        });
        $("#startDynamicProcess").click(function(){
            var theUrl = '/bpmweb/rs/dynamic/build?review=' + $('#addReviewCheck').is(':checked');
            $.ajax({
                url: theUrl,
                type: 'POST',
                data: {},
                dataType: 'json',
                complete: function(response, status, xhr){
                    alert('An instance of a dynamic process has been successfully started.');
                }
            })
        });
        $("#logoutButton").click(function(){
            exitSession();
        });
    });

</script>


</body>
</html>