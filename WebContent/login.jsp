<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%><%
	request.setCharacterEncoding("utf-8");
	String hint = request.getParameter("hint");
	if(hint == null)
		hint="";
	String msg ="";
	String user_str = "";
	String pwd_str = "";
	String connectString = "jdbc:mysql://jeako.pub:3306/follow"
					+ "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8"; 
	String user="uroot"; 
	String pwd="123";
	ArrayList<String> username = new ArrayList<String> ();
	ArrayList<String> password = new ArrayList<String> ();
	try{
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(connectString,user, pwd);
	  Statement stmt=con.createStatement();
	  ResultSet rs=stmt.executeQuery("select * from user");
	  while(rs.next()) {
		  username.add(rs.getString("username")) ;
		  password.add(rs.getString("password")) ;
	  }
	  
	  Iterator it = username.iterator();
      while(it.hasNext()){
          user_str += it.next() + ",";
      }
      it = password.iterator();
      while(it.hasNext()){
          pwd_str += it.next() + ",";
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
		<style type="text/css">
		   *{font-size:20px;font-family:微软雅黑}
		   #content {width:400px;height:400px}
		   .container{ position: center; height: 400px;width:400px;margin:100px auto;padding:80px;}
		   input{color:#660099; box-shadow:0 3px 8px 0 rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(0, 0, 0, 0.14);
		    border-radius:1rem;
		    padding:10px 25px 10px 25px;
		    background-color:rgba(255,255,255,0.95);}
		      input.input{text-align:center;padding: 8px;margin-bottom: 15px;margin-left:75px;width: 12em;background-color: #000000;filter:alpha(opacity:70);opacity:0.6;}
		      input.button1{text-size text-align:center;padding: 8px;margin-bottom: 15px;margin-left:75px; width: 6em;}
		      input.button{text-size text-align:center;padding: 8px;margin-bottom: 15px;margin-left:10px; width: 6em;}
		      body{background-image: url(5.jpg); background-position: center; background-size: cover; background-repeat:no-repeat; background-attachment: fixed;overflow: hidden;  }
		      h1{font-size: 35px;color:#3366FF;padding-bottom: 10px} 
		</style>
	</head>
	
	<body>
	  <div class="container">
	  	  <h1 align="center">FOLLOW</h1>
	  	  <form id="login" action="login.jsp?hint=Invalid username/password" method="POST" enctype="multipart/form-data"> 
				<input type="text" id="id" class="input" placeholder="username"></p> 
				<input type="password" id="pwd" class="input" placeholder="password"></p> 
		 		<input type="submit" id="log_in" value="log in" class="button1" onclick="check()">
		 		<input type="submit" id="sign_up" value="sign up" class="button" onclick="signup()">
		 		<p id="print"><%=hint %></p>
		  </form>
		 		
		  <script type="text/javascript">
		  	function check(){
		  		var out = document.getElementById("print");
		  		
		  		var user = "<%=user_str %>";
		  		var pwd = "<%=pwd_str %>";
		  		var user_strs= new Array(); //定义数组 
		  		var pwd_strs= new Array(); 
				user_strs = user.split(","); //字符分割
				pwd_strs = pwd.split(","); 
				
 				var idv = document.getElementById("id").value;
 				var pwdv = document.getElementById("pwd").value;
				
 				out.innerHTML = "Invalid username/password";
				for (i=0;i<user_strs.length ;i++ ) 
				{ 	
					if(idv == user_strs[i] && pwdv == pwd_strs[i] && idv!="" && pwdv!="") {
						out.innerHTML = "yes";
						document.getElementById("login").action = "page.jsp?user="+idv;
						out.innerHTML = "";
					}
				} 
		  		
		  	}
		  </script>
		  
		  <script type="text/javascript">
		  	function signup(){
				document.getElementById("login").action = "signup.jsp";
		  	}
		  </script>
  
		  <br><br>  
	  </div>
	</body>
</html>
