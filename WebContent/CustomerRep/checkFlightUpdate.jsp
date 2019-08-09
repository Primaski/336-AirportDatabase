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
	<%
		String FlightID = request.getParameter("FlightID");
		String RouteID = request.getParameter("RouteID");
		String depDate = request.getParameter("depDate");
		String arrDate = request.getParameter("arrDate");
		String TailNumber = request.getParameter("tailNum");
		String econ = request.getParameter("economyPrice");
		String bcp = request.getParameter("businessClassPrice");
		String fcp = request.getParameter("firstClassPrice");
		String firstCapacity="";
		String businessCapacity="";
		String economyCapacity="";

		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://summercs336.ch54a1ii8pba.us-east-2.rds.amazonaws.com:3306/TravelDB", "sqlAdmin",
				"sqlPassword");
		Statement st = con.createStatement();
		 

		String str1 = "SELECT AirlineCode FROM Aircrafts WHERE TailNumber = '" + TailNumber + "'";
		String compAirline="";
		boolean isValid = false;
		Statement st1 = con.createStatement();
		ResultSet rs = st1.executeQuery(str1);
		if (rs.next()) {
			compAirline = rs.getString(1);

		}

		String str2 = "SELECT AirlineCode FROM Routes WHERE routeID = '" + RouteID + "'";
		String compAirline2="";
		Statement st2 = con.createStatement();
		ResultSet rs2 = st2.executeQuery(str1);
		if (rs2.next()) {
			compAirline2 = rs2.getString(1);

		}
		if (compAirline.equals(compAirline2)) {
			isValid = true;
		}
		if (FlightID == "" || FlightID == null || FlightID.length() > 6) {
			out.println("Please provide a FlightID");
			out.println("<a href=\"addFlight.jsp\">Try Again</a>");
			return;
		} else {
			if (!FlightID.equals(session.getAttribute("editFID")))

				rs = st.executeQuery("select * from Flights where FlightID ='" + FlightID + "'");

			if (rs.next()) {
				out.println("Sorry, this Flight ID is already in use!");
				out.println("<a href=\"addFlight.jsp\">Try Again</a>");
				return;
			} else {
				
				
					st.executeUpdate("UPDATE Flights SET FlightID = '"+FlightID+"' Where routeID = '"+ RouteID + "' AND departDate ='" + depDate + "' AND arriveDate= = '" + arrDate
								+ "' AND TailNumber ='" + TailNumber + "'");
						out.println("Successfully Edited airport code:  " + FlightID + "<br/>");

						

			
			}
		}
	%>
	<br />
	<a href="customerRepIndex.jsp">Back to Rep Menu</a>

</body>
</html>