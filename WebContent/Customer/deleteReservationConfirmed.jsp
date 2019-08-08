<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

	
	<head><title>Deleting Reservation</title></head>
	<body>
		<% 
		try{
			String slatedForDeletion = request.getParameter("slatedForDeletion");
			
			if(slatedForDeletion == null || slatedForDeletion == ""){
				out.println("Oops! Error retrieving parameter."); return;
			}
			
			//format is: [ticketNo]: [metaData]
			//since metadata is irrelevant, we can cut out ticketNo and slate it for deletion
			
			String ticketNo = "";
			
			try{
				ticketNo = slatedForDeletion.split(":")[0];
			}catch (Exception e){
				out.println("Failed to retrieve ticket number slated for deletion");
				e.printStackTrace();
				return;
			}
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String flightClass = "";
			String flightID = "";
			
			//class necessary to increment flight capacity
			String getFlightInfoQuery =
					"SELECT FlightID, flightClass FROM Tickets WHERE TicketID = '" + ticketNo + "'";
			String deleteFromBuysQuery = 
					"DELETE FROM Buys WHERE TicketID = '" + ticketNo + "'";
			String deleteFromTicketsQuery = 
					"DELETE FROM Tickets WHERE TicketID = '" + ticketNo + "'";
			String incFlightCapacityQuery = "";
			
			try{
				ResultSet flightInfo = stmt.executeQuery(getFlightInfoQuery);
				flightInfo.next();
				flightID = flightInfo.getString("FlightID");
				flightClass = flightInfo.getString("flightClass");
				flightClass = ((flightClass == "business") ? "businessClass" : flightClass);
			}catch(Exception e){
				out.println("Failure in retrieving flight information.");
				e.printStackTrace();
				return;
			}
			
			try{
				Statement stmt2 = con.createStatement();
				int rowsAffected = stmt2.executeUpdate(deleteFromBuysQuery);
				if(rowsAffected != 1){
					//can't delete anything else, expected one
					out.println("Zero rows were deleted from Buys table. Unable to continue.");
					return;
				}
			}catch(Exception e){
				out.println("Failure in deleting ticket from Buys table.");
				e.printStackTrace();
				return;
			}
			
			try{
				Statement stmt3 = con.createStatement();
				int rowsAffected = stmt3.executeUpdate(deleteFromTicketsQuery);
				if(rowsAffected != 1){
					//can't update flight capacity, expected 1
					out.println("Zero rows were deleted from Flights table. Unable to continue.");
					return;
				}
			}catch(Exception e){
				out.println("Failure in deleting from Tickets table.");
				e.printStackTrace();
				return;
			}
			
			try{
				incFlightCapacityQuery = "UPDATE Flights SET " + 
						flightClass + "Capacity = " + flightClass + "Capacity + 1 WHERE FlightID = '" 
						+ flightID + "'";
				Statement stmt4 = con.createStatement();
				int rowsAffected = stmt4.executeUpdate(incFlightCapacityQuery);
				if(rowsAffected != 1){
					//failure needs to be reported to maintain capacity integrity
					out.println("Zero rows were deleted from Flights table. Unable to continue.");
					return;
				}
			}catch(Exception e){
				out.println("Failure in incrementing capacity from Flights table. Unable to continue.");
				e.printStackTrace();
				return;
			}		
		}catch(Exception e){
			e.printStackTrace();
		}
		%>
		
		<h1>Success!</h1>
		<h3>Successfully deleted your reservation from the database. Please check 
		<a href= "viewReservations.jsp">My Reservations</a> to confirm!</h3>
	</body>
</html>
	