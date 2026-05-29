<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import = "com.login.dto.MyMemberDto" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MyMemberDto dto = (MyMemberDto)session.getAttribute("dto");
	if(dto == null){
		pageContext.forward("index.jsp");
		return;
	}
%>
<div>
	<span><%=dto.getMyname() %>님 환영합니다.(등급: <%=dto.getMyrole() %>)</span>
	<button onclick="location.href='logincontroller.jsp?command=logout'">로그아웃</button>
</div>
<hr>
<h1>User Main</h1>
<div>
	<h3><a href="logincontroller.jsp?command=userinfo&myno=<%=dto.getMyno() %>">내정보 보기</a></h3>
</div>
</body>
</html>