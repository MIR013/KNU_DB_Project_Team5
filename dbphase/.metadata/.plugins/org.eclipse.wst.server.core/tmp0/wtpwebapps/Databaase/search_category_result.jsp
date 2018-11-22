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
	String mcat = request.getParameter("middlecat");
	String scat = request.getParameter("SmallCat");
	
	query = "SELECT I.Item_id, I.Item_name FROM ITEM I, CATEGORY C WHERE C.Large_category = '"+lcat
			+"' AND C.Middle_category = '"+mcat+"' AND C.Small_category = '"+scat+"' AND C.Category_no = I.Category_no";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.print("<div class=\"container\"><table> <tr><th><h2> [ Search Result ]</h2></th></tr>");

	out.print("<tr><td><table border=\"1\" align=\"center\"> ");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i=1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	out.println("<th>"+ "</th>");
	while(rs.next()){
		out.print("<tr>");
		String iid = rs.getString(1);
		out.print("<td>"+iid+"</td>");
		out.print("<td>"+rs.getString(2)+"</td>");
		out.print("<td>");
		out.print("<form action='item_detail.jsp' method='POST'>");
		out.print("<input type=\"hidden\" name = \"selectID\" value = "+iid+" />");
		out.print("<input type=\"submit\" value=\"Detail\"/>");
		out.print("</form>");
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table>");

%>
<%
String nextpage = "<form action=\"main_page.jsp\" method=\"POST\">" +
			"<input type=\"submit\" value=\"BACK\"/>" +
			"</form>";
out.print(nextpage);

out.print("</table></div>");
%>
</body>
</html>