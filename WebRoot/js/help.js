function getOffsetPosition(el) {
    var the = el;
    var x = 0;
    var y = 0;
    while (the) {
        if (the.tagName.match(/^[Bb][Oo][Dd][Yy]$/) != null) {
            break;
        }
        x += the.offsetLeft;
        y += the.offsetTop;
        the = the.offsetParent;
    }
    return {x: x, y: y, width: el.offsetWidth, height: el.offsetHeight};
}

function getClientHeight() {
    return document.getElementsByTagName('body')[0].clientHeight;
}

function initDiv() {
    //  var _width="200px";
    //  var _height="20px";
    document.write('<iframe id="framemask" frameborder="0" style="display:none;background-Color:#223322;position:absolute;  z-index:499;  visibility:hidden "></iframe>');
    document.write('<div id="theDiv" style="display:none;POSITION: absolute;background-color:#cce4f7; border-right: 1px solid #6699CC; border-bottom: 1px solid #6699CC; border-top:1px solid #6699CC; border-left:1px solid #6699CC; position:absolute;   z-index:500;  visibility:hidden;cursor:pointer;padding: 5px 5px 5px 5px;font-size:8pt;" onmouseover="showLayer()" onmouseout="closeD()" >');
    //width:'+_width+';
    document.write('</div>');
}
function showD() {
    var scrollTop;
    var scrollHeight;
    var scrollWidth;
    var scrollLeft;
    if (document.documentElement && document.documentElement.scrollTop) {
        scrollTop = document.documentElement.scrollTop;
        scrollHeight = document.documentElement.scrollHeight;
        scrollWidth = document.documentElement.scrollWidth;
        scrollLeft = document.documentElement.scrollLeft;
    } else {
        scrollTop = document.body.scrollTop;
        scrollHeight = document.body.scrollHeight;
        scrollWidth = document.body.scrollWidth;
        scrollLeft = document.body.scrollLeft;
    }
    var args = showD.arguments;
    var posi = getOffsetPosition(document.getElementById(args[0]));
    //imgid
    var _left = posi.x + 10 + 'px';
    var _top = posi.y + 'px';
    document.getElementById('theDiv').innerHTML = args[1];
    //helpMessage
    var divVar = document.getElementById('theDiv');
    divVar.style.display = 'block';
    //alert(scrollTop + '  ' + document.documentElement.scrollHeight + '  ' + posi.y);
    //var imgOffsetBottom = scrollTop - posi.y + 520;
    //alert(imgOffsetBottom);
    /*if(imgOffsetBottom < divVar.offsetHeight) {
        _top = posi.y - (divVar.offsetHeight - imgOffsetBottom) + 'px';
    }*/
    //alert('imgOffsetBottom=' + imgOffsetBottom + ',   divVar.offsetHeight=' + divVar.offsetHeight);
    divVar.style.left = _left;
    divVar.style.top = _top;
    divVar.style.visibility = 'visible';

    var maskVar = document.getElementById('framemask');
    maskVar.style.display = 'block';
    maskVar.style.left = divVar.style.left;
    maskVar.style.top = divVar.style.top;
    maskVar.style.width = divVar.offsetWidth + 'px';
    maskVar.style.height = divVar.offsetHeight + 'px';
    maskVar.style.visibility = 'visible';

    var divOffsetBottom = getClientHeight() - 10 + scrollTop - (posi.y + divVar.offsetHeight);
    //window.frameElement.offsetHeight+window.frameElement.offsetTop  self.pageYOffset
    if (divOffsetBottom < 0) {
        _top = posi.y + divOffsetBottom + 'px';
        divVar.style.top = _top;
        maskVar.style.top = divVar.style.top;
        maskVar.style.height = divVar.offsetHeight + 'px';
    }

    /*var divOffsetRight = 550 + scrollLeft - (posi.x + divVar.offsetWidth);
    if(divOffsetRight < 0) {
        _left = posi.x + divOffsetRight + 'px';
        divVar.style.left = _left;
        maskVar.style.left = divVar.style.left;
        maskVar.style.height = divVar.offsetHeight + 'px';
        maskVar.style.width = divVar.offsetWidth + 'px';
    }*/
}
function showLayer() {
    document.getElementById('theDiv').style.display = 'block';
    document.getElementById('theDiv').style.visibility = 'visible';
    document.getElementById('framemask').style.display = 'block';
    document.getElementById('framemask').style.visibility = 'visible';
}
function closeD() {
    document.getElementById('theDiv').style.display = 'none';
    document.getElementById('theDiv').style.visibility = 'hidden';
    document.getElementById('framemask').style.display = 'none';
    document.getElementById('framemask').style.visibility = 'hidden';

}
initDiv();

function writeImg(id, helpMsg) {
    //	alert('<img id="'+id+'" src="images/help-1.gif" style="cursor:pointer" onmouseover="showD(\''+id+'\', \''+ helpMsg +'\')" onmouseout="closeD()"/>');

    document.write('<img id="' + id + '" src="images/help.gif" style="cursor:pointer;vertical-align:middle" onmouseover="showD(\'' + id + '\', \'' + helpMsg + '\')" onmouseout="closeD()"/>');
}

function writeImg1(id, helpMsg) {
    //	alert('<img id="'+id+'" src="images/help-1.gif" style="cursor:pointer" onmouseover="showD(\''+id+'\', \''+ helpMsg +'\')" onmouseout="closeD()"/>');

    document.write('<img id="' + id + '" src="../images/help.gif" style="cursor:pointer" onmouseover="showD(\'' + id + '\', \'' + helpMsg + '\')" onmouseout="closeD()"/>');
}