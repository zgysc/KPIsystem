var waitingMessage = "Processing,please wait for a momment";
var isUsingTask = false;
var successMessage = 'Action completely! Redirecting now';
var taskReadyDefaultMessage = 'Test Initializing';
var taskDealingDefaultMessage = 'Test in progress';
var taskSuccessDefaultMessage;
var taskFailedDefaultMessage;
var redirectUrl = 'null';//when
var theForm;

SimpleAjaxAction = function(){
}

SimpleAjaxAction.prototype.openConnection =function(url,formNode,callBackHandler){
    this.callBackhandler = callBackHandler;
    if(!this.callBackhandler || this.callBackhandler == undefined){
        this.callBackhandler = defaultCallBackHandler;
    }
    dojo.io.bind({
        url:url,
        handler:this.callBackhandler,
        encoding:'utf-8',
        formNode:formNode
    });
}

function defaultCallBackHandler(type,data,evt){
    if (type == 'error')
        error("Error! Response is " + data);
    else{
        var index = data.indexOf('|');
					if (index <= 0)
            error('Error! Can not parse the response data.');
        else {
            var infoes = data.split("|");
            var taskid = dojo.string.trim(infoes[1]);
            var header = dojo.string.trim(infoes[0]);
            if (header == 'OK') {
            	var div_showStatus = document.getElementById('div_showStatus');
            	div_showStatus.style.display = "block";
            	var status = document.getElementById('status');
            	if(isUsingTask){
            	    var div = document.createElement('div');
            	    div.innerHTML = waitingMessage;
            	    status.appendChild(div);
            	    var hdn_taskid = document.getElementById('taskid');
            	    hdn_taskid.value = taskid;
            	    showTaskStatus();
            	    checkStatus();
            	}else {
            	    var div = document.createElement('div');
            	    div.innerHTML = successMessage;
            	    div.setAttribute('id','div_successMessage');
            	    var oldDiv = document.getElementById('div_successMessage');
            	    status.appendChild(oldDiv);
            	    setTimeout(status.removeChild(div),3000);
            	    if(redirectUrl != 'null'){
            	      	setTimeout('theForm.action = redirectUrl;theForm.submit();',3000);
            	    }
                	}
            	}
            }
        }
}

var isLooping = true;
var timer;
function checkStatus() {
	if (isLooping) {
		dojo.io.bind({
			url: 'checkstatus.do',
			handler: checkStatusCallback,
			encoding: 'utf-8',
			formNode: theForm
		});

		timer = setTimeout('checkStatus()', 5000);
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
			var taskStatus = document.getElementById('div_showTaskStatus');
			if (header == 'ready') {
			    if(!taskReadyDefaultMessage){
			        taskReadyDefaultMessage = tail;
			    }
				taskStatus.innerHTML = taskReadyDefaultMessage;
			}else if (header == 'dealing') {
			    if(!taskDealingDefaultMessage){
			        taskDealingDefaultMessage = tail;
			    }
				taskStatus.innerHTML = taskDealingDefaultMessage;
			}else if (header == 'success') {
					resetTaskStatus();
					var status;
					if(!successMessage){
				     successMessage = tail;
				 }
					if(redirectUrl != 'null'){
    				 status = document.getElementById('status');
    			  	status.innerHTML = successMessage;
					}
    		 else 
    		      finish(successMessage);

       	isLooping = false;
       	clearTimeout(timer);
       	if(redirectUrl != 'null'){
       	    	setTimeout('theForm.action = redirectUrl;theForm.submit();',3000);
       	}
      } else {
          tail = tail.replace(new RegExp("<[/]*b>","gm"),"");
     				error(taskFailedDefaultMessage + tail);
     				if(redirectUrl != 'null')
    			     	setTimeout('theForm.action = redirectUrl;theForm.submit();',3000);
				
			}
		}
	}
}

function error(errorMessage){
		 var status = document.getElementById('div_showStatus');
		 status.style.display = "none";
		 var div_finishMessage = document.getElementById('div_finishMessage');
    	div_finishMessage.innerHTML = errorMessage;	
    	resetTaskStatus();
}
function finish(finishMessage){
    		 var status = document.getElementById('div_showStatus');
		 status.style.display = "none";
    var div_finishMessage = document.getElementById('div_finishMessage');
    div_finishMessage.style.display = "block";
    	div_finishMessage.innerHTML = finishMessage;	
}
function showTaskStatus(){
	var div_showTaskStatus = document.getElementById('div_showTaskStatus');
	div_showTaskStatus.style.display = "block";
}

function resetTaskStatus(){
	var div_showTaskStatus = document.getElementById('div_showTaskStatus');
	div_showTaskStatus.style.display = "none";	
}
 
 function resetAll(){
     var status = document.getElementById('status');
     status.innerHTML = '';
     var div_showStatus = document.getElementById("div_showStatus");
     div_showStatus.style.display = "none";
     var div_finishMessage = document.getElementById('div_finishMessage');
     div_finishMessage.innerHTML = '';
          div_finishMessage.style.display = "none";
     var div_showTaskStatus = document.getElementById('div_showTaskStatus');
     div_showTaskStatus.style.display = "none";
     isLooping = true;
 }  

