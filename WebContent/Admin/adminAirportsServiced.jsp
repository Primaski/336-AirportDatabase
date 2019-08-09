<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		try {
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();
			String airCode = request.getParameter("airportCode");
			String sql = "SELECT * FROM TravelDB.Routes where departAir = '"+ airCode +"'or arriveAir='"+airCode+"'";
			ResultSet resultSet = null;
			resultSet = stmt.executeQuery(sql);
			if(resultSet.next() == false){
				out.println("This airport has no traffic.");
			}else{
				do{
					out.println("  		   RouteID:   		  " + resultSet.getString(1) + "  		   Airline Code:   		  " + resultSet.getString(2) + "  		   departs from:   		  " + resultSet.getString(3) + "  		   Arrives at:   		  " +resultSet.getString(4) + "  		   departs at:   		  " +resultSet.getString(4) + "  		   arrives at:   		  " +resultSet.getString(4)  + "  		   Stopovers:   		  " +resultSet.getString(7)+ "<br/>");
				}while(resultSet.next());
			}
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
%>
</body>
</html>