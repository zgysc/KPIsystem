<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.mobicloud.kpi.util.MobicloudManager" %>
<%@ page import="com.mobicloud.kpi.Devplan" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="/css/acs.css" rel="stylesheet"/>
    <link href="/js/jquery-1.4.4.min.js" rel="stylesheet"/>
    <style type="text/css">

        table td, table th {
            border-right: 1px solid #999;
            border-bottom: 1px solid #999;
            padding: 2px;
            font-size: 9pt;
            font-weight: bold;
            word-wrap: break-word;
            word-break: break-all;
        }

    </style>

</head>

<body>
<br/>
<%
    String pid=request.getParameter("id");

    Devplan dp= Devplan.dao.findById(pid);

%>
<form name="f" method="post" action="/plan/update/">
    <div class="formTitle">
        <span>Update Plan</span>
    </div>
    <div id="formData" class="formData">
        <table class="formContent">
            <tr>
                <td>项目名称：</td>
                <td><%=dp.get("proj_name")%></td>
            </tr>
            <tr><td>工单号：</td><td><%=MobicloudManager.getInstance().defaultstring(dp.get("order_number"))%></td></tr>
            <tr>
                <td>负责人：</td>
                <td><%=dp.get("people")%></td>
            </tr>
            <tr>
                <td>需求名称：</td>
                <td><%=dp.get("market_named_func")%></td>
            </tr>
            <tr>
                <td>需求分解名称：</td>
                <td><%=MobicloudManager.getInstance().defaultstring(dp.get("RD_named_func"))%></td>
            </tr>
            <tr>
                <td>预计开始时间：</td>
                <td>
                    <input name="plan_start" type="text" maxlength="20" size="20" value="<%=dp.get("plan_start")%>">

                </td>
            </tr>
            <tr>
                <td>预计结束时间：</td>
                <td>
                    <input name="plan_end" type="text" maxlength="20" size="20" value="<%=dp.get("plan_end")%>">

                </td>
            </tr>
            <tr>
                <td>实际开始时间：</td>
                <td>
                    <input name="actual_start" type="text" maxlength="20" size="20" value="<%=MobicloudManager.getInstance().defaultstring(dp.get("actual_start"))%>">

                </td>
            </tr>
            <tr>
                <td>实际结束时间：</td>
                <td>
                    <input name="actual_end" type="text" maxlength="20" size="20" value="<%=MobicloudManager.getInstance().defaultstring(dp.get("actual_end"))%>">

                </td>
            </tr>
            <tr>
                <td>进度：</td>
                <td>
                    <input name="percentage" type="text" maxlength="20" size="10" value="<%=dp.get("percentage")%>">

                </td>
            </tr>

            <tr>
                <td>备注：</td>
                <td>
                    <input name="desp" type="text" maxlength="200" size="90" value="<%=MobicloudManager.getInstance().defaultstring(dp.get("description"))%>">

                </td>
            </tr>
        </table>


        <table class="formContent">
            <tr>
                <td align="center">
                    <input type="submit" value="Submit"/>
                </td>
            </tr>
        </table>
    </div>

    <input type="hidden" name="id" value="<%=pid%>"/>

</form>
</body>
</html>
