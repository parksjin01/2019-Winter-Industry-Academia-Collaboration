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
	%>	<!-- ���ǿ� ����� �� ��� �ѹ��� ����, ���� ������ ������ -->
	
	<script>
	location.href="./index.jsp";	//"IndexPage.jsp" �������� ��ũ, �̵�
	</script>
</body>
</html>