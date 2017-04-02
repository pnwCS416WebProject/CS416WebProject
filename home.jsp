
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.Types,
java.sql.DriverManager,java.sql.DriverPropertyInfo,java.sql.SQLPermission,java.sql.Connection,
java.sql.Statement,java.sql.ResultSet,java.sql.SQLException,java.text.SimpleDateFormat,
java.util.*,java.io.*,java.sql.PreparedStatement,java.sql.CallableStatement,
java.sql.DatabaseMetaData"%>

<html>
<head>
    <link rel="stylesheet" href="Styles.css" type="text/css"/>
</head>
<body>
<div class="header">
    <img src="Navigation.png" usemap="#nav"/>
    <map name="nav" id="">
        <area href="home.jsp" shape="rect" coords="109,47,322,121" />
        <area href="enroll.jsp" shape="rect" coords="340,47,552,120" />
        <area href="Majors.html" shape="rect" coords="571,46,790,119" />
        <area href="login.jsp" shape="rect" coords="810,48,1012,118" />
    </map>
</div>


<h1 align="center">Welcome to JSU!
</h1>
<h3>JSU is a state-of-the-art university with an emphasis on technology. Enroll today!</h3>


<br/><br/>
<div class="data">
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
            Statement st3 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            Statement st4 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            String studentCount = "SELECT COUNT(*) FROM Undergraduate";
            String facultyCount = "SELECT COUNT(*) FROM Professor";
            String courseCount = "SELECT COUNT(*) FROM Course";
            String majorCount = "SELECT COUNT(*) FROM Dept";
            ResultSet rs = st.executeQuery(studentCount);
            ResultSet rs2 = st2.executeQuery(facultyCount);
            ResultSet rs3 = st3.executeQuery(courseCount);
            ResultSet rs4 = st4.executeQuery(majorCount);

            int students;
            int teachers;
            if ( rs.next() )
            {%>
                <h3>There are currently <%=rs.getInt(1)%> students enrolled at JSU.</h3>
          <%    students = rs.getInt(1);
            }
            else
            {%>
                <h3>There are 0 students enrolled at JSU. Become the first student to enroll!</h3>
          <%    students = 1;
            }

            if ( rs2.next() )
            {%>
                <h3>Our students are served by a faculty of <%=rs2.getInt(1)%> full-time professors!</h3>
          <%    teachers = rs2.getInt(1);
            }
            else
            {%>
                <h3>Become a professor today!</h3>
          <%    teachers = 1;
            }
            double ratio = students/(double)teachers;
            %>
                <h3 align="right"><%=ratio%>:1 Student To Faculty Ratio.</h3>
            <%
            if ( rs3.next() && rs4.next() )
            {%>
                <h3><%=rs3.getInt(1)%> courses offered among <%=rs4.getInt(1)%> different majors.</h3>
          <%
            }
            else
            {%>
                <h3>New courses and majors coming soon.</h3>
          <%
            }

        }
        catch(SQLException e)
        {
            out.println(e.getMessage() + e.getErrorCode() + e.getSQLState());
        }


    %>
    <br/>
    <br/>
    <br/>
    <br/>

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