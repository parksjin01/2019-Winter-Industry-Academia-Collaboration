<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="email"/>
<jsp:setProperty name="user" property="pw"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	
		String sessionID = null;
		if (session.getAttribute("sessionID") != null) {
			sessionID = (String) session.getAttribute("sessionID");
		}
		if (sessionID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다')");
			script.println("location.href = './index.jsp'");
			script.println("</script>");
		}
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user);
		if (result == UserDAO.LOGIN_SUCCESS) {
			session.setAttribute("sessionID", user.getEmail());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");	
		} else if (result == UserDAO.INCORRECT_PW) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == UserDAO.NOT_EXIST_EMAIL) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이메일이 존재하지 않습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == UserDAO.DATABASE_ERROR) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	
	%>
</body>
</html>