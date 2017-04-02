
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.Types,
java.sql.DriverManager,java.sql.DriverPropertyInfo,java.sql.SQLPermission,java.sql.Connection,
java.sql.Statement,java.sql.ResultSet,java.sql.SQLException,java.text.SimpleDateFormat,
java.util.*,java.io.*,java.sql.PreparedStatement,java.sql.CallableStatement,
java.sql.DatabaseMetaData"%>
<html>
<head>
    <title>Professor Homepage</title>
</head>
<body>
<%if ( !(request.getParameter("email") == null) )
{%>
<div class="professorInfo">
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
            String getProfessorInfo = "SELECT p.ssn, p.name, p.age, p.address, p.email, p.speciality, p.office "
                    + "FROM Professor p WHERE p.email = '" + request.getParameter("email") + "'";

            ResultSet rs = st.executeQuery(getProfessorInfo);
            ResultSet rs2;

            if ( rs.first() ) //if there's a professor with the specified email in the system
            {
                String getDeptHead = "SELECT d.dno, d.dname FROM Dept d WHERE d.ssn = '" + rs.getString("ssn") + "'";

                rs2 = st2.executeQuery(getDeptHead);


            %>
                <h2 align="center">Professor <%=rs.getString("name").substring(rs.getString("name").indexOf(" "))%>'s Homepage</h2>
                <h4>Personal Info:</h4>
                <p><strong>Name:</strong> <%=rs.getString("name")%> </p>
                <p><strong>Age:</strong> <%=rs.getInt("age")%> </p>
                <p><strong>Address:</strong> <%=rs.getString("address")%> </p>
                <p><strong>Professor Email:</strong> <%=rs.getString("email")%> </p>
                <p><strong>Speciality:</strong> <%=rs.getString("speciality")%> </p>
                <p><strong>Office:</strong> <%=rs.getString("office")%> </p>
            <%
                if ( rs2.first() )
                {
                    String deptHead = "";
                    int deptNum = 0;
                    deptHead = rs2.getString("dname");
                    deptNum = rs2.getInt("dno");
                %>
                    <p><strong>Head of: </strong><%=deptHead%></p>
                    <p><strong>Dept #:</strong> <%=deptNum%></p>

              <%}
              %>
</div>
<div class="courses">
    <h1 align="right"> Teaching Courses: </h1>
    <% String searchCondition = rs.getString("ssn");
        if (searchCondition != null)
        {%>
    <B> <%= getCourseList(searchCondition) %> </B> <HR><BR>
      <%}%>
</div>

<div class="major">

</div><%
            }
    }
    catch(SQLException e)
    {
        out.println(e.getMessage() + e.getErrorCode() + e.getSQLState());
    }
    %>
<%
}
else //user tried accessing homepage without logging in first
{%>
    <p>Please <a href="login.jsp">login</a> first to access your homepage.</p>
<%
}
%>

</body>
</html>


<%! private String getCourseList(String ssn) throws SQLException {
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
        rset = stmt.executeQuery ("SELECT C.cid, C.name, C.room, C.dno FROM course C WHERE C.ssn = '"
                + ssn + "'");
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
            sb.append("<P align=\"right\"> You are not currently teaching any courses.<P>\n");
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

