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
dojo.widget.validate.ValidationTextbox.prototype.validColor = "white";
var isLooping = true;
var theForm;
var taskId;
var deviceID;

function showWaitingDiag_get() {
    dojo.byId("formData").style.display = "none";
    dojo.byId("formDataTitle").style.display = "none";
    dojo.byId("formData2").style.display = "none";
    dojo.byId("formData2Title").style.display = "none";
    dojo.byId("waitingDialog").style.display = "block";
    resetDialog();
    dojo.byId("waitingTitle").style.display = "block";
    dojo.byId("notifyCPE").style.display = "none";
}

function showWaitingDiag_set() {
    dojo.byId("formData").style.display = "none";
    dojo.byId("formData2").style.display = "none";
    dojo.byId("formDataTitle").style.display = "none";
    dojo.byId("formData2Title").style.display = "none";
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

function initTaskImp_get(remoteURL, formNode) {
    isLooping = true;
    theForm = formNode;
    deviceID = theForm.deviceID.value;
    //    alert("deviceID is "  + deviceID);
    //    alert("deviceID is  sadsadas"  );
    dojo.io.bind({
        url: remoteURL,
        handler: initTaskCallback_get,
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

function initTaskCallback_get(type, data, evt) {
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
            //			alert(header);
            //			alert(tail);

            if (header == 'OK') {
                dojo.byId('taskid').value = tail;
                taskId = tail;
                dojo.byId('messageContent').innerHTML =
                'Executing test, please wait or click <a href="#" onClick="notifyCPE_get();" style="font-size:10pt">here</a> to notify CPE.';

                //	Set a timer, check the status of task every 5 seconds
                checkStatus_get();
            } else
                error('Error! ' + tail);
        }
    }
}

function checkStatus_get() {
    if (isLooping) {
        dojo.io.bind({
            url: 'checkstatus.do',
            handler: checkStatusCallback_get,
            encoding: 'utf-8',
            formNode: theForm
        });

        setTimeout('checkStatus_get()', 5000);
    }
}

function checkStatusCallback_get(type, data, evt) {
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
                'Executing test, please wait or click <a href="#" onClick="notifyCPE_get();" style="font-size:10pt">here</a> to notify CPE.';

                dojo.byId('taskStatus').style.display = 'block';
                dojo.byId('taskStatusContent').innerHTML = tail;

            } else if (header == STATUS_SUCCESS) {
                resetDialog();
                isLooping = false;
                dojo.byId('succeedTitle').style.display = 'block';
                dojo.byId('succeedContent').innerHTML = MSG_TASK_SUCCESS + '<br/><br/>'
                        + tail + "<br/>Click <a href='#' onClick='closeDiag()'>here</a> to close this dialog."
                        + "<br/>Click <a href='#' onClick='saveParamValue()'>here</a> to save the value.";
            } else {
                error(MSG_TASK_FAIL + '<br/><br/>' + tail);
            }
        }
    }
}

function initTaskImp_set(remoteURL, formNode) {
    isLooping = true;
    theForm = formNode;
    deviceID = theForm.deviceID.value;
    dojo.io.bind({
        url: remoteURL,
        handler: initTaskCallback_set,
        encoding: 'utf-8',
        formNode: formNode
    });
}

function initTaskCallback_set(type, data, evt) {
    if (type == 'error')
        error("Error! Response is " + data.toString());
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            error('Error! Can not parse the response data.');
        else {
            var header = dojo.string.trim(data.substr(0, index));
            var tail = dojo.string.trim(data.substring(index + 1, data.length));

            if (header == 'OK') {
                dojo.byId('taskid').value = tail;
                taskId = tail;
                dojo.byId('messageContent').innerHTML =
                'Executing test, please wait or click <a href="#" onClick="notifyCPE_set();" style="font-size:10pt">here</a> to notify CPE.';

                //	Set a timer, check the status of task every 5 seconds
                checkStatus_set();
            } else
                error('Error! ' + tail);
        }
    }
}

function checkStatus_set() {
    if (isLooping) {
        dojo.io.bind({
            url: 'checkstatus.do',
            handler: checkStatusCallback_set,
            encoding: 'utf-8',
            formNode: theForm
        });

        setTimeout('checkStatus_set()', 5000);
    }
}

function checkStatusCallback_set(type, data, evt) {
    //    alert("check status call back");
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
                'Executing test, please wait or click <a href="#" onClick="notifyCPE_set();" style="font-size:10pt">here</a> to notify CPE.';

                dojo.byId('taskStatus').style.display = 'block';
                dojo.byId('taskStatusContent').innerHTML = tail;

            } else if (header == STATUS_SUCCESS) {
                resetDialog();
                isLooping = false;
                dojo.byId('succeedTitle').style.display = 'block';
                dojo.byId('succeedContent').innerHTML = MSG_TASK_SUCCESS + '<br/><br/>'
                        + tail + "<br/>Click <a href='#' onClick='closeDiag()'>here</a> to close this dialog.";
            } else {
                error(MSG_TASK_FAIL + '<br/><br/>' + tail);
            }
        }
    }
}

