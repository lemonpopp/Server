<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="java.util.List" %>
<%@ page import="com.mvc.dto.MVCBoardDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%List<MVCBoardDto> list = (List<MVCBoardDto>)request.getAttribute("allList");%>

	<h1>글 목록</h1>
	<table>
		<col width="50px"><col width="100px"><col width="300px"><col width="100px">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
<%
		if(list.size()==0){
%>
			<tr>
				<td colspan="4">---- 글이 존재하지 않습니다 ----</td>
			</tr>			
<%
		}else{
			for(MVCBoardDto dto : list){
%>
				<tr>
					<td><%=dto.getSeq() %></td>
					<td><%=dto.getWriter() %></td>					
					<td><%=dto.getTitle() %></td>
					<td><%=dto.getRegdate() %></td>					
				</tr>
<%			
			}
		}
%>
	</table>

</body>
</html>