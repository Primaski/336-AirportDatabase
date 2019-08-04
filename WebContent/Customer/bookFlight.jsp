<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book your Flight</title>
</head>
<body>
	<%
	try {
		String flightInfo = request.getParameter("flightInfo");

		//verify flight truly exists + get metadata
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		Statement stmt = con.createStatement();
		
		String[] splits = flightInfo.split("\\|");
		if(splits.length != 4){
			out.println("flight info meta data was compromised, please try again.");
			out.println("expected four arguments but received" + flightInfo);
			return;
		}
		
		String departAir = splits[0];
		String arriveAir = splits[1];
		String airlineCode = splits[2];
		String departDate = splits[3];
					
		String query = "SELECT * FROM FlightsExpanded WHERE " +
				"departAir = '" + departAir + "' and " +
				"arriveAir = '" + arriveAir + "' and " +
				"airlineCode = '" + airlineCode + "' and " +
				"departDate = '" + departDate + "'"
		;
					
		ResultSet flightTable = stmt.executeQuery(query);
		String sr = "";	
		String departTime = "";
		String arriveTime = "";
		String noOfStops = "";
		String economyPrice = "";
		String businessPrice = "";
		String firstPrice = "";
		String airlineDisplay = "";
		boolean economyOpen = false;
		boolean businessOpen = false;
		boolean firstOpen = false;
		String depDisplay = "";
		String arrDisplay = "";
		String depLocation = "";
		String arrLocation = "";
				
		try{
			if(flightTable.next()){
				departTime = flightTable.getString("departTime");
				arriveTime = flightTable.getString("arriveTime");
				noOfStops = flightTable.getString("noOfStops");
				airlineDisplay = flightTable.getString("airlineDisplayName");
				economyPrice = flightTable.getString("economyPrice");
				businessPrice = flightTable.getString("businessPrice");
				firstPrice = flightTable.getString("firstClassPrice");
				depDisplay = flightTable.getString("depDisplayName");
				arrDisplay = flightTable.getString("arrDisplayName");
				depLocation = (flightTable.getString("depCity") + "," +
				flightTable.getString("depState"));
				arrLocation = (flightTable.getString("arrCity") + "," +
						flightTable.getString("arrState"));
			}
		}catch(Exception e){ e.printStackTrace(); }
		
		out.println("<h1>Booking Flight: " + departAir + "==>" + arriveAir + "</h1><br/><br/>");
		
		out.println("<h3><ul>" +
					"<li>Trip: " + depDisplay + " (" + departAir + ") ==> " +
								   arrDisplay + " (" + arriveAir + ") </li>" + 
					"<li>Departing on: " + departDate + " at " + departTime + "</li>" +
					"<li>Arriving on: " + departDate + " at " + arriveTime + "</li>" +
					"<li>Using: " + airlineDisplay + " (" + airlineCode + ")</li>"
					//TO-DO: prices, capacity, number of stops
					);
	
	}catch(Exception e){
		out.println("Flight does not exist! Try again!");
	}
	%>

</body>
</html>