<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="com.workssys.uen.comserver.iopcenter.menu.util.MenuUtil"%>
<%@ page import="com.workssys.uen.comserver.iopcenter.menu.Menu" %>
<%@ page import="java.util.List" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.IOPConstants" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.user.User" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.util.IOPDBTableConstants" %>
<%@ page import="com.workssys.ump.commons.func.DES" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.user.UserManagerFactory" %>
<%@ page import="com.workssys.uen.comserver.iopcenter.IOPConstants" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="org.apache.commons.lang.ArrayUtils"%><html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/acs.css" rel="stylesheet"/>
    <link href="css/calendar-blue.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/dojo.js"></script>
    <script type="text/javascript" src="js/functions.js"></script>
    <script type="text/javascript" src="js/executeTask.js"></script>
    <script type="text/javascript" src="js/calendar.js"></script>
    <script type="text/javascript" src="js/calendar-setup.js"></script>
    <script type="text/javascript" src="js/lang/calendar-en.js"></script>
    <script type="text/javascript">
        dojo.require("dojo.widget.DropdownDatePicker");
    </script>
    <script type="text/javascript">
        function formSubmit() {
            var theForm = document.forms[0];
            //            alert("you will submit the form 111: ");
            if (dojo.string.isBlank(theForm.password.value) ||
                dojo.string.isBlank(theForm.confirmpassword.value))
                return;
            if (dojo.byId("password").value != dojo.byId("confirmpassword").value) {
                alert("Please confirm the password");
                return;
            }
            if (!checkValidation(dojo.byId("password").value, "Password") ||
                !checkValidation(dojo.byId("confirmpassword").value, "Confirmpassword") ||
                ((dojo.byId("email").value != "") && !checkEmail(dojo.byId("email").value)))
                return;
            if (document.getElementById("note").value.length > 512) {
                alert("The max length of note is 512");
                return;
            }
            theForm.submit();
            //            alert("you will submit the form 222: ");
        }
        function selectmenu(id) {
            loopSelectmenu(document.getElementsByName("menu"), id);
        }
        function loopSelectmenu(menus, id) {
        	var temp = document.getElementById(id).checked;
            for (var i = 0; i < menus.length; i ++) {
                if (dojo.string.startsWith(menus[i].id, id + "_", true)){
                    menus[i].checked = temp;
                	displayWrite(menus[i].id, menus[i],true);
                }
            }
        }
        function changestatus(status) {
            if (status == "disable") {
                document.getElementById("expiretime").disabled = true;
                document.getElementById("toTime_trigger").disabled = true;
                document.getElementById("trustip").disabled = true;
            }
            if (status == "enable") {
                document.getElementById("expiretime").disabled = false;
                document.getElementById("toTime_trigger").disabled = false;
                document.getElementById("trustip").disabled = false;
            }
        }
        function displayWrite(id,o,bycase){
        	var r = document.getElementById(id + "r");
			var w = document.getElementById(id);
			if(r){
				if (w.disabled) {
					if(bycase){
						r.checked = o.checked;
					}
					w.checked=false;
					return;
				} else {
					if(o.id == r.id){
						if(r.checked==true){
							w.checked = false;
						}
					}
					if(o.id == w.id){
						if(o.checked==true){
							r.checked = false;
						}
					}
				}
			}
		}
    </script>
</head>
<%
    User editUser = (UserManagerFactory.getUserManager()).getUserByName(request.getParameter(IOPConstants.REQUEST_EDIT_USER));
User parentUser = (User) session.getAttribute(IOPConstants.USER_INFO_IN_PAGE);
%>
<body>
<br/>
<form method="post" id="theForm" action="edituser.do">
<div class="formTitle">
        <span class="noticeMessage">
                Please modify the information for the selected user.
        </span>
    <span>Edit User</span>
