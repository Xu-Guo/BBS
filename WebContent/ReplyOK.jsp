<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>

<%@ page import="java.sql.*"%>

<%	
	
	//中文不显示的问题
	//1.中文提交到下一个页面时出问题。解决办法，在后一个页面检查拿到的是不是中文。
	//2.插入数据库的过程中出现问题。解决办法，查看数据库。
	//3.数据库的字符集出了问题。
	//4.从数据库中提取数据的过程中出了问题。
	//5.从数据库中提取的数据正确，但页面显示出了问题。	
	request.setCharacterEncoding("gbk");

	int id = Integer.parseInt(request.getParameter("id"));
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	
	cont = cont.replaceAll("\n", "<br>"); //显示换行，将\n替换成HTML中的换行符<br>.

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
	
	response.sendRedirect("ShowArticleTree.jsp");//问题
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