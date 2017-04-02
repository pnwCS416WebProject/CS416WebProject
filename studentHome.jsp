<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.Types,
java.sql.DriverManager,java.sql.DriverPropertyInfo,java.sql.SQLPermission,java.sql.Connection,
java.sql.Statement,java.sql.ResultSet,java.sql.SQLException,java.text.SimpleDateFormat,
java.util.*,java.io.*,java.sql.PreparedStatement,java.sql.CallableStatement,
java.sql.DatabaseMetaData"%>
<html>
<head>
    <title> Student Homepage </title>
</head>
<body>
<%if ( !(request.getParameter("sid") == null) )
{%>
<div class="studentInfo">
    <%
        try
        {
            Class.forName("org.postgresql.Driver");
        }
        catch(ClassNotFoundException ex)
        {
            out.println("Error: unable to load driver class!");
            return;
        }
        String login = "jdbc:postgresql://localhost:5432/web";
        String user = "postgres";
        String pass = "a";
        try
        {
            Connection con = DriverManager.getConnection(login, user, pass);
            Statement st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            Statement st2 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String getStudentInfo = "SELECT u.name, u.sid, u.age, u.address, u.email, u.deg_prog, u.advsid, u.level "
                                 + "FROM Undergraduate u WHERE u.sid = " + request.getParameter("sid");

            String year = "";
            ResultSet rs = st.executeQuery(getStudentInfo);
            ResultSet rs2;

            if ( rs.first() ) //if there's a student with the specified sid in the system
            {
                if ( rs.getString("level").trim().equals("Freshman") )
                {
                    year = "Freshman (0-30 credit hours)";
                }
                else if ( rs.getString("level").trim().equals("Sophomore"))
                {
                    year = "Sophomore (30-60 credit hours)";
                }
                else if ( rs.getString("level").trim().equals("Junior") )
                {
                    year = "Junior (60-90 credit hours)";
                }
                else //senior
                {
                    year = "Senior (90+ credit hours)";
                }
                String getAdvisorInfo = "SELECT u.name, u.email FROM Undergraduate u WHERE u.sid = " + rs.getInt("advsid");
                rs2 = st2.executeQuery(getAdvisorInfo);
                String advisorName = "";
                String advisorEmail = "";
                String level = "";
                if ( rs2.first() ) //if student has been assigned an advisor
                {
                    advisorName = rs2.getString("name").trim();
                    advisorEmail = rs2.getString("email").trim();
                    level = rs.getString("level").trim();
                    if ( advisorEmail.equals(rs.getString("email").trim()) && !(level.equals("Senior")) ) //if student email = advisor's email
                    {                                                                                     //then they haven't been assigned an
                        advisorName = "Please select your major to be assigned an advisor";               //advisor yet, as freshman are
                        advisorEmail = "";                                                                //made their own advisors before
                    }                                                                                     //declaring a major
                }
          %>
                <h2 align="center"><%=rs.getString("name").substring(0, rs.getString("name").indexOf(" "))%>'s Homepage</h2>
                <h4>Student Info:</h4>
                <p><strong>Name:</strong> <%=rs.getString("name")%> </p>
                <p><strong>Student ID #:</strong> <%=rs.getInt("sid")%> </p>
                <p><strong>Age:</strong> <%=rs.getInt("age")%> </p>
                <p><strong>Address:</strong> <%=rs.getString("address")%> </p>
                <p><strong>Student Email:</strong> <%=rs.getString("email")%> </p>
                <p><strong>Major:</strong> <%=rs.getString("deg_prog")%> </p>
                <p><strong>Year:</strong> <%=year%> </p>
                <%
                    if ( !(level.equals("Senior")) ) //senior's don't have an advisor, only print if student not a senior
                    {
                    %>
                        <p><strong>Advisor Name:</strong> <%=advisorName%></p>
                        <p><strong>Advisor Email:</strong> <%=advisorEmail%></p>
                  <%}
                    else //student is a senior and advises lower level students
                    {
                        String getAdviseeCount = "SELECT COUNT(*) FROM Undergraduate WHERE advsid = "
                                              + request.getParameter("sid");
                        Statement st3 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        ResultSet rs3 = st3.executeQuery(getAdviseeCount);
                        int count;
                        if ( rs3.first() )
                        {
                            count = rs3.getInt(1);
                        }
                        else
                        {
                            count = 0;
                        }
                    %>
                        <p><strong>Student Advisees:</strong> <%=count%> </p>
                  <%}


            }
        }
        catch(SQLException e)
        {
            out.println(e.getMessage() + e.getErrorCode() + e.getSQLState());
        }

    %>
</div>
<div class="courses">
<h1 align="right"> Course List: </h1>
<% String searchCondition = request.getParameter("sid");
    if (searchCondition != null)
    {%>
<B> <%= getCourseList(searchCondition) %> </B> <HR><BR>
  <%}%>
</div>

<div class="major">

</div>
<%
}
else // user tried accessing homepage without logging in
{%>
    <p>Please <a href="login.jsp">login</a> first to access your homepage.</p>
<%
}
%>


</body>
</html>


<%! private String getCourseList(String sid) throws SQLException {
    Connection conn = null;
    Statement stmt = null;
    ResultSet rset = null;
    String login = "jdbc:postgresql://localhost:5432/web";
    String user = "postgres";
    String pass = "a";

    try
    {
        Class.forName("org.postgresql.Driver");
    }
    catch(ClassNotFoundException ex)
    {
        System.out.println("Error: unable to load driver class!");
    }

    try
    {
        System.out.println("here");
        //DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        conn = DriverManager.getConnection(login,
                user, pass);
        stmt = conn.createStatement();
        // dynamic query
        rset = stmt.executeQuery ("SELECT C.cid, C.name, C.room, C.dno FROM enrolled_in E, course C WHERE E.sid = "
                                   + sid + " AND E.cid = C.cid");
        return (formatResult(rset));
    }
    catch (SQLException e)
    {
        return ("<P> SQL error: <PRE> " + e + " </PRE> </P>\n");
    }
    finally
    {
        if (rset!= null) rset.close();
        if (stmt!= null) stmt.close();
        if (conn!= null) conn.close();
    }
}
    private String formatResult(ResultSet rset) throws SQLException
    {
        StringBuffer sb = new StringBuffer();
        if (!rset.next())
            sb.append("<P align=\"right\"> You are not currently enrolled in any courses.<P>\n");
        else
        {  sb.append("<table border=\"2px\" align=\"right\">"
                         + "<tr><th>" + "course number " + "</th>"
                         + "<th>" + "course name" + "</th>" + "<th>" + "room number" + "</th>"
                         + "<th>" + "department number" + "</th>" + "</tr>");
            do {  sb.append("<tr><td>" + rset.getInt(1) + "</td>" + "<td>" + rset.getString(2)
                  + "</td>" + "<td>" + rset.getString(3) + "</td>" + "<td>"
                  + rset.getInt(4) + "</td>" + "<tr>");
            } while (rset.next());
            sb.append("</table>");
        }
        return sb.toString();
    }
%>