<!DOCTYPE html>
<html>
<head>
<title>Welcome!</title>
</head>
<body>
	<h1>Welcome </h1>
		<%=session.getAttribute("user")%>
	<h2>Please choose an option below.</h2>
	<li><a href="customerSearch.jsp">Search for availible tickets</a></li>
	<br />
	<li><a href="manageReservation.jsp">Create, Edit, or Delete
			Flights Reservations</a></li>
	<br />
	<li><a href="reservationLists.jsp">View My Reservations</a></li>
	<br />
	<li><a href="manageWaitlists.jsp"> Join or Leave Wait Lists
			for Overbooked Flights</a></li>
	<br />
	<li><a href="viewAllFlights.jsp">Filter Through Flights Based
			On Price, Airline, and # of Stops</a></li>
	<br />
	<a href="login.jsp">Back to Log In</a>
</body>
</html>