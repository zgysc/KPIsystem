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

function showWaitingDiag() {
    var divFormData = dojo.byId("formData");
    divFormData.style.display = "block";
    dojo.byId("waitingDialog").style.display = "block";
    resetDialog();
    dojo.byId("waitingTitle").style.display = "block";
    dojo.byId("notifyCPE").style.display = "none";
}

function addFirmware(remoteURL, formNode) {
    isLooping = true;
    theForm = formNode;
    dojo.io.bind({
        url: remoteURL,
        handler: addFirmwareCallback,
        encoding: 'utf-8',
        formNode: formNode
    });
}

function addFirmwareCallback(type, data, evt) {

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
            //            alert(header);
            //            alert(tail);
            dojo.byId("display").innerHTML = data;
            resetDialog();
        }
    }
}

function addFirmwareSecond(remoteURL, formNode) {
    isLooping = true;
    theForm = formNode;
    dojo.io.bind({
        url: remoteURL,
        handler: addFirmwareCallbackSecond,
        encoding: 'utf-8',
        formNode: formNode
    });
}

function addFirmwareCallbackSecond(type, data, evt) {
    if (type == 'error')
        error("Error! Response is " + data.toString());
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            error('Error! Can not parse the response data.');
        else {
            var infoes = data.split("|");
            //alert(header);
            alert(date);
            dojo.byId("version").innerHTML = dojo.string.trim(infoes[1]);
            dojo.byId("description").innerHTML = dojo.string.trim(infoes[2]);
            dojo.byId("uploadtime").innerHTML = dojo.string.trim(infoes[3]);
        }
    }
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
    dojo.byId("formData").style.display = "block";
    dojo.byId("taskid").value = "";
}