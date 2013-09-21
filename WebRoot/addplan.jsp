<%@ page language="java" contentType="text/html; charset=gb2312"
         pageEncoding="gb2312"  %>
<%@ page import="com.workssys.uen.comserver.iopcenter.bean.ProjectInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.user.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    //    Vector userList = (Vector) request.getAttribute("users");
    //boolean menuWritePrivilege = ((User) session.getAttribute(IOPConstants.USER_INFO_IN_PAGE)).checkMenuWritePrivilege(IOPDBTableConstants.SHOW_FIRMWARES);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <script type="text/javascript" src="js/dojo.js"></script>
    <script type="text/javascript">

        function refresh() {
            window.location.href = "showfirmwares.do";
        }



        function addFirmware() {
            window.location.href = "addfirmware.jsp";
        }

        function download(fwid) {
            window.location.href = "downloadiopfirmware.do?firmwareid=" + fwid;
        }
    </script>
    <link href="css/acs.css" rel="stylesheet"/>
    <style type="text/css">
            /***
                   The following is just an example of how to use the table.
                   You can override any class names to be used if you wish.
               ***/

        table td, table th {
            border-right: 1px solid #999;
            border-bottom: 1px solid #999;
            padding: 2px;
            font-size: 9pt;
            font-weight: bold;
            word-wrap: break-word;
            word-break: break-all;
        }

            /*table thead td, table thead th {
                background: #cccccc;
            }*/
    </style>

</head>

<body>
<br/>
<%
    List<ProjectInfo> projects=(List<ProjectInfo>)request.getAttribute("projects");
    List<User> peoples=(List<User>)request.getAttribute("peoples");
    List<String> mfuncs=(List<String>)request.getAttribute("functions");
    String date= new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<form name="f" method="post" action="showfirmwares.do">
    <div class="formTitle">
        <span>Add Plan</span>
    </div>
    <div id="formData" class="formData">
<table class="formContent">
  <tr>
      <td>��Ŀ���ƣ�</td>
      <td>
          <select name="proj_name">
     <%
         int piid=0;
         for(ProjectInfo pi:projects){
          piid++;
     %>
      <option <%=(piid==2?"selected":"")%> ><%=pi.getProject_name()%></option>
              <%}%>
        </select>
      </td>
  </tr>
    <tr><td>�������ͣ�</td><td><select name="order_type"><option value="1">��Ʒ����</option><option value="2">��Ӫʵʩ</option><option value="3">��������</option></select></td></tr>
    <tr><td>�����׶Σ�</td><td><select name="curstep"><option value="1" selected>�з��׶�</option><option value="2">�з��ڲ�����</option><option value="3" >QAд��������</option><option value="4" >QA������BUG</option> </select></td></tr>
    <tr><td>�����ţ�</td><td><input type=text name="order_number" size=30></td></tr>
    <tr>
        <td>�����ˣ�</td>
        <td>
            <select name="people" multiple >
                <%
                    for(User pi:peoples){

                %>
                <option><%=pi.getNote()%></option>
                <%}%>
            </select> *��סctrl����ѡ����
        </td>
    </tr>
    <tr>
        <td>�������ƣ�</td>
        <td><!--<input name="market_func" maxlength="100" size="90"/-->

              <select name="market_func">
                <%
                    for(String pi:mfuncs){

                %>
                <option value="<%=pi%>" > <%=pi%> </option>
                <%}%>
            </select>

        </td>
    </tr>
    <tr>
        <td>����ֽ����ƣ�</td>
        <td>
            <input name="rd_func" type="text" maxlength="200" size="90">

        </td>
    </tr>
    <tr>
        <td>Ԥ�ƿ�ʼʱ�䣺</td>
        <td>
            <input name="plan_start" type="text" maxlength="20" size="20" value="<%=date%>">

        </td>
    </tr>
    <tr>
        <td>Ԥ�ƽ���ʱ�䣺</td>
        <td>
            <input name="plan_end" type="text" maxlength="20" size="20" value="<%=date%>">

        </td>
    </tr>
    <tr>
        <td>��ע��</td>
        <td>
            <input name="desp" type="text" maxlength="200" size="90">

        </td>
    </tr>
</table>


        <table class="formContent">
            <tr>
                <td align="center">
                    <input type="submit" value="Submit..."/>
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" name="action" value="add"/>
</form>
</body>
</html>
