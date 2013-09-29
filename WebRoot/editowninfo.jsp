
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="java.util.List" %>
<%@ page import="com.mobicloud.kpi.util.DES" %>
<%@ page import="com.mobicloud.kpi.Users" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/css/acs.css" rel="stylesheet"/>
    <script type="text/javascript">
        function formSubmit() {
            var theForm = document.forms[0];
            if (theForm.password.value=='' ||
                theForm.confirmpassword.value=='')
                return;

            if (theForm.password.value != theForm.confirmpassword.value) {
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
    String username=(String)session.getAttribute("user_name");
    Users user = Users.dao.findFirst("select * from users where user_name =?",username);
    if(user==null) response.sendRedirect("/");
%>
<form method="post" id="theForm" action="/editowninfo">
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
                   trim="true" value="<%=DES.decrypt(user.getStr("password"))%>"/>
        </td>
    </tr>
    <tr>
        <td class="systemsettings">Confirm Password</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input type="password" name="confirmpassword" class="medium"
                   dojoType="ValidationTextBox"
                   required="true"
                   trim="true" value="<%=DES.decrypt(user.getStr("password"))%>"/>
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