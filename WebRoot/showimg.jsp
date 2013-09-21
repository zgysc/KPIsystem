<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/acs.css" rel="stylesheet"/>

</head>
<body>


    <%
        String img=request.getParameter("img");
        if(img!=null){
            String[] imgs=img.split("\\|");
            for(String info:imgs){
              out.println("<img width=320 src='"+info+"'><br>");
            }


        }
    %>

</body>
</html>
