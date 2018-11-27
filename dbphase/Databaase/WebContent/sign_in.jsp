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
	//redundancy check
	String id = request.getParameter("signInID");
	String pwd = request.getParameter("signInPASSWORD");
	
	query = "select * from CUSTOMER where Customer_id = '" + id +"' and Cutomer_pwd = '"+pwd+"'"; //WRONG WORD....
	//out.print("<h1>"+query+"</h1>");
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	if(rs.next()){
		//login
		session.setAttribute("signedUser", id);
		pageContext.forward("main_page.jsp");
	}
	else{
		//logini fail
		String nextpage = "<form>" +
				"<dir class=\"container\"><table><tr><td> <h2>Failed Login </h2><input type=\"button\" value=\"BACK\" onclick=\"location.href='Sign_in.html'\"/></td></tr></table></dir>" +
				"</form>";
		out.print(nextpage);
	}
	


%>


</body>
</html>