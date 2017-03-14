<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.io.*, javax.servlet.*, javax.servlet.http.*, java.sql.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.Statement, java.util.ArrayList"%>

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
<body>

<div class='textBox' style='position: absolute;bottom: 80px;right: 20;'>
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
   Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5740/web?user=postgres&password=a");
   PreparedStatement statement = conn.prepareStatement("SELECT C.dno, C.room, C.remaining_seats, C.capacity " +
                                                       "FROM Course C, Enrolled_in E " +
                                                       "WHERE E.sid = " + sid + " AND C.cid = E.cid");
   ResultSet resultSet = statement.executeQuery();
   for (int i = 1; resultSet.next(); i+=1)
   {%>
      Course <%=i%> | Department: <%=resultSet.getString(1)%> | Room Number: <%=resultSet.getString(2)%> | Remaining Seats: <%=resultSet.getString(3)%>/<%=resultSet.getString(4)%>;
   <%}
} catch (Exception ex)
{%>
   <%=ex.getMessage()%></br>
   Course 1 | Department: 1 | Room Number: GYTE 220 | Remaining Seats: 12/30
<%}%>
</div>

</body>
</html>
