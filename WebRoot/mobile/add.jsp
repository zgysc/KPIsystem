<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="/mobile/css/manage.css" media="screen" rel="stylesheet" type="text/css" />
<script src="/mobile/js/jquery-1.4.4.min.js" type="text/javascript" ></script>
</head>
<body>
	<div class="manage_container">

		<div class="main">
<h1>Mobile管理 ---&gt; 登记
</h1>
<div class="form_box">
	<form action="/mobile/save" method="post">
	<%@ include file="/mobile/_form.jsp"%>
	</form>
</div>
		</div>
	</div>
</body>
</html>
