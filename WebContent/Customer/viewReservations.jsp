<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String failureMessage = "<h1>Oops! It seems you're not logged in.</h1>";
	Object user = null;
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
	
	//Retrieve user flights - NON-WAIT LISTED
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		
	Statement stmt = con.createStatement();
	
	String query =
			"SELECT * from Buys where Username = '" + user.toString() + "'";
		;
		
	ResultSet pretickets = stmt.executeQuery(query);
	boolean initialRow = false;
	try{
		if(!pretickets.next()){
			out.println("<h3>You have no flight reservations.</h3>");
		}else{
			do{
				String ticketID = pretickets.getString("ticketID");
				String boughtOn = pretickets.getString("boughtOn");
				String price = pretickets.getString("price");
				
				
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
				info.next();
				
				//generate new table row - check if initial
				if(!initialRow){
					out.println("<h1>Your reservations:</h1><br><br>");
					out.println("<table border = \"1\">");
					out.println("<tr>");
					out.println("<th>Ticket ID</th>");
					out.println("<th>Flight ID</th>");
					out.println("<th>Departing From</th>");
					out.println("<th>On</th>");
					out.println("<th>At</th>");
					out.println("<th>Arriving At</th>");
					out.println("<th>On</th>");
					out.println("<th>At</th>");
					out.println("<th>Airline</th>");
					out.println("<th>Class</th>");
					out.println("<th>Cost</th>");
					out.println("<th>Purchase Date</th>");
					out.println("</tr>");
					initialRow = true;
				}
				
				out.println("<tr>");
				out.println("<th>" + ticketID + "</th>");
				out.println("<th>" + flightID + "</th>");
				out.println("<th>" + info.getString("departDisplayName") + "</th>");
				out.println("<th>" + info.getString("departDate") + "</th>");
				out.println("<th>" + info.getString("departTime") + "</th>");
				out.println("<th>" + info.getString("arriveDisplayName") + "</th>");
				out.println("<th>" + info.getString("arrivalDate") + "</th>");
				out.println("<th>" + info.getString("arrivalTime") + "</th>");
				out.println("<th>" + info.getString("airlineDisplayName") + "</th>");
				out.println("<th>" + flightClass + "</th>");
				out.println("<th>" + price + "</th>");
				out.println("<th>" + boughtOn + "</th>");
				
			}while(pretickets.next());
			out.println("</tr>");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	%>
	
	<h3>Were you looking to cancel a reservation?<br/>
	<a href = "deleteReservation.jsp">Delete My Reservations</a></h3>
</body>
</html>
