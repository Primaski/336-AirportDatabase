<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

	
	<head><title>Flight Search</title></head>
	<body>
	<h1><b>Flight Search</b></h1>
	<b>Departing:</b> <font color="red"><b>*</b></font>
	<form action="searchResults.jsp" method="POST">
		<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		
		Statement stmt = con.createStatement();
		String str = "SELECT city, state FROM Airports ORDER BY city";
		ResultSet airports = stmt.executeQuery(str);
		out.println("<select name =\"from\">");
		while(airports.next()){
			out.println("<option>" + airports.getString(1) + ", " + airports.getString(2) + "</option>");
		}
		airports.beforeFirst(); 
		out.println("</select> <br/>"); 
		
		
		out.print("<b>Arriving at:</b> <font color=\"red\"><b>*</b></font> <br/>");
		out.print("<select name=\"to\">");
		while(airports.next()){
			out.println("<option>" + airports.getString(1) + ", " + airports.getString(2) + "</option>");
		}
		out.println("</select> <br/>");
		
		out.println("<b>Departing Date:</b><br/>");
		out.println("<input name = \"departmonth\" maxlength ="
			+ "\"2\" size = \"2\" type = \"number\" onkeypress=\"return isNo(event)\"/>");
		out.println("<input name = \"departday\" maxlength = \"2\"" 
			+ "size = \"2\" type = \"number\" onkeypress=\"return isNo(event)\"/>");
		out.println("<br/>(* Month, Day)<br/>");
		
		out.println("<b>Arrival Date:</b><br/>");
		out.println("<input name = \"arrivemonth\" maxlength ="
			+ "\"2\" size = \"2\" type = \"number\" onkeypress=\"return isNo(event)\"/>");
		out.println("<input name = \"arriveday\" maxlength = \"2\"" 
			+ "size = \"2\" type = \"number\" onkeypress=\"return isNo(event)\"/>");
		out.println("<br/>(* Month, Day)<br/>");
		
		out.print("<b>Airline:</b><br/>");
		out.print("<select name=\"airline\">");
		Statement stmt2 = con.createStatement();
		String str2 = "SELECT displayName FROM Airlines ORDER BY displayName";
		ResultSet airports2 = stmt.executeQuery(str2);
		out.println("<option>No Preference</option>");
		while(airports2.next()){
			out.println("<option>" + airports2.getString(1) + "</option>");
		}
		con.close();
		out.println("</select> <br/>");
		
		out.print("<b>Maximum Price:</b><br/>");
		out.println("<input name=\"price\" placeholder=\"Any\" maxlength = \"4\" type=\"number\" " + 
			"onkeypress=\"return isNo(event)\"/><br/>");
		
		out.print("<b>Sort by:</b><br/>");
		out.print("<select name=\"sort\">");
		out.print("<option>Price (default)</option>" +
				  "<option>Takeoff Time</option>" +
				  "<option>Takeoff Time (desc.)</option>" +
				  "<option>Landing Time</option>" +
				  "<option>Landing Time (desc.)</option>" 
				);
		out.println("</select><br/>");
		out.println("todo: number of stops, round trips, one way");
		%>
		<br/>
		<input type="submit" value="Submit"/>
		</form>
	</body>
	<script>
	function isNo(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)){ return false; }
	    return true;
	}
	</script>
</html>
		<!--
		this.getClass().getClassLoader().getResource("/WEB-INF/lib/CustomerSearchUtil.java");
		try{
			String[][] table = CustomerSearchUtil.GetTableArr("SELECT city, state FROM Airports");
			
			for(int i = 0; i < table[0].length; i++){
				out.println("<option>" + table[0][i] + "</option>");
			}
		}catch(Exception e){
				out.println("I GOT AN ERROR");
				e.printStackTrace();
			}
		-->
		