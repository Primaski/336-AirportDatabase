<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>
<body>
	<%
	    
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();
			String departAirport = request.getParameter("from");
			String arriveAirport = request.getParameter("to");
			String departMo = request.getParameter("departmonth");
			String departDay = request.getParameter("departday");
			/*String arriveMonth = request.getParameter("arrivemonth");
			String arriveDay = request.getParameter("arriveday");*/
			String airline = request.getParameter("airline");
			String stops = request.getParameter("stops");
			String price = request.getParameter("price");
			String sortBy = request.getParameter("sort");
			
			String[] departAirCityState = departAirport.split(", ");
			String[] arriveAirCityState = arriveAirport.split(", ");
			
			//out.print(departAirport + arriveAirport + departMo + departDay + airline + price + sortBy);
			
			
			//Arrival and departure are necessary, this parses the "City, State" into 2 distinct columns,
			//and searches the four columns corresponding to Departure and Arrival. This will be added to the query.
			String arrival = "arriveCity = '" + arriveAirCityState[0] + 
					"' and arriveState = '" + arriveAirCityState[1] + "'" ;
			String departure = " and departCity = '" + departAirCityState[0] + "' and " +
				       "departState = '" + departAirCityState[1] + "'";
			
			
			//First optional parameter is departing date. If blank, "" will be added instead of a parameter
			String date = "";
			try{
			date = ((departMo.equals("") || departMo == null) || 
					(departDay.equals("") || departMo == null)) ? "" : 
					" and departDate like '2019-" + 
					String.format("%02d", Integer.parseInt(departMo)) + "-" + 
					String.format("%02d", Integer.parseInt(departDay))  + "%'";
			out.println("Date: " + date + "\n\n\n");
			}catch (Exception e){
				out.println(e.toString());
				return;
			}
			
			
			//Second optional parameter is price. Economy price is expected always to be the lowest, and so
			//if the price maximum is less than the economy, then it will also be less for all others. Thus,
			//we need only to search for economy (since the type of booking is on the BOOK page)
			String priceMax = "";
			try{
				priceMax = (price == null || price.equals("")) ? "" :
					" and economyPrice <= " + price;
			}catch(Exception e){
				out.println(e.toString());
				return;
			}
			
			//Third optional parameter is airline. We use the airline display name.
			String reqAirline = "";
			try{
				reqAirline = (airline.equals("No Preference")) ? "" :
					" and airlineDisplayName = '" + airline + "'";
			}catch(Exception e){
				out.println(e.toString());
				return;
			}
			
			//Fourth optional parameter is maximum number of stops.
			String stopso = "";
			try{
				stopso = (stops == null || stops.equals("")) ? "" :
					" and noOfStops <= '" + stops + "'";
			}catch(Exception e){
				out.println(e.toString());
				return;
			}
			
			//Sort by - required, default is price
			String sort = "";
			Map<String,String> orderOptions = new HashMap<String,String>(){{
				put("Price (default)","economyPrice asc");
				put("Takeoff Time", "departDate asc, departTime asc");
				put("Takeoff Time (desc.)", "departDate desc, departTime desc");
				put("Landing Time", "arrivalTime asc");
				put("Landing Time (desc.)", "arrivalTime desc");
			}};
			sort = orderOptions.get(sortBy);
			
			//QUERY TO BE SUBMITTED -
			//uses the searchUtil View - this table merges Flights, Airports, ArrivesAt, DepartsFrom & Airlines.
			String query = "SELECT * " +
			"FROM  searchUtil " + 
			"WHERE  " + arrival +
					    departure +
					    date +
					    priceMax +
					    reqAirline +
					    stopso +
			"ORDER BY " + sort;
			
			//aout.println(query);
				   
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);
			
			if(!result.next()){
				out.println("<h1>Oh no!</h1> " +
			"<h3>No results matched your query. Try narrowing down your search</h3>");
				out.println("<a href = \"customerSearch.jsp\">Back to Search!</a>");
				return;
			}
			
			out.println("<h1>Results matching your criteria:</h1><br><br>");
			out.println("<table border = \"1\">");
			out.println("<tr>");
			out.println("<th>Departing From</th>");
			out.println("<th>On</th>");
			out.println("<th>At</th>");
			out.println("<th>Arriving At</th>");
			out.println("<th>On</th>");
			out.println("<th>At</th>");
			out.println("<th>Airline</th>");
			out.println("<th>Econ. Price</th>");
			out.println("<th>Stops</th>");
			out.println("<th>-----</th>");
			out.println("</tr>");
			
			String[] columns = new String[]{ 
					"departDisplayName", "departDate", "departTime",
					"arriveDisplayName", "departDate", "arrivalTime",
					"airlineDisplayName", "economyPrice", "noOfStops",};
			
			do{
				out.println("<tr>");
				for(String col : columns){
					out.println("<td>");
					out.print(result.getString(col));
					out.println("</td>");
				}
				out.println("<td>" + 
				"<form action =\"bookFlight.jsp\">" +
				"<input type = \"hidden\" name = \"flightID\" " +
				"value =\"" + result.getString("FlightID") + "\"/> " +
				"<input type =\"submit\" value = \"Book it!\" " +
				"</form>" + "</td>");
				out.println("</tr>");
			}while(result.next());
			out.println("</table>");
			
			con.close();
			
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>