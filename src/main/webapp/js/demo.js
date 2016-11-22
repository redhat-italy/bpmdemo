function claimTask(taskId) {
    var baseUrl = '/business-central/rest/task/';
    var theUrl = baseUrl + taskId +'/claim';
    $.ajax({
        url: theUrl,
        type: 'POST',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            //alert(response.responseText);
            var data = jQuery.parseJSON(response.responseText);
            console.log("============> Task: " + taskId + " Claim: " + data.status);
        }
    })
    // After the claim we also give the start to the task
    // this should be conditional in relation to claim status returned SUCCESS.
    var theUrl = baseUrl + taskId +'/start';
    $.ajax({
        url: theUrl,
        type: 'POST',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            //alert(response.responseText);
            var data = jQuery.parseJSON(response.responseText);
            console.log("============> Task: " + taskId + " START: " + data.status);
        }
    })
}

function loadTasks() {
    var theUrl = '/business-central/rest/task/query';
    $.ajax({
        url: theUrl,
        type: 'GET',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            var data = jQuery.parseJSON(response.responseText);
            formatTaskList(data);
        }
    })
}

function formatTaskList(data) {
    var ndx = 0;
    $('#availableTaskList').empty();
    $('#claimedTaskList').empty();

    $.each(data.taskSummaryList, function (index, task) {
        var d = new Date(task['created-on']);
        var content = '<tr>';
        content += '<td width="30">'+ task.id + '</td>';
        content += '<td width="110">' + d.toLocaleDateString() + '</td>';
        content += '<td width="100">'+ d.toLocaleTimeString() + '</td>';
        content += '<td width="90">'+ task.name + '</td>';
        if (task.status == "Ready") {
            content += '<td width="80"><button type="button" class="btn btn-default btn-sm claimTask" data-id="' + task.id + '">Prendi in Carico</button></td>';
        } else {
            switch (task.name){
                case 'configurazione':
                    content += '<td width="80"><button type="button" class="btn btn-default btn-sm open-praticaConfigurazione" data-toggle="modal" data-target="#praticaConfigurazione" data-id="' + task.id + '">Apri</button></td>';
                    break;
                case 'anagrafe':
                    content += '<td width="80"><button type="button" class="btn btn-default btn-sm open-praticaAnagrafe" data-toggle="modal" data-target="#praticaAnagrafe" data-id="' + task.id + '">Apri</button></td>';
                    break;
                case 'inquadramento':
                    content += '<td width="80"><button type="button" class="btn btn-default btn-sm open-praticaInquadramento" data-toggle="modal" data-target="#praticaInquadramento" data-id="' + task.id + '">Apri</button></td>';
                    break;
                case 'accettazione':
                    content += '<td width="80"><button type="button" class="btn btn-default btn-sm open-praticaAccettazione" data-toggle="modal" data-target="#accettazionePratica" data-id="' + task.id + '">Apri</button></td>';
                    break;
            }
        }
        content += '</tr>';

        if (task.status == "Ready") {// Add the row to the available task list
            $('#availableTaskList').append(content);
        }
        if (task.status == "InProgress") {
            $('#claimedTaskList').append(content);
        }

    });
}

function completeConfigurationTask() {
    var map_par = false;
    var taskId = $("#cfg_taskId").val().trim();
    var theUrl = '/business-central/rest/task/' + taskId + '/complete?';

    var the_name = $("#cfg_inputName").val();
    the_name = the_name.replace(' ', '+');
    if (the_name) {
        theUrl += 'map_nome_inp=' + the_name;
        map_par = true;
    }

    var the_cf = $("#cfg_inputCF").val().trim();
    if (the_cf) {
        if(map_par){
            theUrl += '&';
        }
        theUrl += 'map_cf_inp=' + the_cf;
        map_par = true;
    }

    var the_email = $("#cfg_inputEmail").val().trim();
    if (the_email) {
        if(map_par){
            theUrl += '&';
        }
        theUrl += 'map_email_inp=' + the_email;
        map_par = true;
    }

    var the_tel = $("#cfg_inputTel").val().trim();
    if (the_tel) {
        if(map_par){
            theUrl += '&';
        }
        theUrl += 'map_telefono_inp=' + the_tel;
        map_par = true;
    }

    var the_role = $("#cfg_inputRole").val().trim();
    if (the_role) {
        if(map_par){
            theUrl += '?';
        }
        theUrl += 'map_tipoContratto_inp=' + the_role;
        map_par = true;
    }

    $.ajax({
        url: theUrl,
        type: 'POST',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            //alert(response.responseText);
            var data = jQuery.parseJSON(response.responseText);
            console.log("============> Task: " + taskId + " Complete TASK: " + data.status);
        }
    })

}

