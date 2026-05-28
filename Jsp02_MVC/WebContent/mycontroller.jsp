<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="com.mvc.dao.MVCBoardDao" %>
<%@ page import="com.mvc.dto.MVCBoardDto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//view에서 요청힌 내용을 담은 command 받기
	String command = request.getParameter("command");
	System.out.println("[command: " + command +"]");
	
	MVCBoardDao dao = new MVCBoardDao();
	
	if(command.equals("boardlist")){
		//전체출력
		List<MVCBoardDto> list = dao.selectAll();
		
		request.setAttribute("allList", list);
		//화면전환
		pageContext.forward("boardlist.jsp");
		/*
			pageContext 객체
			jsp 기본 객체
			jsp 페이지당 하나의 pageContext 객체 생성된다.
			해당 객체를 통해 다른 객체를 구할때 사용하거나, 페이지의 흐름을 제어할 때 사용
			
			화면 흐름 제어
			-forward:
				request에 담긴 값이 유효
				request, response 객체 유지
				1)pageContext.forward()
				2)<jsp:forward>
				3)requestDispatcher
			-redirect:
				클라이언트가 새로 페이지를 요청한 것과 같은 방식으로 페이지 이동
				request, response 객체 유지X
				1)response.sendRedirect()
		*/
	}else if(command.equals("boardinsertform")){
		response.sendRedirect("boardinsert.jsp");
	}else if(command.equals("boardinsert")){
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		MVCBoardDto dto = new MVCBoardDto(0,writer,title,content,null);
		
		int res = dao.insert(dto);

		String msg="";
		String url="";
		
		if(res>0){
			msg="글 작성 완료";
			url="?command=boardlist";
		}else{
			msg="글 작성 실패";
			url="?command=boardinsertform";
		}
		request.setAttribute("msg",msg);
		request.setAttribute("url",url);
		pageContext.forward("result.jsp");
		
	}else if(command.equals("boarddetail")){
		//필요 데이터 준비 후 화면 전환
		int seq = Integer.parseInt(request.getParameter("seq"));
		MVCBoardDto res = dao.selectOne(seq);
		request.setAttribute("dto",res);
		pageContext.forward("boarddetail.jsp");
	}else if(command.equals("boardupdateform")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		MVCBoardDto dto = dao.selectOne(seq);
		
		request.setAttribute("dto", dto);
		pageContext.forward("boardupdate.jsp"); 	
	}else if(command.equals("boardupdate")){
		//넘어오는 파라미터를 받어
		int seq = Integer.parseInt(request.getParameter("seq"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		//dao를 통해 update 진행하고
		//" UPADATE MVCBOARD SET TITLE=?, CONTETN=? WHERE SEQ=? "
				
		MVCBoardDto dto = new MVCBoardDto(seq,"",title,content,null);
		int res = dao.update(dto);
		//결과에 따라 result페이지를 통해 화면 처리
		
		String msg="";
		String url="";
		
		if(res>0){
			msg="글 수정 완료";
			url="?command=boardlist";
		}else{
			msg="글 수정 실패";
			url="?command=boardupdateform&seq="+seq;
		}
		request.setAttribute("msg",msg);
		request.setAttribute("url",url);
		pageContext.forward("result.jsp");
		
	}else if(command.equals("boarddelete")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		int res = dao.delete(seq);
		
		String msg="";
		String url="";
		
		if(res>0){
			msg="글 삭제 완료";
			url="?command=boardlist";
		}else{
			msg="글 삭제 실패";
			url="?command=boarddetail&seq="+seq;
		}
		request.setAttribute("msg",msg);
		request.setAttribute("url",url);
		pageContext.forward("result.jsp");
	}
		
%>
</body>
</html>