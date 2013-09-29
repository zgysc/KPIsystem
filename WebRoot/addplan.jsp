<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"  %>

<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.mobicloud.kpi.*" %>
<%@ page import="com.mobicloud.kpi.util.MobicloudManager" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="/css/acs.css" rel="stylesheet"/>
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
    List<Proj> projects= MobicloudManager.getInstance().getAllProject();
    List<Users> peoples=MobicloudManager.getInstance().getAllUsers();
    List<MarketFunc> mfuncs=MobicloudManager.getInstance().getAllMaretFunc();
    List<OrderType> orderTypes=MobicloudManager.getInstance().getAllOrderType();
    List<CurStep> steps=MobicloudManager.getInstance().getAllSteps();
    String date= new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<form name="f" method="post" action="/plan/add">
    <div class="formTitle">
        <span>Add Plan</span>
    </div>
    <div id="formData" class="formData">
<table class="formContent">
  <tr>
      <td>项目名称：</td>
      <td>
          <select name="devplan.proj_name">
     <%
         int piid=0;
         for(Proj pi:projects){
          piid++;
     %>
      <option <%=(piid==2?"selected":"")%> ><%=pi.getStr("proj_name")%></option>
              <%}%>
        </select>
      </td>
  </tr>
    <tr><td>任务类型：</td><td>
        <select name="devplan.order_type">
            <%for(OrderType orderType:orderTypes){
            int theid = orderType.getLong("id").intValue();
            %>
            <option value="<%=theid%>" <%=(theid==1?"selected":"")%> ><%=orderType.getStr("name")%></option>
            <%}%>

        </select>
    </td></tr>
    <tr><td>所处阶段：</td><td><select name="devplan.curstep">
        <%for(CurStep step:steps){
            int theid = step.getInt("id");
        %>
        <option value="<%=theid%>" <%=(theid==1?"selected":"")%> ><%=step.getStr("name")%></option>
        <%}%>
    </select></td></tr>
    <tr><td>工单号：</td><td><input type=text name="devplan.order_number" size=30></td></tr>
    <tr>
        <td>负责人：</td>
        <td>
            <select name="devplan.people" multiple >
                <%
                    for(Users pi:peoples){

                %>
                <option><%=pi.getStr("note")%></option>
                <%}%>
            </select> *按住ctrl可以选多人  ${peoplemsg}
        </td>
    </tr>
    <tr>
        <td>需求名称：</td>
        <td><!--<input name="market_func" maxlength="100" size="90"/-->

              <select name="devplan.market_named_func">
                <%
                    for(MarketFunc pi:mfuncs){

                %>
                <option value="<%=pi.getStr("name")%>" > <%=pi.getStr("name")%> </option>
                <%}%>
            </select>

        </td>
    </tr>
    <tr>
        <td>需求分解名称：</td>
        <td>
            <input name="devplan.RD_named_func" type="text" maxlength="200" size="90">

        </td>
    </tr>
    <tr>
        <td>预计开始时间：</td>
        <td>
            <input name="devplan.plan_start" type="text" maxlength="20" size="20" value="<%=date%>">

        </td>
    </tr>
    <tr>
        <td>预计结束时间：</td>
        <td>
            <input name="devplan.plan_end" type="text" maxlength="20" size="20" value="<%=date%>">

        </td>
    </tr>
    <tr>
        <td>备注：</td>
        <td>
            <input name="devplan.description" type="text" maxlength="200" size="90">

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
    <input type="hidden" name="devplan.operator" value="<%=(String)session.getAttribute("user_name")%>"/>
</form>
</body>
</html>
