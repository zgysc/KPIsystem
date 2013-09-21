<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.demo.mobile.Users" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<fieldset class="solid">
	<legend>登记</legend>
      <input type="hidden" name="borrow_mobile.id" />
	<div>
		<label>手机/卡</label>
		<select  name="borrow_mobile.mobile">
            <%
                List<Map<String,Object>> list= (List<Map<String,Object>>)request.getAttribute("mobiles");
                for(Map<String,Object> obj:list){

                    out.println("<option value='"+obj.get("id")+"'>"+obj.get("info")+"</option>") ;
                }
            %>
		</select>
	</div>
	<div>
		<label>借用人</label>
		<select name="borrow_mobile.people" >
            <%
                List<Users> users= ((Map)request.getAttribute("users")).get("users");
                for(Users u:users){

                    out.println("<option value='"+u.get("user_name")+"'>"+u.get("note")+"</option>") ;
                }
            %>

		</select>
	</div>
	<div>
		<label>&nbsp;</label>
		<input value="提交" type="submit">
	</div>
</fieldset>