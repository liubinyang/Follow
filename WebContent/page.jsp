<%@ page language="java" import="java.util.*,java.sql.*"
		 contentType="text/html; charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
	
	String param = request.getParameter("user");
	String pid = "";
	if(param != null && !param.isEmpty()){
		pid += param;
	}
	else{
		pid += "visitor";
	}
%>

<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
<meta charset="utf-8">
<style type="text/css">
   *{font-size:20px;font-family:微软雅黑}
   .d1{position:fixed;z-index:-1;height:100%;width: 100px;top:0px;left:0px;background-color: #000000}
   .d2{position:absolute;height:98%;left:100px;right:0px;top:0px;right:0px;}
    .dd{height: 40px;width: 40px;padding: 30px;border-radius: 1em 0em 0em 1em;}
    .dd:hover{background-color:#99CCFF;}
    .lin{text-align: center;color: #9999FF}
    img{
    	width:100%; 
    	height:100%; 
    }
   body{background-color: #99CCFF}
</style>
</head>
<body >
  <div class="d1">
    <div class="dd" id="info"><img src="main_user.png" /></div>
    <p class="lin">&nbsp———&nbsp</p> 
    <div class="dd" id="browse"><img src="main_book.png"/></div>
    <div class="dd" id="liked" ><img src="main_love.png"/></div>
    <div class="dd" id="add"><img src="main_add.png"/></div>
  </div>
  
  <script>
	document.getElementById("info").onclick = Function("return user_info()");
	document.getElementById("browse").onclick = Function("return browse()");
	document.getElementById("liked").onclick = Function("return liked()");
	document.getElementById("add").onclick = Function("return add_item()");
	var user = "<%=pid %>";
	function user_info(){
		document.getElementById("iframe").src = "page_info.jsp?user="+user;
	}
	
	function browse(){
		document.getElementById("iframe").src = "page_browse.jsp?user="+user;
	}

  	function liked(){
		document.getElementById("iframe").src = "page_liked.jsp?user="+user;
	}
  	
  	function add_item(){
		document.getElementById("iframe").src = "page_add.jsp?user="+user;
	}
  </script>	
  
  <div class="d2">
  	<iframe src="page_info.jsp?user=<%=pid %>" id="iframe" height="100%" width="100%" frameborder="0"></iframe>
  </div>
</body>
</html>