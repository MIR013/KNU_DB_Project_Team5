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
//update
	String c_ship = null;

	//update in db
	String x = request.getParameter("modifyADDRESS");
	query = "SELECT Shippingcomp_name FROM SHIPPINGCOMPANY_LOCATION WHERE Shippingcomp_location = '"+ x+"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		c_ship = rs.getString(1);
	}
	
	String name;
	if(request.getParameter("modifyNAME").equals("null")){
		name = "null";
	}else
	{
		name = "'"+request.getParameter("modifyNAME")+"'";
	}	

	String phone;
	if(request.getParameter("modifyPHONE_NUMBER").equals("null")){
		phone="null";
	}
	else{
		phone = "'"+request.getParameter("modifyPHONE_NUMBER")+ "'";
	}
	
	String job;
	if(request.getParameter("modifyJOB").equals("null")){
		job="null";
	}
	else{
		job =  "'"+request.getParameter("modifyJOB")+ "'";
	}
	
	String type;
	if(request.getParameter("modifyTYPE").equals("null")){
		type="null";
	}
	else{
		type = "'"+request.getParameter("modifyTYPE")+ "'";
	}
	
	String sex;
	if(request.getParameter("modifySEX").equals("null")){
		sex="null";
	}
	else{
		sex = "'"+request.getParameter("modifySEX")+ "'";
	}

	String cid = (String)session.getAttribute("signedUser");
	query="UPDATE CUSTOMER SET "
			+ " Name = "+ name + " , "
			+ " Address = '"+request.getParameter("modifyADDRESS")+ "' , "
			+ " Phone_number = " +phone + " ,"
			+ " Job = "+ job + " ,"
			+ " Type = " + type+" ,"
			+ " Sex = " + sex+" ,"
			+ " Age = " + request.getParameter("signUpAGE")+" ,"
			+ " C_shipname = '"+c_ship +"'"
			+ " WHERE Customer_id = '" + cid +"' ";

	
	pstmt = conn.prepareStatement(query);
	cnt = pstmt.executeUpdate();
	
	if(cnt==0){
		System.out.println("update personal information success!");
	}
	
	conn.commit();
	
	//out.print("<h6>"+ query +"</h6>");
	
	conn.close();
	pstmt.close();
	
	//next page
	pageContext.forward("update_success.jsp");
	
%>



</body>
</html>