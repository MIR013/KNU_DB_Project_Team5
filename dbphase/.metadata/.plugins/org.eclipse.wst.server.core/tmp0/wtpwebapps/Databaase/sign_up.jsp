<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up success</title>
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
//insert
	String c_ship = null;

	//id redundancy check
	

	//insert in db
	
	String add = request.getParameter("signUpADDRESS");
	query = "SELECT Shippingcomp_name FROM SHIPPINGCOMPANY_LOCATION WHERE Shippingcomp_location = '"+ add +"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		c_ship = rs.getString(1);
	}
	
	String name;
	if(request.getParameter("signUpNAME").equals("null")){
		name = "null";
	}else
	{
		name = "'"+request.getParameter("signUpNAME")+"'";
	}	

	String phone;
	if(request.getParameter("signUpPHONE_NUMBER").equals("null")){
		phone="null";
	}
	else{
		phone = "'"+request.getParameter("signUpPHONE_NUMBER")+ "'";
	}
	
	String job;
	if(request.getParameter("signUpJOB").equals("null")){
		job="null";
	}
	else{
		job =  "'"+request.getParameter("signUpJOB")+ "'";
	}
	
	String type;
	if(request.getParameter("signUpTYPE").equals("null")){
		type="null";
	}
	else{
		type = "'"+request.getParameter("signUpTYPE")+ "'";
	}
	
	String sex;
	if(request.getParameter("signUpSEX").equals("null")){
		sex="null";
	}
	else{
		sex = "'"+request.getParameter("signUpSEX")+ "'";
	}
	
	query="INSERT INTO CUSTOMER VALUES( "
			+ "'"+request.getParameter("signUpID")+ "', "
			+ "'"+request.getParameter("signUpPASSWORD")+ "', "
			+ name + ","
			+ "'"+request.getParameter("signUpADDRESS")+ "', "
			+ phone + ","
			+job + ","
			+ type+","
			+ sex+","
			+ request.getParameter("signUpAGE")+", "
			+ "'"+c_ship +"' )";
	
	//out.print("<h6>"+ query +"</h6>");

	
	pstmt = conn.prepareStatement(query);
	cnt = pstmt.executeUpdate();
	
	if(cnt==0){
		System.out.println("insert success!");
	}
	
	conn.commit();

	
	//log in 
	String id = request.getParameter("signUpID");
	String pwd = request.getParameter("signUpPASSWORD");
	session.setAttribute("signedUser", id);
	
	conn.close();
	pstmt.close();
	
	//next page
	pageContext.forward("recommand.jsp");
	
%>



</body>
</html>