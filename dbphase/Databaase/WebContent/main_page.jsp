<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> --The Team5's Shopping Mall--</h1>

<form>
	<input type="button" value="My Page" onclick="location.href='my_page.html'"/>
	</br>
	
	<input type="button" value="Search Category" onclick="location.href='search_category_large.jsp'"/>
	</br>
	
	<input type="button" value="Search Item" onclick="location.href='search_item.html'"/>
	</br>
</form>

<%
String serverIP = "localhost";
String dbName = "phase2";
String portNum = "3306";
String url = "jdbc:mysql://" + serverIP + ":" + portNum + "/" + dbName;
String user = "knu";
String pass = "comp322";
Connection conn = null;

Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(url,user,pass);
PreparedStatement pstmt;
ResultSet rs;
ResultSetMetaData rsmd;
int cnt;
String query;
conn.setAutoCommit(false);
%>

<%
	String adm = (String)session.getAttribute("signedUser");
	query = "select Type from CUSTOMER where Customer_id = '" + adm +"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	String t=null;
	while(rs.next()){
		t = rs.getString(1);
	}
	if(t != null && t.equals("4")){
		String nextpage = "<form>" +
				"<input type=\"button\" value=\"Admin Page\" onclick=\"location.href='admin_page.html'\"/>" +
				"</form>";
		out.print(nextpage);
	}
	
%>
<%
out.print("</br>");
String nextpage = "<form action=\"log_out.jsp\" method=\"POST\">" +
			"<input type=\"submit\" value=\"LOGOUT\"/>" +
			"</form>";
out.print(nextpage);
%>

</body>
</html>