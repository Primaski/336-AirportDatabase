<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remaining Aircrafts</title>
</head><head><title>Remaining Aircrafts</title></head>
	<body>
	<h1><b>Remaining Aircrafts</b></h1>

	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String delAircraft = request.getParameter("toBeDel");
			String delQuery="delete  from Aircrafts where Tailnumber = '"+ delAircraft + "'";
			Statement stmt = con.createStatement();
			stmt.executeUpdate(delQuery);
			String query="Select * from Aircrafts";
			ResultSet result = stmt.executeQuery(query);
			if(result.next() == false){
				out.println("Result set is empty.");
			}else{
				do{
					out.println(result.getString(1) + "  		   Model:   		  " + result.getString(2) + "  		   Color:  		   " + result.getString(3) +"			Airline:		 " +result.getString(4)+ "<br/>");
				}while(result.next());
			}
			con.close();
			
			

		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>