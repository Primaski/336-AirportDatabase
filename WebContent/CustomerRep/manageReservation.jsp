<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>


<head>
<title>Manage Reservation</title>
</head>
<body>
	<h1>
		<b>Select a Customer to assist</b>
	</h1>
	<b>Customer Username: </b>
	<font color="red"><b>*</b></font>
	<form action="repCreateRes.jsp" method="POST">
		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			Statement stmt = con.createStatement();
			String str = "SELECT username FROM users where userRole = 'Customer'";
			ResultSet airports = stmt.executeQuery(str);
			out.println("<select name =\"repSelUser\">");
			while (airports.next()) {
				out.println("<option>" + airports.getString(1));
			}
			airports.beforeFirst();//hi
			out.println("</select> <br/>");
			con.close();
		%>
		<br /> <input type="submit" value="Select Customer" />
	</form>

	<a href="customerRepIndex.jsp">Back to Rep Menu</a>
</body>
</html>