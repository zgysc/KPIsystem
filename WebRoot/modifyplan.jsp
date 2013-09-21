<%@ page language="java" contentType="text/html; charset=gb2312"
         pageEncoding="gb2312"  %>
<%@ page import="com.workssys.uen.comserver.iopcenter.bean.DevPlan" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.util.MobicloudManager" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <script type="text/javascript" src="js/dojo.js"></script>
    <link href="css/acs.css" rel="stylesheet"/>
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

    DevPlan dp= MobicloudManager.getInstance().getPlanById(pid);

%>
<form name="f" method="post" action="showdevices.do">
    <div class="formTitle">
        <span>Update Plan</span>
    </div>
    <div id="formData" class="formData">
        <table class="formContent">
            <tr>
                <td>项目名称：</td>
                <td><%=dp.getProj_name()%></td>
            </tr>
            <tr><td>任务类型：</td><td><%=dp.getOrder_type()%></td></tr>
            <tr><td>工单号：</td><td><%=dp.getOrder_number()%></td></tr>
            <tr>
                <td>负责人：</td>
                <td><%=dp.getPeople()%></td>
            </tr>
            <tr>
                <td>需求名称：</td>
                <td><%=dp.getMarket_named_func()%></td>
            </tr>
            <tr>
                <td>需求分解名称：</td>
                <td><%=dp.getRD_named_func()%></td>
            </tr>
            <tr>
                <td>预计开始时间：</td>
                <td>
                    <input name="plan_start" type="text" maxlength="20" size="20" value="<%=dp.getPlan_start()%>">

                </td>
            </tr>
            <tr>
                <td>预计结束时间：</td>
                <td>
                    <input name="plan_end" type="text" maxlength="20" size="20" value="<%=dp.getPlan_end()%>">

                </td>
            </tr>
            <tr>
                <td>实际开始时间：</td>
                <td>
                    <input name="actual_start" type="text" maxlength="20" size="20" value="<%=StringUtils.defaultString(dp.getActual_start())%>">

                </td>
            </tr>
            <tr>
                <td>实际结束时间：</td>
                <td>
                    <input name="actual_end" type="text" maxlength="20" size="20" value="<%=StringUtils.defaultString(dp.getActual_end())%>">

                </td>
            </tr>
            <tr>
                <td>进度：</td>
                <td>
                    <input name="percentage" type="text" maxlength="20" size="10" value="<%=dp.getPercentage()%>">

                </td>
            </tr>

            <tr>
                <td>备注：</td>
                <td>
                    <input name="desp" type="text" maxlength="200" size="90" value="<%=dp.getDescription()%>">

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
    <input type="hidden" name="act" value="modifyplan"/>
    <input type="hidden" name="id" value="<%=pid%>"/>
    <input type="hidden" name="isinterupt" value="0"/>
</form>
</body>
</html>
