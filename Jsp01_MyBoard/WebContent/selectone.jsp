<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import = "com.my.dao.MyBoardDao" %>
<%@ page import = "com.my.dto.MyBoardDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//필요 데이터 준비(파라미터로 넘어온 myno값과 같은 데이터)
	
	//1.parameter로 넘어오는 myno 받기
	int myno = Integer.parseInt(request.getParameter("myno"));
	//2.db에서 select 하기
	MyBoardDao dao = new MyBoardDao();
	MyBoardDto res = dao.selectOne(myno);
%>
	<h1>DETAIL</h1>
	<table>
		<tr>
			<th>NAME</th>
			<td><%=res.getMyname() %></td>
		</tr>
		<tr>
			<th>TITLE</th>
			<td><%=res.getMytitle() %></td>
		</tr>
		<tr>
			<th>CONTENT</th>
			<td>
				<textarea rows="10" cols="40" readonly="readonly"><%=res.getMycontent() %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan='2'>
				<button onclick="location.href='myupdate.jsp?myno=<%=res.getMyno()%>'">수정</button>
				<button onclick="location.href='mydelete.jsp?myno=<%=res.getMyno()%>'">삭제</button>
			</td>
		</tr>
	</table>
</body>
</html>