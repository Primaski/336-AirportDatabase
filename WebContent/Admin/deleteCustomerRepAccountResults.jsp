<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remaining Customer Representative Accounts</title>
</head><head><title>Remaining Customer Representative Accounts</title></head>
	<body>
	<h1><b>Remaining Customer REpresentative Accounts</b></h1>

	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String delAccount = request.getParameter("toBeDel");
			String delQuery="delete  from users where username = '"+ delAccount + "'";
			Statement stmt = con.createStatement();
			stmt.executeUpdate(delQuery);
			String query="Select * from users where userRole = 'Customer Rep'";
			ResultSet result = stmt.executeQuery(query);
			if(result.next() == false){
				out.println("Result set is empty.");
			}else{
				do{
					 out.println(result.getString(1) + "  		  User Role: 		  " + result.getString(3) +"<br/>");
				}while(result.next());
			}
			con.close();
			
			

		} catch (Exception e) {
			out.print(e);
		}
	%>
<br />
	<a href="manageCustomers.jsp">Return to Manage Customers Menu</a>
</body>
</html>