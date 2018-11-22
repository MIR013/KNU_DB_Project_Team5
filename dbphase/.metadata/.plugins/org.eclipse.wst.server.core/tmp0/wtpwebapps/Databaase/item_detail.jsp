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
	query = "SELECT * FROM ITEM WHERE Item_id = '"+iid+"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.print("<div class=\"container\"><table> <tr><th><h2> [ SHipping Company Count ]</h2></th></tr>");
	out.print("<tr><td><table border=\"1\" align=\"center\"> ");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i=1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.print("<tr>");
		for(int i=1;i<=cnt;i++){
			out.print("<td>"+rs.getString(i)+"</td>");
		}
		out.print("</tr>");
	}
	
	out.print("</table>");
	conn.commit();
	
	
%>
<tr>
	<td>
		<form action="insert_shoppingbag.jsp" method="post">
		<%
			out.print("<input type=\"hidden\" name = \"itemID\" value ="+ iid+" />");
		%>
			Value: <input type="text" name = "itemNum" required/>
			<input type="submit" value="Add Shoppingbag" name="submit"/>
		</form>
	</td>
</tr>

	
<%
	
	String nextpage = "<tr><td><form action=\"main_page.html\" method=\"POST\">" +
			"<input type=\"submit\" value=\"BACK\"/>" +
			"</form></td></tr>";
	out.print(nextpage);
	
	out.print("</table></div>");


%>
</body>
</html>