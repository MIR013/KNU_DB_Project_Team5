<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.*" %>
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
Statement stmt;
stmt = conn.createStatement();
ResultSet rs;
ResultSetMetaData rsmd;
int cnt;
String query;
conn.setAutoCommit(false);
%>
<%
	
	//if there is error then rollback to start point
	//Savepoint sp=conn.setSavepoint("Savepoint");
	conn.commit();
	
	String cid = (String)session.getAttribute("signedUser");
	//check shoppingbag
	query = "select * from INCLUDE where Customer_id = '"+cid+"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	System.out.println(cid+": "+query);
	if(!rs.next()){
		pageContext.forward("purchase_empty.jsp");
	}
	else{
	
%>


<%
		
		//do purchase
		//stock lack-fail
		query = "select a.Item_id,b.Item_num from ITEM a,INCLUDE b where a.Item_id = b.Item_id and b.Customer_id = '"+cid+"' and a.Keep_num < b.Item_num * a.Relese_unit LOCK IN SHARE MODE";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		System.out.println(cid+": "+query);
		if(rs.next()){
			conn.commit();
			pageContext.forward("purchase_fail.jsp");
		}
		else{

%>
<%
			//control concurrency by transaction
			
			System.out.print(conn.getTransactionIsolation());
			// ORDERS INCLUDE ITEM SHIPPINGCOMPANY ->lock
			//default public static final int  TRANSACTION_REPEATABLE_READ = 4
			//conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);//8


			
			try{
	
				//insert orders, delete include, update item keep_num, update shippingcomp - success
				SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
				java.util.Date currentTime = new java.util.Date ();
				String mTime = mSimpleDateFormat.format ( currentTime );
				System.out.println ( mTime );
				
				//get next order_no
				int ono=0;
				query = "select Order_no from ORDERS order by Order_no DESC limit 1 LOCK IN SHARE MODE";/////////////////////
				pstmt = conn.prepareStatement(query);
				System.out.println(cid+": "+query);
				rs = pstmt.executeQuery();
				if(rs.next()){
					ono = Integer.parseInt(rs.getString(1))+1;
				}
				//insert orders
				query = "select Item_id,Item_num from INCLUDE where Customer_id = '"+cid+"' LOCK IN SHARE MODE";
				pstmt = conn.prepareStatement(query);
				System.out.println(cid+": "+query);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String iid = rs.getString(1);
					int snum = Integer.parseInt(rs.getString(2));
					String query2 = "insert into ORDERS values ("+ono+", str_to_date('"+mTime+"','%Y-%m-%d'), '"+cid+"', '"+
									iid+"', "+snum+")";
					System.out.println(cid+": "+query2);
					pstmt = conn.prepareStatement(query2);
					cnt = pstmt.executeUpdate();
					
					//for ITEM lock in share mode
					
					String query4 = "select * from ITEM where Item_id = '"+iid+"' and Keep_num LOCK IN SHARE MODE";
					pstmt = conn.prepareStatement(query4);
					ResultSet rs2 = pstmt.executeQuery();
					System.out.println(cid+": "+query4);
					
					
					//update item Invalid value for getShort()
					String query3 = "update ITEM set Keep_num = Keep_num - "+snum+"*Relese_unit where Item_id = '"+iid+"'";
					System.out.println(cid+": "+query3);
					//System.out.println(query3);
					pstmt = conn.prepareStatement(query3);
					cnt = pstmt.executeUpdate();
				}
				
				//delete include
				query = "delete from INCLUDE where Customer_id = '"+cid+"'";
				System.out.println(cid+": "+query);
				pstmt = conn.prepareStatement(query);
				cnt = pstmt.executeUpdate();
				
				//update shipping
				query = "select C_shipname from CUSTOMER where Customer_id = '"+cid+"'";
				pstmt = conn.prepareStatement(query);
				System.out.println(cid+": "+query);
				rs = pstmt.executeQuery();
				String cname = null;
				if(rs.next()){
					cname = rs.getString(1);
				}
				
				
				//for SHIPPINGCOMPANY lock in share mode
				String query4 = "select * from SHIPPINGCOMPANY where Shippingcomp_name = '"+cname+"' LOCK IN SHARE MODE";
				pstmt = conn.prepareStatement(query4);
				ResultSet rs2 = pstmt.executeQuery();
				System.out.println(cid+": "+query4);
				
				
				query = "update SHIPPINGCOMPANY set Shippingcomp_count = Shippingcomp_count +1 where Shippingcomp_name = '"+cname+"'";
				pstmt = conn.prepareStatement(query);
				System.out.println(cid+": "+query);
				cnt = pstmt.executeUpdate();
				
				out.print("<div class=\"container\"><table><tr><th><h2>" + " [ purchasing is sucessed! ]" + "</h2></th></tr>");
				
				String nextpage = "<tr><td><form action=\"my_page.html\" method=\"POST\">" +
						"<input type=\"submit\" value=\"BACK\"/></td></tr>" +
						"</form></table></div>";
				out.print(nextpage);
	
				conn.commit();
				
				
			}
			catch(SQLException se){
				out.print("<h2>rollback1</h2>");
				conn.rollback(); 
			}
			
			System.out.print(conn.getTransactionIsolation());
			
			
			conn.commit();
			//conn.setTransactionIsolation(Connection.TRANSACTION_NONE);//0
			conn.close();
			out.print("<h2>rollback2</h2>");
		}

		out.print("<h2>rollback3</h2>");
	}
%>


</body>
</html>