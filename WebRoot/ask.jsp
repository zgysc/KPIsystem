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
                    <td align="center"><h2>����KPI��������ָ����ʾ����</h2></td>
                </tr>
                <tr><td>    �����ʾ�����Ŀ��ּ���ڶ��ճ�Ա���Ĺ��������������������죬���ֹ�ƽ������ԭ�򣬽���һϵ�п������ġ���Ҷ��ϿɵĿ���ָ�꣬�Դ���Ϊ�Ժ����н��͵����ݡ�</td></tr>
            </table><br><br>
      <table    cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
    <tr><td>1.����ù�˾Ŀǰ��KPI���˷�ʽ�Ƿ����</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T1" value="1" checked/>���� <input type="radio" name="T1" value="2"/>������ <input type="radio" name="T1" value="3"/>������</td></tr>
    <tr><td>2.�Ƿ�ͬ�⹫˾��Ŀǰ��KPI���˷�ʽ���иĸ</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T2" value="1" checked/>ͬ�� <input type="radio" name="T2" value="2"/>��ͬ�� <input type="radio" name="T2" value="3"/>�Ĳ��Ķ���</td></tr>
    <tr><td>3.��˾׼���Ƴ��ƱҵĻ������ߣ������Ժ�һ���Ʒ������Ϊ��Ǩ�����ݣ�����ã�</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T3" value="1" checked/>�޳� <input type="radio" name="T3" value="2"/>���޳� <input type="radio" name="T3" value="3"/>����ν</td></tr>
    <tr><td>4.������ͨ�����µĿ��˷�ʽ���Ƿ�ͬ�⽫ÿ���˵Ľ��ͼ�¼��ȫ͸������ȫ����ɹ��KPI��¼�ϣ�</td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T4" value="1" checked/>ͬ�� <input type="radio" name="T4" value="2"/>��ͬ�� <input type="radio" name="T4" value="3"/>���а�</td></tr>
    <tr><td>5.����������Ļ��ֹ����еķ����Լ��ȼ�����������<a href="http://172.16.0.11:9000/kpi/jfgz.html" target="_blank">���ֹ���</a></td></tr>
    <tr><td height="35" valign="top"><input type="radio" name="T5" value="1" checked>������ <input type="radio" name="T5" value="2">Ӧ�ټӴ�������� <input type="radio" name="T5" value="3">Ӧ�������������</td></tr>
    <tr><td>6.��������������µ�����������ɣ������Ӧ�ý������ٻ��֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T6"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>7.Э��ͬ���������ָ��֮���һ�������񣬸ý������ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T7"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>8.Ϊ��˾��չ�����ײ߲�ȡ��һ����Ч���ý������ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T8"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>9.�ڹ�˾�ڲ��ٰ켼����ѵ���ý������ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T9"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>10.�����׶�Ϊ�Լ���������Ա����������������С���ߣ���߲���Ч�ʺ��������ý����ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T10"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>11.������ģ��û�й�����bug���ǹ�����bug����5�����ý����ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T11"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>12.QA��Ա�����µĲ��Լ����������Ч�ʣ��ý����ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T12"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>13.��ҹ��ϵͳ�������������渺��ϵͳ�����������ý����ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T13"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>14.�����Ĺ��ܱ�QA���Գ��й�����bug��ÿ��bugӦ�ÿ۶��ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T14"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>15.������ԭ��δ�������ÿ�����ܵ�۶��ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T15"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>16.gitʹ�ò���������������¸�����ͬ���˵Ĵ��룬�۶��ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T16"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
    <tr><td>17.͵����ȥmerge���룬����ֱ�Ӹ����˱��˵Ĵ��룬�۶��ٷ֣�</td></tr>
    <tr><td height="35" valign="top"><select  name="T17"><%for(int i=5;i<=50;i++){%><option><%=i%></option><%}%></select></td></tr>
<!--    <tr><td>18.�������ϵĹ����⣬����û�����Щ�����ճ�����������ָ��Ӧ�������أ�</td></tr>
    <tr><td height="35" valign="top"><textarea  name="T18" style="height:200;width:800;"></textarea></td></tr>-->
    <tr><td  align=center><input type="submit" value="�ύ�ʾ�"/></td></tr>
</table>
</form>
<%
String ss=(String)request.getAttribute("ret");
    if("1".equals(ss)){
       out.print("<script>alert('��л���Ĳ��룡');</script>");
    }else if("0".equals(ss)){
        out.print("<script>alert('�Ѿ�Ͷ��Ʊ��');</script>");
    }
%>
</body>
</html>
