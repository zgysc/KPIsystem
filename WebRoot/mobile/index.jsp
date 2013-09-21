<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link href="/css/manage.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.4.4.min.js" type="text/javascript" ></script>
</head>
<body>


<div class="main">
    <h1>手机借用登记表
    </h1>
    <div class="table_box">
        <table class="list">
            <tbody>
            <tr>
                <th >ID</th>
                <th >时间</th>
                <th >姓名</th>
                <th >厂商或卡</th>
                <th >型号</th>
                <th >号码</th>

                <th >地区</th>
            </tr>
            <%
                List<Map<String,Object>> records=(List<Map<String,Object>>)request.getAttribute("results");
                int i=0;
                for(Map<String,Object> record:records){
                    i++;
            %>
            <tr>
                <td style="text-align:left;"><%=String.valueOf(i)%></td>
                <td style="text-align:left;"><%=String.valueOf(record.get("borrow_date"))%></td>
                <td style="text-align:left;"><%=String.valueOf(record.get("note"))%></td>
                <td style="text-align:left;"><%=String.valueOf(record.get("vender"))%></td>
                <td style="text-align:left;"><%=String.valueOf(record.get("model"))%></td>
                <td style="text-align:left;"><%=String.valueOf(record.get("phone_number"))%></td>
                <td style="text-align:left;"><%=String.valueOf(record.get("area"))%></td>
            </tr>
            <%}%>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
