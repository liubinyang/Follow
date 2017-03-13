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
	
	String act = request.getParameter("act");
	if(act==null) act="";
	
	String str = "";
	try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con = DriverManager.getConnection(connectString,user, pwd);
		  Statement stmt=con.createStatement();
		  if(act.equals("delete")){
			  String fmt="delete from %s where focusword='%s'";
			  String sql = String.format(fmt,pid+"words",request.getParameter("word"));
			  int cnt = stmt.executeUpdate(sql);
			  if(cnt>0){
				  %>
				  <script>
				  	alert("delete successfully");
				  </script>
				  <%
			  }
			  else{
				  %>
				  <script>
				  	alert(<%=msg%>);
				  </script>
				  <%
			  }
		  }
		  else if(act.equals("add")){
			  String fmt="insert into %s(focusword) values('%s')";
			  String sql = String.format(fmt,pid+"words",request.getParameter("word"));
			  int cnt = stmt.executeUpdate(sql);
			  if(cnt>0){
				  %>
				  <script>
				  	alert("add successfully");
				  </script>
				  <%
			  }
			  else{
				  %>
				  <script>
				  	alert(<%=msg%>);
				  </script>
				  <%
			  }
		  }
		  ResultSet rs=stmt.executeQuery("select * from "+pid+"words");
		  while(rs.next()) {
			  str += "<span onclick=\"dele(this.innerText)\">";
			  str += rs.getString("focusword");
		  	  str += "</span>";
		  }
%>


<!DOCTYPE HTML>
<html>
	<head>
		<title>add tag</title>
		<style>
	  	 	*{font-size:20px;font-family:微软雅黑}
			body{
				font-family:微软雅黑,宋体;
			}
			a:link,a:visited { color:blue; }
			.container{
				margin:0 auto;
				width:100%;
				text-align:center;
			}
			form { line-height:50px; }
			a{
				margin-top : 300px;
			}
			span{
	   			margin : 20px;
				cursor:pointer;
	  		}
	  		img{
	  			width:50px;
	  		}
		</style>
	</head>
	<body>
		<script language="javascript">
			function dele(val){
				window.location.href="page_add.jsp?user=<%=pid%>&act=delete&word="+val;
			}
			function add(){
				input = prompt("input tag you wanna follow:","");
				if (input != null){
					window.location.href="page_add.jsp?user=<%=pid%>&act=add&word="+input;
				}
			}
		</script>
		<div class="container">
			<%=str %>
			<p onclick="add()"><img src="main_add.png"/></p>
		</div>
	</body>
</html>

<%
		  rs.close();
		  stmt.close();
		  con.close();
	}
	catch (Exception e){
		msg = e.getMessage();
	}
	
	
%>