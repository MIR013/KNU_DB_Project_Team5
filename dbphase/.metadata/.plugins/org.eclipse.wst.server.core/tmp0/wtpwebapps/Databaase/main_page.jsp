<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel='stylesheet' type='text/css' href='mystyle.css'>
<title>Insert title here</title>
</head>
<body>

<form>
	<div class="container">
		<table>
		<tr>
				<th><h2> [ The Team5's Shopping Mall ]</h2></th>
		</tr>
		<tr>
			<td><input type="button" value="My Page" onclick="location.href='my_page.html'"/></td>
		</tr>
		<tr>
		<td><input type="button" value="Search Category" onclick="location.href='search_category_large.jsp'"/></td>
		</tr>
		<tr>
		<td><input type="button" value="Search Item" onclick="location.href='search_item.html'"/></td>
		</tr>


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
		String nextpage = "<tr><td><input type=\"button\" value=\"Admin Page\" onclick=\"location.href='admin_page.html'\"/></td></tr>";
		out.print(nextpage);
	}
	
%>
<%
out.print("</br>");
String nextpage = "<tr><td><input type=\"button\" value=\"LOGOUT\" onclick=\"location.href='log_out.jsp'\"/></td></tr>";
out.print(nextpage);

%>
		</table>
	</div>
</form>
</body>
</html>