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
<h2>Welcome to our Mall!</h2>
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
<h1>Our Recommended TOP 3 Items!!</h1>
<%
	query="SELECT I.Item_id	FROM ORDERS O, ITEM I WHERE O.Item_id = I.Item_id GROUP BY I.Item_id ORDER BY sum(O.Item_num * I.Relese_unit) DESC LIMIT 3";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.print("<table border=\"1\"> ");
	out.print("<td>Item ID</td>");
	out.print("<td>Item NAME</td>");
	while(rs.next()){
		out.print("<tr>");
		String iid = rs.getString(1);
		String newQuery = "select Item_id, Item_name from ITEM where Item_id = '"+ iid+"'";
		PreparedStatement pstmt2 = conn.prepareStatement(newQuery);
		ResultSet rs2 = pstmt2.executeQuery();
		while(rs2.next()){
			out.print("<td>"+rs2.getString(1)+"</td>");
			out.print("<td>"+rs2.getString(2)+"</td>");
		}
		out.print("</tr>");
		
		
	}
	out.print("</table>");

	conn.commit();
	conn.close();
	pstmt.close();

%>
<%
	String nextpage = "<form action=\"main.jsp\" method=\"POST\">" +
						"<input type=\"submit\" value=\"CLOSE\"/>" +
						"</form>";
	out.print(nextpage);
%>


</body>
</html>