 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="adminRevenueReports.jsp" method="POST">
		Enter Username: 

		<br /> <input type="text" name="Username" /> <br />
		<input type="submit" value="Submit" />
		<br>
		
		Enter FlightID: 
		<br /> <input type="text" name="FlightID"/> <br />
		<input type="submit" value="Submit" />
		
		Enter AirlineCode: 
		<br /> <input type="text" name="AirlineCode"/> <br />
		<input type="submit" value="Submit" />
	</form>
	<br />
	<a href="adminIndex.jsp">Back to Admin Menu</a>

</body>
</html>