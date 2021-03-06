<%@page import="constant.Constant"%>
<%@page import="java.text.DateFormat"%>
<%@page import="server.problemStatus_sql"%>
<%@page import="org.apache.http.client.ClientProtocolException"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.llwwlql.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="server.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Problem Status List</title>
    <link rel="shortcut icon" href="img/ldu_top_1.ico"/>
    <link href="css/page_1.css" type="text/css" rel="stylesheet"/>
    <link rel="stylesheet" href="css/register.css" />
    <script type="text/javascript" src="js/register.js" ></script>
	<script type="text/javascript" src="js/jquery-3.1.1.min.js" ></script>
	<script type="text/javascript" src="js/register_jquery.js" ></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <div class="contain">
			<jsp:include page="top.jsp"></jsp:include>
			<div class="body">			<!-- 标题栏 -->
				<span class="st_body_h2">Problem Status</span>
				 <table class="rank_table">
 					<tr class="ps_top1" style="width: 100%; height:5%;">
 						<td width="9%" height="22" >RunId</td>
 						<td width="12%" >User</td>
 						<td width="7%" >Problem</td>
 						<td width="24%">Result</td>
 						<td width="8%">Memory</td>
 						<td width="8%">Time</td>
 						<td width="8%">Language</td>
 						<td width="8%">Code Length</td>
 						<td width="18%">Submit Time</td>
 					</tr>
 					<%
 					///创建数据库操作对象
 					Server server=new Server();
			  		ResultSet rs=null,rs1=null;
			  		int max=0;
			  		///获取当前最大Runid
			  		String s1="select Runid from problemstatus order by Runid desc limit 1";
			  		rs1=server.operate(s1,1);
		  			while(rs1.next())
		  			{
		  			//out.println(rs1.getInt("Runid"));
		  			//Constant.status_rank=1;
			           max=rs1.getInt("Runid");
			          break;
			          }
			          int status_rank=Integer.parseInt((String)session.getAttribute("status_rank"));
			          int temp=status_rank;
			          if(temp+15<max)
			          {
			          		session.setAttribute("flag_prev","0");
			          }
			          else
			          session.setAttribute("flag_prev","1");
			  		///查找problemstatus表并按Runid降序

			  		int flag_next=0;
			  		int contant=status_rank-15;
			  		String sql;
			  		//out.println("constant"+contant+"<br>");
			  		if(contant>0)
				  		{
				  			 sql="select * from (select * from problemstatus ORDER BY Runid asc limit "+String.valueOf(contant)+",15) as T order by T.Runid desc"; 
				  			  session.setAttribute("flag_next","0");  ///没到最后一页
				  		}
			  		else
			  			{
			  				int special=15+contant; 
			  				sql="select * from (select * from problemstatus ORDER BY Runid asc limit 0,"+String.valueOf(special)+") as T order by T.Runid desc";
			  				flag_next=1;
			  				session.setAttribute("flag_next","1");  ///到了最后一页
			  				}
		  			rs=server.operate(sql,1);
			         int flag=1;  ///控制奇数行与偶数行
 					  while(rs.next()){
 					  if(flag%2==1)
 					  {
 						 %>		<!-- 总表 -->
 					<tr class="ps_top2" style="width: 100%;">
 						<td width="9%"><%=rs.getInt("Runid") %></td>
 						<td width="12%"><%=rs.getString("Username") %></td>
 						<td width="7%" ><%=rs.getInt("Problem_id")%></td>
 						<%
 							String s=rs.getString("Result");
 							if(s.equals("Accepted"))
 							{
 						 %>
 						<td width="24%" style="color: red;"><%=rs.getString("Result")%></td>
 						<%
 						}
 							else
 							{
	 						 %>
	 						 <td width="24%" style="color: green;" ><%=rs.getString("Result")%></td>
	 						 <%
 						 }
 						  %>
 						<td width="8%" ><%=rs.getString("Memory")%></td>
 						<td width="8%" ><%=rs.getString("Time") %></td>
 						<td width="8%" ><%=rs.getString("Language") %></td>
 						<td width="8%" ><%=rs.getString("CodeLength")%></td>
 						<td width="18%" ><%=rs.getString("SubmitTime") %></td>
 					</tr>	
 					<%
 						
 					 }
 					 else{
 					 %>
 					 <tr class="ps_top2" style="width: 100%;">
 						<td width="9%" bgcolor="#cde1ec"><%=rs.getInt("Runid") %></td>
 						<td width="12%" bgcolor="#cde1ec"><%=rs.getString("Username") %></td>
 						<td width="7%" bgcolor="#cde1ec"><%=rs.getInt("Problem_id")%></td>
 						<%
 							String s=rs.getString("Result");
 							if(s.equals("Accepted"))
 							{
 						 %>
 						<td width="24%" style="color: red;" bgcolor="#cde1ec" ><%=rs.getString("Result")%></td>
 						<%
 						}
 							else
 							{
 						 %>
 						 <td width="24%" style="color: green;" bgcolor="#cde1ec" ><%=rs.getString("Result")%></td>
 						 <%
 						 	}
 						  %>
 						<td width="8%" bgcolor="#cde1ec"><%=rs.getString("Memory") %></td>
 						<td width="8%" bgcolor="#cde1ec"><%=rs.getString("Time") %></td>
 						<td width="8%" bgcolor="#cde1ec"><%=rs.getString("Language") %></td>
 						<td width="8%" bgcolor="#cde1ec"><%=rs.getString("CodeLength") %></td>
 						<td width="18%" bgcolor="#cde1ec"><%=rs.getString("SubmitTime") %></td>
 					</tr>	
 					 <%
 					 }
 					 flag++;
 					}
 					 %>
 					 </table>
 					 <p class="ps_p" align="center"> 			<!-- 翻页-->
 					 	<a style="margin-right: 20px" href="jsp/first_page.jsp">First Page</a>
 					 	<%
 					 	int flagnext=Integer.parseInt((String)session.getAttribute("flag_next"));
 					 	int flagprev=Integer.parseInt((String)session.getAttribute("flag_prev"));
 					 	if(flagnext==0)///判断是否为题目列表最后一页
 					 		{
 					 			if(flagprev==0)
 					 			{						///如果不是第一页也不是最后一页，则正常运行
			 					 	%>
			 					 	<a style="margin-right: 20px" href="servlet/change_cs_prev" name="prev">< Prev Page</a>
			 					 	<a style="margin-right: 20px" href="servlet/change_cs_next" name="next">Next Page ></a>
			 					 	<%
 					 			}
 					 			else
 					 			{      ///如果是第一页，则prev_page为first_page
	 					 			%>
	 					 			<a style="margin-right: 20px" href="jsp/first_page.jsp" name="prev">< Prev Page</a>
	 					 			<a style="margin-right: 20px" href="servlet/change_cs_next" name="next">Next Page ></a>
	 					 			<%
 					 			}
 					 		}
 					 	else   ///是最后一页
 					 		{
 					 	 %>
 					 	  <a style="margin-right: 20px" href="servlet/change_cs_prev" name="prev">< Prev Page</a>
 					 	 <%
 					 	 	}
 					 	  %>
 					 	<a href="jsp/last_page.jsp">Last Page</a>
 					 </p>
			</div>
			<div class="foot">
   			<span class="f1">LuDong Unversity Online Judge 1.0</span>
   			<span class="f2">Developer:Lu Qilu Tang Yukai Xu Fuhao</span>
   			<span class="f2">Copyright@2012-2016 LDU ACM Team. All Rights Reserved.</span>
   		</div>
		</div>
		<jsp:include page="register.jsp"></jsp:include>
  </body>
</html>
