<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="com.mvc.dto.MVCBoardDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% MVCBoardDto dto = (MVCBoardDto)request.getAttribute("dto"); %>
	<h1>게시글 수정</h1>
	<form action="mycontroller.jsp" method="post">
		<input type="hidden" name="command" value="boardupdate">
		<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
		<table>
			<tr>
				<th>번호</th>
				<td><%=dto.getSeq()%></td>
				<th>작성자</th>
				<td><%=dto.getWriter()%></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td colspan="3"><%=dto.getRegdate()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><input type="text" name="title" value="<%=dto.getTitle() %>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><textarea rows="10" cols="60" name="content"><%=dto.getContent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="location.href='mycontroller.jsp?command=boardlist'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>