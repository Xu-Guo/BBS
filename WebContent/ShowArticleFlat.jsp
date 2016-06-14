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
	Class.forName("com.mysql.jdbc.Driver");

	String url = "jdbc:mysql://localhost/bbs?user=root&password=mysql";
	Connection conn = DriverManager.getConnection(url);

	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where pid = 0");//找出所有root node，主题node
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
						<%= rs.getString("cont")%>
					</td>
				</tr>

		<%
			}
			rs.close();
			stmt.close();
			conn.close();
		%>
	</table>


</body>

<%
	
%>
</html>