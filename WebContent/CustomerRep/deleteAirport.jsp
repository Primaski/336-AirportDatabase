<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>


<head>
<title>Delete Airports</title>
</head>
<body>
	<h1>
		<b>Select an Airport to Delete</b>
	</h1>
	<b>Airports: </b>
	<font color="red"><b>*</b></font>
	<form action="deleteAirportResults.jsp" method="POST">
		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			Statement stmt = con.createStatement();
			String str = "SELECT AirportCode FROM Airports";
			ResultSet airports = stmt.executeQuery(str);
			out.println("<select name =\"toBeDel\">");
			while (airports.next()) {
				out.println("<option>" + airports.getString(1));
			}
			airports.beforeFirst();//hi
			out.println("</select> <br/>");
			con.close();
		%>
		<br /> <input type="submit" value="Delete Selected Airport" />
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