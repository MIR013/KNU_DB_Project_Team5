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
	
	String iid = request.getParameter("itemID");
	int inum = Integer.parseInt(request.getParameter("itemNumber"));

	//check item id
	query = "SELECT Keep_num FROM ITEM WHERE Item_id = '" + iid + "'";
	//out.print("<h2>"+query+"</h2>");
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	int knum=0;
	if(rs.next()){
		knum = Integer.parseInt(rs.getString(1));
	}
	else{
		pageContext.forward("search_fail.jsp");
		
	}
	inum += knum;
	query = "UPDATE ITEM SET Keep_num = "+inum+" WHERE Item_id = '"+iid+"'";
	pstmt = conn.prepareStatement(query);
	cnt = pstmt.executeUpdate();
	if(cnt==0){
		System.out.println("update personal information success!");
	}
		
	conn.commit();


%>
<%
	query = "SELECT Item_id, Item_name, Keep_num FROM ITEM WHERE Item_id = '" + iid + "'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	out.print("<div class=\"container\"><table> <tr><th><h2> [ Update Stock Result ] </h2></th></tr>");
	out.print("<tr><td><table border=\"1\" align=\"center\"> ");

	out.println("<th> Item_id </th>");
	out.println("<th> Item_name </th>");
	out.println("<th> Stock </th>");
	out.print("<tr>");
	if(rs.next()){
		out.print("<td>"+rs.getString(1)+"</td>");
		out.print("<td>"+rs.getString(2)+"</td>");
		out.print("<td>"+rs.getString(3)+"</td>");
		out.print("</tr>");
	}
%>
<%
	
	String nextpage = "</table> <tr><td><form action=\"admin_page.html\" method=\"POST\">" +
			"<input type=\"submit\" value=\"BACK\"/>" +
			"</form></td></tr>";
out.print(nextpage);
	out.print("</table></div>");
%>



</body>
</html>