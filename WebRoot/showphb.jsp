<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mobicloud.kpi.util.MobicloudManager" %>
<%@ page import="com.mobicloud.kpi.Users" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/css/acs.css" rel="stylesheet"/>
    <script type="text/javascript">
        function showme(event,obj){

            obj.style.backgroundColor='#feef66';
        }
        function hidme(obj){

            obj.style.backgroundColor='';
        }
        function toggle_params(temp, img) {
            if ($(temp).style.display == "none") {
                new Effect.SlideDown(temp);
                img.src = "/images/hide.png";
            } else {
                new Effect.SlideUp(temp);
                img.src = "/images/show_detail.gif";
            }
        }


    </script>
    <STYLE type="text/css">
        TABLE.contentTable {
            BORDER-RIGHT: #ccc 1px solid;
            BORDER-TOP: #ccc 1px solid;
            FONT-SIZE: 10pt;
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
            FONT-SIZE:9pt;
            PADDING-BOTTOM: 1px;
            PADDING-TOP: 1px;
            BORDER-BOTTOM: #999 1px solid;
            word-break: break-all;
        }
        TABLE TH {
            PADDING-RIGHT: 0px;
            PADDING-LEFT: 0px;
            FONT-WEIGHT: bold;
            FONT-SIZE: 9pt;
            PADDING-BOTTOM: 0px;
            PADDING-TOP: 0px;
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



<table width="100%" border=0>
    <tr>
        <td width="50%" valign="top">
            <table class="topbutton" align="center">
                <tr>
                    <td align="center"><h2>云币排行榜</h2></td>
                </tr>
            </table>
      <table  class="contentTable"  cellpadding="0" cellspacing="0" border="0" width="400" align="center">
    <thead>
    <tr  style="border-bottom:1px;">
        <th align="center" width="100" background="/images/iop_gui_v3_old_258.gif">姓名</th>
        <th align="center" width="100" background="/images/iop_gui_v3_old_258.gif">云币</th>
        <th align="center" width="100" background="/images/iop_gui_v3_old_258.gif">等级</th>
        <th align="center" width="100" background="/images/iop_gui_v3_old_258.gif" >历史明细</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Users> phbusers= MobicloudManager.getInstance().getPHB();
        int i_order=0;
        int lastvalue=99999;
        int currentphb=0;
        for(Users user:phbusers){
         i_order++;
        if("2".equals(String.valueOf(user.get("user_id")))) continue;
    %>
    <tr valign="middle" class="deviceinfo1" onmouseover="showme(event,this);" onmouseout="hidme(this);" >
        <td align="left">
            <%
                int uservalue=(Integer)user.get("dd_number");
                if(uservalue>0){
                    if(uservalue<lastvalue){currentphb++;}
                    if(currentphb==1){
                      out.println("<img src='images/golden.png'>");
		     	
		    }else if(currentphb==2){
                    
         	           out.println("<img src='images/silver.png'>");
               	    }else if(currentphb==3){
                   	 out.println("<img src='images/cu.png'>");
                    }
                    lastvalue=uservalue;
                    out.print("<b><font color=green>"+user.get("note")+"</font></b>");
               }else{
		out.print(user.get("note"));
		}

        %></td>
        <td align="center"><%=uservalue%></td>
        <td align="center"><%=MobicloudManager.getInstance().getRank(uservalue)%></td>
        <td align="center"><a href="/showprisehistory.jsp?act=prisehistory&user_id=<%=user.get("user_id")%>"><img src="/images/viewdetail.gif" border="0" title="查看明细"></a></td>

    </tr>
    <%}%>

    </tbody>
</table>
        </td>
        <td width="50%" align="center">
            <table class="topbutton" align="center" border=0>
                <tr>
                    <td align="center"><h2>积分说明</h2></td>
                </tr>
            </table>
            <table border=1 width=400>
                <tr><td>云币值</td><td>图标</td><td>军衔</td></tr>
                <tr>  <td>&lt;=50</td><td><img src="/images/lv3.gif"></td><td>列兵</td></tr>
                <tr> <td>100</td><td><img src="/images/lv3.gif"><img src="/images/lv3.gif"></td><td>少尉</td></tr>
                <tr> <td>200</td><td><img src="/images/lv3.gif"><img src="/images/lv3.gif"><img src="/images/lv3.gif"></td><td>中尉</td></tr>
                <tr> <td>500</td><td><img src="/images/lv2.gif"></td><td>上尉</td></tr>
                <tr><td>1000</td><td><img src="/images/lv2.gif"><img src="/images/lv3.gif"></td><td>少校</td></tr>
                <tr><td>1500</td><td><img src="/images/lv2.gif"><img src="/images/lv3.gif"><img src="/images/lv3.gif"></td><td>中校</td></tr>
                <tr><td>2100</td><td><img src="/images/lv2.gif"><img src="/images/lv3.gif"><img src="/images/lv3.gif"><img src="/images/lv3.gif"></td><td>上校</td></tr>
                <tr><td>2900</td><td><img src="/images/lv2.gif"><img src="/images/lv2.gif"></td><td>大校</td></tr>
                <tr><td>3900</td><td><img src="/images/lv2.gif"><img src="/images/lv2.gif"><img src="/images/lv3.gif"></td><td>少将</td></tr>
                <tr><td>5000</td><td><img src="/images/lv2.gif"><img src="/images/lv2.gif"><img src="/images/lv3.gif"><img src="/images/lv3.gif"></td><td>中将</td></tr>
                <tr><td>7700</td><td><img src="/images/lv2.gif"><img src="/images/lv2.gif"><img src="/images/lv3.gif"><img src="/images/lv3.gif"><img src="/images/lv3.gif"></td><td>上将</td></tr>
                <tr><td>9000</td><td><img src="/images/lv2.gif"><img src="/images/lv2.gif"><img src="/images/lv2.gif"></td><td>大将</td></tr>
                <tr><td>&gt;9000</td><td><img src="/images/lv1.gif"></td><td>元帅</td></tr>
            </table>
 <table class="topbutton" align="center" border=0>
                <tr>
                    <td align="center" valign="bottom"><h2>积分规则</h2></td>
                </tr>
            </table>
            <table border=1 width=400>
                <tr><td>主动提出任务并如期完成</td><td>奖10</td></tr>
                <tr><td>协助同事完成任务指标之外的任务</td><td>奖10</td></tr>
                <tr><td>为公司发展建言献策并取得一定成效</td><td>奖10</td></tr>
                <tr><td>优化改进旧有代码提高效率</td><td>奖10</td></tr>
                <tr><td>在公司内部举办各种培训</td><td>奖10</td></tr>
                <tr><td>联调阶段方便同事而开发额外的测试数据和工具</td><td>奖10</td></tr>
                <tr><td>QA测试出的非功能性bug少于5个</td><td>奖15</td></tr>
                <tr><td>QA测试出的功能性bug</td><td>罚 5/每个</td></tr>
                <tr><td>无特殊原因未完成任务</td><td>罚10/每个 </td></tr>
                <tr><td>git使用不熟练覆盖了其他人代码</td><td>罚20</td></tr>
                <tr><td>没有merge动作，偷懒直接覆盖他人代码</td><td>罚50</td></tr>

            </table>
        </td>
    </tr>
</table>
</body>
</html>
