<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airport Update Results</title>
</head>
<body>
	<%
	String airportcode = request.getParameter("AirportCode");
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
		if (airportcode == "" || airportcode == null || airportcode.length() > 3) {
			out.println("Please provide a valid airport Code");
			out.println("<a href=\"addAirport.jsp\">Try Again</a>");
			return;
		} else {
			if (!airportcode.equals(session.getAttribute("editAirportCode"))) {

				rs = st.executeQuery("select * from Airports where airportcode ='" + airportcode + "'");

				if (rs.next()) {
					out.println("Sorry, this Airport Code is already in use!");
					out.println("<a href=\"addAirport.jsp\">Try Again</a>");
					return;
				}
			} else {

				st.executeUpdate("UPDATE Airports SET airportCode = '" + airportcode + "' WHERE displayName = '"
						+ airportName + "' AND address ='" + address + "' AND city = '" + city + "'" + "' AND state ='" + state + "' AND country = '" + country + "' AND zipCode = '" + zip + "'");
				out.println("Successfully Edited airport code:  " + airportcode + "<br/>");

	
				if (airportName == null || !airportName.equals(session.getAttribute("editAirportName"))) {
					st.executeUpdate(
							"UPDATE Airports SET displayName = '" + airportName + "' WHERE airportcode = '" + airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Name!" + "<br/>");
				} else {
					out.println("Name was not updated." + "<br/>");
				}
				if (!address.equals(session.getAttribute("editAddress"))) {
					st.executeUpdate("UPDATE Airports SET address = '" + address + "' WHERE airportcode = '"
							+ airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Address!" + "<br/>");
				} else {
					out.println("Address was not updated." + "<br/>");
				}
				if (city == null || !city.equals(session.getAttribute("editCity"))) {
					st.executeUpdate("UPDATE Airports SET city = '" + city + "' WHERE airportcode = '"
							+ airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s city!" + "<br/>");
				} else {
					out.println("City was not updated." + "<br/>");
				}
				if (state == null || !state.equals(session.getAttribute("editState"))) {
					st.executeUpdate(
							"UPDATE Airports SET state = '" + state + "' WHERE airportcode = '" + airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s State!" + "<br/>");
				} else {
					out.println("State was not updated." + "<br/>");
				}
				if (!country.equals(session.getAttribute("editCountry"))) {
					st.executeUpdate("UPDATE Airports SET country = '" + country + "' WHERE airportcode = '"
							+ airportcode + "'");
					out.println("Successfully Edited " + airportcode + "'s Country!" + "<br/>");
				} else {
					out.println("Country was not updated." + "<br/>");
				}
			}
		}

		con.close();
	%>
	<br />
	<a href="customerRepIndex.jsp">Back to Rep Menu</a>

</body>
</html>