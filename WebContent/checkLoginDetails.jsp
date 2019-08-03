<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String userid = request.getParameter("username");
		String pwd = request.getParameter("password");
		String myUserRole;
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://summercs336.ch54a1ii8pba.us-east-2.rds.amazonaws.com:3306/TravelDB", "sqlAdmin",
				"sqlPassword");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
		if (rs.next()) {
			try{
				myUserRole = rs.getString("userRole");

				if (myUserRole.equals("Admin")) {
					session.setAttribute("user", userid); // the username will be stored in the session
					out.println("welcome " + userid);
					out.println("<a href='logout.jsp'>Log out</a>");
					response.sendRedirect("Admin/adminIndex.jsp");
				} else if (myUserRole.equals("Customer")) {
					session.setAttribute("user", userid); // the username will be stored in the session
					out.println("welcome " + userid);
					out.println("<a href='logout.jsp'>Log out</a>");
					response.sendRedirect("Customer/customerIndex.jsp");
				} else if (myUserRole.equals("Customer Rep")) {
					session.setAttribute("user", userid); // the username will be stored in the session
					out.println("welcome " + userid);
					out.println("<a href='logout.jsp'>Log out</a>");
					response.sendRedirect("CustomerRep/customerRepIndex.jsp");
				} else {

					session.setAttribute("user", userid); // the username will be stored in the session
					out.println("welcome " + userid);
					out.println("<a href='logout.jsp'>Log out</a>");
					response.sendRedirect("success.jsp");
				}
			}catch (Exception e){
				e.printStackTrace();
			}
		} else {
			out.println("Invalid username or password <a href='login.jsp'>try again</a>");
		}
	%>

</body>
</html>