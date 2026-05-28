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
	<h1>게시글 보기</h1>
	<table>
		<tr>
			<th>번호</th>
			<td><%=dto.getSeq() %></td>
			<th>작성자</th>
			<td><%=dto.getWriter() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<th colsan="3"><%=dto.getRegdate() %></th>
		</tr>
		<tr>
			<th>제 목</th>
			<th colsan="3"><%=dto.getTitle() %></th>
		</tr>
		<tr>
			<th>내 용</th>
			<th colsan="3"><textarea rows="10" cols="60" readonly="readonly"><%=dto.getContent() %></textarea></th>
		</tr>
		<tr>
			<td colspan="4">
				<input type="button" value="수정" onclick="location.href='mycontroller.jsp?command=boardupdateform&seq=<%=dto.getSeq() %>'">
				<input type="button" value="삭제" onclick="location.href='mycontroller.jsp?command=boarddelete&seq=<%=dto.getSeq() %>'">
			</td>
		</tr>
	</table>
</body>
</html>