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
		if (TailNumber == "" || TailNumber == null || TailNumber.length() > 6) {
			out.println("Please provide a valid tail number");
			out.println("<a href=\"addAircraft.jsp\">Try Again</a>");
			return;
		} else {
			if (!TailNumber.equals(session.getAttribute("editTailnum"))) {

				rs = st.executeQuery("select * from Aircrafts where Tailnumber ='" + TailNumber + "'");

				if (rs.next()) {
					out.println("Sorry, this tailnumber is already in use!");
					out.println("<a href=\"addAircraft.jsp\">Try Again</a>");
					return;
				}
			} else {

				st.executeUpdate("UPDATE Aircrafts SET Tailnumber = '" + TailNumber + "' WHERE model = '"
						+ ModelNumber + "' AND color ='" + Color + "' AND AirlineCode = '" + AirlineCode + "'");
				out.println("Successfully Edited Tailnumber:  " + TailNumber + "<br/>");

				if (ModelNumber == null || !ModelNumber.equals(session.getAttribute("editModelNum"))) {
					st.executeUpdate("UPDATE Aircrafts SET model = '" + ModelNumber + "' WHERE Tailnumber = '"
							+ TailNumber + "'");
					out.println("Successfully Edited " + TailNumber + "'s Model number!" + "<br/>");
				} else {
					out.println("Model number was not updated." + "<br/>");
				}
				if (Color == null || !Color.equals(session.getAttribute("editColor"))) {
					st.executeUpdate(
							"UPDATE Aircrafts SET color = '" + Color + "' WHERE Tailnumber = '" + TailNumber + "'");
					out.println("Successfully Edited " + TailNumber + "'s Color!" + "<br/>");
				} else {
					out.println("Color was not updated." + "<br/>");
				}
				if (!AirlineCode.equals(session.getAttribute("editAirlineCode"))) {
					st.executeUpdate("UPDATE Aircrafts SET AirlineCode = '" + AirlineCode + "' WHERE Tailnumber = '"
							+ TailNumber + "'");
					out.println("Successfully Edited " + TailNumber + "'s Airline Code!" + "<br/>");
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