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
String query=null;
conn.setAutoCommit(false);
%>
<%
	String iid = request.getParameter("selectID");
	String cid = (String)session.getAttribute("signedUser");
	query = "delete from INCLUDE where Customer_id = '"+cid+"' and Item_id = '"+iid+"'";
	pstmt = conn.prepareStatement(query);
	cnt = pstmt.executeUpdate();
	
	if(cnt==0){
		System.out.println("insert success!");
	}
	
	conn.commit();
	
	
%>
	<div class="container">
		<table>
			<tr>
				<th><h2> [ Delete Shoppingbag Item Success ] </h2></th>
			</tr>
			<tr>
				<td><input type="button" value="CLOSE" onclick="location.href='my_page_shoppingbag.jsp'"/> </td>
			</tr>

			<tr><td></td></tr>
	
		</table>
	</div>



</body>
</html>