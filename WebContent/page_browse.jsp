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
	
	ArrayList<String[]>  list = new ArrayList<String[]>();//先定义一个集合对象;
	try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con = DriverManager.getConnection(connectString,user, pwd);
		  Statement stmt = con.createStatement();
		
		  ResultSet rs=stmt.executeQuery("select * from "+pid);
		  while(rs.next()) {
			  String sublist[] = new String[3];
			  sublist[0] = rs.getString("word");
			  sublist[1] = rs.getString("string");
			  sublist[2] = rs.getString("link");
			  list.add(sublist);
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
		<title>browse</title>
		<style>
			body{
				font-family:微软雅黑,宋体;
			}
			a:link,a:visited { color:blue; }
			.container{
				margin:0 auto;
				width:100%;
			}
			form { line-height:50px; }
			.parent{ background:#FFF38F;cursor:pointer;}
			.selected{ background:#FF6500;color:#fff;}
			table{
				width:100%;
			}
			td{
				width:100%;
				text-align: left;
			}
		</style>
	</head>
	<body>
	<!--   引入jQuery -->
		<script src="http://www.codefans.net/ajaxjs/jquery1.3.2.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(function(){
			$('tr.parent').click(function(){   // 获取所谓的父行
			$(this)
				.toggleClass("selected")   // 添加/删除高亮
				.siblings('.child_'+this.id).toggle();  // 隐藏/显示所谓的子行
				});
			})
		</script>
		
		<div class="container">
			
			<table>
				<%
				Iterator <String[]>it = list.iterator(); 
				String curword ="";
				int counter = 0;
				while(it.hasNext()){
					String[] sublist = it.next();
					if(!sublist[0].equals(curword)){
						counter++;
						curword = sublist[0];
				%>
					<tr class="parent" id="row_<%=counter%>">
						<td> <%=sublist[0] %> </td>
					</tr>
				<%
					}
				%>
					<tr class="child_row_<%=counter%>">
						<td> <a href="<%=sublist[2]%>"><%=sublist[1] %></a></td>
					</tr>
				<%
				}
				%>
			</table>
			
			<%=msg%><br>
		</div>
		
		
	</body>
</html>


