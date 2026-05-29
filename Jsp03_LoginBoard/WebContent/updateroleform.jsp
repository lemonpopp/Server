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

<%
	MyMemberDto tmp = (MyMemberDto)request.getAttribute("selectone");
%>
<h1>회원등급 변경 페이지</h1>

<form action="logincontroller.jsp" method="post">
	<input type="hidden" name="command" value="updaterole">
	<input type="hidden" name="myno" value="<%=tmp.getMyno() %>">
	<table>
	<col width="50px"><col width="200px">
		<tr>
			<th>번호</th>
			<td><%=tmp.getMyno() %></td>
		</tr>
		<tr>
			<th>I D</th>
			<td><%=tmp.getMyid() %></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><%=tmp.getMyname() %></td>
		</tr>
		<tr>
			<th>등급</th>
			<td>
				<select name="myrole">
					<option value="USER" <%=tmp.getMyrole().equals("USER")?"selected":"" %>>일반회원</option>
					<option value="MANAGER" <%=tmp.getMyrole().equals("MANAGER")?"selected":"" %>>매니저</option>
					<option value="ADMIN"  <%=tmp.getMyrole().equals("ADMIN")?"selected":"" %>>관리자</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="변경완료">
			</td>
		</tr>
	</table>
</form>

</body>
</html>