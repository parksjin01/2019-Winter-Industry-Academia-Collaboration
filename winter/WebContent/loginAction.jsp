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
			script.println("alert('�̹� �α����� �Ǿ��ֽ��ϴ�')");
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
			script.println("alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == UserDAO.NOT_EXIST_EMAIL) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�̸����� �������� �ʽ��ϴ�')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == UserDAO.DATABASE_ERROR) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�����ͺ��̽� ������ �߻��߽��ϴ�')");
			script.println("history.back()");
			script.println("</script>");
		}
	
	%>
</body>
</html>