<!DOCTYPE html>
<html>
<head>
<title>Welcome!</title>
</head>
<body>
	<%
	String failureMessage = "<h1>Oops! It seems you're not logged in.</h1>";
	try{
		Object user = session.getAttribute("user");
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
	%>
	<h2>Please choose an option below.</h2>
	<li><a href="customerSearch.jsp">Search for available flights</a></li>
	<br />
	<li><a href="viewReservations.jsp">View My Reservations and Wait Listings</a></li>
	<br />
	<li><a href="manageReservations.jsp">Modify My Reservations and Wait Listings</a></li>
	<br /><br />
	<li>To join the wait list for a full flight, search for the flight using our 
	search tool, and then click "Join wait list" if there is no remaining capacity.</li>
	<a href="login.jsp">Back to Log In</a>
</body>
</html>