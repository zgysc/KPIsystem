var __sto = setTimeout;
window.setTimeout = function(callback, timeout, param) {
    var args = Array.prototype.slice.call(arguments, 2);
    var _cb = function() {
        callback.apply(null, args);
    }
    __sto(_cb, timeout);
}

function error(errorMessage) {
    alert(errorMessage);
}

var STATUS_SUCCESS = 'Succeeded';
var STATUS_FAIL = 'Failed';
var STATUS_DEALING = 'In Progress';
var STATUS_READY = 'Ready';

var deviceList;
function Device(deviceID, taskID) {
    this.deviceID = deviceID;
    this.checkTimer = null;
    this.result = STATUS_SUCCESS;
    this.isfinish = false;
    this.taskID = taskID;
    // check next unfinished task
}

Device.prototype.finish = function () {
//    alert("Device " + this.deviceID + " execute finish")
    this.isfinish = true;
    if (this.checkTimer != null)clearTimeout(this.checkTimer);
    if (this.result == STATUS_SUCCESS)
        dojo.byId('img_' + this.deviceID).src = 'images/passed.gif';
    else dojo.byId('img_' + this.deviceID).src = 'images/failed.gif';
    dojo.byId('status_' + this.deviceID).innerHTML = this.result;
}
// get next unfinished task index of current device
/*Device.prototype.getNextUnfinishedTask = function() {
    for (var i = 0; i < this.taskList.length; i++) {
        if (!this.taskList[i].taskFinished) return i;
    }
    return -1;
}

Device.prototype.setTaskFinish = function (taskid) {
    for (var i = 0; i < this.taskList.length; i ++) {
        if (this.taskList[i].taskID == taskid) {
            this.taskList[i].taskFinished = true;
            //alert("task " + taskList[i].taskID + " finished");
            break;
        }
    }
}*/

/*Device.prototype.checkStatusCallback = function (type, data, evt) {
    //        alert(data);
    if (type == 'error')
        error("Error! Response is " + data);
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            error('Error! Can not parse the response data.');
        else {
            var infoes = data.split("|");
            var taskid = dojo.string.trim(infoes[0]);
            var header = dojo.string.trim(infoes[1]);
            var tail = dojo.string.trim(infoes[2]);
            if (header == 'ready' || header == 'dealing') {
                dojo.byId(taskid + "status").innerHTML = header;
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/loading.gif'/>";
                dojo.byId(taskid + "details").innerHTML = tail;
            } else if (header == 'success') {
                alert("response task " + taskid + " of device " + this.deviceID);

                this.setTaskFinish(taskid);
                //                        if (taskSize == taskSuccess) isLooping = false;
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/passed.gif'/>";
                dojo.byId(taskid + "status").innerHTML = header;
                dojo.byId(taskid + "details").innerHTML = tail + "&nbsp;";
                this.checkStatus();
            } else {
                alert("response task " + taskid + " of device " + this.deviceID);

                this.setTaskFinish(taskid);
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/failed.gif'/>";
                dojo.byId(taskid + "status").innerHTML = header;
                dojo.byId(taskid + "details").innerHTML = tail;
                this.checkStatus();
            }
        }
    }
}*/

function getDeviceByID(deviceID) {
    for (var i = 0; i < deviceList.length; i ++) {
        if (deviceList[i].deviceID == deviceID) {
            return deviceList[i];
        }
    }
    return null;
}

function checkStatusCallback(type, data, evt) {
    if (type == 'error')
        error("Error!");
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            error('Error! Can not parse the response data.');
        else {
            var infoes = data.split("|");
            var deviceID = dojo.string.trim(infoes[0]);
            var device = getDeviceByID(deviceID);
            if (device == null) return;
            var taskid = dojo.string.trim(infoes[1]);
            if (taskid == '-1') return;
            var header = dojo.string.trim(infoes[2]);
            var tail = dojo.string.trim(infoes[3]);
            if (header == STATUS_READY || header == STATUS_DEALING) {
                dojo.byId(taskid + "status").innerHTML = header;
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/loading.gif'/>";
                dojo.byId(taskid + "details").innerHTML = tail;

                // change device status
                if (dojo.byId('status_' + deviceID).innerHTML == STATUS_READY && header == STATUS_DEALING) {
                    dojo.byId('status_' + deviceID).innerHTML = STATUS_DEALING;
                }
            } else if (header == STATUS_SUCCESS) {
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/passed.gif'/>";
                dojo.byId(taskid + "status").innerHTML = header;
                dojo.byId(taskid + "details").innerHTML = tail + "&nbsp;";
                dojo.byId(taskid + "oper").innerHTML = "&nbsp;";
                device.taskID = dojo.string.trim(infoes[4]);
                if (device.taskID == '-1') {
                    device.finish();
                    return;
                }
                checkStatus(device);
            } else {
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/failed.gif'/>";
                dojo.byId(taskid + "status").innerHTML = header;
                dojo.byId(taskid + "details").innerHTML = tail;
                dojo.byId(taskid + "oper").innerHTML = "&nbsp;";
                device.result = STATUS_FAIL;
                device.taskID = dojo.string.trim(infoes[4]);
                if (device.taskID == '-1') {
                    device.finish();
                    return;
                }
                checkStatus(device);
            }
        }
    }
}

function terminateTask(result, taskID, deviceID) {
    dojo.io.bind({
        url: 'ajaxterminatetask.do?deviceID=' + deviceID + '&taskID=' + taskID + "&result=" + result,
        handler: terminateTaskCallback,
        encoding: 'utf-8',
        formNode: dojo.byId("theForm")
    });
}

function terminateTaskCallback(type, data, evt) {
    if (type == 'error')
        error("Error!");
    else {
        var index = data.indexOf('|');
        if (index <= 0)
            error('Error! Can not parse the response data.');
        else {
            var info = data.split('|');
            if(info[0] == 'Error') {
                error(info[1]);
                return;
            }
            if(info.length != 5) {
                error('Error! Can not parse the response data.');
                return;
            }
            var deviceID = dojo.string.trim(info[1]);
            var device = getDeviceByID(deviceID);
            if (device == null) return;
            var taskid = dojo.string.trim(info[2]);
            var result = dojo.string.trim(info[3]);
            var detail = dojo.string.trim(info[4]);
            // force success
            if(result == '1') {
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/passed.gif'/>";
                dojo.byId(taskid + "status").innerHTML = STATUS_SUCCESS;
                dojo.byId(taskid + "details").innerHTML = detail + "&nbsp;";    
            }
            // force fail
            else {
                dojo.byId(taskid + "gif").innerHTML = "<img src='images/failed.gif'/>";
                dojo.byId(taskid + "status").innerHTML = STATUS_FAIL;
                dojo.byId(taskid + "details").innerHTML = detail + "&nbsp;";
                device.result = STATUS_FAIL;
            }
            dojo.byId(taskid + "oper").innerHTML = "&nbsp;";
        }
    }    
}