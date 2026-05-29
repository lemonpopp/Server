<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import="com.login.dto.MyMemberDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MyMemberDto dto = (MyMemberDto)request.getAttribute("dto");
%>
	<h1>내 정보 수정</h1>
	<form action="logincontroller.jsp" method="post">
		<input type="hidden" name="command" value="updateuser">
		<input type="hidden" name="myno" value="<%=dto.getMyno() %>">
		<table>
			<tr>
				<th>I D</th>
				<td><%=dto.getMyid() %></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=dto.getMyname() %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="myaddr" value="<%=dto.getMyaddr() %>"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="myphone" value="<%=dto.getMyphone() %>"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="myemail" value="<%=dto.getMyemail() %>"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="완료">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>