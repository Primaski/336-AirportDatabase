<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>accountRec</title>
</head>
<body>
       <input type="submit" value="Submit"/>
	<%
		String userid = request.getParameter("username");
		String pwd = request.getParameter("password");
		String firstName = request.getParameter("first");
		String lastName = request.getParameter("last");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zip = request.getParameter("zipCode");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://summercs336.ch54a1ii8pba.us-east-2.rds.amazonaws.com:3306/TravelDB", "sqlAdmin",
				"sqlPassword");
		Statement st = con.createStatement();
		ResultSet rs;
		if(userid == "" || userid == null){
			out.println("Please provide a username and password!");
			out.println("<a href=\"createaccount.jsp\">Try Again</a>");
			return;
		}
		rs = st.executeQuery("select * from users where username='" + userid + "'");
		
		if (rs.next()) {
			out.println("Sorry, this username is already taken!");
			out.println("<a href=\"createaccount.jsp\">Try Again</a>");
			return;
		} else {
			if(pwd == "" || pwd == null){
				out.println("Please provide a password!");
				out.println("<a href=\"createaccount.jsp\">Try Again</a>");
				return;
			}else if(firstName == null || firstName == "" || lastName == null || 
				lastName == "" || email == null || email == "" ){
				out.println("First name, last name and email are required fields.");
				out.println("<a href=\"createaccount.jsp\">Try Again</a>");
				return;
			}else if(state.length()> 2){
				out.println("Please provide only state INITIALS (2 characters).");
				out.println("<a href=\"createaccount.jsp\">Try Again</a>");
				return;
			}else if(zip.length()> 5){
				out.println("Please enter a valid postal code.");
				out.println("<a href=\"createaccount.jsp\">Try Again</a>");
				return;
			}
			int rowsModified = st.executeUpdate("insert into users "
					+ "(username, password, userRole, address, city, state, zip, email, firstName, lastName) values ('" +
			  userid + "','" +
			  pwd  + 
			  "','Customer','"+
			  address  + "','" +
			  city  + "','" +
			  state  + "','" +
			  zip  + "','" +
			  email  + "','" +
			  firstName  + "','" +
			  lastName  + "')");
			if(rowsModified != 0){
				out.println("Successfully created " + userid + "'s account! Please log in.");
			}else{
				out.println("No entries were added.");
			}
		}
		
		%>
		<br/>
     <a href="login.jsp">Log In</a>

</body>
</html>