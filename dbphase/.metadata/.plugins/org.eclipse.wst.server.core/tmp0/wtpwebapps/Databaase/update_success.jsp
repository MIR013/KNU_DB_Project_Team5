<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' href='mystyle.css'>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String adm = (String)session.getAttribute("signedUser");

	out.print("<div class=\"container\"><table><tr><th><h2>" + adm + "'s Modifying is success! " + "</h2></th></tr>");
	
	String nextpage = "<tr><td><form action=\"my_page.html\" method=\"POST\">" +
			"<input type=\"submit\" value=\"CLOSE\"/></td></tr>" +
			"</form></table></div>";
	out.print(nextpage);

%>
</body>
</html>