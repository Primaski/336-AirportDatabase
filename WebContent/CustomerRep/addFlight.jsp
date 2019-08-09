<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<title>Add Flight</title>


</head>

<body>

	<h1>Add Flight</h1>
	<br />
	<form action="checkFlightCreation.jsp" method="POST">
		Flight ID: <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="FlightID" required /> <br />
	Route ID:<font color="red"><b>*</b></font>: <br /> 	<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String str = "SELECT routeID FROM Routes";
		 
			Statement stmt = con.createStatement();
			ResultSet airports = stmt.executeQuery(str);
			out.println("<select name =\"RouteID\" onSelect=\"populate()\">");
			while (airports.next()) {
				out.println("<option>" + airports.getString(1));
			
			}
			airports.beforeFirst();//hi
			out.println("</select> <br/>");
			
			 con.close();
			
		%>

		Departure Date <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="depDate" required /><br /> 
		Departure Time <font color="red"><b>*</b></font>: <br /> <input type="text" name="depTime"			required /> <br />
		Tail Number:<font color="red"><b>*</b></font>: <br /> 
<%
			
			ApplicationDB db1 = new ApplicationDB();
			Connection con1 = db1.getConnection();
			String ac =request.getParameter("RouteID");
			//String ac="F9";
			String str1 = "SELECT Tailnumber FROM Aircrafts";
		 
			Statement stmt1 = con1.createStatement();
			ResultSet airports1 = stmt1.executeQuery(str1);
			out.println("<select name =\"TailNumber\"  >");
			while (airports1.next()) {
				out.println("<option>" + airports1.getString(1));
			}
			airports1.beforeFirst();//hi
			out.println("</select> <br/>");
			
			 con.close();
			
		%>

		Economy Class Price: <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="economyPrice" required /> <br /> 
		Business Class Price: <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="businessClassPrice" required /> <br /> 
		First Class Price: <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="firstClassPrice" required /> <br /> 	
		
       <input type="submit"value="Add Flight" />
	</form>
	<br />
	<a href="manageFlights.jsp">Return to Flights Menu</a>
</body>
</html>

