<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="recomm.Recomm" %>
<%@ page import="recomm.RecommDAO" %>
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
			int recommID = 0;
			if (request.getParameter("recommID") != null) {
				recommID = Integer.parseInt(request.getParameter("recommID"));
			}
			if (recommID == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Invalid item')");
				script.println("history.back()");
				script.println("</script>");
			}
			if (sessionID == null) {  
				PrintWriter  script = response.getWriter();
				script.println("<script>");
				script.println("alert('no authority')");
				script.println("location.href = './index.jsp'");
				script.println("</script>");
			} else {
				
				RecommDAO recommDAO = new RecommDAO();
				
				// delete 쿼리 수행
				int result = recommDAO.delete(recommID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('fail')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter  script = response.getWriter();
					script.println("<script>");
					script.println("location.href = './index.jsp#sites'");
					script.println("</script>");
				}
	
			}
		
	%>
</body>
</html>