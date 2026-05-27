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
	int myno = Integer.parseInt(request.getParameter("myno"));
	int res = new MyBoardDao().delete(myno);
	
	if(res>0){
%>
		<script type="text/javascript">
			alert("게시글 삭제 성공");
			location.href="mylist.jsp"
		</script>
<%
	}else{
%>
		<script type="text/javascript">
			alert("게시글 삭제 실패");
			location.href="selectone.jsp?myno=<%=myno%>"
		</script>
<%	
	}
	
%>
</body>
</html>