<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='mystyle.css'>
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
	String lcat = request.getParameter("largecat");
	String mcat = request.getParameter("MiddleCat");
	query = "SELECT distinct Small_category FROM CATEGORY WHERE Large_category = '" +lcat+"' AND Middle_category = '"+ mcat + "'";
	//out.print("<h2>"+query+"</h2>");
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.print("<form action = search_category_result.jsp method = 'POST'><div class=\"container\"> <table>");
	out.print("<tr><th><h2> [ Search Small Categories ]</h2></th></tr>");
	//large check box
	out.print("	<tr> <td>Middle Category : <select name=\"SmallCat\">"); 
	while(rs.next()){
		out.print("<option value=\"");
		String cat = rs.getString(1);
		out.print(cat);
		out.print("\">"+cat+"</option>");
		
	}
	out.print("</select></td></td>");
	

	out.print("<input type=\"hidden\" name = \"largecat\" value = "+lcat+" />");
	out.print("<input type=\"hidden\" name = \"middlecat\" value = "+mcat+" />");
	
	out.print("<tr>	<td><input type=\"button\" value=\"BACK\" onclick=\"location.href='search_category_large.jsp'\"/>  <input type=\"submit\" value=\"search\"/> </td> </tr>");
	out.print("</table></form>");
	
%>

</body>
</html>