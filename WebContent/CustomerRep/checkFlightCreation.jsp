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
		ResultSet rs1 = st1.executeQuery(str1);
		if (rs1.next()) {
			compAirline = rs1.getString(1);

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
		}
		ResultSet rs = st.executeQuery("select * from Flights where FlightID ='" + FlightID + "'");

		if (rs.next()) {
			out.println("Sorry, this Flight ID is already in use!");
			out.println("<a href=\"addFlight.jsp\">Try Again</a>");
			return;
		} else {
			if (RouteID == "" || RouteID == null) {
				out.println("Please provide a model number!");
				out.println("<a href=\"addFlight.jsp\">Try Again</a>");
				return;
			} else if (depDate == "" || depDate == null) {
				out.println("Please provide a valid departure date!");
				out.println("<a href=\"addFlight.jsp\">Try Again</a>");
				return;
			} else if (TailNumber == "" || TailNumber == null && isValid == false) {
				out.println("Please provide valid Tailnumber for this route!");
				out.println("<a href=\"addFlight.jsp\">Try Again</a>");
				return;
			} else if (arrDate == "" || arrDate == null) {
				out.println("Please provide a valid departure date!");
				out.println("<a href=\"addFlight.jsp\">Try Again</a>");
				return;
			} else if (bcp == null || bcp == "" || fcp == null || fcp == "" || econ == null || econ == "") {
				out.println("Enter Valid prices.");
				out.println("<a href=\"addFlight.jsp\">Try Again</a>");
				return;
			}
			String capacityQuery = "select *  from AircraftModelsCapacity where model = (select model from Aircrafts where Tailnumber = '"
					+ TailNumber + "' )";

			Statement stmt2 = con.createStatement();
			ResultSet result2 = stmt2.executeQuery(capacityQuery);

			if (result2.next() == false) {
				out.println("Result set is empty.");
			} else {
				firstCapacity = result2.getString(2);
				businessCapacity = result2.getString(3);
				economyCapacity = result2.getString(4);
				session.removeAttribute("editfcc");
				session.removeAttribute("editbcc");
				session.removeAttribute("editecc");
				session.setAttribute("editfcc", businessCapacity);
				session.setAttribute("editbcc", businessCapacity);
				session.setAttribute("editecc", economyCapacity);
			}

			int rowsModified = st.executeUpdate("insert into Flights "
					+ "(FlightID, routeID, departDate, arriveDate, TailNumber, firstClassPrice, businessClassPrice,economyPrice, firstClassCapacity, businessClassCapacity, economyCapacity) values ('"
					+ FlightID + "','" + RouteID + "','" + depDate + "','" + arrDate + "','" + TailNumber + "','"
					+ fcp + "','" + bcp + "','" + econ + "','" + firstCapacity + "','" + businessCapacity + "','"
					+ economyCapacity + "')");
			if (rowsModified != 0) {
				out.println("Successfully created Flight " + FlightID + "! Have a safe Trip!");

			} else {
				out.println("No entries were added.");
			}
		}
	%>
	<br />
	<a href="customerRepIndex.jsp">Back to Rep Menu</a>

</body>
</html>