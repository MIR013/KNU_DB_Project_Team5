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
	String cid = (String)session.getAttribute("signedUser");
	query = "SELECT a.Item_id,a.Item_num,b.Relese_unit,b.Keep_num FROM INCLUDE a, ITEM b WHERE Customer_id = '"+cid+"' and a.Item_id = b.Item_id";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.print("<div class=\"container\"><table> <tr><th><h2> [ Shoppingbag Item List ] </h2></th></tr>");

	out.print("<tr><td><table border=\"1\" align=\"center\"> ");
	
	int before = -1;
	out.println("<tr><th> Item_id </th>");
	out.println("<th> Item_num </th>");
	out.println("<th> Release_unit </th>");
	out.println("<th> Stock </th>");
	out.println("<th></th></tr>");
	while(rs.next()){
		out.print("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td>"+"<td>"+rs.getString(4)+"</td>");
		out.print("<td>");
		out.print("<form action='delete_shoppingbag.jsp' method='POST'>");
		out.print("<input type=\"hidden\" name = \"selectID\" value = "+rs.getString(1)+" />");
		out.print("<input type=\"submit\" value=\"Delete\"/>");
		out.print("</form>");
		out.print("</td>");
		out.print("</tr>");
	
	}

%>

<%
	String nextpage = "</table><tr><td><form action=\"my_page.html\" method=\"POST\">" +
				"<input type=\"submit\" value=\"BACK\"/>" +
				"</form>"+"<input type=\"button\" value=\"ORDER\" onclick=\"location.href='purchase.jsp'\"/>"+
				"</td></tr>";
	out.print(nextpage);
	out.print("</table></div>");
%>



</body>
</html>