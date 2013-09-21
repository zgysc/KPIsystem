<%@ page language="java" contentType="text/html;charset=gb2312"  pageEncoding="gb2312" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="css/acs.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/dojo.js"></script>
    <script type="text/javascript" src="js/notifycpe.js"></script>
    <script type="text/javascript" src="js/executeTask.js"></script>
    <script language="JavaScript" type="text/javascript" src="js/scriptaculoua/lib/prototype.js"></script>
    <script language="JavaScript" type="text/javascript" src="js/scriptaculoua/src/scriptaculous.js?load=effects"></script>
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
                img.src = "images/hide.png";
            } else {
                new Effect.SlideUp(temp);
                img.src = "images/show_detail.gif";
            }
        }
        function editDeviceInfo(sn) {
            window.location.href = "modifydeviceinfo.do?from=showdevice&deviceID=" + sn;
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

<form name="f" action="askstat.do">

            <table  align="center">
                <tr>
                    <td align="center"><h2>关于KPI考核量化指标的问卷调查</h2></td>
                </tr>
                <tr><td>    本次问卷调查的目的旨在于对日常员工的工作的质量进行量化考察，体现公平公正的原则，建立一系列可量化的、大家都认可的考察指标，以此作为以后工作中奖惩的依据。</td></tr>
            </table><br><br>
      <table    cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
    <tr><td>1.你觉得公司目前的KPI考核方式是否合理？</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T1" value="1" checked/>合理 <input type="radio" name="T1" value="2"/>不合理 <input type="radio" name="T1" value="3"/>还可以</td></tr>
    <tr><td>2.是否同意公司对目前的KPI考核方式进行改革？</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T2" value="1" checked/>同意 <input type="radio" name="T2" value="2"/>不同意 <input type="radio" name="T2" value="3"/>改不改都行</td></tr>
    <tr><td>3.公司准备推出云币的积分政策，用以以后兑换奖品或者作为升迁的依据，你觉得？</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T3" value="1" checked/>赞成 <input type="radio" name="T3" value="2"/>不赞成 <input type="radio" name="T3" value="3"/>无所谓</td></tr>
    <tr><td>4.如果真的通过了新的考核方式，是否同意将每个人的奖惩记录完全透明化，全部都晒在KPI记录上？</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T4" value="1" checked/>同意 <input type="radio" name="T4" value="2"/>不同意 <input type="radio" name="T4" value="3"/>都行啊</td></tr>
    <tr><td>5.你觉得这样的积分规则中的分数以及等级评定合理吗？<a href="http://172.16.0.11:9000/kpi/jfgz.html" target="_blank">积分规则</a></td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T5" value="1" checked>还可以 <input type="radio" name="T5" value="2">应再加大升级间隔 <input type="radio" name="T5" value="3">应再缩短升级间隔</td></tr>
    <tr><td>6.假如你主动提出新的任务并如期完成，你觉得应该奖励多少积分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T6"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>7.协助同事完成任务指标之外的一般性任务，该奖励多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T7"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>8.为公司发展建言献策并取得一定成效，该奖励多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T8"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>9.在公司内部举办技术培训，该奖励多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T9"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>10.联调阶段为自己和其他组员建立测试数据甚至小工具，提高测试效率和质量，该奖多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T10"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>11.开发的模块没有功能性bug，非功能性bug少于5个，该奖多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T11"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>12.QA人员引人新的测试技术，提高了效率，该奖多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T12"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>13.熬夜对系统进行升级，认真负责，系统升级正常，该奖多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T13"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>14.开发的功能被QA测试出有功能性bug，每个bug应该扣多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T14"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>15.无特殊原因未完成任务，每个功能点扣多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T15"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>16.git使用不熟练，误操作导致覆盖了同组人的代码，扣多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T16"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>17.偷懒不去merge代码，而是直接覆盖了别人的代码，扣多少分？</td></tr>
    <tr><td height="35" valign="top"><select  name="T17"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
<!--    <tr><td>18.除了以上的规则外，你觉得还有哪些可以日常容易量化的指标应该纳入呢？</td></tr>
    <tr><td height="35" valign="top"><textarea  name="T18" style="height:200;width:800;"></textarea></td></tr>-->
    <tr><td  align=center><input type="submit" value="提交问卷"/></td></tr>
</table>
</form>
<%
String ss=(String)request.getAttribute("ret");
    if("1".equals(ss)){
       out.print("<script>alert('感谢您的参与！');</script>");
    }else if("0".equals(ss)){
        out.print("<script>alert('已经投过票了');</script>");
    }
%>
</body>
</html>
