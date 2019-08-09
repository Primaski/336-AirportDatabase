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
			String user = request.getParameter("Username");
			String FlightID = request.getParameter("FlightID");
			String airCode = request.getParameter("AirlineCode");
			String sql="";
			if(user!=""){
			sql = "SELECT sum(price) FROM TravelDB.Tickets inner join Buys inner join Routes where username = '"+user+"'";
			}
			if(FlightID!=""){
			sql = "SELECT sum(price) FROM Tickets inner join Buys where FlightID ='"+FlightID+"'";
			}
			if(airCode!=""){
			sql = "SELECT sum(price) FROM Tickets inner join Buys where airlineCode ='"+airCode+"'";
			}
			ResultSet resultSet = null;
			resultSet = stmt.executeQuery(sql);
			if(resultSet.next() == false){
				out.println("This user has no flights reserved");
			}else{
				do{
					out.println("Total Cost: "+resultSet.getString(1)) ;
				}while(resultSet.next());
			}
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
%>
</body>
</html>