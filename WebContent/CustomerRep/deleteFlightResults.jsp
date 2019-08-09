<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remaining Flights</title>
</head>
<head>
<title></title>
</head>
<body>
	<h1>
		<b>Remaining Flights</b>
	</h1>

	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String delFlight = request.getParameter("toBeDel");
			//String selQuery = "select * from Flights where FlightID = '" + delFlight + "'";
			String delQuery="delete  from Flights where FlightID = '"+ delFlight + "'";
			Statement stmt = con.createStatement();
			//ResultSet result = stmt.executeQuery(selQuery);
			stmt.executeUpdate(delQuery);
			String query = "Select * from Airports";
			ResultSet result = stmt.executeQuery(query);
			if (result.next() == false) {
				out.println("Result set is empty.");
			} else {
				do {
					out.println("Flight ID:" + result.getString(1) + "  RouteID:   " + result.getString(2)
							+ "   DepDate:     " + result.getString(3) + "   ArrivalDate:    " + result.getString(4)
							+ "<br/>");
				} while (result.next());
			}
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
	%>
	<br />
	<a href="manageFlights.jsp">Return to Airports Menu</a>
</body>
</html>