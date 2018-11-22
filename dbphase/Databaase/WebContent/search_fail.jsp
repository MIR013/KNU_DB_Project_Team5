<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='mystyle.css'>
</head>
<body>

<%
	out.print("<div class=\"container\"><table><tr><th><h2>" + " searching is failed " + "</h2></th></tr>");
	
	String nextpage = "<tr><td><form action=\"search_item.html\" method=\"POST\">" +
			"<input type=\"submit\" value=\"BACK\"/></td></tr>" +
			"</form></table></div>";
	out.print(nextpage);

%>
</body>
</html>