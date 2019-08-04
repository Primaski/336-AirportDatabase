<!DOCTYPE html>
<html>
<head>
<title>Welcome!</title>
</head>
<%=session.getAttribute("user")%>
<body>
	<h1>Welcome </h1>
	<h2>Please choose an option below.</h2>
	<li><a href="customerSearch.jsp">Search for available flights</a></li>
	<br />
	<li><a href="manageReservation.jsp">Create, Edit, or Delete
			Flights Reservations</a></li>
	<br />
	<li><a href="reservationLists.jsp">View My Reservations</a></li>
	<br /><br />
	<li>To join the wait list for a full flight, search for the flight using our 
	search tool, and then click "Join wait list" if there is no remaining capacity.</li>
	<a href="login.jsp">Back to Log In</a>
</body>
</html>