<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String failureMessage = "<h1>Oops! It seems you're not logged in.</h1>";
	Object user = null;
	try{
		user = session.getAttribute("user");
		if(user == null){
			out.println(failureMessage);
			return;
		}else{
			out.println("<h1> Welcome, " + user.toString() + "!</h1><br/>");
		}
	}catch(Exception e){
		out.println(failureMessage);
		return;
	}
	
	//Retrieve user flights - NON-WAIT LISTED
	
	
	
	
	%>
</body>
</html>
