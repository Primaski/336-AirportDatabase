<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Get Waitlist</title>
</head>
<body>
	<h1>Search Flight Wait Lists By FlightID</h1>
	<h2></h2>
	<br />
	<form action="getWaitlistResults.jsp" method="POST">
		Flight ID: <br /> 	<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			Statement stmt = con.createStatement();
			String str = "SELECT FlightID FROM Flights";
			ResultSet airports = stmt.executeQuery(str);
			out.println("<select name =\"toBeEd\">");
			while (airports.next()) {
				out.println("<option>" + airports.getString(1));
			}
			airports.beforeFirst();//hi
			out.println("</select> <br/>");
		%> <br />
		<input type="submit" value="Return Waitlist for Flight" />
	</form>
	<br />
	<a href="customerRepIndex.jsp">Back to Rep Menu</a>



</body>
</html>