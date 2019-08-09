<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verify</title>
</head>
<body>
	<h1>Confirm booking:</h1><br/>
	<% 
	try{
		String flightInfo = request.getParameter("flightInfo");
		String round = request.getParameter("round");
		boolean roundTrip = (round == null) ? false : true;
		
		///verify flight truly exists + get metadata
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		Statement stmt = con.createStatement();
		String[] splits = flightInfo.split("\\|");
		if(splits.length != 2){
			out.println("flight info meta data was compromised, please try again.");
			out.println("expected two arguments but received" + flightInfo);
			return;
		}
		String flightID = splits[0];
		String bci = splits[1];

		String bookedClass = (bci.equals("3")) ? 
				"economy" : ((bci.equals("2")) ? 
				"business" : "firstClass");
	
		String query = 	"SELECT * " +
						"FROM searchUtil " +
						"WHERE FlightID = " + flightID;
		ResultSet result = stmt.executeQuery(query);
		
		String price = "";
		String departAir = "";
		String arriveAir = "";
		if(result.next()){
			int capacity = -1;
			try{
				capacity = Integer.parseInt(result.getString(bookedClass + "Capacity"));
			}catch(NumberFormatException e){
				out.println("Expected capacity to be an integer, but was not parsable.");
				return;
			}catch(Exception e){
				e.printStackTrace();
				out.println("Error occurred while parsing capacity. Please check stack trace.");
				return;
			}
			switch(capacity){
				case -1:
					out.println("Error: Unable to receive capacity value");
					return;
				case 0:
					out.println("<h1>Oops!</h1><br/>" +
						"<h3>It turns out this flight is already full!</h3>");
					//TO-DO: WAITLIST INSTEAD
					return;
				default:
					break;
			}
			price = result.getString(bookedClass + "Price");
			departAir = result.getString("departAir");
			arriveAir = result.getString("arriveAir");
		}else{
			out.println("Flight does not exist! Try again."); return;
		}
				
		out.println("You are about to book a flight from <b>" + departAir + " to " + 
			arriveAir + "</b> in <b>" + bookedClass +  "</b> for $" + price + ".00. " + 
				"Are you sure you wish to do this?<br/><br/>" +
			"You will be able to cancel your reservation through your My Reservations page up to " +
			"24 hours before the flight's departure.<br/><br/>");
		out.println( 
		"<form action =\"bookFlightConfirmed.jsp\" method = \"POST\">" +
		"<input type = \"hidden\" name = \"flightInfo\" " +
		"value = \"" + flightInfo + "\" />" +
		((roundTrip) ? "<input type = \"hidden\" name = \"round\" " +
		"value = 1" + "\" />" : "") +
		"<input type =\"submit\" value = \"I'm sure, let's book it!\"> " +
		"</form>" + "</td><br/>"
		);
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
</body>
</html>