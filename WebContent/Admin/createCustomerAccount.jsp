<!DOCTYPE html>
<html>
   <head>
      <title>Create Account</title>
   </head>
   <body>
   <h1> Create Account</h1>
   <br/>
     <form action="checkCustomerAccountCreation.jsp" method="POST">
       Username <font color="red"><b>*</b></font>: <br/> <input type="text" name="username" required/> <br/>
       Password <font color="red"><b>*</b></font>: <br/> <input type="password" name="password" required/> <br/>
       First Name <font color="red"><b>*</b></font>: <br/> <input type="text" name="first" required/> <br/>
       Last Name <font color="red"><b>*</b></font>: <br/> <input type="text" name="last" required/> <br/>
       Email Address<font color="red"><b>*</b></font>: <br/> <input type="text" name="email" required/> <br/>
       Street Address: <br/> <input type="text" name="address"/> <br/>
       City: <br/> <input type="text" name="city"/> <br/>
       State:<br/> <input type="text" name="state"/> <br/>
       Zip Code:<br/> <input type="text" name="zipCode"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <br/>
  <a href="adminIndex.jsp">Back to Admin Menu</a>
   </body>
</html>