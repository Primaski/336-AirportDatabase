<!DOCTYPE html>
<html>
   <head>
      <title>Add Aircraft</title>
   </head>
   <body>
   <h1>Add Aircraft</h1>
   <br/>
     <form action="checkAircraftCreation.jsp" method="POST">
       ModelNumber <font color="red"><b>*</b></font>: <br/> <input type="text" name="modelNum" required/> <br/>
       EconomyCapacity <font color="red"><b>*</b></font>: <br/> <input type="number" name="econCapacity" required/> <br/>
       BusinessCapacity <font color="red"><b>*</b></font>: <br/> <input type="number" name="busCapacity" required/> <br/>
       FirstClassCapacity <font color="red"><b>*</b></font>: <br/> <input type="number" name="firstCapacity" required/> <br/>
     
       <input type="submit" value="Submit"/>
     </form>
     <br/>
     <a href="manageAircrafts.jsp">Return to Aircrafts Menu</a>
   </body>
</html>

