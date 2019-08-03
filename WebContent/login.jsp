<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
   <h1> Login Page </h1>
   <h2> Welcome back! </h2>
     <form action="checkLoginDetails.jsp" method="POST">
       Username: <br/> <input type="text" name="username" required/> <br/>
       Password: <br/> <input type="password" name="password" required/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <br/>
     <a href="index.jsp">Return to Main Menu</a>
   </body>
</html>