</div>
<div name="formData" id="formData" class="formData">
<table class="formContent">
    <tr>
        <td class="systemsettings">User Name</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input value="<%=request.getAttribute("userName") == null?editUser.getUserName():request.getAttribute("userName")%>"
                   type="text" name="userNameShow" class="medium" disabled=""/>
            <input value="<%=request.getAttribute("userName") == null?editUser.getUserName():request.getAttribute("userName")%>"
                   type="hidden" name="userName" class="medium"/>
        </td>
    </tr>
    <tr>
        <td class="systemsettings">Password</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input value="<%=request.getAttribute("password")==null?DES.decrypt(editUser.getPassword()):request.getAttribute("password")%>"
                   dojoType="ValidationTextBox" required="true" id="password"
                   type="password" name="password" class="medium"/>
        </td>
    </tr>
    <tr>
        <td class="systemsettings">Confirm Password</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input value="<%=request.getAttribute("password")==null?DES.decrypt(editUser.getPassword()):request.getAttribute("password")%>"
                   dojoType="ValidationTextBox" required="true" id="confirmpassword"
                   type="password" name="confirmpassword" class="medium"/>
        </td>
    </tr>
    <tr>
        <td class="systemsettings">E-Mail Address</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input type="text" name="email" id="email" class="selectLength" dojoType="ValidationTextBox"
                   required="false" trim="true"
                   value="<%=request.getAttribute("email") == null? (editUser.getEmail()==null?"":editUser.getEmail()): request.getAttribute("email")%>"/>
        </td>
    </tr>
    <tr>
        <td class="systemsettings">Note</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <textarea rows="5" name="note" class="selectLength"
                      id="note"><%=request.getAttribute("note") == null ? (editUser.getNote() == null ? "" : editUser.getNote().trim()) : request.getAttribute("note")%></textarea>
        </td>
    </tr>
</table>
<hr/>
<table class="formContent">
    <%
        boolean status = false;
        if (request.getAttribute("status") != null) {
            if (request.getAttribute("status").equals("enable"))
                status = true;
            if (request.getAttribute("status").equals("disable"))
                status = false;
        } else {
            status = (editUser.getActive().intValue() == 1);
        }
    %>
    <tr>
        <td class="systemsettings">Status</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left" style="font-size:9pt;">
            <input type="radio" name="status" onclick="changestatus('enable')"
                   value="enable" <%=status ? "checked" : ""%>/>Enable
            <input type="radio" name="status" onclick="changestatus('disable')"
                   value="disable" <%=status ? "" : "checked"%>/>Disable
        </td>
    </tr>
         <%
    	String username= (String)session.getAttribute(IOPConstants.SESSION_LOGIN);
    	boolean isAdmin = false;
    	String starAdmin="";
    	Integer level=editUser.getLevel();
    	if(editUser.getLevel().compareTo(IOPConstants.ROOTLEVEL) == 0){
    	 	isAdmin = true;
    	 	starAdmin=IOPConstants.ISADMIN_ADMIN;
    	}
    	else{
    		isAdmin = false;
    		starAdmin=IOPConstants.ISADMIN_PERSON;
    	}
     %>
         <tr>
        <%
        	if(IOPConstants.ISADMIN_ADMIN.equals(Integer.toString(parentUser.getLevel()))){
        %>
			<td class="systemsettings">User Group</td>
	        <td width="10px">&nbsp;&nbsp;</td>
	        <td align="left" style="font-size:9pt;">
			<input type="hidden" name="isAdmin" value="<%=starAdmin %>"/>
				
	            <input type="radio" name="is_Admin" disabled
	                   value="<%=IOPConstants.ISADMIN_ADMIN %>" <%=isAdmin ? "checked" : ""%>/>Manager
	            <input type="radio" name="is_Admin" disabled
	                   value="<%=IOPConstants.ISADMIN_PERSON %>"  <%=isAdmin ? "" : "checked"%>/>Vendor
	        </td>
		<%
        	}else{
        %>
			<input type="hidden" name="isAdmin" value="<%=starAdmin %>"/>
			<input type="hidden" name="is_Admin" value="<%=IOPConstants.ISADMIN_ADMIN %>" <%=isAdmin ? "checked" : ""%>/>
		<%
        	}
        %>
        
    </tr>
    <tr>
        <td class="systemsettings">Expire Time</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input name="expiretime" <%=status?"":"disabled"%>
                   id="expiretime" class="medium" value="<%=request.getAttribute("expiretime") == null?
                   (editUser.getExpiredate()==null?"":((new SimpleDateFormat("yyyy-MM-dd")).format(editUser.getExpiredate()))):request.getAttribute("expiretime")%>">
            <button type="reset" id="toTime_trigger" <%=status ? "" : "disabled"%>>...</button><font style="font-size:9pt;font-weight:normal;">&nbsp;(yyyy-MM-dd)</font>
            <script type="text/javascript">
                Calendar.setup({
                    inputField     :    "expiretime",      // id of the input field
                    ifFormat       :    "%Y-%m-%d",       // format of the input field
                    showsTime      :    false,            // will display a time selector
                    button         :    "toTime_trigger",   // trigger for the calendar (button ID)
                    singleClick    :    false,           // double-click mode
                    step           :    1                // show all years in drop-down boxes (instead of every other year as default)
                });
            </script>
        </td>
    </tr>
    <tr id="trust">
        <td class="systemsettings">Trust IP</td>
        <td width="10px">&nbsp;&nbsp;</td>
        <td align="left">
            <input id="trustip" class="selectLength" name="trustip" type="text"
                    <%=status ? "" : "disabled"%>
                   value="<%=request.getAttribute("trustip") == null? (editUser.getTrustip() == null?"":editUser.getTrustip()):request.getAttribute("trustip")%>"/>
        </td>
    </tr>
