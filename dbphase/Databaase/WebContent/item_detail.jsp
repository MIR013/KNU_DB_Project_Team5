<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String iid = request.getParameter("selectID");
	out.print("<h2>"+iid +" is selected</h2>");


%>
</body>
</html>