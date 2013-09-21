<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/acs.css" rel="stylesheet"/>
<script type="text/javascript">
    function showme(event,obj){
        var oSon = window.document.getElementById("floatdate");
        if (oSon == null) return;
        with (oSon){
            style.display = "block";
            var et =event || window.event;
            var y =  et.clientY || et.offsetY;
            style.pixelTop = y + window.document.body.scrollTop - 22;
            style.pixelLeft = 5;
        }
        obj.style.backgroundColor='#feef66';
    }
    function hidme(obj){
        var oSon = window.document.getElementById("floatdate");
        if(oSon == null) return;
        oSon.style.display="none";
        obj.style.backgroundColor='';
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
<%
    int monthlastday=(Integer)request.getAttribute("monthlastday");
    String month=(String)request.getAttribute("month");
    int tbwidth=monthlastday * 20 + 400 + 15;
    List<Integer> dlist=new ArrayList<Integer>();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-M-d");
        String year=String.valueOf(new Date().getYear());
        try {
            for(int i=1;i<=31;i++){
                Date d=sdf.parse(year+"-"+month+"-"+i);
                if(d.getDay()==0 || d.getDay()==6) dlist.add(i);
            }

        } catch (ParseException e) {
            //return ;
        }

    String operator=(String)request.getSession(false).getAttribute("user_name");

%>
<form  name="f" action="/plan/" >
    <input type="hidden" name="export" value="true"/>
    <input type="hidden" name="month" value="<%=month%>"/>


<table class="topbutton">
    <tr>
        <td align="center"><H2><%=month%>月份KPI考核计划</H2>&nbsp;&nbsp; <img src="/images/export_mouseover.gif"  title="导出EXCEL..." onclick="document.f.submit();"/></td>
    </tr>
</table>

<table id="floatdate" class="contentTable" cellpadding="0" cellspacing="0" border="0" width="<%=tbwidth%>" style="display:none;z-index:9;position:absolute;table-layout:fixed;">
  <thead>
      <tr  style="border-bottom:1px;">    
          <th align="center" width="20" background="/images/iop_gui_v3_old_258.gif">ID</th>
          <th align="center" width="40" background="/images/iop_gui_v3_old_258.gif">项目</th>
          <th align="center" width="50" background="/images/iop_gui_v3_old_258.gif">类别</th>
          <th align="center" width="130" background="/images/iop_gui_v3_old_258.gif" >需求名称</th>
          <th align="center" width="130" background="/images/iop_gui_v3_old_258.gif" >模块</th>
          <th align="center" width="50" background="/images/iop_gui_v3_old_258.gif" >负责人</th>
          <%for(int i=1;i<=monthlastday;i++){%>    
          <th align="center" width="20" <%=(dlist.contains(i)?"bgcolor=red":"background=\"/images/iop_gui_v3_old_258.gif\"")%> ><%=i%></th>
          <%}%>                                    
          <th align="center" width="15">&nbsp;</th> 
      </tr></thead>
	</tbody>
  </table> 
<table id="targettable" class="contentTable" style="left:1px;table-layout: fixed" cellpadding="0" cellspacing="0" border="0" width="<%=tbwidth%>" align="left">
<thead>
    <tr class="formTitle" style="border-bottom:1px;">
        <th align="center" width="20">ID</th>
        <th align="center" width="40">项目</th>
        <th align="center" width="50">类别</th>
        <th align="center" width="130">需求名称</th>
        <th align="center" width="130">模块</th>
        <th align="center" width="50">负责人</th>
        <%for(int i=1;i<=monthlastday;i++){%>
        <th align="center" width="20"><%=i%></th>
        <%}%>
        <th align="center" width="15">&nbsp;</th>

    </tr>
</thead>
<tbody>
<%
  int rownum=0;
   List<Map<String,Object>> plans=(List<Map<String,Object>>)request.getAttribute("plans");
    for(Map<String,Object> dp:plans){
        System.out.println(dp.toString());
     rownum++;
%>
<tr valign="middle" class="deviceinfo1" onmouseover="showme(event,this);" onmouseout="hidme(this);" >
    <td><%=rownum%></td><td align="center" width="40">
        <%if("admin".equals((String)session.getAttribute("user_name")) || String.valueOf(dp.get("people")).indexOf((String)session.getAttribute("truename"))>=0){%>
        <a href="modifyplan.jsp?id=<%=dp.get("id")%>&month=<%=month%>"><%=dp.get("proj_name")%></a>
        <%}else{
          out.println(dp.get("proj_name"));
       }%>
    </td>
    <td id="deviceID" align="center" width="50" title="<%=dp.get("order_number")%>"><%=dp.get("order_type")%></td>
    <td align="center" width="130"><%=dp.get("market_named_func")%></td>
    <td align="center" width="130"><%=dp.get("rd_named_func")%></td>
    <%if("2".equals(dp.get("curstep"))||"4".equals(dp.get("curstep"))){%>
    <td align="center" title="<%=dp.get("people")%>" width="50"><img src="/images/userlogin.gif"><img src="/images/userlogout.gif"></td>
    <%}else{%>
    <td align="center" width="50" title="<%=dp.get("people")%>"><%=dp.get("people")%></td>
    <%}for(int j=1;j<(Integer)dp.get("plan_start_pos");j++){%>
    <td align="center" width="20">&nbsp;</td>
    <%}for(int dc=0;dc<(Integer)dp.get("daycost");dc++){%>
    <td width="20" title="<%=dp.get("description")%>" align=center bgcolor="<%=dp.get("color")%>">
        <% if(dc==(Integer)dp.get("daycost")/2){%><font color=white><%=dp.get("percentage")%></font> <%}%>
    </td>
    <%}for(int k=0;k<((Integer)dp.get("lastday")-(Integer)dp.get("plan_start_pos")-(Integer)dp.get("daycost")+1);k++){%>
    <td width="20" align="center">&nbsp;</td>
    <%}
        if("admin".equals(operator) || operator.equals(dp.get("operator")))
        {

    %>
     <td width="15" onmouseover="showme(event,this)" onmouseout="hidme(this)">
         <a href="/plan/delete/id=<%=dp.get("id")%>&month=<%=month%>"><img src="/images/redpoint.gif" border="0" title="delete"> </a> </td>
     <%}else{%>
    <td width="15" onmouseover="showme(event)" onmouseout="hidme()" ></td>
    <%}%>
</tr>
<%}%>

</tbody>
</table>
<br><br>
<div align="center"><img src="/images/export_mouseover.gif"  title="导出EXCEL..." onclick="document.f.submit();"/></div>
</form>

</body>
</html>
