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

<h2>search small categories</h2>
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
	out.print("<form action = search_category_result.jsp method = 'POST'> <table>");
	
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
	
	out.print("<tr>	<td><input type=\"reset\" value=\"reset\"/> <input type=\"submit\" value=\"search\"/> </td> </tr>");
	out.print("</table></form>");
	
%>

<%
String nextpage = "<form action=\"main_page.jsp\" method=\"POST\">" +
			"<input type=\"submit\" value=\"BACK\"/>" +
			"</form>";
out.print(nextpage);
%>
</body>
</html>