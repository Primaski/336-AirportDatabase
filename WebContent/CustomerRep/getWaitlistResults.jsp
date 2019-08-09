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
	<h1><b>Get Waitlist for Flight</b></h1>

	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String waitlistID = request.getParameter("toBeDisp");
		
			Statement stmt = con.createStatement();
		
			String query="Select * from WaitsFor Where FlightID = '"+waitlistID+"'";
			ResultSet result = stmt.executeQuery(query);
			if(result.next() == false){
				out.println("Result set is empty.");
			}else{
				do{
					out.println("Flight ID:     "+result.getString(1) + "     Customer Username:     " + result.getString(2) +  "<br/>");
				}while(result.next());
			}
			con.close();
			
			

		} catch (Exception e) {
			out.print(e);
		}
	%>
<br />
	<a href="customerRepIndex.jsp">Return to Customer Rep Menu</a>
</body>
</html>