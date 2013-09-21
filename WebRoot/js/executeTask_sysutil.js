/*
	Javascript used in pages that create and execute task (
	getparameter.jsp, setparameter.jsp).
*/
dojo.require("dojo.widget.validate");
dojo.require("dojo.string");
dojo.require("dojo.io.*");
dojo.require("dojo.event.*");
dojo.widget.validate.ValidationTextbox.prototype.validColor="white";
var isLooping = true;
var STATUS_SUCCESS = 'Succeeded';
var STATUS_FAIL = 'Failed';
var STATUS_DEALING = 'In Progress';
var STATUS_READY = 'Ready';

var MSG_TASK_SUCCESS = 'Test Succeeded';
var MSG_TASK_FAIL = 'Test Failed';
var theForm;

function showWaitingDiag_monitor() {
    backupUtilStatus();
    dojo.byId("waitingDialog").style.display = "block";
    resetDialog();
    dojo.byId("waitingTitle").style.display = "block";
    dojo.byId("notifyCPE").style.display = "none";
//    messageContent
}
function initTaskImp(remoteURL, formNode) {
	isLooping = true;
    theForm=formNode;
    dojo.io.bind({
		url: remoteURL,
		handler: initTaskCallback,
		encoding: 'utf-8',
		formNode: formNode
	});
}
        
function showWaitingDiag_notify() {
    backupUtilStatus();
    dojo.byId("waitingDialog").style.display = "block";
    resetDialog();
    dojo.byId("waitingTitle").style.display = "block";
    dojo.byId('messageContent').innerHTML = "Notifying device,please wait.";
}
function showWaitingDiag_stunconfig(){
   showWaitingDiag_monitor();
}
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
    restoreUtilStatus();
//    dojo.byId("taskid").value = "";
}
function closeDiag1(){
    closeDiag();
    dojo.byId("taskid").value = "";
}
function backupUtilStatus() {
    //alert("backupUtilStatus");
    backupSingleUtil("notify");
    backupSingleUtil("monitor");
    backupSingleUtil("export");
    backupSingleUtil("stunConfig");
//    backupSingleUtil("ping");
}

function restoreUtilStatus() {
    restoreSingleUtil("notify");
    restoreSingleUtil("monitor");
    restoreSingleUtil("export");
    restoreSingleUtil("stunConfig");
//    restoreSingleUtil("ping");
}

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
					+ tail + "<br/>Click <a href='#' onClick='closeDiag1()'>here</a> to close this dialog.";
			} else {
				error(MSG_TASK_FAIL + '<br/><br/>' + tail);
			}
		}
	}
}