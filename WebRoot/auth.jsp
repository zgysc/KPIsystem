<%--
  Created by IntelliJ IDEA.
  User: richl
  Date: 2007-6-21
  Time: 10:51:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="tags/struts-html.tld" prefix="html" %>
<%@ taglib uri="tags/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="tags/iopcenter.tld" prefix="iop" %>
<iop:validateSession/>
<html>
<head>
    <title><bean:message key="auth.title"/></title>
    <script src="js/prototype.js"></script>
    <style type="text/css">
        body {
            background-image: url( images/login/body.back.jpg );
        }

        .STYLE4 {
            color: #999999;
            font-size: 12px;
        }

        .STYLE1 {
            position: relative;
            width: 631px;
            height: 340px;
            background: url( 'images/auth/back.gif' ) no-repeat;
        }

        .STYLE2 {
            position: relative;
            top: 115px;
            left: 60px;
        }

        .STYLE3 {
            position: relative;
            top: 130px;
        }
    </style>

    <script type="text/javascript">
        var is_ie = !!(window.attachEvent && !window.opera);
        var is_ie6 = ( is_ie && /msie 6\.0/i.test(navigator.userAgent) );
        function fixPNG(myImage, hand)
        {
            if (hand != null) {
                var imgStyle = "display:inline-block;cursor:pointer;" + myImage.style.cssText;
            } else {
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
        function focus_Text() {
            document.getElementById("lk").focus();
        }
        window.onload = function() {
            if (is_ie6)
            {
                $$("#main img").each(function(node) {
                    fixPNG(node, true)
                });
            }
            focus_Text();
        };

        var close_flag = 'true';
        var chk_auth_ret = false;
        function validateLicenseKey() {
            if (document.forms[0].key.value.length == 81) {
                return true;
            } else {
                alert('<bean:message key="error.uen.auth.license.invalid" />');
                return false;
            }
        }
        function submit_page() {
            var k = document.forms[0].key;
            if (k.value == '' || k.value.length == 0) {
                alert('<bean:message key="auth.license.key.null" /> ');
                chk_auth_ret = false;
            } else {
                chk_auth_ret = validateLicenseKey();
                if (chk_auth_ret) {
                    close_flag = 'false';
                }
            }
        }
        function close_page() {
            chk_auth_ret = false;
            window.location.href = "logout.do";
        }
        function checkAuth() {
            return chk_auth_ret;
        }
        function logout() {
            window.location.href = "logout.do";
        }

        function unload() {
            if (!chk_auth_ret) logout();
        }
    </script>
</head>
<%
    System.out.println("-----------------------------");
    String rc = (String) request.getAttribute("LICENSE_RC");
    System.out.println("rc " + rc);
%>
<body style="margin-top:-50px; margin-bottom:0px; margin-left:0px; margin-right:0px;" onbeforeunload="unload();">
<form id="form1" name="form1" method="post" action="auth.do" onSubmit="return checkAuth();">
    <div style="position:absolute;top:0px;left:0px;width:100%;height:100%">
        <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center">
                    <div id="main" class="STYLE1">
                        <div style="width:610px; height:30px;position:absolute;top:-30px;left:5px;">
                            <img style="float:left;" src="images/logo.png"/>
                            <img style="float:right" src="images/acs_logo.png"/>
                        </div>
                        <div class="STYLE2">
                            <input id="rc" tabindex="1" type="text" name="rc" value="${LICENSE_RC}" readonly="true"
                                   class="input_auth">
                        </div>
                        <div class="STYLE2" style="margin-top:10px;">
                            <input id="lk" tabindex="2" type="text" name="key" maxlength="81" class="input_auth">
                        </div>
                        <div class="STYLE3">
                            <input type="image" src="images/auth/submit.png" name="auth"
                                   onclick="document.forms[0].act.value='auth';submit_page()"/>
                            <input id="close" type="image" src="images/auth/close.png" name="later"
                                   onclick="close_page();"/>
                            <input type="hidden" name="act">
                        </div>
                        <div style="font-size:9pt;color:red">&nbsp;<html:errors/></div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</form>

</body>
</html>