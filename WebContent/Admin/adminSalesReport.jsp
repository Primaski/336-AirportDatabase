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
<h1>Sales Reports:</h1>
<%
		try {
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();
			String Month = request.getParameter("month");
			String sql = "SELECT * FROM TravelDB.Buys where Buys.boughtOn like '2019-"+Month+"%'";
			ResultSet resultSet = null;
			resultSet = stmt.executeQuery(sql);
			if(resultSet.next() == false){
				out.println("This month has no sales.");
			}else{
				do{
					out.println("  		   TicketID:   		  " + resultSet.getString(1) + "  		   Username:   		  " + resultSet.getString(2) + "  		   Price:  		   " + resultSet.getString(3) +"			Date:		 " +resultSet.getString(4)+ "<br/>");
				}while(resultSet.next());
			}
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
%>

</body>
</html>