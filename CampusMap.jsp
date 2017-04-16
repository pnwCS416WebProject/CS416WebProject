<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.io.*,javax.servlet.*,javax.servlet.http.*,java.sql.*,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Statement"%>

   <!-- Course: CS 416 -->
   <!-- Name: Drake -->
   <!-- Iteration 1 -->   
   
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
</head>

<body onload='Rasterize()'>

<script>

function face(p1, p2, p3, p4)
{
   this.point1 = p1;
   this.point2 = p2;
   this.point3 = p3;
   this.point4 = p4;
}



function point(x,y,z)
{
   this.x = x;
   this.y = y;
   this.z = z;
}

function buildBuildingModel()
{
   var buildingModel = [];
   var p1;
   var p2;
   var p3;
   var p4;
   
   <%try
   {
      int building = 1;
      
      if (request.getParameter("bid")!= null)
      {
         building = request.getParameter("bid")
      }
      
      DriverManager.registerDriver(new org.postgresql.Driver());
      Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/web?user=postgres&password=a");
      PreparedStatement statement2 = conn.prepareStatement("SELECT r.rid " +
                                                           "FROM room r " +
                                                           "WHERE r.bid = " + building);
      ResultSet resultSet2 = statement.executeQuery();
      for (int i = 0; resultSet.next(); i += 1)
      {
         PreparedStatement statement2 = conn.prepareStatement("SELECT p1.x1, p1.y1, p2.x2, p2.y2, p3.x3, p3.y3, p4.x4, p4.y4 " +
                                                              "FROM point1 p1, point2 p2, point3 p3, point3 p4 " +
                                                              "WHERE p1.rid = " + resultSet.getString(1) + " AND p2.rid = " + resultSet.getString(1) + " AND p3.rid = " + resultSet.getString(1) + " AND p4.rid = " + resultSet.getString(1));
         ResultSet resultSet2 = statement.executeQuery();
         resultSet2.next();
         %>
         p1 = new point(<%=resultSet2.getString(1)%>,<%=resultSet2.getString(2)%>,0);
         p2 = new point(<%=resultSet2.getString(3)%>,<%=resultSet2.getString(4)%>,0);
         p3 = new point(<%=resultSet2.getString(5)%>,<%=resultSet2.getString(6)%>,0);
         p4 = new point(<%=resultSet2.getString(7)%>,<%=resultSet2.getString(8)%>,0);
         buildingModel[<%=i%>] = new face(p1,p2,p3,p4);
      <%}
      
   }%>
   
   return buildingModel;
}



function Rasterize()
{
   model2D = buildBuildingModel();
   if (typeof model2D != 'undefined')
   {
      var numberOfFaces = model2D.length;
   }
   for (var i = 0; i < numberOfFaces; i = i + 1)
   {
      var p1 = [model2D[i].point1.x,model2D[i].point1.y];
      var p2 = [model2D[i].point2.x,model2D[i].point2.y];
      var p3 = [model2D[i].point3.x,model2D[i].point3.y];
      var p4 = [model2D[i].point4.x,model2D[i].point4.y];
      
      var canvas = document.getElementById("campusMap");
      
      var h = canvas.height;
      var w = canvas.width;
      
      var context = canvas.getContext('2d');
      context.beginPath();
      
      context.moveTo(w*p1[0], h*p1[1]);
      context.lineTo(w*p2[0], h*p2[1]);
      context.lineTo(w*p3[0], h*p3[1]);
      context.lineTo(w*p4[0], h*p4[1]);
      context.closePath();
      context.fill();
      context.stroke();
   }
   return;
}
</script>


<canvas id="campusMap" width="1000" height="500" style="border:1px solid #d3d3d3;">
Your browser does not support the HTML5 canvas tag.</canvas>

</body>
</html>