</table>
<hr/>
<%
    //show all the menus.
    //if the parent user do not have a menu, it will be disabled.
    User adminUser = UserManagerFactory.getUserManager().getUserByName("admin"); //to get all the menus;
    List parentMenus = adminUser.getShowMenus();
    for (int i = 0; i < parentMenus.size(); i++) {
        Menu parentMenu = (Menu) parentMenus.get(i);
%>
<table width="80%" align="center" style="font-size:9pt;margin-top:10px;">
    <tr>
        <td style="font-weight:bold;" align="left" colspan="3">
            <input type="checkbox" id="<%=parentMenu.getMenuId()%>" name="<%=parentMenu.getMenuId()%>"
                   onclick="selectmenu('<%=parentMenu.getMenuId()%>')"/><%=parentMenu.getDispalyName()%>
        </td>
    </tr>
    <tr>
        <%
            List childMenus = parentMenu.getChildMenus();
            String[] savemenus = (String[]) request.getAttribute("menus");
            String[] menu_read = (String[]) request.getAttribute("menu_read");
            int id = 0;
            for (int j = 0; j < childMenus.size(); j++) {
                Menu childMenu = (Menu) childMenus.get(j);
                //only admin can have system_settings, system log and license_management menus.
                if (childMenu.getDispalyName().equals(IOPDBTableConstants.SYSTEM_SETTING) ||
                        childMenu.getDispalyName().equals(IOPDBTableConstants.LICENSE_MANAGEMENT) ||
                        childMenu.getDispalyName().equals(IOPDBTableConstants.SYSTEM_BACKUP_RESTORE) ||
                        childMenu.getDispalyName().equals(IOPDBTableConstants.UPLOAD_LOG_FILE_MENU) ||
                        childMenu.getDispalyName().equals(IOPDBTableConstants.SYSTEM_LOG))
                    continue;
                //check if the parent user has this menu.
                List allowMenus = parentUser.getMenus();
                boolean contains = false;
                for (int l = 0; l < allowMenus.size(); l++) {
                    if (((Menu) allowMenus.get(l)).getMenuId().equals(childMenu.getMenuId())) {
                        contains = true;
                        break;
                    }
                }
        %>
        <td width="33%">
            <%
                if (childMenu.getDispalyName().equals(IOPDBTableConstants.SYSTEM_STATUS)) {
            %>
            <input type="checkbox" id="<%=childMenu.getMenuId()%>" name="system_status"
                   disabled="true" checked/><%=childMenu.getDispalyName()%>
                   <%
	                    if ((id + 1) % 3 == 0) {
				        %>
					    </tr>
					    <tr>
			        <%}%>
            <%
            }
            // if the parent user do not have a menu. he can not gave it to his child user.
            else if ((childMenu.getDispalyName().equals(IOPDBTableConstants.USER_MANAGEMENT) &&
                    parentUser.getLevel().intValue() >= (User.PARENT_MAXLEVEL - 1)) || !contains){
            %>
            <input type="checkbox" id="<%=childMenu.getMenuId()%>" name="disabled_menus"
                disabled="true"><%=childMenu.getDispalyName()%>
                <%
                    if ((id + 1) % 3 == 0) {
			        %>
				    </tr>
				    <tr>
		        <%}%>
            <%
            } else {
            %>
            
            
            	<%
	           		if(ArrayUtils.indexOf(IOPDBTableConstants.READ_WRITE_MENUSNEW, childMenu.getName()) >= 0){
	           	%>
	           		<%
			            if (id % 2 == 0 && id != 0) {
			        	%><td>&nbsp;</td>
					    </tr>
					    <tr>
					    <td>
		        	<%}%>
            
            		<input type="checkbox" id="<%=parentMenu.getMenuId()%>_<%=j%>r" name="menu_read"
                   value="<%=childMenu.getMenuId()%>"
                   <%
                        if (menu_read != null
                        		&& ArrayUtils.indexOf(menu_read, childMenu.getMenuId().toString()) >= 0) {
                    %>
                   			checked
					<%
                    } else {
                        List menus = editUser.getMenus();
                        for (int k = 0; k < menus.size(); k++) {
                            if (((Menu) menus.get(k)).getMenuId().equals(childMenu.getMenuId())
                            		&& ((Menu) menus.get(k)).getPrivilege().equals(Menu.PRIVILEGE_READ)) {
                    %>
                   checked
                    <%
                                    break;
                                }
                            }
                        }
                    %>
                   onclick="displayWrite('<%=parentMenu.getMenuId()%>_<%=j%>',this)"/>
                   <%=childMenu.getDispalyName()%>
                   (<%=IOPDBTableConstants.DISPLAY_PRIVILEGE_READ%>)
                   </td>
	                 <%
				            if ((id + 1) % 2== 0) {
				        	%><td>&nbsp;</td>
						    </tr>
						    <tr>
				        	<%
			                }
			                id++;
	                %>
	                <td width="33%" align="left">
	                <input type="checkbox" id="<%=parentMenu.getMenuId()%>_<%=j%>" name="menu"
                     <%
                        if (!MenuUtil.checkEdit(childMenu.getName(),parentUser.getUserId())) {
                    %>
                   			disabled="disabled"
                    <%} else {%>
                    	value="<%=childMenu.getMenuId()%>"
                    	onclick="displayWrite('<%=parentMenu.getMenuId()%>_<%=j%>',this)"
                    	<%
	                        if (savemenus != null
	                        		&& ArrayUtils.indexOf(savemenus, childMenu.getMenuId().toString()) >= 0) {
	                    %>
	                   			checked
	                    <%
	                    } else {
	                        List menus = editUser.getMenus();
	                        for (int k = 0; k < menus.size(); k++) {
	                            if (((Menu) menus.get(k)).getMenuId().equals(childMenu.getMenuId())
	                            		&& ((Menu) menus.get(k)).getPrivilege().equals(Menu.PRIVILEGE_WRITE)) {
	                    %>
	                   checked
	                    <%
	                                    break;
	                                }
	                            }
	                        }
	                    %>
                    <%} %>
                   />
                   <%=childMenu.getDispalyName()%>
                   (<%=IOPDBTableConstants.DISPLAY_PRIVILEGE_WRITE%>)
                   </td>
                <%} else { %>
                	<input type="checkbox" id="<%=parentMenu.getMenuId()%>_<%=j%>" name="menu"
	                   value="<%=childMenu.getMenuId()%>"
	                    <%
	                        if (savemenus != null) {
	                            for (int k = 0; k < savemenus.length; k++) {
	                                if (savemenus[k].equals(childMenu.getMenuId().toString())) {
	                    %>
	                   checked
	                    <%
	                                break;
	                            }
	                        }
	                    } else {
	                        List menus = editUser.getMenus();
	                        for (int k = 0; k < menus.size(); k++) {
	                            if (((Menu) menus.get(k)).getMenuId().equals(childMenu.getMenuId())) {
	                    %>
	                   checked
	                    <%
	                                    break;
	                                }
	                            }
	                        }
	                    %>
	                    /><%=childMenu.getDispalyName()%> </td>
	                     <%
		                    if ((id + 1) % 3 == 0) {
					        %>
						    </tr>
						    <tr>
				        <%}%>
                <%} %>
            <%}%>
        <%
                id++;
            }
        %>
    </tr>
</table>
<%
    }
%>
<br/>
<table class="formContent">
    <%--<tr>
        <td colspan="3"><hr/></td>
    </tr>--%>
    <tr>
        <td align="center">
            <img class="button" src="images/ok.gif" onClick="formSubmit();"/>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <img class="button" src="images/cancel.gif" onClick="javascript:window.location.href='showusers.do';"/>
        </td>
    </tr>
</table>
</div>
</form>
<script type="text/javascript">
    <%if(request.getAttribute("errmsg")!=null && request.getAttribute("errmsg")!=""){%>
    alert('${errmsg}');
    <%}%>
</script>
</body>
</html>
