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

    <title>Demo BPM Suite - protected page</title>

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
            <a class="navbar-brand" href="index.jsp">Applicazione <b>bpmweb</b></a>
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

<div class="container">
    <h3>Attivita' da prendere in carico</h3>
    <p>La lista dei task assegnati al proprio gruppo di appartenenza:<br>

    <table class="table table-striped" style="width:80%">
        <thead>
        <tr>
            <th width="10%">#</th><th width="25%">date of issue</th><th width="25%">time</th><th width="20%">Task</th><th width="20%">&nbsp;</th>
        </tr>
        </thead>
        <tbody id="availableTaskList">
        </tbody>
        <tfoot>
        <tr>
            <th colspan="6">&nbsp;</th>
        </tr>
        </tfoot>
    </table>

    </p>

    <h3>Attivita' in corso</h3>
    <p>La lista dei task presi in carico:<br>

    <table class="table table-striped" style="width:80%">
        <thead>
        <tr>
            <th width="10%">#</th><th width="25%">date of issue</th><th width="25%">time</th><th width="20%">Task</th><th width="20%">&nbsp;</th>
        </tr>
        </thead>
        <tbody id="claimedTaskList">
        </tbody>
        <tfoot>
        <tr>
            <th colspan="6">&nbsp;</th>
        </tr>
        </tfoot>
    </table>

    </p>

    <hr>
    <footer>
        <p>&copy; 2016 Red Hat Italy</p>
    </footer>

</div> <!-- /container -->

<!-- Modal per TASK Configurazione -->
<div id="praticaConfigurazione" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h3 class="modal-title">ASL - Gestione Sistema Paghe</h3>
            </div>
            <div class="modal-body">
                <h4>Immatricolazione Dipendente</h4>

                <div class="container"></div>

                <form class="form-horizontal" role="form">

                    <input type="hidden" name="taskId" id="cfg_taskId" value=""/>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="cfg_inputName">Nome</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="cfg_inputName" placeholder="nome e cognome"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="cfg_inputCF">CF</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="cfg_inputCF" placeholder="codice fiscale"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="cfg_inputEmail">email</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="cfg_inputEmail" placeholder="indirizzo di posta elettronica"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="cfg_inputTel">tel.</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="cfg_inputTel" placeholder="numero di telefono"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="cfg_inputRole">ruolo</label>
                        <div class="col-sm-10">
                            <select class="selectpicker show-tick form-control" id="cfg_inputRole" title="Selezionare un ruolo...">
                                <option>impiegato</option>
                                <option>quadro</option>
                                <option>dirigente</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="reset" class="btn btn-default" data-dismiss="modal">Annulla</button>
                <button type="submit" class="btn btn-primary" data-dismiss="modal" id="saveConfiguration"><i class="glyphicon glyphicon-ok"></i> Salva</button>
            </div>
        </div>

    </div>
</div>

<!-- Modal per TASK Anagrafe -->
<div id="praticaAnagrafe" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Ministero - Gestione Sistema Paghe</h4>
            </div>
            <div class="modal-body">
                <h5>Immatricolazione Dipendente</h5>

                <form class="form-horizontal" role="form">

                    <input type="hidden" name="taskId" id="ana_taskId" value=""/>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="ana_inputName">Nome</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="ana_inputName" placeholder="nome e cognome"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="ana_inputCF">CF</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="ana_inputCF" placeholder="codice fiscale"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="ana_inputEmail">email</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="ana_inputEmail" placeholder="indirizzo di posta elettronica"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="ana_inputTel">tel.</label>
                        <div class="col-sm-10"><input type="text" class="form-control" id="ana_inputTel" placeholder="numero di telefono"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="reset" class="btn btn-default" data-dismiss="modal">Annulla</button>
                <button type="submit" class="btn btn-primary" data-dismiss="modal" id="saveAnagrafe"><i class="glyphicon glyphicon-ok"></i> Salva</button>
            </div>
        </div>

    </div>
