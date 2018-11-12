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

<%
String serverIP = "localhost";
String dbName = "phase2";
String portNum = "3306";
String url = "jdbc:mysql://" + serverIP + ":" + portNum + "/" + dbName;
String user = "knu";
String pass = "comp322";
Connection conn = null;

Class.forName("com.mysql.jdbc.Driver");
out.print("<h2>Driver ok!</h2>");
conn = DriverManager.getConnection(url,user,pass);
out.print("<h2>conn ok!</h2>");
PreparedStatement pstmt;
ResultSet rs;
ResultSetMetaData rsmd;
int cnt;
String query;
%>

<%

query = "select * from SUPPLIER";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();

out.println("<table border=\"1\">");
rsmd = rs.getMetaData();
cnt = rsmd.getColumnCount();
for (int i = 1; i <= cnt; i++) {
	out.println("<th>" + rsmd.getColumnName(i) + "</th>");
}
while (rs.next()) {
	out.println("<tr>");
	out.println("<td>" + rs.getString(1) + "</td>");
	out.println("</tr>");
}
out.println("</table>");

%>




</body>
</html>