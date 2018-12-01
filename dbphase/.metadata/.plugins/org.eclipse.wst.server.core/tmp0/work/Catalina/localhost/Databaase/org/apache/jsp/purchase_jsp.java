/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.35
 * Generated at: 2018-12-01 11:06:10 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.*;
import java.sql.*;
import java.util.*;

public final class purchase_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.text");
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<meta charset=\"UTF-8\">\n");
      out.write("<link rel='stylesheet' type='text/css' href='mystyle.css'>\n");
      out.write("<title>Insert title here</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");

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

      out.write('\n');

	
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
	

      out.write('\n');
      out.write('\n');
      out.write('\n');

		
		//do purchase
		//stock lack-fail
		query = "select a.Item_id,b.Item_num from ITEM a,INCLUDE b where a.Item_id = b.Item_id and b.Customer_id = '"+cid+"' and a.Keep_num < b.Item_num * a.Relese_unit LOCK IN SHARE MODE";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		System.out.println(cid+": "+query);
		if(rs.next()){
			pageContext.forward("purchase_fail.jsp");
		}
		else{


      out.write('\n');

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
					/*
					String query4 = "select * from ITEM where Item_id = '"+iid+"' and Keep_num LOCK IN SHARE MODE";
					pstmt = conn.prepareStatement(query4);
					ResultSet rs2 = pstmt.executeQuery();
					System.out.println(cid+": "+query4);
					*/
					
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
				conn.rollback(); 
			}
			
			System.out.print(conn.getTransactionIsolation());
			
			
			conn.commit();
			//conn.setTransactionIsolation(Connection.TRANSACTION_NONE);//0
			conn.close();
		}
	}

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
