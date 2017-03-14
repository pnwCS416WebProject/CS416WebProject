<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.io.*,javax.servlet.*,javax.servlet.http.*,java.sql.*,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Statement"%>

   <!-- Course: CS 416 -->
   <!-- Name: Drake -->
   <!-- Iteration 1 -->
   
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />

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
background-color: #000000;
margin-left:10%;
margin-right:10%;
}
</style>

<title>Math</title>
</head>
<body>
<div class='header'>
<img src='Navigation.png' usemap='#nav'/>
<map name='nav' id=''>
<area href='Home.html' shape='rect' coords='109,47,322,121' />
<area href='Enroll.html' shape='rect' coords='340,47,552,120' />
<area href='Majors.html' shape='rect' coords='571,46,790,119' />
<area href='Login.html' shape='rect' coords='810,48,1012,118' />
</map>
</div>
<h1>CS</h1>
<p>Math is the study of lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
<h4>Courses:</h4>
<ul>
<li>This is a course</li>
<li>This is another course</li>
<li>This is yet another course</li>
<li>Guess what another course</li>
<li>This is not a course just kidding yes it is</li>
</ul>
<h4>Projects:</h4>
<ul>
<li>This is a project</li>
<li>Another project</li>
</ul>

<%try
{
   DriverManager.registerDriver(new org.postgresql.Driver());
   Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5740/web?user=postgres&password=a");
   PreparedStatement statement = conn.prepareStatement("SELECT p.name, d.office " + 
                                                       "FROM Dept d,Professor p " +
                                                       "WHERE d.Dname = 'Department of Math' AND d.ssn = p.ssn");
   ResultSet resultSet = statement.executeQuery();
   while (resultSet.next())
   {%>
      <strong>Department Head: <%=resultSet.getString(1)%></strong>
      <strong>Department Office: <%=resultSet.getString(2)%></strong>
   <%}
} catch (Exception ex)
{%>
   <%=ex.getMessage()%></br>
   <strong>Department Head: Dr. Strangelove</strong>
   <strong>Department Office: Room 815</strong>
<%}%>

<p>Please contact the department secretary if you have any questions at foo@bar.com</p>
</body>
</html>
