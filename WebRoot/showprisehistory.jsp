<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.bean.PriseInfo" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.util.MobicloudManager" %>
<%@ taglib uri="tags/iopcenter.tld" prefix="iop" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/acs.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/dojo.js"></script>
    <script type="text/javascript" src="js/notifycpe.js"></script>
    <script type="text/javascript" src="js/executeTask.js"></script>
    <script language="JavaScript" type="text/javascript" src="js/scriptaculoua/lib/prototype.js"></script>
    <script language="JavaScript" type="text/javascript" src="js/scriptaculoua/src/scriptaculous.js?load=effects"></script>
    <script type="text/javascript">
        dojo.require("dojo.string");
        dojo.require("dojo.io.*");
        dojo.require("dojo.event.*");


        function toggle_params(temp, img) {
            if ($(temp).style.display == "none") {
                new Effect.SlideDown(temp);
                img.src = "images/hide.png";
            } else {
                new Effect.SlideUp(temp);
                img.src = "images/show_detail.gif";
            }
        }
        function showpic(img){
            var path=img;
            if(path!=null){
                var ulr="showimg.jsp?img="+img
               window.showModalDialog(ulr,window,"dialogHeight:500px;dialogWidth:350px;dialogTop:400px;dialogLeft:400px;resizable:yes;scrollbars:yes;titlebar:no");

            }
        }

    </script>
    <STYLE type="text/css">
        TABLE.contentTable {
            BORDER-RIGHT: #ccc 1px solid;
            BORDER-TOP: #ccc 1px solid;
            FONT-SIZE: 9pt;
            BORDER-LEFT: #ccc 1px solid;
            CURSOR: default;
            BORDER-BOTTOM: #ccc 1px solid;
            font-family: Arial, Verdana, Helvetica, sans-serif;
        }
        TABLE TD {
            BORDER-RIGHT: #999 1px solid;
            PADDING-RIGHT: 0px;
            PADDING-LEFT: 0px;
            FONT-WEIGHT: normal;
            FONT-SIZE:8pt;
            PADDING-BOTTOM: 1px;
            PADDING-TOP: 1px;
            BORDER-BOTTOM: #999 1px solid;
            word-break: break-all;
        }
        TABLE TH {
            BORDER-RIGHT: #999 1px solid;
            PADDING-RIGHT: 0px;
            PADDING-LEFT: 0px;
            FONT-WEIGHT: bold;
            FONT-SIZE: 9pt;
            PADDING-BOTTOM: 0px;
            PADDING-TOP: 0px;
            BORDER-BOTTOM: #999 1px solid
        }
        TABLE THEAD TD {
            BACKGROUND: #cccccc
        }
        .deviceinfo1 {
            PADDING-RIGHT: 0px;
            PADDING-LEFT: 0px;
            BACKGROUND: #FFFFFF;
            PADDING-BOTTOM: 1px;
            PADDING-TOP: 1px;
        }
        .deviceinfo2 {
            PADDING-RIGHT: 0px;
            PADDING-LEFT: 0px;
            PADDING-BOTTOM: 0px;
            PADDING-TOP: 0px;
        }
    </STYLE>
</head>
<body>
<br/>

<table class="topbutton" align="center">
    <tr>
        <td align="center"><h2>奖惩历史记录</h2></td>
    </tr>
</table>

<table  class="contentTable"  cellpadding="0" cellspacing="0" border="0"  align="center">
    <thead>
    <tr  style="border-bottom:1px;">
        <th align="center" width="20%" background="images/iop_gui_v3_old_258.gif">时间</th>
        <th align="center" width="15%" background="images/iop_gui_v3_old_258.gif">姓名</th>
        <th align="center" width="15%" background="images/iop_gui_v3_old_258.gif">加减分</th>
        <th align="center" width="50%" background="images/iop_gui_v3_old_258.gif">原因</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<PriseInfo> infos = MobicloudManager.getInstance().getPriseHistory(request.getParameter("user_id"), true);

        for(PriseInfo info:infos){

    %>
    <tr valign="middle" class="deviceinfo1" onmouseover="showme(event,this);" onmouseout="hidme(this);" >
        <td align="center"><%=info.getThedate()%></td>
        <td align="center" ><%=info.getUser_name()%></td>
        <td align="center">
            <%
            if(Integer.parseInt(info.getScore())>0){
              out.print("<font color=green>"+info.getScore()+"</font>");
            }else{
                out.print("<font color=red>"+info.getScore()+"</font>");
            }
        %></td>
        <td align="left"><span onclick="showpic('<%=info.getImg()%>')"><%=info.getReason()%></span></td>
    </tr>
    <%}%>

    </tbody>
</table>
</body>
</html>
