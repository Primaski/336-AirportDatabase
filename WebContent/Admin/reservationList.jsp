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
			String sql="";
			if(user!=""){
			sql = "SELECT * FROM Tickets inner join Buys where username ='"+user+"'";
			}
			if(FlightID!=""){
			sql = "SELECT * FROM Tickets inner join Buys where FlightID ='"+FlightID+"'";
			}
			ResultSet resultSet = null;
			resultSet = stmt.executeQuery(sql);
			if(resultSet.next() == false){
				out.println("This user has no flights reserved");
			}else{
				do{
					out.println("  		   TicketID:   		  " + resultSet.getString(1) + "  		   FlightID:   		  " + resultSet.getString(2) + "  		   Class:  		   " + resultSet.getString(3) +"			Date:		 " +resultSet.getString(4)+ "  		   Username:   		  " + resultSet.getString(6)+"<br/>");
				}while(resultSet.next());
			}
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
%>
</body>
</html>