<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Selected Airport</title>
</head>
<body>
	<h1>Edit Selected Airport: To change airport code, edit no other fields</h1>
	<br />
	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String editAirport = request.getParameter("toBeEd");
			String query = "SELECT *  FROM Airports WHERE AirportCode = '" + editAirport + "'";

			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(query);

			if (result.next() == false) {
				out.println("Result set is empty.");
			} else {

				String AirportCode = result.getString(1);
				String AirportName = result.getString(2);
				String Address = result.getString(3);
				String City = result.getString(4);
				String State = result.getString(5);
				String Country = result.getString(6);
				String zipCode = result.getString(7);

				session.removeAttribute("editAirportCode");
				session.removeAttribute("editAirportName");
				session.removeAttribute("editAddress");
				session.removeAttribute("editCity");
				session.removeAttribute("editState");
				session.removeAttribute("editCountry");
				session.removeAttribute("editzipCode");

				session.setAttribute("editAirportCode", AirportCode);
				session.setAttribute("editAirportName", AirportName);
				session.setAttribute("editAddress", Address);
				session.setAttribute("editCity", City);
				session.setAttribute("editState", State);
				session.setAttribute("editCountry", Country);
				session.setAttribute("editzipCode", zipCode);

			}

			con.close();

		} catch (Exception e) {
			out.print(e);
		}
	%>

	 <form action="checkAirportUpdate.jsp" method="POST">
       AirportCode <font color="red"><b>*</b></font>: <br/> <input type="text" name="AirportCode" value=<%=session.getAttribute("editAirportCode")%> required/> <br/>
       AirportName <font color="red"><b>*</b></font>: <br/> <input type="text" name="AirportName" value=<%=session.getAttribute("editAirportName")%> required/> <br/>
       Address <font color="red"><b>*</b></font>: <br/> <input type="text" name="Address" value=<%=session.getAttribute("editAddress")%> required/> <br/>
       City <font color="red"><b>*</b></font>: <br/> <input type="text" name="City" value=<%=session.getAttribute("editCity")%> required/> <br/>
       State <font color="red"><b>*</b></font>: <br/> <input type="text" name="State" value=<%=session.getAttribute("editState")%> required/> <br/>
       Country <font color="red"><b>*</b></font>: <br/> <input type="text" name="Country" value=<%=session.getAttribute("editCountry")%> required/> <br/>
       zipCode <font color="red"><b>*</b></font>: <br/> <input type="text" name="zipCode" value=<%=session.getAttribute("editzipCode")%> required/> <br/>
       
       <input type="submit" value="Edit Airport"/>
	</form>
	<br />
	<a href="manageAirports.jsp">Return to Airports Menu</a>
</body>
</html>

