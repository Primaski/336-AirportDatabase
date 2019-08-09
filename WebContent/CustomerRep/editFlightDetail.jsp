<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Selected Flight</title>
</head>
<body>
	<h1>Edit Selected Flight</h1>
	<br />
	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String editFlight = request.getParameter("toBeEdit");
			String query = "select *  from Flights where FlightID = '" + editFlight + "'";


			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(query);

			if (result.next() == false) {
				out.println("Result set is empty.");
			} else {

				String FlightID = result.getString(1);
				String RouteID = result.getString(2);
				String departDate = result.getString(3);
				String arriveDate = result.getString(4);
				String Tailnumber = result.getString(5);
				String fcp = result.getString(6);
				String bcp = result.getString(7);
				String ecp = result.getString(8);
				String firstCapacity = result.getString(9);
				String businessCapacity = result.getString(10);
				String economyCapacity = result.getString(11);
				
				session.removeAttribute("editFID");
				session.removeAttribute("editRID");
				session.removeAttribute("editDDAte");
				session.removeAttribute("editADate");
				session.removeAttribute("editTailnum");
				session.removeAttribute("editfcp");
				session.removeAttribute("editbcp");
				session.removeAttribute("editecp");
				session.removeAttribute("editfcc");
				session.removeAttribute("editbcc");
				session.removeAttribute("editecc");
				
				session.setAttribute("editFID", FlightID);
				session.setAttribute("editRID", RouteID);
				session.setAttribute("editDDAte", departDate);
				session.setAttribute("editADate", arriveDate);
				session.setAttribute("editTailnum", Tailnumber);
				session.setAttribute("editfcp", fcp);
				session.setAttribute("editbcp", bcp);
				session.setAttribute("editecp", ecp);
				session.setAttribute("editfcc", businessCapacity);
				session.setAttribute("editbcc", businessCapacity);
				session.setAttribute("editecc", economyCapacity);

			}

			con.close();

		} catch (Exception e) {
			out.print(e);
		}
	%>

	<form action="checkFlightUpdate.jsp" method="POST">
	

	Flight ID: <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="FlightID" 	value=<%=session.getAttribute("editFID")%> required /> <br />
	RouteID <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="tailNum"
			value=<%=session.getAttribute("editRID")%> required /> <br />
		Departure Date <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="depDate" 	value=<%=session.getAttribute("editDDAte")%> required /><br /> 
		Arrival Date <font color="red"><b>*</b></font>: <br /> <input type="text" name="arrDate"	value=<%=session.getAttribute("editADAte")%>		required /> <br />
		TailNumber <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="tailNum"
			value=<%=session.getAttribute("editTailnum")%> required /> <br />
		Economy Class Price: <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="economyPrice" 	value=<%=session.getAttribute("editecp")%> required /> <br /> 
		Business Class Price: <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="businessClassPrice" 	value=<%=session.getAttribute("editbcp")%> required /> <br /> 
		First Class Price: <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="firstClassPrice" 	value=<%=session.getAttribute("editfcp")%> required /> <br /> 	
		

		<input type="submit" value="Submit" />
	</form>
	<br />
	<a href="manageFlights.jsp">Return to Flights Menu</a>
</body>
</html>

