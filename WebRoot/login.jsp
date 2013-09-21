<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mobicloud KPI Management System</title>
<script LANGUAGE="JavaScript">
    <!--
	var form;
    var is_ie = !!(window.attachEvent && !window.opera);
    var is_ie6 = ( is_ie && /msie 6\.0/i.test(navigator.userAgent) );
    function fixPNG(myImage, hand)
    {
        if (hand != null)
        {
            var imgStyle = "display:inline-block;cursor:pointer;" + myImage.style.cssText;
        }
        else
        {
            var imgStyle = "display:inline-block;" + myImage.style.cssText;
        }
        var arVersion = navigator.appVersion.split("MSIE");
        var version = parseFloat(arVersion[1]);

        if ((version >= 5.5) && (version < 7) && (document.body.filters) && (myImage.src) ? myImage.src.substring(myImage.src.length - 3, myImage.src.length).toLowerCase() == "png" : false && myImage.tagName.toUpperCase() == "IMG")
        {
            var imgID = (myImage.id) ? "id='" + myImage.id + "' " : "";
            var imgClass = (myImage.className) ? "class='" + myImage.className + "' " : "";
            var imgTitle = (myImage.title) ? "title='" + myImage.title + "' " : "title='" + myImage.alt + "' ";

            var strNewHTML = "<span " + imgID + imgClass + imgTitle + "style=\"" + "width:" + myImage.width + "px; height:" + myImage.height
                    + "px;" + imgStyle + ";" + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader" + "(src=\'" + myImage.src + "\', sizingMethod='scale');\"></span>";
            myImage.outerHTML = strNewHTML;
        }
    }
    function checkLogin(form) {
        if (form.act.value == 'reset') {
            document.forms[0].reset();
            return false;
        } else {
            if (form.username.value == ''){
            	alert('<bean:message key="page.login.username.null" />');
            	return false;
            }else if(form.password.value == '') {
                alert('<bean:message key="page.login.password.null" />');
                return false;
            }
        }
        return true;
    }

    function setAction(act) {
        //	alert(act);
        document.forms[0].act.value = act;       
    }
    function focus_Text() {
        document.getElementById("username").focus();
    }
    window.onload = function() {
        //resizeWindow();
        if (is_ie6)
        {
            $$("#main img").each(function(node) {
            	if(node.id == "forget"){
            		//pass
            	}else{
                	fixPNG(node, true)
                }
            });
        }

    };

	function forgetpassword(){
		//alert('test');
		form = document.getElementById("form");
	    if (form.username.value == '') {
            alert('<bean:message key="page.login.username.null" />');
            return false;
        }
		setAction('forget');
		//alert('forget');
		form.submit();
	}
    //-->
</script>
<style type="text/css">
    <!--
    html, body {
        height: 100%;
        width: 100%;
    }

    body {
        background-image: url( images/login/body.back.jpg );
    }

    body, td, th {
        font-family: Arial, Helvetica, sans-serif;
    }

    .input_login {
        border: 1px solid #ccc;
        width: 160px;
    }

    .STYLE4 {
        color: #999999;
        font-size: 12px;
    }

    .STYLE1 {
        position: relative;
        width: 631px;
        height: 340px;
        background: url( 'images/login/back.gif' ) no-repeat;
    }

    .STYLE2 {
        position: relative;
        top: 95px;
        left: 10px;
    }

    .STYLE3 {
        position: relative;
        top: 105px;
        left: 52px;
    }
    
    .STYLE5 {
        position: relative;
        top: 115px;
        left: 0px
    }
    
    .STYLE6 {
        position: relative;
        top: 125px;
        left: 20px
    }
    
	.STYLE7 {
        position: relative;
       	font-size:9pt;
       	color:red;
       	top: -13px;
    }

    -->
</style>
</head>


<body style="margin-top:-50px; margin-bottom:0px; margin-left:0px; margin-right:0px;">
<form action="/login/" method="post" onsubmit="return checkLogin(this)" id="form">
    <div style="position:absolute;top:0px;left:0px;width:100%;height:100%">
        <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center">
                    <div id="main" class="STYLE1">

                        <div class="STYLE2">
                        	<input id="username" type="text" name="username" class="input_login"/>
                        </div>
                        <div class="STYLE3">
                        	<input id="password" type="password" name="password" class="input_login"/>
							<img id="forget" style="cursor:pointer;" src=images/login/forgot-password.gif alt="Forgot Password" onClick="forgetpassword()"/>
                        </div>
                        <div class="STYLE5">
                        	<img src="images/login/force-logout.gif"/>&nbsp;&nbsp;
                        	<input type="checkbox" name="kick" value="true" onfocus="this.blur()" />
                        </div>
                        <div class="STYLE6">
                            <input type="image" src="images/login.png"
                                   onClick="setAction('login');" onfocus="this.blur();"/>

                            <input type="hidden" name="act"/>
                        </div>
                        <div class="STYLE7">&nbsp;</div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    
</form>
</body>
</html>