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
<h2>search result</h2>
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
	
	out.print("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i=1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
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
%>
</body>
</html>