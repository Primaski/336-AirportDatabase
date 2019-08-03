<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<title>Add Aircraft</title>
</head>
<body>
	<h1>Add Aircraft</h1>
	<br />
	<form action="checkAircraftCreation.jsp" method="POST">
		TailNumber <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="tailNum" required /> <br /> ModelNumber <font
			color="red"><b>*</b></font>: <br /> <input type="text"
			name="modelNum" required /> <br /> Color <font color="red"><b>*</b></font>:
		<br /> <input type="text" name="color" required /> <br /> AirlineCode
		<%
 	ApplicationDB db = new ApplicationDB();
 	Connection con = db.getConnection();
 	String str = "SELECT AirlineCode FROM Airlines";
 	Statement stmt = con.createStatement();
 	ResultSet airports = stmt.executeQuery(str);
 	out.println("<select name =\"airlineCode\">");
 	while (airports.next()) {
 		out.println("<option>" + airports.getString(1));
 	}
 	airports.beforeFirst();//hi
 	out.println("</select> <br/>");
 %>

		<input type="submit" value="Submit" />
	</form>
	<br />
	<a href="manageAircrafts.jsp">Return to Aircrafts Menu</a>
</body>
</html>

