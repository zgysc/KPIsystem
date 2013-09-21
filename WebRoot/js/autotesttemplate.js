var requestFrom;
var theForm;
var parameters;
function saveTemplate() {
    var deviceID = document.getElementById("deviceID");
    if (parameters != undefined && !(deviceID.value == "" || (parameters.options.length == 0))) {
        if (parameters != undefined) {
            for (var i = 0; i < parameters.options.length; i++) {
                parameters.options[i].selected = true;
            }
        }
        var theForm = document.forms[0];
        theForm.action = "savetemplate.do?requestfrom=" + requestFrom;
        theForm.submit();
    }
}

