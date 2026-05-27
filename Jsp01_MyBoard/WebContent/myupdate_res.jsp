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
	//1.전달되는 파라미터들을 받기
	
	int no = Integer.parseInt(request.getParameter("myno"));
	String title = request.getParameter("mytitle");
	String content = request.getParameter("mycontent");
	
	//2.받은 데이터를 객체에(MyBoardDto) 저장
	MyBoardDto dto = new MyBoardDto(no,null,title,content,null);
	
	//3.dao에 update() 실행
	int res = new MyBoardDao().update(dto);
	
	if(res>0){
%>
	<script type="text/javascript">
		alert("게시글 수정 성공");
		location.href="selectone.jsp?myno=<%=dto.getMyno() %>";
	</script>
<%		
	}else{
%>
	<script type="text/javascript">
		alert("게시글 수정 실패");
		location.href="myupdate.jsp?myno=<%=dto.getMyno() %>";
	</script>
<%
	}
%>
</body>
</html>