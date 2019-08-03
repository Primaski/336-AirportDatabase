<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Corrected Airports</title>
</head><head><title>Corrected Airports</title></head>
	<body>
	<h1><b>Corrected Airports</b></h1>

	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String delAirport = request.getParameter("toBeEdited");
			String delQuery="update Airports where AirportCode = '"+ delAirport + "'";
			Statement stmt = con.createStatement();
			stmt.executeUpdate(delQuery);
			String query="Select * from Airports";
			ResultSet result = stmt.executeQuery(query);
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			if(result.next() == false){
				out.println("Result set is empty.");
			}else{
				do{
					out.println(result.getString(1) + ":     " + result.getString(2) + " Located at " + result.getString(3) +", " +result.getString(4) +", " + result.getString(5)+" "+  result.getString(7)+" " + result.getString(6)+ "<br/>");
				}while(result.next());
			}
			con.close();
			
			

		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>