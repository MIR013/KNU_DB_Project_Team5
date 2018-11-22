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
String query;
conn.setAutoCommit(false);
%>

<%
	query = "SELECT distinct Large_category FROM CATEGORY";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.print("<form action = search_category_middle.jsp method = 'POST'><div class=\"container\"> <table>");
	out.print("<tr><th><h2> [ Search Large Categories ]</h2></th></tr>");
	
	//large check box
	out.print("	<tr> <td>Large Category : <select name=\"largeCat\">"); 
	while(rs.next()){
		out.print("<option value=\"");
		String lcat = rs.getString(1);
		out.print(lcat);
		out.print("\">"+lcat+"</option>");
		
	}
	out.print("</select></td></td>");
	
	
	out.print("<tr>	<td><input type=\"button\" value=\"BACK\" onclick=\"location.href='main_page.jsp'\"/> <input type=\"submit\" value=\"NEXT\"/> </td> </tr>");
	out.print("</table></div></form>");
%>

</body>
</html>