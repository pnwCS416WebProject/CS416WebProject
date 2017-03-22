<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.io.*, javax.servlet.*, javax.servlet.http.*, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.Statement"%>

   <!-- Course: CS 416 -->
   <!-- Name: Drake -->
   <!-- Iteration 1 -->
   
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />

<style type='text/css'>
.textBox
{
background-color: #cc9900;
height:200px;
width:600px;
border:1px solid #ccc;
overflow:auto;
}
</style>

</head>

<%if (request.getParameter("course")!= null)
{
   try
   {
      DriverManager.registerDriver(new org.apache.derby.jdbc.ClientDriver());
      Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/web?user=postgres&password=a");
      PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) " +
                                                          "FROM Course " +
                                                          "WHERE c.cid='" + request.getParameter("course"));
      ResultSet resultSet = statement.executeQuery();
      resultSet.next();
      if (resultSet.getString(1).equals("1"))
      {
         /*insert into the database*/
         statement = conn.prepareStatement("SELECT u.ssn, u.email, u.password " +
                                           "FROM Undergraduate u" +
                                           "WHERE lower(email) = '" + request.getParameter("email") + "' AND password = '" + request.getParameter("pass") + "'");
         resultSet = statement.executeQuery();
         resultSet.next();%>
         
         <body onload='redirect()'>
         
         <script>
         function redirect()
         {
            location.href = 'AddCourses.jsp';
         }
         </script>
      <%} else
      {%>
         <body>
         IVALID LOGIN
      <%}
   } catch (Exception ex)
   {%>
      <body>
      <%=ex.getMessage()%></br>
      SYSTEM UNAVAILABLE. CHECK BACK LATER.
   <%}
}%>

Select a course you would like to enroll in.

<div class='textBox' style='position: absolute;bottom: 80px;right: 20;'>
<form action="AddCourses.jsp">
<select name="course">
<%try
{
   Cookie[] cookies = null;
   cookies = request.getCookies();
   boolean loggedIn = false;
   String sid = "";
   
   if (cookies != null)
   {
      for (int i = 0; i < cookies.length; i+=1)
      {
         if (cookies[i].getName().equals("ssn"))
         {
            loggedIn = true;
            sid = cookies[i].getValue();
         }
      }
   }
   DriverManager.registerDriver(new org.postgresql.Driver());
   Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/web?user=postgres&password=a");
   PreparedStatement statement = conn.prepareStatement("SELECT C.name C.cid " +
                                                       "FROM Course C" +
                                                       "WHERE NOT EXISTS (SELECT * " +
                                                       "FROM Enroll E " +
                                                       "WHERE E.sid = " + sid + " AND C.cid = E.cid)");
   ResultSet resultSet = statement.executeQuery();
   for (int i = 1; resultSet.next(); i+=1)
   {%>
      <option value=<%=resultSet.getString(2)%>><%=resultSet.getString(1)%></option>
   <%}
} catch (Exception ex)
{%>
   <%=ex.getMessage()%></br>
   You have already signed up for every course!
<%}%>
</form>
</div>

</body>
</html>
