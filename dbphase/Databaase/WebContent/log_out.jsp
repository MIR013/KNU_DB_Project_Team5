<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>log out is successed</h2>
<%
session.invalidate();

String nextpage = "<form action=\"main.html\" method=\"POST\">" +
			"<input type=\"submit\" value=\"CLOSE\"/>" +
			"</form>";
out.print(nextpage);
%>
</body>
</html>