function completeAnagrafeTask() {
    var map_par = false;
    var taskId = $("#ana_taskId").val().trim();
    var theUrl = '/business-central/rest/task/' + taskId + '/complete?';

    var the_name = $("#ana_inputName").val();
    the_name = the_name.replace(' ', '+');
    if (the_name) {
        theUrl += 'map_nome_inp=' + the_name;
        map_par = true;
    }

    var the_cf = $("#ana_inputCF").val().trim();
    if (the_cf) {
        if(map_par){
            theUrl += '&';
        }
        theUrl += 'map_cf_inp=' + the_cf;
        map_par = true;
    }

    var the_email = $("#ana_inputEmail").val().trim();
    if (the_email) {
        if(map_par){
            theUrl += '&';
        }
        theUrl += 'map_email_inp=' + the_email;
        map_par = true;
    }

    var the_tel = $("#ana_inputTel").val().trim();
    if (the_tel) {
        if(map_par){
            theUrl += '&';
        }
        theUrl += 'map_telefono_inp=' + the_tel;
        map_par = true;
    }

    $.ajax({
        url: theUrl,
        type: 'POST',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            //alert(response.responseText);
            var data = jQuery.parseJSON(response.responseText);
            console.log("============> Task: " + taskId + " Complete TASK: " + data.status);
        }
    })

}

function completeAccettazioneTask(isAccepted) {
    var taskId = $("#acc_taskId").val().trim();
    var theUrl = '/business-central/rest/task/' + taskId + '/complete?map_approval_inp=' + isAccepted;

    $.ajax({
        url: theUrl,
        type: 'POST',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            //alert(response.responseText);
            var data = jQuery.parseJSON(response.responseText);
            console.log("============> Task ACCETTAZIONE, ID: " + taskId + " Complete TASK: " + data.status);
        }
    })

}

function completeInquadramentoTask() {
    var taskId = $("#inq_taskId").val().trim();
    var theUrl = '/business-central/rest/task/' + taskId + '/complete?';

    var ruolo = $("#inq_ruolo").val();
    theUrl += 'map_tipoContratto_inp=' + ruolo;

    var sede = $("#inq_sede").val();
    theUrl += 'map_sede_inp=' + sede;

    var car = $("#inq_car").val();
    theUrl += 'map_auto_inp=' + car;

    $.ajax({
        url: theUrl,
        type: 'POST',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            var data = jQuery.parseJSON(response.responseText);
            console.log("============> Task: " + taskId + " Complete TASK: " + data.status);
        }
    })

}

function getProcessVariables(processId) {
    console.log("============> Process: get variables...");
    var theUrl = '/business-central/rest/runtime/it.mef.demo:bpmdemo:1.0/withvars/process/instance/' + processId;
    $.ajax({
        url: theUrl,
        type: 'GET',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            var data = jQuery.parseJSON(response.responseText);
            var numero_pratica = data['variables']['requestID'];
            var nome = data['variables']['nome'];
            var cod_fis = data['variables']['cf'];
            console.log("============> Process: " + processId + " - " + numero_pratica + " - " + nome + " - " + cod_fis);
            $(".modal-body #acc_nmr").html( numero_pratica );
            $(".modal-body #acc_nome").html( nome );
            $(".modal-body #acc_cf").html( cod_fis );
        }
    })
}

function getProcessVariablesForInquadramento(processId) {
    var theUrl = '/business-central/rest/runtime/it.mef.demo:bpmdemo:1.0/withvars/process/instance/' + processId;
    $.ajax({
        url: theUrl,
        type: 'GET',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            var data = jQuery.parseJSON(response.responseText);
            var numero_pratica = data['variables']['requestID'];
            var nome = data['variables']['nome'];
            var cod_fis = data['variables']['cf'];
            $(".modal-body #imm_nmr").html( numero_pratica );
            $(".modal-body #imm_nome").html( nome );
        }
    })
}

function formatAccettazioneForm(taskId) {
    var theUrl = '/business-central/rest/task/query?taskId=' + taskId;

    console.log("============> querying: " + theUrl);
    $.ajax({
        url: theUrl,
        type: 'GET',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            var data = jQuery.parseJSON(response.responseText);
            var processId = data['taskSummaryList'][0]['process-instance-id'];
            getProcessVariables(processId);
        }
    })
}

function formatInquadramentoForm(taskId) {
    var theUrl = '/business-central/rest/task/query?taskId=' + taskId;

    console.log("============> querying: " + theUrl);
    $.ajax({
        url: theUrl,
        type: 'GET',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            var data = jQuery.parseJSON(response.responseText);
            var processId = data['taskSummaryList'][0]['process-instance-id'];
            getProcessVariablesForInquadramento(processId);
        }
    })
}

function exitSession() {
    var theUrl = '/bpmweb/rs/session/logout';
    $.ajax({
        url: theUrl,
        type: 'POST',
        data: {},
        dataType: 'json',
        complete: function(response, status, xhr){
            window.location.href = '/bpmweb';        }
    })

}