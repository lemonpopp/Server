<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="java.util.List" %>
<%@ page import="com.login.dto.MyMemberDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	const updateRole = (myno)=>{
		location.href="logincontroller.jsp?command=updateroleform&myno="+myno;
	}
</script>
</head>
<body>
<%
	MyMemberDto dto = (MyMemberDto)session.getAttribute("dto");
	if(dto == null){
		pageContext.forward("index.jsp");
		return;
	}
	List<MyMemberDto> list = (List<MyMemberDto>)request.getAttribute("list");
%>
<div>
	<span><%=dto.getMyname() %>님 환영합니다.(등급: <%=dto.getMyrole() %>)</span>
	<button onclick="location.href='logincontroller.jsp?command=logout'">로그아웃</button>
</div>
<hr>
<h1>회원 정보 조회</h1>

<table border="1">
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>주소</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th>가입여부</th>
		<th>등급</th>
		<th>등급변경</th>
	</tr>
<%
	for(MyMemberDto m : list){
%>
	<tr>
		<td><%=m.getMyno() %></td>
		<td><%=m.getMyid() %></td>
		<td><%=m.getMypw() %></td>
		<td><%=m.getMyname() %></td>
		<td><%=m.getMyaddr() %></td>
		<td><%=m.getMyphone() %></td>
		<td><%=m.getMyemail() %></td>
		<td><%=m.getMyenabled().equals("Y")? "가입":"탈퇴" %></td>
		<td><%=m.getMyrole() %></td>
		<td><button onclick="updateRole(<%=m.getMyno()%>)">변경</button></td>
	</tr>
<%		
	}
%>
	
</table>

</body>
</html>