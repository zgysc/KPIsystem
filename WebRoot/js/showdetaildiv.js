function getBodyWidth() {
    var bodyElement = document.getElementsByTagName("body")[0];
    return bodyElement.clientWidth;
}

function initDiv() {
    //  var _width="200px";
    //  var _height="20px";
    document.write('<iframe id="framemask" frameborder="0" style="display:none;background-Color:#223322;position:absolute;  z-index:499;  visibility:hidden "></iframe>');
    document.write('<div id="theDiv" style="display:none; width:400px; POSITION: absolute;background-color:#cce4f7; border-right: 1px solid #6699CC; border-bottom: 1px solid #6699CC; border-top:1px solid #6699CC; border-left:1px solid #6699CC; position:absolute;   z-index:500;  visibility:hidden;padding: 5px 5px 5px 5px;font-size:8pt;overflow-y:auto;scrollbar-face-color:#DEE3E7;scrollbar-highlight-color:#FFFFFF;scrollbar-shadow-color:#DEE3E7;scrollbar-3dlight-color:#D1D7DC;scrollbar-arrow-color:#006699;scrollbar-track-color:#EFEFEF;scrollbar-darkshadow-color:#98AAB1;word-break:break-all;">');
    document.write('<font id="theDiv_content"></font>');
    document.write('<br/>');
    document.write('<div align="center"><a style="cursor:pointer;font-size:10pt;" onclick="closeD()"><u>close</u></a></div>');
    document.write('</div>');
}
function showD() {
    closeD();
    var scrollTop;
    var scrollHeight;
    if (document.documentElement && document.documentElement.scrollTop) {
        scrollTop = document.documentElement.scrollTop;
        scrollHeight = document.documentElement.scrollHeight;
    } else {
        scrollTop = document.body.scrollTop;
        scrollHeight = document.body.scrollHeight;
    }
    var args = showD.arguments;
//    var posi = getOffsetPosition(document.getElementById(args[0]));
    //imgid
    var _top = 100 + 'px';
    document.getElementById('theDiv_content').innerHTML = args[1];
    //helpMessage
    var divVar = document.getElementById('theDiv');
    divVar.style.display = 'block';
    divVar.style.top = scrollTop + 100 + 'px';
    divVar.style.visibility = 'visible';

    if(divVar.offsetHeight > 300) {
        divVar.style.height = 300 + 'px';
//        divVar.style.width = divVar.offsetWidth + 15 + 'px';
    }
    divVar.style.left = (getBodyWidth() - divVar.offsetWidth) / 2 + 'px';
    var maskVar = document.getElementById('framemask');
    maskVar.style.display = 'block';
    maskVar.style.left = divVar.style.left;
    maskVar.style.top = divVar.style.top;
    maskVar.style.width = divVar.offsetWidth + 'px';
    maskVar.style.height = divVar.offsetHeight + 'px';
    maskVar.style.visibility = 'visible';
}

function closeD() {
    document.getElementById('theDiv').style.display = 'none';
    document.getElementById('theDiv').style.visibility = 'hidden';
    document.getElementById('theDiv').style.height = 0;
    document.getElementById('theDiv').style.width = 400;
    document.getElementById('framemask').style.display = 'none';
    document.getElementById('framemask').style.visibility = 'hidden';
}
initDiv();

function writeImg(id, helpMsg) {
    //	alert('<img id="'+id+'" src="images/help-1.gif" style="cursor:pointer" onmouseover="showD(\''+id+'\', \''+ helpMsg +'\')" onmouseout="closeD()"/>');
    document.write('<img id="' + id + '" src="images/viewdetail.gif" alt="Show details" style="cursor:pointer" onclick="showD(\'' + id + '\', \'' + helpMsg + '\')"/>');
}