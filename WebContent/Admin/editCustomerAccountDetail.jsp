<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%><!DOCTYPE html>
<html>
<head>
<title>Edit Account</title>
</head>
<body>
	<h1>To Modify Username, first name, last name and email cannot be changed!</h1>
	<br />
	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String editAccount = request.getParameter("toBeEdit");
			String query = "select *  from users where username = '" + editAccount + "'";

			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(query);

			if (result.next() == false) {
				out.println("Result set is empty.");
			} else {
				//(username, password, userRole, address, city, state, zip, email, firstName, lastName)
				String Username = result.getString(1);
				String Password = result.getString(2);
				//String UserRole = result.getString(3);
				String StreetAddress = result.getString(4);
				String City = result.getString(5);
				String State = result.getString(6);
				String ZipCode = result.getString(7);
				String EmailAddress = result.getString(8);
				String FirstName = result.getString(9);
				String LastName = result.getString(10);
				
				

				session.removeAttribute("editUsername");
				session.removeAttribute("editPassword");
				session.removeAttribute("editFirstName");
				session.removeAttribute("editLastName");
				session.removeAttribute("editEmailAddress");
				session.removeAttribute("editStreetAddress");
				session.removeAttribute("editCity");
				session.removeAttribute("editState");
				session.removeAttribute("editZipCode");

				session.setAttribute("editUsername", Username);
				session.setAttribute("editPassword", Password);
				session.setAttribute("editFirstName", FirstName);
				session.setAttribute("editLastName", LastName);
				session.setAttribute("editEmailAddress", EmailAddress);
				session.setAttribute("editStreetAddress", StreetAddress);
				session.setAttribute("editCity", City);
				session.setAttribute("editState", State);

				session.setAttribute("editZipCode", ZipCode);

			}

			con.close();

		} catch (Exception e) {
			out.print(e);
		}
	%>
	<form action="checkCustomerAccountUpdate.jsp" method="POST">
		Username <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="username" value=<%=session.getAttribute("editUsername")%>
			required /> <br /> Password <font color="red"><b>*</b></font>: <br />
		<input type="password" name="password"
			value=<%=session.getAttribute("editPassword")%> required /> <br />
		First Name <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="first"
			value=<%=session.getAttribute("editFirstName")%> required /> <br />
		Last Name <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="last"
			value=<%=session.getAttribute("editLastName")%> required /> <br />
		Email Address<font color="red"><b>*</b></font>: <br /> <input
			type="text" name="email"
			value=<%=session.getAttribute("editEmailAddress")%> required /> <br />
		Street Address: <br /> <input type="text" name="address"
			value=<%=session.getAttribute("editStreetAddress")%> /> <br />
		City: <br /> <input type="text" name="city"
			value=<%=session.getAttribute("editCity")%> /> <br /> State:<br />
		<input type="text" name="state"
			value=<%=session.getAttribute("editState")%> /> <br />  Zip Code:<br />
		<input type="text" name="zipCode"
			value=<%=session.getAttribute("editZipCode")%> /> <br /><br /> <input
			type="submit" value="Edit Account" />
	</form>
	<br />
	<a href="adminIndex.jsp">Back to Admin Menu</a>
</body>
</html>