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
	<input type="submit" value="Submit" />
	<%
		String userid = request.getParameter("username");
		String pwd = request.getParameter("password");
		String firstName = request.getParameter("first");
		String lastName = request.getParameter("last");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zip = request.getParameter("zip");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://summercs336.ch54a1ii8pba.us-east-2.rds.amazonaws.com:3306/TravelDB", "sqlAdmin",
				"sqlPassword");
		Statement st = con.createStatement();
		ResultSet rs;
		if (!userid.equals(session.getAttribute("editUsername"))) {

			rs = st.executeQuery("select * from users where username='" + userid + "'");

			if (rs.next()) {
				out.println("Sorry, this username is already taken!"+"<br/>");
				out.println("<a href=\"editCustomerAccount.jsp\">Try Again</a>");
				return;
			} else {
				st.executeUpdate("UPDATE users SET username = '" + userid + "' WHERE firstName = '" + firstName
						+ "' AND lastName ='" + lastName + "' AND email = '" + email + "'");
				out.println("Successfully Edited username:  " + userid+"<br/>");

			}

		} else {

			if (pwd==null||!pwd.equals(session.getAttribute("editPassword"))){
				st.executeUpdate("UPDATE users SET password = '" + pwd + "' WHERE username = '" + userid + "'");
				out.println("Successfully Edited " + userid + "'s password!"+"<br/>");
			} else {
				out.println("Password was not updated."+"<br/>");
			}
			if (firstName==null||!firstName.equals(session.getAttribute("editFirstName"))){
				st.executeUpdate("UPDATE users SET firstName = '" + firstName + "' WHERE username = '" + userid + "'");
				out.println("Successfully Edited " + userid + "'s first Name!"+"<br/>");
			} else {
				out.println("First Name was not updated."+"<br/>");
			}
			if ( lastName==null||!lastName.equals(session.getAttribute("editLastName"))){
				st.executeUpdate("UPDATE users SET lastName = '" + lastName + "' WHERE username = '" + userid + "'");
				out.println("Successfully Edited " + userid + "'s Last Name!"+"<br/>");
			} else {
				out.println("Last Name was not updated."+"<br/>");
			}
			if (email==null||!email.equals(session.getAttribute("editEmailAddress"))){
				st.executeUpdate("UPDATE users SET password = '" + pwd + "' WHERE username = '" + userid + "'");
				out.println("Successfully Edited " + userid + "'s email!"+"<br/>");
			} else {
				out.println("Email was not updated."+"<br/>");
			}if (state==null||!state.equals(session.getAttribute("editState"))){
				st.executeUpdate("UPDATE users SET state = '" + state + "' WHERE username = '" + userid + "'");
				out.println("Successfully Edited " + userid + "'s state!"+"<br/>");
			} else {
				out.println("State was not updated."+"<br/>");
			}if (zip==null||!zip.equals(session.getAttribute("editZipCode"))&&zip.length()<5){
				st.executeUpdate("UPDATE users SET zip = '" + zip + "' WHERE username = '" + userid + "'");
				out.println("Successfully Edited " + userid + "'s Zip Code!"+"<br/>");
			} else {
				out.println("Zip Code was not updated."+"<br/>");
			}
		}
		con.close();
	%>
	<br />
	<a href="adminIndex.jsp">Back to Admin Menu</a>

</body>
</html>