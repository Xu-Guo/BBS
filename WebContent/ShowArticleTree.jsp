<!--��ǰҳ�汾�����  -->
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
	

	private void tree(Connection conn, int id, int level,boolean login) { //@չʾ level:��ǰnode�������ȼ������Ϊroot������
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String preStr = "";
		for (int i = 0; i < level; i++) {
			preStr += "----";//@չʾ �����ַ���
		}
		try {
			stmt = conn.createStatement();
			String sql = "select * from article where pid = " + id; //pid:���ڵ�id
			rs = stmt.executeQuery(sql);
			
			String strLogin = "";

			while (rs.next()) {
				if (login) {
					strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" + rs.getInt("pid")
							+ "'>Delete</a>";//ɾ�����ӵ����ӣ��贫�뵱ǰid�븸�ڵ�id��
				}
				str += "<tr><td>" + rs.getInt("id") + "</td><td>" + preStr + "<a href='ShowArticleDetail.jsp?id="
						+ rs.getInt("id") + "'>" + rs.getString("title") + "</a></td>" + //��ʾ����detail������
						strLogin + "</td></tr>";
				if (rs.getInt("isleaf") != 0) { //current node has child node
					tree(conn, rs.getInt("id"), level + 1,login); //�ݹ����tree(), ���뵱ǰnode��id
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
	ResultSet rs = stmt.executeQuery("select * from article where pid = 0");//�ҳ�����root node������node
	String strLogin = "";
	while (rs.next()) {
		if (login) {
			strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" + rs.getInt("pid")
					+ "'>Delete</a>";//ɾ�����ӵ����ӣ��贫�뵱ǰid�븸�ڵ�id��
		}
		//��������id��title
		str += "<tr><td>" + rs.getInt("id") + "</td><td>" + "<a href='ShowArticleDetail.jsp?id="
				+ rs.getInt("id") + "'>" + rs.getString("title") + "</a></td>" + //��ʾ����detail������
				strLogin + "</td></tr>";//ɾ�����ӵ�����,�贫�뵱ǰid�븸�ڵ�id��
		//str += String.format("<tr><td>%d</td></tr><a href='ShowArticleDetail.jsp?id=", rs.getInt("id"));
		if (rs.getInt("isleaf") != 0) {//�����ǰnode�����ӽڵ�
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
			str = "";//jsp������Ϊ��Ա�������´�ˢ����Ȼ��չʾ������ǰ��ʾ�ַ�����Ϊ�գ�ˢ�º�����ʾ�ϴ����ݡ�
			login = false;
		%>
	</table>


</body>

<%
	
%>
</html>