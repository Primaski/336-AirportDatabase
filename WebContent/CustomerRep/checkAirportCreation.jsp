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
		String airportCode = request.getParameter("AirportCode");
		String airportName = request.getParameter("AirportName");
		String address = request.getParameter("Address");
		String city = request.getParameter("City");
		String state = request.getParameter("State");
		String country = request.getParameter("Country");
		String zip = request.getParameter("zipCode");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://summercs336.ch54a1ii8pba.us-east-2.rds.amazonaws.com:3306/TravelDB", "sqlAdmin",
				"sqlPassword");
		Statement st = con.createStatement();
		ResultSet rs;
		if (airportCode == "" || airportCode == null || airportCode.length() > 3) {
			out.println("Airport code invalid");
			out.println("<a href=\"addAirport.jsp\">Try Again</a>");
			return;
		}
		rs = st.executeQuery("select * from Airports where AirportCode='" + airportCode + "'");

		if (rs.next()) {
			out.println("Sorry, this airportCode already exists!");
			out.println("<a href=\"addAirport.jsp\">Try Again</a>");
			return;
		} else {
			if (airportName == "" || airportName == null) {
				out.println("This airport name is invalid!");
				out.println("<a href=\"addAirport.jsp\">Try Again</a>");
				;
				return;
			} else if (address == null || address == "" || city == null || city == "" || city == null
					|| city == "") {
				out.println("address and city invalid.");
				out.println("<a href=\"addAirport.jsp\">Try Again</a>");
				return;
			} else if (state.length() > 2) {
				out.println("Please provide only state INITIALS (2 characters).");
				out.println("<a href=\"addAirport.jsp\">Try Again</a>");
				return;
			}
			int rowsModified = st.executeUpdate("insert into Airports "
					+ "(AirportCode, displayName, address, city, state, country, zipCode) values ('" + airportCode
					+ "','" + airportName + "','" + address + "','" + city + "','" + state + "','" + country + "','"
					+ zip + "')");
			if (rowsModified != 0) {
				out.println("Successfully added " + airportCode + "!");
			} else {
				out.println("No entries were added.");
			}
		}
		con.close();
	%>
	<br />
	<a href="customerRepIndex.jsp">Back to Customer Rep</a>

</body>
</html>