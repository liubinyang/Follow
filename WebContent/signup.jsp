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
	
	String username = request.getParameter("username");
	if(username == null) username ="";
	String password = request.getParameter("password");
	if(password == null) password ="";
	String repwd = request.getParameter("repwd");
	if(repwd == null) repwd ="";
	String submit = request.getParameter("sub");
	if(submit == null) submit ="";
	
	if(username != "" && password != "" && password.equals(repwd) 
			&& submit.equals("sign_up") ){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(connectString,user, pwd);
			Statement stmt = con.createStatement();
			ResultSet rs=stmt.executeQuery("select * from user");
			boolean flag = false;
			while(rs.next()) {
				  if(rs.getString("username").equals(username) ){
					  flag = true;
				  }
			}
			if(!flag){
				String fmt="insert into user(username,password) values('%s','%s')";
				String sql = String.format(fmt,username,password);
				int cnt = stmt.executeUpdate(sql);
				if(cnt>0) {
					msg = "Sign up successfully!";
					fmt="create table %swords (focusword varchar(30))";
					sql = String.format(fmt,username);
					stmt.executeUpdate(sql);
					
				}
			}
			else{
				msg = "username repeat";
			}
			stmt.close();
			con.close();
		}
		catch (Exception e){
			msg = e.getMessage();
		}
	}
	else if( (username == "" || password == "" || repwd == "") && submit.equals("立即注册") ){
		msg = "username/password cant be empty";
	}
	else{
		msg = " ";
	}
	
%>

<!DOCTYPE HTML>
<html>
	<head>
		<title>sign_up</title>
		<style type="text/css">
		   *{font-size:20px;font-family:微软雅黑}
		   body{background-image: url(5.jpg); background-position: center; background-size: cover; background-repeat:no-repeat; background-attachment: fixed;overflow: hidden;  }
		   #content {width:400px;height:400px}
		   .container{height: 400px;width:400px;margin:100px auto;padding:80px;}
		   input{color:#660099; box-shadow:0 3px 8px 0 rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(0, 0, 0, 0.14);
		    border-radius:1rem;
		    padding:10px 25px 10px 25px;
		    background-color:rgba(255,255,255,0.95);}
		      input.text{text-align:center;padding: 8px;margin-bottom: 15px;margin-left:75px;width: 12em;background-color: #000000;filter:alpha(opacity:70);opacity:0.6;}
		      input.button{text-size text-align:center;padding: 8px;margin-bottom: 15px;margin-left:75px; width: 13em;}
		      a{float: right;padding-right: 170px;padding-top: 10px; color:#3399ff;}
		      h1{font-size: 35px;color:#3366FF ;padding-bottom: 10px} 
		</style>
	</head>
	<body>
		<div class="container">
			<h1 align="center">FOLLOW</h1>
			<form action="signup.jsp" method="get" >
				<input name="username" id="username" class="text" type="text" placeholder="username" >
				<input name="password" id="password" class="text" type="password" placeholder="password" >
				<input name="repwd" id="repwd" type="password" class="text" placeholder="confirm" >
				<input type="submit" name="sub" class="button" value="sign_up" >
			</form>
			
			<p><%=msg%></p>
			<a href='login.jsp'>返回</a>
		</div>
	</body>
</html>