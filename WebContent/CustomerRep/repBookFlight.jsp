<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book Passenger Flight</title>
</head>
<body>
	<%
	try {
		String flightInfo = request.getParameter("flightInfo");

		String userRepHelped = request.getParameter("repSelUser");
		session.setAttribute("userHelped", userRepHelped);
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
		String departTime = "null";
		String arriveTime = "null";
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
				departTime = flightTable.getString("departTime");
				arriveTime = flightTable.getString("arriveTime");
				noOfStops = flightTable.getString("noOfStops");
				airlineDisplay = flightTable.getString("airlineDisplayName");
				econCapacity = flightTable.getString("economyRemainingCapacity");
				businessCapacity = flightTable.getString("businessRemainingCapacity");
				firstCapacity = flightTable.getString("firstClassRemainingCapacity");
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
		}catch(Exception e){ out.println(e.toString()); e.printStackTrace(); return; }
		
		out.println("<h1>Booking Flight: " + departAir + " ==> " + arriveAir + "</h1><br/><br/>");
		
		out.println("<h3><ul>" +
					"<li>Trip: " + depDisplay + " (" + departAir + ") ==> " +
								   arrDisplay + " (" + arriveAir + ") </li>" + 
					"<li>Departing on: " + departDate + " at " + departTime + "</li>" +
					"<li>Arriving on: " + departDate + " at " + arriveTime + "</li>" +
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
			"<form action =\"bookFlightVerify.jsp\">" +
			"<input type = \"hidden\" name = \"flightInfo\"" +
			"value = \"" + flightInfo + "|3" + "\" />" +
			"<input type =\"submit\" value = \"Book Economy\" " +
			"</form>" + "</td><br/>");
		}else{ 
			//TO-DO: Wait list
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
			"<form action =\"bookFlightVerify.jsp\">" +
			"<input type = \"hidden\" name = \"flightInfo\"" +
			"value = \"" + flightInfo + "|2" + "\" />" +
			"<input type =\"submit\" value = \"Book Business\" " +
			"</form>" + "</td><br/>");
		}else{ 
			//TO-DO: Wait list
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
			"<form action =\"bookFlightVerify.jsp\">" +
			"<input type = \"hidden\" name = \"flightInfo\"" +
			"value = \"" + flightInfo + "|1" + "\" />" +
			"<input type =\"submit\" value = \"Book First-Class\" " +
			"</form>" + "</td><br/>");
		}else{ 
			///TO-DO: Wait list
		}
		out.println("</h3>");
		
	
	}catch(Exception e){
		e.printStackTrace();
	}
	%>

</body>
</html>