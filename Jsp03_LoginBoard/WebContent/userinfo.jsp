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
	MyMemberDto info = (MyMemberDto)request.getAttribute("dto");
%>
<h1>마이페이지</h1>
<table>
	<tr>
		<th>I D</th>
		<td><%=info.getMyid() %></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><%=info.getMyname() %></td>
	</tr>
	<tr>
		<th>주소</th>
		<td><%=info.getMyaddr() %></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><%=info.getMyphone() %></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><%=info.getMyemail() %></td>
	</tr>
	<tr>
		<th>등급</th>
		<td><%=info.getMyrole() %></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="수정" onclick="updateUser(<%=info.getMyno()%>)">
			<input type="button" value="탈퇴" onclick="deleteUser(<%=info.getMyno()%>)">
			<input type="button" value="목록" onclick="location.href='usermain.jsp'">
		</td>
	</tr>
</table>
<script type="text/javascript">
	function updateUser(myno){
		let con = window.confirm("회원 정보 수정을 하시겠습니까?");
		if(con){
			location.href="logincontroller.jsp?command=updateform&myno="+myno;			
		}
	}
	function deleteUser(myno){
		location.href="logincontroller.jsp?command=deleteuser&myno="+myno;
	}
</script>
</body>
</html>