<!DOCTYPE html>
<html>
   <head>
      <title>Add Airport</title>
   </head>
   <body>
   <h1> Add Airport</h1>
   <br/>
     <form action="checkAirportCreation.jsp" method="POST">
       AirportCode <font color="red"><b>*</b></font>: <br/> <input type="text" name="AirportCode" required/> <br/>
       AirportName <font color="red"><b>*</b></font>: <br/> <input type="text" name="AirportName" required/> <br/>
       Address <font color="red"><b>*</b></font>: <br/> <input type="text" name="Address" required/> <br/>
       City <font color="red"><b>*</b></font>: <br/> <input type="text" name="City" required/> <br/>
       State <font color="red"><b>*</b></font>: <br/> <input type="text" name="State" required/> <br/>
       Country <font color="red"><b>*</b></font>: <br/> <input type="text" name="Country" required/> <br/>
       zipCode <font color="red"><b>*</b></font>: <br/> <input type="text" name="zipCode" required/> <br/>
       
       <input type="submit" value="Add Airport"/>
     </form>
     <br/>
     <a href="manageAirports.jsp">Return to Aircrafts Menu</a>
   </body>
</html>