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
	// presentPwd and newPwd != null
	String prep = request.getParameter("presentPwd");
	String newp = request.getParameter("newPwd");
	
	if( prep.equals("null") || newp.equals("null")){
		pageContext.forward("update_fail.jsp");
	}
	// presentPWd
	String cpwd = null;
	String cid = (String)session.getAttribute("signedUser");
	//Customer_id is not Cutomer_id is right
	query = "SELECT Cutomer_pwd FROM CUSTOMER WHERE Customer_id = '" + cid + "'";
	//out.print("<h2>"+query+"</h2>");
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	if(rs.next()){
		cpwd = rs.getString(1);
	}
	if(prep.equals(cpwd)){
	// update
		query = "UPDATE CUSTOMER SET Cutomer_pwd = '"+newp+"' WHERE Customer_id = '"+cid+"'";
		pstmt = conn.prepareStatement(query);
		cnt = pstmt.executeUpdate();
		if(cnt==0){
			System.out.println("update personal information success!");
		}
		
		conn.commit();
		pageContext.forward("update_success.jsp");
	}
	else
	{
		pageContext.forward("update_fail.jsp");
	}
	
%>



</body>
</html>