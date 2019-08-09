
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
		<h1>Most Active Flights</h1>
<%
		try {
	
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();
			String sql = "Select flightID, max(k.pri) from (SELECT flightid, count(*) as pri FROM TravelDB.SpecificTo group by flightID) as k";
			ResultSet resultSet = null;
			resultSet = stmt.executeQuery(sql);
			if(resultSet.next() == false){
				out.println("There are no flights");
			}else{
				do{
					out.println();
					out.println("The Most active flight is flight number: " + resultSet.getString(1)+"   With the number of flights recording at: "+ resultSet.getString(2));
					
				}while(resultSet.next());
			}
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
%>
</body>
</html>