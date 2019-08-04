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

		//verify flight truly exists + get metadata
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		Statement stmt = con.createStatement();
		
		String[] splits = flightInfo.split("\\|");
		if(splits.length != 5){
			out.println("flight info meta data was compromised, please try again.");
			out.println("expected five arguments but received" + flightInfo);
			return;
		}
	
		String departAir = splits[0];
		String arriveAir = splits[1];
		String airlineCode = splits[2];
		String departDate = splits[3];
		String bci = splits[4];
	
		String bookedClass = (bci.equals("3")) ? 
				"economy" : ((bci.equals("2")) ? 
				"business" : "firstClass");
	
		String query = 	"SELECT " + bookedClass + "Price " +
						"FROM FlightsExpanded " +
						"WHERE departAir = '" + departAir + "' and " +
							   "arriveAir = '" + arriveAir + "' and " +
							   "airlineCode = '" + airlineCode + "' and " +
							   "departDate = '" + departDate + "'";
		ResultSet result = stmt.executeQuery(query);
		
					
		String price = "";
		if(result.next()){
			price = result.getString(bookedClass + "Price");
		}else{
			out.println("Flight does not exist! Try again."); return;
		}
	
				
		out.println("You are about to book a flight from <b>" + departAir + " to " + 
			arriveAir + "</b> in <b>" + bookedClass +  "</b> for $" + price + ".00. " + 
				"Are you sure you wish to do this?<br/><br/>" +
			"You will be able to cancel your reservation through your My Reservations page up to " +
			"24 hours before the flight's departure.<br/><br/>");
					
		out.println( 
		"<form action =\"bookFlightConfirmed.jsp\">" +
		"<input type = \"hidden\" name = \"flightInfo\"" +
		"value = \"" + flightInfo + "|" + bci + "\" />" +
		"<input type =\"submit\" value = \"I'm sure, let's book it!\" " +
		"</form>" + "</td><br/>"
		);
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
</body>
</html>