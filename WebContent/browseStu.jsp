<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
	request.setCharacterEncoding("utf-8");
	String msg ="";
	String connectString = "jdbc:mysql://jeako.pub:3306/follow"
					+ "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8"; 
        StringBuilder table=new StringBuilder("");
	try{
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con=DriverManager.getConnection(connectString, 
	                 "uroot", "123");
	  Statement stmt=con.createStatement();
	  ResultSet rs=stmt.executeQuery("select * from jeako");
	  while(rs.next()) {
             table.append("<p>"+rs.getString("string")+"</p>");
	  }
	  rs.close();
	  stmt.close();
	  con.close();
	}
	catch (Exception e){
	  msg = e.getMessage();
	}
%><!DOCTYPE HTML>
<html>
<head>
<title>登陆</title>
</head>
<body>
  <div class="container">
	  <h1>1111</h1>  
	  <%=table%><br><br>  
  </div>
</body>
</html>
