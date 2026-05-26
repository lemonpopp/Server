<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import = "com.my.dao.MyBoardDao" %>
<%@ page import = "com.my.dto.MyBoardDto" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	//자바코드 작성
	//1.DB에서 데이터 조회
	MyBoardDao dao = new MyBoardDao();
	List<MyBoardDto> list = dao.selectAll();
%>
</head>
<body>
	<h1>LIST PAGE</h1>
	<table border="1">
		<col width="50px"><col width="100px"><col width="200px"><col width="100px">
		<tr>
			<th>NO</th>
			<th>NAME</th>
			<th>TITLE</th>
			<th>DATE</th>
		</tr>
<%
		for(int i=0; i<list.size();i++){
%>
			<tr>
				<td><%= list.get(i).getMyno() %></td>
				<td><%= list.get(i).getMyname() %></td>
				<td><%= list.get(i).getMytitle() %></td>
				<td><%= list.get(i).getMydate() %></td>
			</tr>
<%
		}
%>
		
	</table>
</body>
</html>