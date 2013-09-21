/*
	Javascript used in pages that create and execute task (
	getparameter.jsp, setparameter.jsp).
*/
dojo.require("dojo.widget.validate");
dojo.require("dojo.widget.ComboBox");
dojo.require("dojo.widget.Button");
dojo.require("dojo.widget.Tree");
dojo.require("dojo.widget.TreeRPCController");
dojo.require("dojo.widget.TreeSelector");
dojo.require("dojo.widget.TreeNode");
dojo.require("dojo.widget.TreeContextMenu");
dojo.require("dojo.widget.Select");
dojo.require("dojo.string");
dojo.require("dojo.io.*");
dojo.require("dojo.event.*");
dojo.widget.validate.ValidationTextbox.prototype.validColor="white";
var isLooping = true;
var theForm;
var divStatuses = new Array();
var hdn_taskID;

function showWaitingDiag() {
//backupSingleUtil("atmdiagnostic");
//backupSingleUtil("dsldiagnostic");
//backupSingleUtil("pingdiagnostic");
//backupDivStatus();
//    var divFormTitle = document.getElementsByTagName("div");
//    for(var i=0; i <divFormTitle.length; i++) {
//        if(divFormTitle[i].className == "formTitle")
//            divFormTitle[i].style.display = "none";
//    }

    dojo.byId("waitingDialog").style.display = "block";
	resetDialog();
	dojo.byId("waitingTitle").style.display = "block";
	dojo.byId("notifyCPE").style.display = "none";
}
function showWaitingDiag_ping() {
//    backupDivStatus();

    dojo.byId("waitingDialog").style.display = "block";
    resetDialog();
    dojo.byId("waitingTitle").style.display = "block";
    dojo.byId("notifyCPE").style.display = "none";
}

/*
function backupDivStatus(){
    var divs = document.getElementsByTagName("div");
    divStatuses = divs;
    for(var i=0; i<divs.length; i++) {
        divs[i].old_display = divs[i].style.display;
	//    if(divs[i].id.indexOf("title") == -1){
    	  divs[i].style.display = "none";
	  //  }
    }
}

function restoreDivStatus(){
   for(var j=0; j<divStatuses.length; j++) {
    	 var _divOld = divStatuses[j];
    	 _divOld.style.display = _divOld.old_display;
    	    }
}
*/

/*
function backupSingleUtil(utilName) {
    var titleDiv = dojo.byId("titleDiv_" + utilName);
    var dataDiv = dojo.byId("dataDiv_" + utilName);
    titleDiv.old_display = titleDiv.style.display;
    titleDiv.style.display = "none";
    dataDiv.old_display = dataDiv.style.display;
    dataDiv.style.display = "none";
}

function restoreSingleUtil(utilName) {
    //alert(utilName);
    var titleDiv = dojo.byId("titleDiv_" + utilName);
    var dataDiv = dojo.byId("dataDiv_" + utilName);
    titleDiv.style.display = titleDiv.old_display;
    //alert(titleDiv.style.display);
    dataDiv.style.display = dataDiv.old_display;
    //alert(dataDiv.style.display);
}
*/

function showDownloadDiag() {
	dojo.byId("waitingDialog").style.display = "block";
	resetDialog();
	dojo.byId("waitingTitle").style.display = "block";
	dojo.byId("notifyCPE").style.display = "none";
}

function initTaskImp(remoteURL, formNode) {
	isLooping = true;
	theForm = formNode;
	dojo.io.bind({
		url: remoteURL,
		handler: initTaskCallback,
		encoding: 'utf-8',
		formNode: formNode
	});
}

/*
function initTaskCallback(type, data, evt) {
	if (type == 'error')
		error("Error! Response is " + data.toString());
	else {
		var index = data.indexOf('|');
		if (index <= 0)
			error('Error! Can not parse the response data.');
		else {
			var header = dojo.string.trim(data.substr(0, index));
			var tail = dojo.string.trim(
				data.substring(index + 1, data.length));
			if (header == 'OK') {
			    if(diagnosticType == "DSL Diagnostic"){
			        
			    }
				hdn_taskID.value = tail;
				dojo.byId('messageContent').innerHTML =
					'Executing task, please wait or click <a href="#" onClick="notifyCPE();" style="font-size:10pt">here</a> to notify CPE.';

				//	Set a timer, check the status of task every 5 seconds
				checkStatus();
			} else
				error('Error! ' + tail);
		}
	}
}
*/

