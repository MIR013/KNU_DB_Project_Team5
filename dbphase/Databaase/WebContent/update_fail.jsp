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
	String adm = (String)session.getAttribute("signedUser");
	out.print("<h2>" + adm + "'s Modifying is fail! " + "</h2>");
	
	String nextpage = "<form action=\"my_page_passwd.html\" method=\"POST\">" +
			"<input type=\"submit\" value=\"CLOSE\"/>" +
			"</form>";
	out.print(nextpage);

%>
</body>
</html>