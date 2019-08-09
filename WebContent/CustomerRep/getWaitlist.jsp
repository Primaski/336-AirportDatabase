<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>


<head>
<title>Get Waitlist for Flight</title>
</head>
<body>
	<h1>
		<b>Get Waitlist for Flight</b>
	</h1>
	<b>Flights: </b>
	<font color="red"><b>*</b></font>
	<form action="getWaitlistResults.jsp" method="POST">
		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			Statement stmt = con.createStatement();
			String str = "SELECT FlightID FROM Flights";
			ResultSet airports = stmt.executeQuery(str);
			out.println("<select name =\"toBeDisp\">");
			while (airports.next()) {
				out.println("<option>" + airports.getString(1));
			}
			airports.beforeFirst();//hi
			out.println("</select> <br/>");
			con.close();
		%>
		<br /> <input type="submit" value="Return Waitlist for Selected Flight" />
	</form>
		<a href="customerRepIndex.jsp">Return to Customer Rep Menu</a>
	</body>
	<script>
	function isNo(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)){ return false; }
	    return true;
	}
	</script>
</html>