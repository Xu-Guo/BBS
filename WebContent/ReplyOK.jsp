<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>

<%@ page import="java.sql.*"%>

<%	
	
	//���Ĳ���ʾ������
	//1.�����ύ����һ��ҳ��ʱ�����⡣����취���ں�һ��ҳ�����õ����ǲ������ġ�
	//2.�������ݿ�Ĺ����г������⡣����취���鿴���ݿ⡣
	//3.���ݿ���ַ����������⡣
	//4.�����ݿ�����ȡ���ݵĹ����г������⡣
	//5.�����ݿ�����ȡ��������ȷ����ҳ����ʾ�������⡣	
	request.setCharacterEncoding("gbk");

	int id = Integer.parseInt(request.getParameter("id"));
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	
	cont = cont.replaceAll("\n", "<br>"); //��ʾ���У���\n�滻��HTML�еĻ��з�<br>.

	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?user=root&password=mysql";
	Connection conn = DriverManager.getConnection(url);
	
	conn.setAutoCommit(false);

	String sql = "insert into article values(null,?,?,?,?,now(),0)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	Statement stmt = conn.createStatement();
	
	pstmt.setInt(1, id);
	pstmt.setInt(2, rootid);
	pstmt.setString(3, title);
	pstmt.setString(4, cont);
	pstmt.executeUpdate();

	stmt.executeUpdate("update article set isleaf = 1 where id = " + id);
	
	conn.commit();
	conn.setAutoCommit(true);
	
	stmt.close();
	pstmt.close();
	conn.close();
	
	response.sendRedirect("ShowArticleTree.jsp");//����
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<font color="red" size="7">
	OK!
</font>
</body>
</html>