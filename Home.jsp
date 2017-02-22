<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.io.*,javax.servlet.*,javax.servlet.http.*,java.sql.*,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Statement"%>

<!--
Home page
-->
<html>
<head>

<style type='text/css'>
.header
{
text-align:right;
background-color: #ffffff;
}
body
{
background-color: a4c5fc;
}
.data
{
background-color: #00ffff;
margin-left:10%;
margin-right:10%;
}
</style>

<title>JSU Homepage</title>
</head>
<body>
<div class='header'>
<img src='Navigation.png' usemap='#nav'/>
<map name='nav' id=''>
<area href='Home' shape='rect' coords='109,47,322,121' />
<area href='Enroll.html' shape='rect' coords='340,47,552,120' />
<area href='Majors.html' shape='rect' coords='571,46,790,119' />
<area href='Login.html' shape='rect' coords='810,48,1012,118' />
</map>
</div>
<br/>
<br/><br/><br/>
<div class='data'>
<p>Welcome to the JSU homepage. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
<br/>
<br/>
<br/>
<br/>

<%try
{
   DriverManager.registerDriver(new org.postgresql.Driver());
   Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5740/database");
   PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) " + 
                                                       "FROM Undergraduate");
   ResultSet resultSet = statement.executeQuery();
   while (resultSet.next())
   {%>
      <strong>There are currently <%=resultSet.getString(1)%> students enrolled at JSU.</strong>
   <%}
} catch (Exception ex)
{%>
   <strong>There are currently 0 students enrolled at JSU.</strong>
<%}%>

<br/>

<%try
{
   DriverManager.registerDriver(new org.postgresql.Driver());
   Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5740/database");
   PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) " + 
                                                       "FROM Professor");
   ResultSet resultSet = statement.executeQuery();
   while (resultSet.next())
   {%>
      <strong>There are currently <%=resultSet.getString(1)%> professors working at JSU.</strong>
   <%}
} catch (Exception ex)
{%>
   <strong>There are currently 0 professors working at JSU.</strong>
<%}%>

<br/>

<%try
{
   DriverManager.registerDriver(new org.postgresql.Driver());
   Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5740/database");
   PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) " + 
                                                       "FROM Courses");
   ResultSet resultSet = statement.executeQuery();
   while (resultSet.next())
   {%>
      <strong>There are currently <%=resultSet.getString(1)%> courses offerred at JSU.</strong>
   <%}
} catch (Exception ex)
{%>
   <strong>There are currently 0 courses offerred at JSU.</strong>
<%}%>

<br/><br/><br/><br/>

<br/>
<br/>
<br/>
<br/>

<br/>
<br/>
<br/>
<br/>

<br/>
<br/>
<br/>
<br/>

<br/>
<br/>
<br/>
<br/>

<br/>
<br/>
<br/>
<br/>

</div>
</body>
</html>
