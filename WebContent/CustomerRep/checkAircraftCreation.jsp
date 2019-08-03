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
		String TailNumber = request.getParameter("tailNum");
		String ModelNumber = request.getParameter("modelNum");
		String Color = request.getParameter("color");
		String AirlineCode = request.getParameter("airlineCode");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://summercs336.ch54a1ii8pba.us-east-2.rds.amazonaws.com:3306/TravelDB", "sqlAdmin",
				"sqlPassword");
		Statement st = con.createStatement();
		ResultSet rs;
		if (TailNumber == "" || TailNumber == null||TailNumber.length()>6) {
			out.println("Please provide a valid tail number");
			out.println("<a href=\"addAircraft.jsp\">Try Again</a>");
			return;
		}
		rs = st.executeQuery("select * from Aircrafts where Tailnumber ='" + TailNumber + "'");

		if (rs.next()) {
			out.println("Sorry, this tailnumber is already in use!");
			out.println("<a href=\"addAircraft.jsp\">Try Again</a>");
			return;
		} else {
			if (ModelNumber == "" || ModelNumber == null) {
				out.println("Please provide a model number!");
				out.println("<a href=\"addAircraft.jsp\">Try Again</a>");
				return;
			} else if (AirlineCode == null || AirlineCode == "" || Color == null || Color == "") {
				out.println("Airline or color invalid.");
				out.println("<a href=\"addAircraft.jsp\">Try Again</a>");
				return;
			}
			int rowsModified = st
					.executeUpdate("insert into Aircrafts " + "(Tailnumber, model, color, AirlineCode) values ('"
							+ TailNumber + "','" + ModelNumber + "','" + Color + "','" + AirlineCode + "')");
			if (rowsModified != 0) {
				out.println("Successfully created " + TailNumber + "'s registration! Have a safe Flight!");
			} else {
				out.println("No entries were added.");
			}
		}
	%>
	<br />
	<a href="customerRepIndex.jsp">Back to Rep Menu</a>

</body>
</html>