var temp = null;
function checkStatus() {
    if(temp != null) clearTimeout(temp);
    if (isLooping) {
		dojo.io.bind({
			url: 'checkstatus.do',
			handler: checkStatusCallback,
			encoding: 'utf-8',
			formNode: theForm
		});

		temp = setTimeout('checkStatus()', 5000);
	}
}

/*
function checkStatusCallback(type, data, evt) {
	if (type == 'error')
		error("Error! Response is " + data);
	else {
		var index = data.indexOf('|');
		if (index <= 0)
			error('Error! Can not parse the response data.');
		else {
			var header = dojo.string.trim(data.substr(0, index));
			var tail = dojo.string.trim(
				data.substring(index + 1, data.length));
			//alert(header);
			//alert(tail);

			if (header == 'ready' || header == 'dealing') {
				resetDialog();
				dojo.byId('waitingTitle').style.display = 'block';
				dojo.byId('messageContent').innerHTML =
					'Executing task, please wait or click <a href="#" onClick="notifyCPE();" style="font-size:10pt">here</a> to notify CPE.';

				dojo.byId('taskStatus').style.display = 'block';
				dojo.byId('taskStatusContent').innerHTML = tail;
			} else if (header == 'success') {
                isLooping = false;
                resetDialog();
				dojo.byId('succeedTitle').style.display = 'block';
				dojo.byId('succeedContent').innerHTML = 'Execute task successfully!<br/><br/>'
					+ tail + "<br/>Click <a href='#' onClick='closeDiag()'>here</a> to close this dialog.";
			} else {
				error('Failed to execute task.<br/><br/>' + tail);
			}
		}
	}
}
*/

/*
function notifyCPE() {
	isLooping = false;
	//alert("notifing cpe...");
	resetDialog();
	dojo.byId("waitingTitle").style.display = "block";
	dojo.byId("taskStatus").style.display = "block";
	dojo.byId("notifyCPE").style.display = "block";

	dojo.byId("notifyCPEContent").innerHTML = 'Notifying CPE, please wait';

	//alert("connect to server...");
    dojo.io.bind({
        url: 'notifycpe.do',
        handler: notifyCPECallback,
        encoding: 'utf-8',
        formNode: theForm,
        timeoutSeconds: 5,
        timeout: function(type) {
            dojo.byId('notifyCPEContent').innerHTML =
            '<span style="color:red">Notify device timeout.</span>'
        }
    });
}

function notifyCPECallback(type, data, evt) {
	if (type == 'error')
		dojo.byId('notifyCPEContent').innerHTML =
			'<span style="color:red">Notify device failed. Reason is get invalid response.</span>';
	else {
		var index = data.indexOf('|');
		if (index <= 0)
			dojo.byId('notifyCPEContent').innerHTML =
				'<span style="color:red">Notify device failed. Reason is: can not parse the response data.</span>';
		else {
			var header = dojo.string.trim(data.substr(0, index));
			var tail = dojo.string.trim(
				data.substring(index + 1, data.length));
			//	alert(header);
			//	alert(tail);
			if (header == 'OK') {
				//	dojo.byId('action').value = 'checkStatus';
				dojo.byId('notifyCPEContent').innerHTML = 'Notify device successfully.';
			} else
				dojo.byId('notifyCPEContent').innerHTML =
					'<span style="color:red">Notify device failed. Reason is: ' +
					tail + '</span>';
		}
	}

	isLooping = true;
	checkStatus();
}
*/

function error(msg) {
	isLooping = false;
	resetDialog();
	dojo.byId("errorTitle").style.display = "block";
	var content = msg + "<br>Click <a href='#' onClick='closeDiag()'>here</a> to close this dialog.";
	dojo.byId("errorContent").innerHTML = content;
}

function resetDialog() {
	dojo.byId("waitingTitle").style.display = "none";
	dojo.byId("errorTitle").style.display = "none";
	dojo.byId("succeedTitle").style.display = "none";
	dojo.byId("taskStatus").style.display = "none";
	//	dojo.byId("notifyCPE").style.display = "none";
}

function closeDiag() {
	dojo.byId("waitingDialog").style.display = "none";
//	restoreSingleUtil("atmdiagnostic");
//	restoreSingleUtil("dsldiagnostic");
//	restoreSingleUtil("pingdiagnostic");
	restoreDivStatus();

	hdn_taskID.value = "";

}
