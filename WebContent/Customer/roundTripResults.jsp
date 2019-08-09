<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

	
	<head><title>Round Trip Options</title></head>
	<body>
		<h1>Round Trip Options</h1>
		<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		Statement stmt = con.createStatement();
		String arriveAir = request.getParameter("departair"); //flipped for round trip
		String departAir = request.getParameter("arriveair"); //flipped for round trip
		String arriveMo = request.getParameter("arrivemonth");
		String arriveDay = request.getParameter("arriveday");

		//First optional parameter is departing date. If blank, "" will be added instead of a parameter
		String date = "";
		try{
		date = ((arriveMo.equals("") || arriveMo == null) || 
				(arriveDay.equals("") || arriveDay == null)) ? "" : 
				"arrivalDate = '2019-" + 
				String.format("%02d", Integer.parseInt(arriveMo)) + "-" + 
				String.format("%02d", Integer.parseInt(arriveDay))  + "' ";
		}catch (Exception e){
			out.println(e.toString());
			return;
		}
		
		String arrival = "arriveAir = '" + arriveAir + "' and ";
		String departure = "departAir = '" + departAir + "' and ";
		
		
		//QUERY TO BE SUBMITTED -
		//uses the searchUtil View - this table merges Flights, Airports, ArrivesAt, DepartsFrom & Airlines.
		String query = "SELECT * " +
		"FROM  searchUtil " + 
		"WHERE  " + arrival +
				    departure +
				    date +
		"ORDER BY arrivalTime";
		
		out.println(query);
			   
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
			"<form action =\"bookFlight.jsp\" method = \"POST\">" +
			"<input type = \"hidden\" name = \"flightID\" " +
			"value =\"" + result.getString("FlightID") + "\"/> " +
			"<input type = \"hidden\" name = \"round\" value = 1>" +
			"<input type =\"submit\" value = \"Book it!\" " +
			"</form>" + "</td>");
			out.println("</tr>");
		}while(result.next());
		out.println("</table>");
		
		con.close();
		
		%>
	</body>
</html>
	