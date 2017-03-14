<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.io.*,javax.servlet.*,javax.servlet.http.*,java.sql.*,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Statement"%>

   <!-- Course: CS 416 -->
   <!-- Name: Drake -->
   <!-- Iteration 1 -->
   
<html>
<head>
<title>Login</title>

<style type='text/css'>
.login
{
   text-align:center;
   width:80%;
   margin-top:20%;
   margin-left:10%;
   margin-right:10%;
   background-color: #808040;
}

.f1
{
border: 1px solid black;
background-color: #D9DAB8;
}
</style>
</head>

<body>
<div class='login'>
<form method='post' action='Login.jsp'>
<label>Please enter your username:<br/></label>
<input type='text' name='email' value=<%=request.getParameter("email")%>><br/>
<label>Please enter a password for your account:<br/></label>
<input type='password' name='pass' value=<%=request.getParameter("pass")%>><br/>

<input type='submit' value='login' name='login'>
<br/>
<%if (request.getParameter("login")!= null)
{
   try
   {
      DriverManager.registerDriver(new org.apache.derby.jdbc.ClientDriver());
      Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5740/web?user=postgres&password=a");
      PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) " +
                                                          "FROM Undergraduate " +
                                                          "WHERE lower(email)='" + request.getParameter("email") + "' AND password='" + request.getParameter("pass") + "'");
      ResultSet resultSet = statement.executeQuery();
      resultSet.next();
      if (resultSet.getString(1).equals("1"))
      {
         statement = conn.prepareStatement("SELECT u.ssn, u.email, u.password " +
                                           "FROM Undergraduate u" +
                                           "WHERE lower(email) = '" + request.getParameter("email") + "' AND password = '" + request.getParameter("pass") + "'");
         resultSet = statement.executeQuery();
         resultSet.next();%>
         
         <body onload='processLogin()'>
         
         <script>
         function processLogin()
         {
            var d = new Date();
            d.setTime(d.getTime() + (24*60*60*1000));
            var expires = 'expires='+ d.toGMTString();
            document.cookie = 'ssn=" + resultSet.getString(1) + ";' + expires + ';path=/';
            location.href = 'studentHome.jsp';
         }
         </script>
      <%} else
      {%>
         IVALID LOGIN
      <%}
   } catch (Exception ex)
   {%>
      <%=ex.getMessage()%></br>
      SYSTEM UNAVAILABLE. CHECK BACK LATER.
   <%}
}%>
</div>
</body>
</html>
