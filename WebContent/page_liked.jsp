<%@ page language="java" import="java.util.*,java.sql.*"
		 contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
	String msg = "";
	String connectString = "jdbc:mysql://jeako.pub:3306/follow"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8";
	String user="uroot"; 
	String pwd="123";
	
	String param = request.getParameter("user");
	String pid = "";
	if(param != null && !param.isEmpty()){
		pid += param;
	}
	else{
		pid += "visitor";
	}
	
	String str = "";
	try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con = DriverManager.getConnection(connectString,user, pwd);
		  Statement stmt=con.createStatement();
		  ResultSet rs=stmt.executeQuery("select * from "+pid);
		  while(rs.next()) {
			  str += "<p><a href=\"" ;
			  str += rs.getString("link");
			  str += "\">"; 
		  	  str += rs.getString("string");
		  	  str += "</a></p>";
		  }

		  rs.close();
		  stmt.close();
		  con.close();
	}
	catch (Exception e){
		msg = e.getMessage();
	}
	
	
%>

<!DOCTYPE HTML>
<html>
	<head>
		<title>新增学生记录</title>
		<style>
			body{
				font-family:微软雅黑,宋体;
			}
			a:link,a:visited { color:blue; }
			.container{
				margin:0 auto;
				width:500px;
				text-align:center;
			}
			form { line-height:50px; }
			a{
				margin-top : 300px;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<%=str %>
			<%=msg%><br>
		</div>
	</body>
</html>