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

	String cid = (String)session.getAttribute("signedUser");
	int inum = Integer.parseInt(request.getParameter("itemNum"));
	String iid = request.getParameter("itemID"); 
	
	//check redundancy
	query = "SELECT Item_num FROM INCLUDE WHERE Item_id = '"+iid+"' AND Customer_id = '"+cid+"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	if(rs.next()){
		//update
		int nnum = Integer.parseInt(rs.getString(1));

		//out.print("<h2>"+query+inum+nnum+"</h2>");
		nnum += inum;
		query = "UPDATE INCLUDE SET Item_num = "+nnum+" WHERE Customer_id = '"+cid+"' AND Item_id = '"+iid+"'";
		
		pstmt = conn.prepareStatement(query);
		cnt = pstmt.executeUpdate();
		if(cnt==0){
			System.out.println("update success!");
		}
		
		//out.print("<h2>"+query+"</h2>");
	}else{
		//insert
		
		query = "SELECT Shoppingbag_no FROM SHOPPINGBAG WHERE Customer_id = '"+cid+"'";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		int sno=0;
		if(rs.next()){
			sno = Integer.parseInt(rs.getString(1));
		}
		
		
		query = "INSERT INTO INCLUDE VALUES ("+ sno +", '"+cid+"', '"+iid+"', "+inum+")";
		
		pstmt = conn.prepareStatement(query);
		cnt = pstmt.executeUpdate();
		if(cnt==0){
			System.out.println("insert success!");
		}
		
	}
	
	conn.commit();
	

%>
<div class="container">
	<table>
		<tr><td> <h2>Insert Success</h2></td></tr>
		<tr><td><input type="button" value="Back" onclick="location.href='main_page.jsp'"/></td></tr>
	</table>
</div>


</body>
</html>