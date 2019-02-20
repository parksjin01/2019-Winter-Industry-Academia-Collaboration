<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		session.invalidate();
	%>	<!-- 세션에 저장된 값 모두 한번에 삭제, 세션 연결이 끊어짐 -->
	
	<script>
	location.href="./index.jsp";	//"IndexPage.jsp" 페이지로 링크, 이동
	</script>
</body>
</html>