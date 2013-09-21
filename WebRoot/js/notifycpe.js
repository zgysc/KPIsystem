dojo.require("dojo.io.*");

// constants
var msg_InvalidResponse = 'Invalid response, notify device failed.';
var msg_ParseError = 'Parse response error, notify device failed.';
var msg_NotifyFailed = 'Notify device failed.';
var msg_NotifySucceeded = 'Notify device succeeded.';
var msg_NotifyTimeout = 'Notify device timeout.';

// multi device in same page
var SEPARATOR = ':';
var deviceNotificationList = '';

function checkDeviceInNotification(sn) {
    var snlist = deviceNotificationList.split(SEPARATOR);
    for(var i = 0; i < snlist.length; i ++) {
        if(snlist[i] == sn) return true;
    }
    return false;     
}

function addDeviceInNotification(sn) {
    deviceNotificationList += (sn + SEPARATOR);
}

function delDeviceInNotification(sn) {
    var snlist = deviceNotificationList.split(SEPARATOR);
    deviceNotificationList = '';
    for(var i = 0; i < snlist.length; i ++) {
        if(snlist[i] != sn) addDeviceInNotification(snlist[i]);
    }
}

function clearAll() {
    deviceNotificationList = '';
}

function ConnectionRequest(sn) {
    this.sn = sn;

    this.notify = function() {
        if(checkDeviceInNotification(this.sn)) return;

//        alert('notify ' + sn);

        var deviceID;
        var oForm = document.forms[0];
        if (sn == null || sn.length < 1) {
            deviceID = oForm.deviceID.value;
        }
        else deviceID = sn;
        var temp = this;
        dojo.io.bind({
            url: 'notifycpe.do?deviceID=' + deviceID,
            handler: function(type, data, evt){temp.notifyCallback(type, data, evt)},
            encoding: 'utf-8',
            formNode: oForm,
            timeoutSeconds: 5,
            timeout: function(type) {
                alert(msg_NotifyTimeout);
                clearAll();
            }
        });
        addDeviceInNotification(this.sn);
    }

    this.notifyCallback = function(type, data, evt) {
        if (type == 'error')
            alert(msg_InvalidResponse);
        else {
            var index = data.indexOf('|');
            if (index <= 0)
                alert(msg_ParseError);
            else {
                var header = dojo.string.trim(data.substr(0, index));
                var tail = dojo.string.trim(data.substring(index + 1, data.length));
                if (header == 'OK') {
                    alert(msg_NotifySucceeded + '\r\nResponse is:' + tail);
                } else if (header == 'Fail') {
                    alert(msg_NotifyFailed + '\r\n' + tail);
                } else {
                    alert('Notify device failed.\r\nReason is:' + tail);
                }
            }
        }
        delDeviceInNotification(this.sn);
//        alert('response ' + sn);
    }
}

function notifyDevice(sn) {
    /*var deviceID;
    var oForm = document.forms[0];
    if (sn == null || sn.length < 1) {
        deviceID = oForm.deviceID.value;
    }
    else deviceID = sn;
    dojo.io.bind({
        url: 'notifycpe.do?deviceID=' + deviceID,
        handler: notifyDeviceCallback,
        encoding: 'utf-8',
        formNode: oForm,
        timeoutSeconds: 5,
        timeout: function(type) {alert(msg_NotifyTimeout);}
    });*/
    new ConnectionRequest(sn).notify();
}

/*
function notifyDeviceCallback(type, data, evt) {
    if (type == 'error')
        alert(msg_InvalidResponse);
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            alert(msg_ParseError);
        else {
            var header = dojo.string.trim(data.substr(0, index));
            var tail = dojo.string.trim(data.substring(index + 1, data.length));
            if (header == 'OK') {
                alert(msg_NotifySucceeded + '\r\nResponse is:' + tail);
            } else if (header == 'Fail') {
                alert(msg_NotifyFailed + '\r\n' + tail);
            } else {
                alert('Notify device error.\r\nReason is:' + tail);
            }
        }
    }
}
*/


/////////////////////////////////////////////////////////////////////////////
var inNotify = false;
function notifyCPE() {
    if(inNotify) return;
//	isLooping = false;
	resetDialog();
	dojo.byId("waitingTitle").style.display = "block";
	dojo.byId("taskStatus").style.display = "block";
	dojo.byId("notifyCPE").style.display = "block";

	dojo.byId("notifyCPEContent").innerHTML = 'Notifying CPE, please wait';

    dojo.io.bind({
        url: 'notifycpe.do',
        handler: notifyCPECallback,
        encoding: 'utf-8',
        formNode: theForm,
        timeoutSeconds: 5,
        timeout: function(type) {
            dojo.byId('notifyCPEContent').innerHTML =
            '<span style="color:red">' + msg_NotifyTimeout + '</span>';
            inNotify = false;
        }
    });
    inNotify = true;
}

function notifyCPECallback(type, data, evt) {
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
			var tail = dojo.string.trim(
				data.substring(index + 1, data.length));
			if (header == 'OK') {
				dojo.byId('notifyCPEContent').innerHTML = msg_NotifySucceeded;
			} else
				dojo.byId('notifyCPEContent').innerHTML =
					'<span style="color:red">' + msg_NotifyFailed + ' Reason is: ' + tail + '</span>';
		}
	}

//	isLooping = true;

    inNotify = false;
    checkStatus();
}
/////////////////////////////////////////////////////////////////////////////
