<%@ page import="java.util.List" %>
<%@ page import="com.mobicloud.kpi.Menu" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Mobicloud KPI Management System</title>
<script src="/js/jquery-1.4.4.min.js" type="text/javascript" ></script>
<style type="text/css">
    <!--
    html {
        overflow: hidden
    }

    body {
        margin-left: 5px;
        margin-right: 5px;
    }

    html, body {
        height: 100%
    }

    .tablecontent {
        padding-top: 2px;
    }

    -->
</style>
<link href="/css/iop.css" rel="stylesheet" type="text/css"/>
<link href="/css/acs.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
    <!--
    .STYLE1 {
        color: #C9773C
    }

    .STYLE3 {
        color: #D8E8E4;
        font-family: Arial, Verdana, Helvetica, sans-serif;
        font-size: 14px;
    }

    .myadd span {
        line-height: 100%;
        vertical-align: super;
    }

    .myadd {
        cursor: pointer;
    }

    a:link {
        text-decoration: none;
        font-size:12pt;
        color: #226622;
    }

    a:visited {
        text-decoration: none;
        font-size:12pt;
        color: #226622;
    }

    a:hover {
        text-decoration: none;
        background: #fffecd;
        font-size:12pt;
        color: #226622;
    }

    a:active {
        text-decoration: none;
        font-size:12pt;
        color: #226622;
    }

    body, td, th {
        font-family: Arial, Verdana, Helvetica, sans-serif;
    }

    .style5 {
        color: #666666
    }

    .style8 {
        font-size: 10px;
        margin-bottom: 2px;
        margin-right: 20px !important;
        margin-right: 20px;
        width: 220px;
    }

    .my_test {
        margin-left: 0px;
        display: none;
    }

    ul {
        margin-top: 2px;
        margin-bottom: 2px
    }

    #left_dynamic_menu {
        width: 193px;
        overflow-y: auto;
        overflow-x: hidden;
        margin-top: -20px;
        height: 100%
    }

    .li_border {
        background-color: #D6EBE5;
        border: dashed 1px #999999
    }

    .count_down {
        font-size: 12px;
        margin-bottom: -15px;
        margin-right: 150px;
        width: 100px;
    }

    .count_down span {
        vertical-align: top
    }

    .count_down img {
        margin-left: 0px;
        cursor: pointer
    }

    -->
</style>

<script language="JavaScript">



    function logoutunonload() {
        window.location.href = "/logout";
    }




    function logout() {
        window.location.href = "/logout";
    }
    function logoutManul() {
        if (confirm("Are you sure to logout?")) {
            window.location.href = "/logout";
        }
    }


</script>
</head>
<body onUnload="logoutunonload()" style="margin-top:5px; background-color:#D3DFDD;">



<form style="position:absolute" method="post" id="theForm" action="">
</form>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" cellpadding="0" cellspacing="0">
    <tr>
        <td width="15" height="41" align="left" valign="top"><img src="/images/iop_gui_v3_29.gif" width="15" height="41"></td>
        <td height="41" align="left" valign="middle" background="/images/iop_gui_v3_30.gif" width="200">
            <img src="/images/kpilogo.jpg" width="150" height="38" align="middle"/></td>
        <td height="41" align="left" valign="middle" background="/images/iop_gui_v3_30.gif">
            <a href="/plan/" target="content_iframe">本月任务</a>&nbsp;&nbsp;&nbsp;
            <%

                List<Menu> menus=(List<Menu>)request.getAttribute("menuList");
                for(Menu menu:menus){
                %>

            <a href="<%=menu.get("forward")%>" target="content_iframe"><%=menu.get("display_name")%></a>&nbsp;&nbsp;&nbsp;
            <%
                }
            %>
            <a href="/plan/myplan" target="content_iframe">我的任务</a>&nbsp;&nbsp;&nbsp;
            <a href="/plan/readySearch/" target="content_iframe">搜索任务</a>&nbsp;&nbsp;&nbsp;
           <a href="/showphb.jsp" target="content_iframe">云币排行榜</a>&nbsp;&nbsp;&nbsp;
           <a href="/showprisehistory.jsp" target="content_iframe">奖惩记录</a>&nbsp;&nbsp;&nbsp;

	   <a href="/mobile/bin-debug/mobile.html" target="content_iframe">手机借用登记信息</a><img src="/images/new19.gif">&nbsp;&nbsp;&nbsp;
        </td>
        <td align="right" width="200" height="41" valign="bottom" background="/images/iop_gui_v3_30.gif">
            <%=session.getAttribute("truename")%>
            &nbsp;<a href="/editowninfo.jsp" target="content_iframe"><img class="iconbutton" src="/images/menu/edit-owninfor.gif" border="0" title="修改密码"/></a>&nbsp;
            <img  class="iconbutton" src="/images/menu/logout.gif" onclick="logoutManul()"/></td>
        <td width="20" height="41" align="left" valign="top"><img src="/images/iop_gui_v3_32.gif" width="20" height="41"/></td>
    </tr>
    <tr>
        <td align="left" valign="top" height="100%" background="/images/iop_gui_v3_49.gif">&nbsp;</td>
        <td style="height:100%;width:100%"  align="center" valign="top" class="constent"  id="content_div" colspan="3">
            <iframe frameborder="0" class="mframe_"  src="/plan/readySearch/" name="content_iframe"  id="content_iframe" scrolling="auto"></iframe>
        </td>
        <td align="left" valign="top" height="100%" background="/images/iop_gui_v3_52.gif">&nbsp;</td>

    </tr>
    <tr>
        <td width="15" height="19" align="left" valign="top">
            <img src="/images/iop_gui_v3_69.gif" width="15" height="19"/></td>
        <td align="left" valign="top" colspan="3"><img src="/images/iop_gui_v3_70.gif" width="100%" height="19"/></td>
        <td width="20" height="19" align="left" valign="top"><img src="/images/iop_gui_v3_72.gif" width="20" height="19"/></td>
    </tr>
</table>



</body>
</html>
