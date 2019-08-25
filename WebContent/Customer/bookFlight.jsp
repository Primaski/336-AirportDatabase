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
		String flightID = request.getParameter("flightID");
		String round = request.getParameter("round");
		boolean roundTrip = (round == null) ? false : true;

		//verify flight truly exists + get metadata
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		Statement stmt = con.createStatement();
					
		String query = "SELECT * FROM searchUtil WHERE " +
				"FlightID = '" + flightID + "'"
		;
					
		ResultSet flightTable = stmt.executeQuery(query);
		String sr = "";	
		String departAir = "null";
		String departDate = "null";
		String arriveAir = "null";
		String airlineCode = "null";
		String departTime = "null";
		String arrivalTime = "null";
		String noOfStops = "null";
		String economyPrice = "null";
		String businessPrice = "null";
		String firstPrice = "null";
		String airlineDisplay = "null";
		String econCapacity = "null";
		String businessCapacity = "null";
		String firstCapacity = "null";
		String depDisplay = "null";
		String arrDisplay = "null";
		String depLocation = "null";
		String arrLocation = "null";
				
		try{
			if(flightTable.next()){
				departAir = flightTable.getString("departAir");
				departDate = flightTable.getString("departDate");
				arriveAir = flightTable.getString("arriveAir");
				airlineCode = flightTable.getString("airlineCode");
				departTime = flightTable.getString("departTime");
				//not found?
				arrivalTime = flightTable.getString("arrivalTime");
				noOfStops = flightTable.getString("noOfStops");
				airlineDisplay = flightTable.getString("airlineDisplayName");
				econCapacity = flightTable.getString("economyCapacity");
				businessCapacity = flightTable.getString("businessCapacity");
				firstCapacity = flightTable.getString("firstClassCapacity");
				economyPrice = flightTable.getString("economyPrice");
				businessPrice = flightTable.getString("businessPrice");
				firstPrice = flightTable.getString("firstClassPrice");
				depDisplay = flightTable.getString("departDisplayName");
				arrDisplay = flightTable.getString("arriveDisplayName");
				depLocation = (flightTable.getString("departCity") + "," +
				flightTable.getString("departState"));
				arrLocation = (flightTable.getString("arriveCity") + "," +
						flightTable.getString("arriveState"));
			}
		}catch(Exception e){ out.println(e.toString()); e.printStackTrace(); return; }
		
		out.println("<h1>Booking " + ((roundTrip) ? "Return " : "")
		+ "Flight: " + departAir + " ==> " + arriveAir + "</h1><br/><br/>");
		
		out.println("<h3><ul>" +
					"<li>Trip: " + depDisplay + " (" + departAir + ") ==> " +
								   arrDisplay + " (" + arriveAir + ") </li>" + 
					"<li>Departing on: " + departDate + " at " + departTime + "</li>" +
					"<li>Arriving on: " + departDate + " at " + arrivalTime + "</li>" +
					"<li>Using: " + airlineDisplay + " (" + airlineCode + ") </li>" +
					"<li>Number of stops: " + noOfStops + "</li>" +
					"</ul><br/><br/>"
					);
		
		out.println("Economy Class - $" + economyPrice + ".00 <br/>");
		String open = (Integer.parseInt(econCapacity) > 0) ? 
				"<b><font color = \"green\">Available!</font></b>" : 
				"<b><font color = \"red\">Full</font></b>";
		boolean isOpen = (Integer.parseInt(econCapacity) > 0) ? true : false;
		out.println("Status: " + open + "<br/>");
		
		if(isOpen){ 
			 //3 is the economy class indicator - pass previous flight primary keys
			out.println("<td>" + 
			"<form action =\"bookFlightVerify.jsp\" method = \"POST\" >" +
			"<input type = \"hidden\" name = \"flightInfo\" " +
			"value = \"" + flightID  + "|3" + "\" />" +
			((roundTrip) ? "<input type = \"hidden\" name = \"round\" " +
			"value = 1" + "\" />" : "") +
			"<input type =\"submit\" value = \"Book Economy\"> " +
			"</form>" + "</td><br/>");
		}else{ 
			//Wait list
			out.println("<td>" + 
			"<form action =\"waitlistFlightVerify.jsp\" method = \"POST\" >" +
			"<input type = \"hidden\" name = \"flightInfo\" " +
			"value = \"" + flightID  + "|3" + "\" />" +
			((roundTrip) ? "<input type = \"hidden\" name = \"round\" " +
			"value = 1" + "\" />" : "") +
			"<input type =\"submit\" value = \"Waitlist for Economy\"> " +
			"</form>" + "</td><br/>");
		}
		
		out.println("</h3>");
		out.println("<h3>");
		out.println("Business Class - $" + businessPrice + ".00 <br/>");
		open = (Integer.parseInt(businessCapacity) > 0) ? 
				"<b><font color = \"green\">Available!</font></b>" : 
				"<b><font color = \"red\">Full</font></b>";
		isOpen = (Integer.parseInt(businessCapacity) > 0) ? true : false;
		out.println("Status: " + open + "<br/>");
		
		if(isOpen){ 
			 //2 is the business class indicator - pass previous flight primary keys
			out.println("<td>" + 
			"<form action =\"bookFlightVerify.jsp\" method = \"POST\" >" +
			"<input type = \"hidden\" name = \"flightInfo\" " +
			"value = \"" + flightID  + "|2" + "\" />" +
			((roundTrip) ? "<input type = \"hidden\" name = \"round\" " +
			"value = 1" + "\" />" : "") +
			"<input type =\"submit\" value = \"Book Business\"> " +
			"</form>" + "</td><br/>");
		}else{ 
			out.println("<td>" + 
			"<form action =\"waitlistFlightVerify.jsp\" method = \"POST\" >" +
			"<input type = \"hidden\" name = \"flightInfo\" " +
			"value = \"" + flightID  + "|2" + "\" />" +
			((roundTrip) ? "<input type = \"hidden\" name = \"round\" " +
			"value = 1" + "\" />" : "") +
			"<input type =\"submit\" value = \"Waitlist for Business Class\"> " +
			"</form>" + "</td><br/>");
		}
		
		out.println("</h3>");
		out.println("<h3>");
		out.println("First Class - $" + firstPrice + ".00 <br/>");
		open = (Integer.parseInt(firstCapacity) > 0) ? 
				"<b><font color = \"green\">Available!</font></b>" : 
				"<b><font color = \"red\">Full</font></b>";
		isOpen = (Integer.parseInt(firstCapacity) > 0) ? true : false;
		out.println("Status: " + open + "<br/>");
		
		if(isOpen){ 
			 //1 is the first class indicator - pass previous flight primary keys
			out.println("<td>" + 
			"<form action = \"bookFlightVerify.jsp\" method = \"POST\" > " +
			"<input type = \"hidden\" name = \"flightInfo\" " +
			"value = \"" + flightID  + "|1" + "\" /> " +
			((roundTrip) ? "<input type = \"hidden\" name = \"round\" " +
			"value = 1" + "\" /> " : "") +
			"<input type =\"submit\" value = \"Book First-Class\"> " +
			"</form>" + "</td><br/>");
		}else{ 
			//Wait list
			out.println("<td>" + 
			"<form action = \"waitlistFlightVerify.jsp\" method = \"POST\" > " +
			"<input type = \"hidden\" name = \"flightInfo\" " +
			"value = \"" + flightID  + "|1" + "\" /> " +
			((roundTrip) ? "<input type = \"hidden\" name = \"round\" " +
			"value = 1" + "\" />" : "") +
			"<input type =\"submit\" value = \"Waitlist for First-Class\"> " +
			"</form>" + "</td><br/>");
		}
		out.println("</h3>");
		
	
	}catch(Exception e){
		e.printStackTrace();
	}
	%>

</body>
</html>