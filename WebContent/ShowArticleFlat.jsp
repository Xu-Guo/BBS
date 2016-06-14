<!--当前页面本身编码  -->
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%><%@page import="java.sql.*"%>

<%!boolean login = false;%>
<%
	String admin = (String) session.getAttribute("admin");
	//boolean login = false;
	if (admin != null && admin.equals("true")) {
		login = true;
	}
%>


<%	
	int pageSize = 3;

	String strPageNum = request.getParameter("pageNum");
	int pageNum = 1;
	if(strPageNum == null || strPageNum.equals("")){
		pageNum = 1;
	}else{
		try{
		pageNum = Integer.parseInt(strPageNum.trim());
		}catch(NumberFormatException e){
			pageNum = 1;
		}
		if(pageNum<=0) pageNum = 1;
	}
	
	
	
	
	Class.forName("com.mysql.jdbc.Driver");

	String url = "jdbc:mysql://localhost/bbs?user=root&password=mysql";
	Connection conn = DriverManager.getConnection(url);
	
	Statement stmtCount = conn.createStatement();
	ResultSet rsCount = stmtCount.executeQuery("select count(*) from article where pid = 0");
	rsCount.next();
	int totalRecords = rsCount.getInt(1);
	
	int totalPages = totalRecords % pageSize == 0 ? totalRecords / pageSize : totalRecords / pageSize + 1;// 计算总页数
	if(pageNum > totalPages) pageNum = totalPages;
	int startPos = (pageNum -1) * pageSize;
	
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where pid = 0 order by pdate desc limit " + startPos + "," + pageSize);//找出所有root node，主题node,按pdate倒叙排列，并且按每页pageSize个分页显示
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

	<a href="Post.jsp">Post a new article</a>
	

	<table border="1">
		<%
			while (rs.next()) {
		%>
				<tr>
					<td>
						<%= rs.getString("title")%>
					</td>
				</tr>

		<%
			}
			rs.close();
			stmt.close();
			conn.close();
		%>
	</table>
	Total Pages:<%=totalPages %>   Page:<%=pageNum %>
	<a href="ShowArticleFlat.jsp?pageNum=<%=pageNum-1%>"> < </a> &nbsp;&nbsp;&nbsp;
	<a href="ShowArticleFlat.jsp?pageNum=<%=pageNum+1%>"> > </a>


</body>

<%
	
%>
</html>