<%@ page import="com.workssys.uen.comserver.iopcenter.user.User" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.IOPConstants" %>
<%@ page import="com.workssys.ump.commons.func.DES" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.util.IOPDBTableConstants" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.menu.Menu" %>
<%@ page import="java.util.List" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.user.UserManagerFactory" %>
<%@ page import="com.workssys.commons.lang.DateUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="tags/struts-html.tld" prefix="html" %>
<%@ taglib uri="tags/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="tags/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="tags/iopcenter.tld" prefix="iop" %>
<iop:updateUser/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/acs.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/dojo.js"></script>
    <script type="text/javascript" src="js/functions.js"></script>
    <script type="text/javascript" src="js/executeTask.js"></script>
    <script type="text/javascript">
        function formSubmit() {
            var theForm = document.forms[0];
            if (dojo.string.isBlank(theForm.password.value) ||
                (dojo.string.isBlank(theForm.confirmpassword.value)))
                return;

            if (dojo.byId("password").value != dojo.byId("confirmpassword").value) {
                alert("please confirm password");
                return;
            }
            theForm.submit();
        }
    </script>
</head>
<body>
<br>
<%
    User user = (User) session.getAttribute(IOPConstants.USER_INFO_IN_PAGE);
%>
<form method="post" id="theForm" action="editowninfo.do">
<div class="formTitle">

    <span>修改密码</span>
</div>
<div id="formData" class="formData">
<table class="formContent">
    <tr>
        <td class="systemsettings">New Password</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input type="password" name="password" class="medium"
                   dojoType="ValidationTextBox"
                   required="true"
                   trim="true" value="<%=DES.decrypt(user.getPassword())%>"/>
        </td>
    </tr>
    <tr>
        <td class="systemsettings">Confirm Password</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input type="password" name="confirmpassword" class="medium"
                   dojoType="ValidationTextBox"
                   required="true"
                   trim="true" value="<%=DES.decrypt(user.getPassword())%>"/>
        </td>
    </tr>

</table>
<table class="formContent">
    <tr>
        <td align="center">
            <img class="button" src="images/ok.gif" onClick="formSubmit();" alt=""/>
        </td>
    </tr>
</table>
</div>
<br/>
</form>
<%
if("yes".equals((String)request.getAttribute("setok"))) {
    out.print("<script>alert('修改成功');</script>");
}
%>
</body>
</html>