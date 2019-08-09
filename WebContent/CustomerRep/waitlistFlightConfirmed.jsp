<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.format.*, java.time.LocalDateTime"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking Waitlist Status</title>
</head>
<body>
	<%
		/*
		Operates similarly, but not equivalently to "bookFlightConfirmed.jsp"
			1. Verify user is logged in
			2. Verify again that flight exists and flight is truly full
			3. Increment next highest priority number
			4. Put customer - flight in relations table "WaitsFor"
			5. Give confirmation message
		*/
		
		String flightInfo = request.getParameter("flightInfo");
		String round = request.getParameter("round");
		boolean roundTrip = (round == null) ? false : true;
		
	/*////////////////////////////////////STEP 1////////////////////////////////////*/
		
		String failureMessage = "<h1>Oops!</h1><br/><h3>It seems you're not logged in!</h3>";
		Object user = session.getAttribute("custUName");
		try{
			if(user == null){
				//failure on step 1
				out.println(failureMessage);
				return;
			}
		}catch(Exception e){
			//failure on step 1
			out.println(failureMessage);
			e.printStackTrace();
			return;
		}
		
		
		/*////////////////////////////////////STEP 2////////////////////////////////////*/
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		Statement stmt = con.createStatement();
		if(flightInfo == null){
			out.println("No flight information passed."); 
			return;
		}
		String[] splits = flightInfo.split("\\|");
		if(splits.length != 2){
			out.println("flight info meta data was compromised, please try again.");
			out.println("expected five arguments but received" + flightInfo);
			return;
		}
	
		String flightID = splits[0];
		String bci = splits[1];
		String departAir = "";
		String arriveAir = "";
		String airline = "";
					
		String bookedClass = (bci.equals("3")) ? 
				"economy" : ((bci.equals("2")) ? 
				"business" : "firstClass");
	
		String query = 	"SELECT " + "* " +
						"FROM searchUtil " +
						"WHERE flightID = '" + flightID + "'";
		ResultSet flightExpanded = stmt.executeQuery(query);
		
		try{
			if(flightExpanded.next()){
				if(flightExpanded.getString(bookedClass + "Capacity") == null){
					//failure on step 2
					out.println("Flight does not exist! Try again."); return;
				}else{
					int remaining = Integer.parseInt(flightExpanded.getString(bookedClass + "Capacity"));
					if(remaining > 0){
						//failure on step 2 - capacity
						out.println("This flight already has open spots! You must have landed on a wrong page!"); return;
					}
				}
				departAir = flightExpanded.getString("departAir");
				arriveAir = flightExpanded.getString("arriveAir");
				airline = flightExpanded.getString("airlineCode");
			}else{
				//failure on step 2
				out.println("Flight does not exist! Try again."); return;
			}
		}catch(Exception e){
			//failure on step 2
			out.println("Flight does not exist! Try again.");
			e.printStackTrace();
			return;
		}
		flightExpanded.beforeFirst(); //rewind
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); 
		LocalDateTime now = LocalDateTime.now();
		String generatedOn = dtf.format(now);
		
		
		/*////////////////////////////////////STEP 3////////////////////////////////////*/
		
		String priorityQueueNo = "";
		try{
			Statement stmt3 = con.createStatement();
			
			String getPriorityQueueNo = "SELECT IFNULL(max(priority) + 1, 1) AS `maximal` FROM WaitsFor " + 
				"WHERE FlightID = '" + flightID + "'";
			
			ResultSet newPrior = stmt3.executeQuery(getPriorityQueueNo);
			if(!newPrior.next()){
				//if this happens, must be an error, because if null it will return 1
				out.println("`getPriorityQueueNo` unexpectedly returned no values. Failure at step 3.");
				return;
			}
			priorityQueueNo = newPrior.getString("maximal");
			try{
				Integer.parseInt(priorityQueueNo);
			}catch(Exception e){
				out.println("Expected an integer for priorityQueueNo, but received something else. Failure on step 3.");
				return;
			}
		}catch(Exception e){
			//failure on step 3
			out.println("Failure on step 3, see stack trace.");
			e.printStackTrace();
			return;
		}
		
		/*////////////////////////////////////STEP 4////////////////////////////////////*/
		
		String amountPaid = "";
		try{
			out.println("got here");
			Statement stmt4 = con.createStatement();
			boolean success = false;
			flightExpanded.next();
			out.println("got here");
			amountPaid = flightExpanded.getString(bookedClass + "Price");
			out.println("got here");
			
			query = "INSERT into WaitsFor (FlightID,Username,priority,price,flightclass,boughtOn) values ('" +
					flightID + "', '" + user.toString() + "', '" + priorityQueueNo + "' , '" + 
					amountPaid + "', '" + bookedClass + "', '" + generatedOn + "')";
			
			out.println(query);
			success = (stmt4.executeUpdate(query) == 1) ? true : false;
			
			if(!success){
				//failure on step 4
				out.println("Error in inserting Ticket/Buyer relation.");
				return;
			}
			
		}catch (Exception e){
			out.println("Failure on step 4, see stack trace.");
			e.printStackTrace();
			return;
		}
		
		/*////////////////////////////////////STEP 5////////////////////////////////////*/
		out.println("<h1>Waitlist Flight</h1>");
		out.println("Successfully purchased waitlisted your flight! You can view this " +
				"in your reservations.<br/><br/>");
		
		if(!roundTrip){
			//implies round trip has not yet been booked	
			out.println("Would you like to make this a round trip? If so, please select your expected return date.<br/>" +
			"Note that booking a return flight while never being granted a ticket for the departure flight is entirely possible, " + 
			"and it is STRONGLY recommended that you postpone booking a return flight until you've been accepted for a departure flight.<br/>");

			out.println("<form action=\"roundTripResults.jsp\" method=\"POST\">");
			out.println("<b>Departing Date:</b><br/>");
			out.println("<input type = \"hidden\" name = \"arriveair\" " +
					"value = \"" + arriveAir + "\" />");
			out.println("<input type = \"hidden\" name = \"departair\" " +
					"value = \"" + departAir + "\" />");
			out.println("<input type = \"hidden\" name = \"airline\" " +
				"value = \"" + airline + "\" />");
			out.println("<input name = \"arrivemonth\" maxlength ="
				+ "\"2\" size = \"2\" type = \"number\" onkeypress=\"return isNo(event)\"/>");
			out.println("<input name = \"arriveday\" maxlength = \"2\"" 
				+ "size = \"2\" type = \"number\" onkeypress=\"return isNo(event)\"/>");
			out.println("<br/>(* Month, Day)<br/>");
			out.println("<input type=\"submit\" value=\"Submit\"/>");
			out.println("</form>");
		}else{
			out.println("Your round trip is secured!");
		}
		
		out.println("<a href=\"customerRepIndex.jsp\">Return to Main Menu</a>");
		con.close();
		
		
	%>

	<script>
	function isNo(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)){ 
	    	return false; 
	    	}
	    return true;
	};
	</script>
</body>
</html>