</div>

<!-- Modal per TASK Accettazione -->
<div id="accettazionePratica" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h3 class="modal-title">Amministrazione Centrale - Gestione Sistema Paghe</h3>
            </div>
            <div class="modal-body">
                <h4>Attivazione Sistema Paghe</h4>

                <form class="form-horizontal" role="form">

                    <input type="hidden" name="taskId" id="acc_taskId" value=""/>

                    <div class="container">
                        <h5>Numero di Pratica</h5>
                        <p id="acc_nmr"></p>
                        <h5>Nome</h5>
                        <p id="acc_nome"></p>
                        <h5>Codice Fiscale</h5>
                        <p id="acc_cf"></p>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-danger" data-dismiss="modal" id="rifiuta">Rifiuta</button>
                <button type="submit" class="btn btn-primary" data-dismiss="modal" id="accetta"><i class="glyphicon glyphicon-ok"></i> Aggiungi al Sistema</button>
            </div>
        </div>

    </div>
</div>


<!-- Modal per TASK Inquadramento -->
<div id="praticaInquadramento" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Ministero - Gestione Sistema Paghe</h4>
            </div>
            <div class="modal-body">
                <h5>Completa Immatricolazione</h5>

                <form class="form-horizontal" role="form">

                    <input type="hidden" name="taskId" id="inq_taskId" value=""/>

                    <div class="container">
                        <h5>Numero di Pratica</h5>
                        <p id="imm_nmr"></p>
                        <h5>Nome</h5>
                        <p id="imm_nome"></p>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="inq_ruolo">Livello</label>
                        <div class="col-sm-10">
                            <select class="selectpicker show-tick form-control" id="inq_ruolo" title="Selezionare un ruolo...">
                                <option>impiegato</option>
                                <option>quadro</option>
                                <option>dirigente</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label" for="inq_sede">CF</label>
                        <div class="col-sm-10">
                            <select class="selectpicker show-tick form-control" id="inq_sede" title="Selezionare una sede...">
                                <option>milano</option>
                                <option>roma</option>
                                <option>napoli</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label><input type="checkbox" id="inq_car" value="">Auto Aziendale</label>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="reset" class="btn btn-default" data-dismiss="modal">Annulla</button>
                <button type="submit" class="btn btn-primary" data-dismiss="modal" id="saveInquadramento"><i class="glyphicon glyphicon-ok"></i> Salva</button>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/demo.js"></script>

<script type="text/javascript">

    $(document).ready(function(){
        loadTasks();
        setInterval(loadTasks, 2000);
        $("#saveConfiguration").click(function(){
            completeConfigurationTask();
        });
        $("#saveAnagrafe").click(function(){
            completeAnagrafeTask();
        });
        $("#saveInquadramento").click(function(){
            completeInquadramentoTask();
        });
        $("#accetta").click(function(){
            completeAccettazioneTask(true);
        });
        $("#rifiuta").click(function(){
            completeAccettazioneTask(false);
        });
        $("#logoutButton").click(function(){
            exitSession();
        });
    });

    $(document).on("click", ".claimTask", function () {
        var taskId = $(this).data('id');
        claimTask(taskId);
    });

    $(document).on("click", ".open-praticaConfigurazione", function () {
        var taskId = $(this).data('id');
        $(".modal-body #cfg_taskId").val( taskId );
    });

    $(document).on("click", ".open-praticaAnagrafe", function () {
        var taskId = $(this).data('id');
        $(".modal-body #ana_taskId").val( taskId );
    });

    $(document).on("click", ".open-praticaInquadramento", function () {
        var taskId = $(this).data('id');
        $(".modal-body #inq_taskId").val( taskId );
        formatInquadramentoForm(taskId);
    });

    $(document).on("click", ".open-praticaAccettazione", function () {
        var taskId = $(this).data('id');
        $(".modal-body #acc_taskId").val( taskId );
        formatAccettazioneForm(taskId);
    });


</script>

</body>
</html>