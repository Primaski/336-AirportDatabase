<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>


<head>
<title>Edit Customer Rep Account</title>
</head>
<body>
	<h1>
		<b>Select a Customer Rep Account to Edit</b>
	</h1>
	<b>Airports: </b>
	<font color="red"><b>*</b></font>
	<form action="editCustomerAccountDetail.jsp" method="POST">
		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			Statement stmt = con.createStatement();
			String str = "SELECT username FROM users WHERE userRole='Customer Rep'";
			ResultSet airports = stmt.executeQuery(str);
			out.println("<select name =\"toBeEdit\">");
			while (airports.next()) {
				out.println("<option>" + airports.getString(1));
			}
			airports.beforeFirst();//hi
			out.println("</select> <br/>");
		%>
		<br /> <input type="submit" value="Edit Selected Customer Representative" />
	</form>
	</body>
	<script>
	function isNo(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)){ return false; }
	    return true;
	}
	</script>
</html>