<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

	
	<head><title>Delete Reservation</title></head>
	<body>
	<% 
	String failureMessage = "<h1>Oops!</h1><br> <h3>It seems you're not logged in.</h3>";
	Object user;
	try{
		user = session.getAttribute("user");
		if(user == null){
			out.println(failureMessage);
			return;
		}
	}catch(Exception e){
		out.println(failureMessage);
		return;
	}
	
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement st = con.createStatement();
		String query = "SELECT * FROM Buys WHERE Username = '" + user.toString() + "'";
		ResultSet rs = st.executeQuery(query);
		
		//iterate through each ticket
		if(!rs.next()){
			out.println("<h1>You have no flights booked!</h1>");
			return;
		}else{
			out.println("<form action=\"deleteReservationConfirmed.jsp\" method=\"POST\">");
			out.println("<h1>Cancellable Flight Reservations</h1>");
			out.println("<select name =\"slatedForDeletion\">");
			do{
				String ticketID = rs.getString("ticketID");
				
				Statement stmt2 = con.createStatement();
				String subquery = "SELECT * from Tickets where TicketID = '" + ticketID + "'";
				
				//there is guaranteed to be at least 1 due to foreign key constraint from Buys
				//and no more than 1 due to primary key constraint of Tickets 
				ResultSet tickets = stmt2.executeQuery(subquery);
				tickets.next();
				String flightID = tickets.getString("FlightID");
				String flightClass = tickets.getString("flightClass");
				
				//there is also guaranteed to be at least 1 flight due to foreign key constraint from Tickets
				//and no more than 1 due to primary key constraint of Flights - which searchUtil takes advantage of
				
				Statement stmt3 = con.createStatement();
				String expandedQuery = "SELECT * FROM searchUtil WHERE FlightID = '" + flightID + "'";
				ResultSet info = stmt3.executeQuery(expandedQuery);	
			
				//populate drop down menu
				while(info.next()){
					out.println("<option>" + 
					ticketID + ": " +
					info.getString("departAir") + " --> " +
					info.getString("arriveAir") + " on " +
					info.getString("departDate") + " via " +
					info.getString("airlineCode")
					+ "</option>");
				}	
			}while(rs.next());
			out.println("</select>");
			out.println("<input type=\"submit\" value=\"Submit\"/>");
			out.println("</form>");
		}
	%>
	<h3><br/>This is irreversible. Please double check before pressing Confirm that you really want to delete 
	this reservation. You are not guaranteed to be able to book again, as wait listed users may claim the 
	vacany you have opened up.</h3>
	</body>
</html>
	