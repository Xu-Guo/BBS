<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
	
	
<%	

	String action = request.getParameter("action");
	if (action != null && action.equals("login")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if (username == null || !username.equals("admin")) {
			out.println("username not correct!");
			//return;
		}else if (password == null || !password.equals("admin")) {
			out.println("password not correct!");
			//return;
		}else {
			out.println("Welcome admin!");
			session.setAttribute("admin", "true");
			response.sendRedirect("ShowArticleTree.jsp");
		}
	}
%>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Demo</title>
<style>
li {
	list-style: none;
}
</style>
</head>
<body>
	<div
		style="margin: 10% 0px 0px 40%; border: 2px solid black; width: 300px">
		<form action="Login.jsp" method="post">
		<input type="hidden" name=action value=login>
			<ul>
				<li></li>
				<li><h2>Login Demo</h2></li>
			</ul>
			<ul>
				<li>User Name :</li>
				<li><input type="text" name="username" 
					placeholder="username" size="30" /></li>
			</ul>
			<ul>
				<li>Password :</li>
				<li><input type="password" name="password" 
					placeholder="password" size="30" /></li>
			</ul>
			<ul>
				<li></li>
				<li><input type="submit" name="Submit" value="LOGIN" /></li>
			</ul>
		</form>
	</div>
</body>
</html>