<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Selected Aircraft</title>
</head>
<body>
	<h1>Edit Selected Aircraft</h1>
	<br />
	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String editAircraft = request.getParameter("toBeEdited");
			String query = "select *  from Aircrafts where Tailnumber = '" + editAircraft + "'";

			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(query);

			if (result.next() == false) {
				out.println("Result set is empty.");
			} else {

				String TailNumber = result.getString(1);
				String ModelNumber = result.getString(2);
				String Color = result.getString(3);
				String AirlineCode = result.getString(4);
				session.removeAttribute("editTailnum");
				session.removeAttribute("editModelnum");
				session.removeAttribute("editColor");
				session.removeAttribute("editAirlineCode");
				session.setAttribute("editTailnum", TailNumber);
				session.setAttribute("editModelnum", ModelNumber);
				session.setAttribute("editColor", Color);
				session.setAttribute("editAirlineCode", AirlineCode);

			}

			con.close();

		} catch (Exception e) {
			out.print(e);
		}
	%>

	<form action="checkAircraftUpdate.jsp" method="POST">
		TailNumber <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="tailNum"
			value=<%=session.getAttribute("editTailnum")%> required /> <br />
		ModelNumber <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="modelNum"
			value=<%=session.getAttribute("editModelnum")%> required /> <br />
		Color <font color="red"><b>*</b></font>: <br /> <input type="text"
			name="color" value=<%=session.getAttribute("editColor")%> required />
		<br /> AirlineCode <font color="red"><b>*</b></font>: <br /> <input
			type="text" name="color"
			value=<%=session.getAttribute("editAirlineCode")%> required /> <br />



		<input type="submit" value="Submit" />
	</form>
	<br />
	<a href="manageAircrafts.jsp">Return to Aircrafts Menu</a>
</body>
</html>

