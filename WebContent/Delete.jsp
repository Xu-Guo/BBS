<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>

<%@ page import="java.sql.*"%>

<%!private void del(Connection conn, int id) {
		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			String sql = "select * from article where pid = " + id; //pid:父节点id
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				del(conn, rs.getInt("id"));//首先递归删除所有子节点
			}
			stmt.executeUpdate("delete from article where id =" + id);
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
	int id = Integer.parseInt(request.getParameter("id"));
	int pid = Integer.parseInt(request.getParameter("pid"));

	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?user=root&password=mysql";
	Connection conn = DriverManager.getConnection(url);

	conn.setAutoCommit(false);
	del(conn, id);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select count(*) from article where pid = " + pid);
	rs.next();
	int count = rs.getInt(1);//占位符，只有1个字段。
	rs.close();
	stmt.close();
	
	if(count <=0){
		Statement stmtUpdate = conn.createStatement();
		stmtUpdate.executeUpdate("update article set isleaf = 0 where id = " + pid );
		stmtUpdate.close();
	}

	conn.commit();
	conn.setAutoCommit(true);
	conn.close();
	response.sendRedirect("ShowArticleTree.jsp");//问题
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

</body>
</html>