<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"  %>
<%@ page import="java.util.List" %>
<%@ page import="com.mobicloud.kpi.Proj" %>
<%@ page import="com.mobicloud.kpi.Users" %>
<%@ page import="com.mobicloud.kpi.MarketFunc" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">

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
    List<Proj> projects= Proj.dao.find("select * from proj");
    List<Users> peoples=Users.dao.find("select * from users where level=1");
    List<MarketFunc>  funcs= MarketFunc.dao.find("select * from market_func");
    int month=Integer.parseInt((String)request.getAttribute("month"));
%>
<form name="f" method="post" action="/plan/search">
    <div class="formTitle">
        <span>Search Plan</span>
    </div>
    <div id="formData" class="formData">
        <table class="formContent">
            <tr>
                <td>项目名称：</td>
                <td>
                    <select name="proj_name">
                        <option value="ALL" selected>----------</option>
                        <%
                            for(Proj pi:projects){

                        %>
                        <option><%=pi.getStr("proj_name")%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <tr>
                <td>需求名称：</td>
                <td>
                    <select name="market_func">
                        <option value="ALL" selected>-------------------</option>
                        <%
                            for(MarketFunc pi:funcs){

                        %>
                        <option><%=pi.getStr("name")%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
             <tr>
                <td>负责人：</td>
                <td>
                    <select name="people">
                        <option value="ALL" selected>----------</option>
                        <%
                            for(Users pi:peoples){

                        %>
                        <option value="<%=pi.getStr("note")%>"><%=pi.getStr("note")%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <tr><td>月份：</td><td><select name="month">
                <%for(int i=1;i<=12;i++){%>
                <option <%=(i==month?"selected":"")%> ><%=i%></option>
                <%}%>
            </select></td></tr>
            <tr>
                <td>任务完成情况：</td><td>
                <select name="finishflag" >
                    <option value="ALL" selected >--------------</option>
                    <option value="unfinish">未完成的任务</option>
                </select>
                </td>
            </tr>
            <tr>
                <td>排序顺序：</td>
                <td>
                    <select name="order1">
                        <option value="" selected >-----------</option>
                        <option value="proj_name">项目名称</option>
                        <option value="order_type">类型</option>
                        <option value="people">员工姓名</option>
                        <option value="plan_start">开始时间</option>
                    </select>
                    <select name="order2">
                        <option value="" selected >-----------</option>
                        <option value="proj_name">项目名称</option>
                        <option value="order_type">类型</option>
                        <option value="people">员工姓名</option>
                        <option value="plan_start">开始时间</option>
                    </select>
                    <select name="order3">
                        <option value="" selected >-----------</option>
                        <option value="proj_name">项目名称</option>
                        <option value="order_type">类型</option>
                        <option value="people">员工姓名</option>
                        <option value="plan_start">开始时间</option>
                    </select>
                    <select name="order4">
                        <option value="" selected >-----------</option>
                        <option value="proj_name">项目名称</option>
                        <option value="order_type">类型</option>
                        <option value="people">员工姓名</option>
                        <option value="plan_start">开始时间</option>
                    </select>
                </td>
            </tr>
        </table>


        <table class="formContent">
            <tr>
                <td align="center">
                    <input type=submit value=" 搜索任务..."/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="直接导出EXCEL..." onclick="document.f.export.value='true';document.f.submit();"/>

                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" name="export" value="false"/>
    <input type="hidden" name="act" value="search"/>
</form>
</body>
</html>