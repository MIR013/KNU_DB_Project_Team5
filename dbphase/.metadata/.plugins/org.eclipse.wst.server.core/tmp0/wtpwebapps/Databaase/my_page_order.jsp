<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' href='mystyle.css'>
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
	query = "SELECT Order_no FROM ORDERS WHERE Customer_id = '"+cid+"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.print("<div class=\"container\"><table> <tr><th><h2> [ Ordered List ] </h2></th></tr>");

	out.print("<tr><td><table border=\"1\" align=\"center\"> ");

	System.out.print(conn.getTransactionIsolation());
	int before = -1;
	while(rs.next()){
		int ono = rs.getInt(1);
		
		if(before == ono) continue;
		
		before = ono;
		String newquery = "SELECT Order_date, Item_id, Item_num FROM ORDERS WHERE Customer_id = '"+cid+"' AND Order_no = "+ono;
		ResultSet rs2;
		pstmt = conn.prepareStatement(newquery);
		rs2 = pstmt.executeQuery();	
		
		out.println("<th> Order_no </th>");
		out.println("<th> Order_date </th>");
		out.println("<th> Item_id </th>");
		out.println("<th> Item_num </th>");
		
		out.print("<tr>");
		out.print("<td>"+ono+"</td>");
		int first = 0;
		while(rs2.next()){
			if(first!=0)	out.print("<td> </td>");
			SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
			Date odate = rs2.getDate(1);
			String sodate = sdfDate.format(odate);
			out.print("<td>"+sodate+"</td>");
			String iid = rs2.getString(2);
			out.print("<td>"+iid+"</td>");
			int inum = rs2.getInt(3);
			out.print("<td>"+inum+"</td>");
			out.print("</tr>");
			first++;
		}
		first = 0;
		
	}
	out.print("</table>");

%>

<%
String nextpage = "<form action=\"my_page.html\" method=\"POST\">" +
			"<input type=\"submit\" value=\"BACK\"/>" +
			"</form>";
out.print(nextpage);
out.print("</table></div>");
%>
</body>
</html>