<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.format.*, java.time.LocalDateTime"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking Flight Status</title>
</head>
<body>
	<%
		/*
		Steps in booking a flight after primary keys are retrieved:
			1. Verify user is logged in
			2. Verify again that flight exists and is not full
			3. Generate ticket and store ID
			4. Put customer - ticket in relations table "Buys"
			5. Give confirmation message
		*/
		
		String flightInfo = request.getParameter("flightInfo");
		String round = request.getParameter("round");
		boolean roundTrip = (round == null) ? false : true;
		
	/*////////////////////////////////////STEP 1////////////////////////////////////*/
		
		String failureMessage = "<h1>Oops!</h1><br/><h3>It seems you're not logged in!</h3>";
		Object user = session.getAttribute("user");
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
					if(remaining < 1){
						//failure on step 2 - capacity
						out.println("Unfortunately, " + bookedClass + " on this flight has no more open " +
						"seats. Try a different class or flight!"); return;
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
		
		try{
			String departTime = "";
			flightExpanded.next();
			departTime = flightExpanded.getString("departTime");
			flightExpanded.beforeFirst(); //rewind
			
		//generate ticket
			query = "INSERT INTO Tickets (FlightID, flightClass, generatedOn) " + 
					"values ('" + flightID + "', '" + bookedClass + "', '" + generatedOn + "')";
			int rowsAffected = con.createStatement().executeUpdate(query);
			boolean success = (rowsAffected == 1) ? true : false;
		
			if(!success){
				//failure on step 3	
				out.println("Critical failure in generating ticket (0 database rows were" + 
				" affected). Please contact system administrator.");
				System.out.println("Query `" + query + "` was attempted, and " + rowsAffected
						+ " rows were modified, resulting in this error.");
				return;
			}
		}catch(Exception e){
			//failure on step 3
			out.println("Failure on step 3, see stack trace.");
			e.printStackTrace();
			return;
		}
		
		//get ticket ID - latest ticket
		String ticketID = "";
		ResultSet ticket = null;
		try{
			Statement stmt2 = con.createStatement();
			query = "SELECT * FROM Tickets WHERE generatedOn = (SELECT MAX(generatedOn) FROM Tickets)";
			ticket = stmt2.executeQuery(query);
			
			if( !ticket.next() ){
				//failure on step 3
				out.println("Failed to find latest generated ticket. Contact system administrator.");
				System.out.println("Query " + query + " returned no results.");
				return;
			}
		ticketID = ticket.getString("ticketID");
		}catch(Exception e){
			//failure on step 3
			out.println("Failure on step 3, see stack trace.");
			e.printStackTrace();
			return;
		}

		//decrement available capacity
		try{
			Statement stmt3 = con.createStatement();
			
			bookedClass = (bookedClass == "business") ? "businessClass" : bookedClass; //prevent renaming col
			boolean success = false;
			query = 		"UPDATE Flights " +
							"SET " + bookedClass + "Capacity = if("
							+ bookedClass + "Capacity > 0, "
							+ bookedClass + "Capacity - 1, 0) " +
							"WHERE FlightID = '" + flightID + "'";
			success = (stmt3.executeUpdate(query) == 1) ? true : false;
			bookedClass = (bookedClass == "businessClass") ? "business" : bookedClass; //revert
			
			if(!success){
				//failure on step 3
				out.println("Error in decrementing available capacity.");
				return;
			}
		}catch (Exception e){
			//failure on step 3
			out.println("Failure on step 3, see stack trace.");
			e.printStackTrace();
			return;
		}
		
		/*////////////////////////////////////STEP 4////////////////////////////////////*/
		//req fields: TicketID (step 3), Username (step 1), generatedOn (step 2), amountPaid (step 4)
		
		String amountPaid = "";
		try{
			Statement stmt4 = con.createStatement();
			boolean success = false;
			flightExpanded.next();
			amountPaid = flightExpanded.getString(bookedClass + "Price");
			
			query = "INSERT into Buys (TicketID,Username,price,boughtOn) values ('" +
					ticketID + "', '" + user.toString() + "', '" + amountPaid + "', '" + generatedOn + "')";
			
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
		out.println("Successfully purchased your ticket! Your ticket ID is : <b>" +
		String.format("%08d", Integer.parseInt(ticketID)) + "</b>. You can view this " +
				"in your reservations.<br/><br/>");
		
		if(!roundTrip){
			//implies round trip has not yet been booked	
			out.println("Would you like to make this a round trip? If so, please select your expected return date.<br/>");

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
		
		out.println("<a href=\"customerIndex.jsp\">Return to Main Menu</a>");
		
		
		
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