// constants
var msg_InvalidResponse = 'Invalid response, notify device failed.';
var msg_ParseError = 'Parse response error, notify device failed.';
var msg_NotifyFailed = 'Notify device failed.';
var msg_NotifySucceeded = 'Notify device succeeded.';
var msg_NotifyTimeout = 'Notify device timeout.';

var inNotify_get = false;
function notifyCPE_get() {
    if(inNotify_get) return;
    isLooping = false;
    resetDialog();
    dojo.byId("waitingTitle").style.display = "block";
    dojo.byId("taskStatus").style.display = "block";
    dojo.byId("notifyCPE").style.display = "block";

    dojo.byId("notifyCPEContent").innerHTML = 'Notifying CPE, please wait';

    dojo.io.bind({
        url: 'notifycpe.do',
        handler: notifyCPECallback_get,
        encoding: 'utf-8',
        formNode: theForm,
        timeoutSeconds: 5,
        timeout: function(type) {
            dojo.byId('notifyCPEContent').innerHTML =
			    '<span style="color:red">' + msg_NotifyTimeout + '</span>';
            inNotify_get = false;
        }
    });
    inNotify_get = true;
}

function notifyCPECallback_get(type, data, evt) {
    if (type == 'error')
        dojo.byId('notifyCPEContent').innerHTML = '<span style="color:red">' + msg_InvalidResponse + '</span>';
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            dojo.byId('notifyCPEContent').innerHTML = '<span style="color:red">' + msg_ParseError + '</span>';
        else {
            var header = dojo.string.trim(data.substr(0, index));
            var tail = dojo.string.trim(data.substring(index + 1, data.length));
            if (header == 'OK') {
                dojo.byId('notifyCPEContent').innerHTML = msg_NotifySucceeded;
            } else
                dojo.byId('notifyCPEContent').innerHTML =
                '<span style="color:red">' + msg_NotifyFailed + ' Reason is: ' + tail + '</span>';
        }
    }

    inNotify_get = false;
    isLooping = true;
    checkStatus_get();
}

var inNotify_set = false;
function notifyCPE_set() {
    if(inNotify_set) return;
    isLooping = false;
    resetDialog();
    dojo.byId("waitingTitle").style.display = "block";
    dojo.byId("taskStatus").style.display = "block";
    dojo.byId("notifyCPE").style.display = "block";

    dojo.byId("notifyCPEContent").innerHTML = 'Notifying CPE, please wait';

    dojo.io.bind({
        url: 'notifycpe.do',
        handler: notifyCPECallback_set,
        encoding: 'utf-8',
        formNode: theForm,
        timeoutSeconds: 5,
        timeout: function(type) {
            dojo.byId('notifyCPEContent').innerHTML =
			    '<span style="color:red">' + msg_NotifyTimeout + '</span>'
            inNotify_set = false;
        }
    });
    inNotify_set = true;
}

function notifyCPECallback_set(type, data, evt) {
    if (type == 'error')
        dojo.byId('notifyCPEContent').innerHTML =
        '<span style="color:red">' + msg_InvalidResponse + '</span>';
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            dojo.byId('notifyCPEContent').innerHTML =
            '<span style="color:red">' + msg_ParseError + '</span>';
        else {
            var header = dojo.string.trim(data.substr(0, index));
            var tail = dojo.string.trim(data.substring(index + 1, data.length));
            if (header == 'OK') {
                dojo.byId('notifyCPEContent').innerHTML = msg_NotifySucceeded;
            } else
                dojo.byId('notifyCPEContent').innerHTML =
                '<span style="color:red">' + msg_NotifyFailed + ' Reason is: ' + tail + '</span>';
        }
    }

    inNotify_set = false;
    isLooping = true;
    checkStatus_set();
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
    var divFormTitle = document.getElementsByTagName("div");
    for (var i = 0; i < divFormTitle.length; i++) {
        if (divFormTitle[i].className == "formTitle")
            divFormTitle[i].style.display = "";
    }
    dojo.byId("formData").style.display = "block";
    dojo.byId("formDataTitle").style.display = "block";
    dojo.byId("formData2").style.display = "block";
    dojo.byId("formData2Title").style.display = "block";
    dojo.byId("taskid").value = "";
}

function saveParamValue() {
    window.location.href = "downloadconfigfileparam.do?taskid=" + taskId + "&&deviceID=" + deviceID;
}