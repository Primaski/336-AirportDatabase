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
	String airportcode = request.getParameter("airportcode");
	String airportName = request.getParameter("AirportName");
	String address = request.getParameter("Address");
	String city = request.getParameter("City");
	String state = request.getParameter("State");
	String country = request.getParameter("Country");
	String zip = request.getParameter("zipCode");

	Class.forName("com.mysql.jdbc.Driver");
			Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://summercs336.ch54a1ii8pba.us-east-2.rds.amazonaws.com:3306/TravelDB", "sqlAdmin",
				"sqlPassword");
		Statement st = con.createStatement();
		ResultSet rs;
		if (airportcode == "" || airportcode == null || airportcode.length() <= 3) {
			out.println("Please provide a valid tail number");
			out.println("<a href=\"addAircraft.jsp\">Try Again</a>");
			return;
		} else {
			if (!airportcode.equals(session.getAttribute("editairportcode"))) {

				rs = st.executeQuery("select * from Airports where airportcode ='" + airportcode + "'");

				if (rs.next()) {
					out.println("Sorry, this Airport Code is already in use!");
					out.println("<a href=\"addAirportt.jsp\">Try Again</a>");
					return;
				}
			} else {

				st.executeUpdate("UPDATE Airports SET airportcode = '" + airportcode + "' WHERE model = '"
						+ ModelNumber + "' AND color ='" + Color + "' AND AirlineCode = '" + AirlineCode + "'");
				out.println("Successfully Edited airport code:  " + airportcode + "<br/>");

				if (ModelNumber == null || !ModelNumber.equals(session.getAttribute("editModelNum"))) {
					st.executeUpdate("UPDATE Airports SET model = '" + ModelNumber + "' WHERE airportcode = '"
							+ airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Model number!" + "<br/>");
				} else {
					out.println("Model number was not updated." + "<br/>");
				}
				if (Color == null || !Color.equals(session.getAttribute("editColor"))) {
					st.executeUpdate(
							"UPDATE Airports SET color = '" + Color + "' WHERE airportcode = '" + airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Color!" + "<br/>");
				} else {
					out.println("Color was not updated." + "<br/>");
				}
				if (!AirlineCode.equals(session.getAttribute("editAirlineCode"))) {
					st.executeUpdate("UPDATE Airports SET AirlineCode = '" + AirlineCode + "' WHERE airportcode = '"
							+ airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Airline Code!" + "<br/>");
				} else {
					out.println("Airline Code was not updated." + "<br/>");
				}
				if (ModelNumber == null || !ModelNumber.equals(session.getAttribute("editModelNum"))) {
					st.executeUpdate("UPDATE Airports SET model = '" + ModelNumber + "' WHERE airportcode = '"
							+ airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Model number!" + "<br/>");
				} else {
					out.println("Model number was not updated." + "<br/>");
				}
				if (Color == null || !Color.equals(session.getAttribute("editColor"))) {
					st.executeUpdate(
							"UPDATE Airports SET color = '" + Color + "' WHERE airportcode = '" + airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Color!" + "<br/>");
				} else {
					out.println("Color was not updated." + "<br/>");
				}
				if (!AirlineCode.equals(session.getAttribute("editAirlineCode"))) {
					st.executeUpdate("UPDATE Airports SET AirlineCode = '" + AirlineCode + "' WHERE airportcode = '"
							+ airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Airline Code!" + "<br/>");
				} else {
					out.println("Airline Code was not updated." + "<br/>");
				}
			}
		}

		con.close();
	%>
	<br />
	<a href="customerRepIndex.jsp">Back to Rep Menu</a>

</body>
</html>