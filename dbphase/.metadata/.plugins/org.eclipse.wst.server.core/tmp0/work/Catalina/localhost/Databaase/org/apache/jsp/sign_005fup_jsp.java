/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.35
 * Generated at: 2018-11-29 11:37:25 UTC
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

public final class sign_005fup_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<title>Sign up success</title>\n");
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
ResultSet rs;
ResultSetMetaData rsmd;
int cnt;
String query;
conn.setAutoCommit(false);

      out.write('\n');
      out.write('\n');

//check Customer_id Redundancy
	query = "select * from CUSTOMER where Customer_id = '" + request.getParameter("signUpID") +"'"; 
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	if(rs.next()){
		//id exist
		pageContext.forward("signup_fail.jsp");
	}
	//else go to sing up 
	

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

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
	else{
		c_ship = "han";
	}
	
	String name;
	if(request.getParameter("signUpNAME").isEmpty()){
		name = "null";
		
	}else
	{
		name = "'"+request.getParameter("signUpNAME")+"'";
	}	

	String phone;
	if(request.getParameter("signUpPHONE_NUMBER").isEmpty()){
		phone="null";
	}
	else{
		phone = "'"+request.getParameter("signUpPHONE_NUMBER")+ "'";
	}
	
	String job;
	if(request.getParameter("signUpJOB").isEmpty()){
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
	int age;
	if(request.getParameter("signUpAGE").isEmpty()){
		age=0;
	}
	else{
		age =  Integer.parseInt(request.getParameter("signUpAGE"));
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
			+ age+", "
			+ "'"+c_ship +"' )";
	
	//out.print("<h6>"+ query +"</h6>");

	
	pstmt = conn.prepareStatement(query);
	cnt = pstmt.executeUpdate();
	
	if(cnt==0){
		System.out.println("insert success!");
	}
	
	int a=0;
	query = "SELECT Shoppingbag_no FROM SHOPPINGBAG ORDER BY Shoppingbag_no DESC LIMIT 1";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		a = Integer.parseInt(rs.getString(1))+1;
	}
	
	
	query = "INSERT INTO SHOPPINGBAG VALUES ('"+request.getParameter("signUpID")+"', "+a+")";
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
	
	
	out.print("<h2>"+a+"</h2>");

      out.write("\n");
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
