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

function showWaitingDiag() {
//	var divFormData = dojo.byId("formData");
//	divFormData.style.display = "none";
    var divFormTitle = document.getElementsByTagName("div");
    for(var i=0; i <divFormTitle.length; i++) {
        if(divFormTitle[i].className == "formTitle")
            divFormTitle[i].style.display = "none";
        if(divFormTitle[i].className == 'formData')
            divFormTitle[i].style.display = 'none';

        // extra
        if(divFormTitle[i].canhide == 'true')
            divFormTitle[i].style.display = 'none';
    }

    dojo.byId("waitingDialog").style.display = "block";
	resetDialog();
	dojo.byId("waitingTitle").style.display = "block";
	dojo.byId("notifyCPE").style.display = "none";
}

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

var STATUS_SUCCESS = 'Succeeded';
var STATUS_FAIL = 'Failed';
var STATUS_DEALING = 'In Progress';
var STATUS_READY = 'Ready';

var MSG_TASK_SUCCESS = 'Test Succeeded';
var MSG_TASK_FAIL = 'Test Failed';

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
			//alert(header);
			//alert(tail);

			if (header == 'OK') {
				theForm.taskid.value = tail;
				dojo.byId('messageContent').innerHTML =
					'Executing test, please wait or click <a href="#" onClick="javascript:notifyCPE()" style="font-size:10pt">here</a> to notify CPE.';

				//	Set a timer, check the status of task every 5 seconds
				checkStatus();
			} else
				error('Error! ' + tail);
		}
	}
}
var temp = null;
function checkStatus() {
    if(temp != null) clearTimeout(temp);
//    alert(theForm.id);
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

			if (header == STATUS_READY || header == STATUS_DEALING) {
				resetDialog();
				dojo.byId('waitingTitle').style.display = 'block';
				dojo.byId('messageContent').innerHTML =
					'Executing test, please wait or click <a href="#" onClick="javascript:notifyCPE()" style="font-size:10pt">here</a> to notify CPE.';

				dojo.byId('taskStatus').style.display = 'block';
				dojo.byId('taskStatusContent').innerHTML = tail;
			} else if (header == STATUS_SUCCESS) {
                isLooping = false;
                resetDialog();
				dojo.byId('succeedTitle').style.display = 'block';
				dojo.byId('succeedContent').innerHTML = MSG_TASK_SUCCESS + '<br/><br/>'
					+ tail + "<br/>Click <a href='#' onClick='closeDiag()'>here</a> to close this dialog.";
			} else {
				error(MSG_TASK_FAIL + '<br/><br/>' + tail);
			}
		}
	}
}

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
	//	dojo.byId("formData").disabled = false;
	//dojo.byId("action").value = "initTask";
    var divFormTitle = document.getElementsByTagName("div");
    for(var i=0; i <divFormTitle.length; i++) {
        if(divFormTitle[i].className == "formTitle")
            divFormTitle[i].style.display = "";
        if(divFormTitle[i].className == 'formData')
            divFormTitle[i].style.display = 'block';
        //dojo.byId("formData").style.display = "block";
        
        // extra
        if(divFormTitle[i].canhide == 'true')
            divFormTitle[i].style.display = 'block';
    }
	dojo.byId("taskid").value = "";
}