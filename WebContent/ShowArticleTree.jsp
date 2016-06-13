<!--当前页面本身编码  -->
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%><%@page import="java.sql.*"%>

<%
	String admin = (String) session.getAttribute("admin");
	boolean login = false;
	if (admin != null && admin.equals("true")) {
		login = true;
	}
%>

<%!String str = "";
	

	private void tree(Connection conn, int id, int level,boolean login) { //@展示 level:当前node的缩进等级，如果为root无缩进
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String preStr = "";
		for (int i = 0; i < level; i++) {
			preStr += "----";//@展示 缩进字符串
		}
		try {
			stmt = conn.createStatement();
			String sql = "select * from article where pid = " + id; //pid:父节点id
			rs = stmt.executeQuery(sql);
			
			String strLogin = "";

			while (rs.next()) {
				if (login) {
					strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" + rs.getInt("pid")
							+ "'>Delete</a>";//删除帖子的链接，需传入当前id与父节点id。
				}
				str += "<tr><td>" + rs.getInt("id") + "</td><td>" + preStr + "<a href='ShowArticleDetail.jsp?id="
						+ rs.getInt("id") + "'>" + rs.getString("title") + "</a></td>" + //显示帖子detail的链接
						strLogin + "</td></tr>";
				if (rs.getInt("isleaf") != 0) { //current node has child node
					tree(conn, rs.getInt("id"), level + 1,login); //递归调用tree(), 传入当前node的id
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}%>


<%
	Class.forName("com.mysql.jdbc.Driver");

	String url = "jdbc:mysql://localhost/bbs?user=root&password=mysql";
	Connection conn = DriverManager.getConnection(url);

	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where pid = 0");//找出所有root node，主题node
	String strLogin = "";
	while (rs.next()) {
		if (login) {
			strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" + rs.getInt("pid")
					+ "'>Delete</a>";//删除帖子的链接，需传入当前id与父节点id。
		}
		//输出主题的id，title
		str += "<tr><td>" + rs.getInt("id") + "</td><td>" + "<a href='ShowArticleDetail.jsp?id="
				+ rs.getInt("id") + "'>" + rs.getString("title") + "</a></td>" + //显示帖子detail的链接
				strLogin + "</td></tr>";//删除帖子的链接,需传入当前id与父节点id。
		//str += String.format("<tr><td>%d</td></tr><a href='ShowArticleDetail.jsp?id=", rs.getInt("id"));
		if (rs.getInt("isleaf") != 0) {//如果当前node还有子节点
			tree(conn, rs.getInt("id"), 1,login);//
		}
	}
	rs.close();
	stmt.close();
	conn.close();
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
		<%=str%>
		<%
			str = "";//jsp会视其为成员变量，下次刷新仍然会展示，将当前显示字符串设为空，刷新后不在显示上次内容。
			login = false;
		%>
	</table>


</body>

<%
	
%>
</html>