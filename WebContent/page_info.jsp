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
	
	String str = "<table class=\"lab\">";
	try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con = DriverManager.getConnection(connectString,user, pwd);
		  Statement stmt=con.createStatement();
		  ResultSet rs=stmt.executeQuery("select * from "+pid+"words");
		  while(rs.next()) {
			  str += "<span>" ;
			  str += rs.getString("focusword");
		  	  str += "</span>";
		  }

		  rs.close();
		  stmt.close();
		  con.close();
	}
	catch (Exception e){
		msg = e.getMessage();
	}
	
	
%>

<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
	<meta charset="utf-8">
	<title >login</title>
	<style type="text/css">
	   *{font-size:20px;font-family:微软雅黑}
	   .d1{position:fixed;z-index:-1;height:100%;width: 100px;top:0px;left:0px;background-color: #000000}
	   .title{padding: 20px}
	   .d2{position:absolute;z-index:-1;height: auto;width: auto;top:0px;left:100px;right: 0px; padding-top: 15px;text-align: center;}
	   .dd{height: 40px;width: 40px;padding: 30px; padding-bottom: 30px;padding-top: 30px;border-radius: 1em 0em 0em 1em;}
	   .dd:hover{background-color:#99CCFF;}
	   .lin{text-align: center;color: #9999FF}
	   input{margin: 10px;}
	   .photo{margin-top: 50px;margin-bottom: 20px}
	   .pho{width: 100%; max-width: 200px; height: 100%; max-height: 200px; border-radius: 50%}
	   .user{font-size: 30px;}
	   .lab{margin: 20px;}
	   td{ width:100px;text-align: center; padding: 10px; }
	   body{background-color: #99CCFF}
	   span{
	   		padding : 10px;
	   }
	</style>
</head>
<body >
  <div class="d2" width="70%">
    <div class="photo"><img class="pho" src="1.jpg"/></div>
    <p class="user"><%=pid %></p>
    <p class="keyword">keyword</p>
	<%=str %>
  </div>
</body>
</html>