package com.cs336.pkg;
import java.util.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


public class CustomerSearchUtil {
	public static String hello = "hello!";
	
	public static ResultSet GetTable(String query){
		try{
			//Get the database connection
			Connection con = new ApplicationDB().getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			stmt.close();
			con.close();
			return rs;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	private static Connection ApplicationDB() {
		// TODO Auto-generated method stub
		return null;
	}

	public static String[][] GetTableArr(String query){
		try{
			ResultSet result = GetTable(query);
			int col = result.getMetaData().getColumnCount();
			List<String[]> table = new ArrayList<String[]>();
			while( result.next() ) {
			    String[] row = new String[col];
			    for( int i = 0; i < col; i++ ){
			            Object obj = result.getObject( i+1 );
			            row[i] = (obj == null) ? null : obj.toString();
			    }
			    table.add(row);
			}
			String[][] ret = new String[table.size()][col];
			return table.toArray(ret);
		}catch(Exception e){
			e.printStackTrace();	
		}
		return null;
	}
}
/*
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
	List<String> list = new ArrayList<String>();

	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get the combobox from the index.jsp
		String entity = request.getParameter("price");
		//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
		String str = "SELECT * FROM sells WHERE price <= " + entity;
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("bar");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("beer");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("price");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current bar name:
			out.print(result.getString("bar"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("beer"));
			out.print("</td>");
			out.print("<td>");
			//Print out current price
			out.print(result.getString("price"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");

		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>

</body>
</html>*/