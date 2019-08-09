
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
		<h1>Biggest Spender</h1>
<%
		try {
	
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			Statement stmt = con.createStatement();
			String Month = request.getParameter("month");
			String sql = "Select username, max(k.pri) from(SELECT Username, sum(price) as pri FROM Buys  group by username ) as k";
			ResultSet resultSet = null;
			resultSet = stmt.executeQuery(sql);
			if(resultSet.next() == false){
				out.println("There are no flights");
			}else{
				do{
					out.println();
					out.println("The biggest spender is: " + resultSet.getString(1)+"!!!!   With the record price spent of: "+ resultSet.getString(2));
					
				}while(resultSet.next());
			}
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
%>
</body>
</html>