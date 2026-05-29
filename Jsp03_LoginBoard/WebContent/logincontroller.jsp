<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="com.login.dao.MyMemberDao" %>
<%@ page import="com.login.dto.MyMemberDto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String command = request.getParameter("command");
	System.out.println("[command: " + command + "]");
	MyMemberDao dao = new MyMemberDao();
	
	if(command.equals("login")){
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		MyMemberDto dto = dao.login(id,pw);
		
		if(dto.getMyid() != null){
			//성공
			session.setAttribute("dto",dto);
			session.setMaxInactiveInterval(60*60);	//세션 유지 시간 설정 3600초
			
			//객체의 공유 범위
			//scope
			//1.page영역				: 하나의 jsp페이지 내에서만 객체를 공유
			//2.request영역			: forward를 통해 request 갹체를 공유
			//3.session영역			: 같은 브라우저 내에서의 페이지들은 같은 session 객체를 공유
			//4.application영역		: 하나의 어플리케이션 당 1개의 apllication 객체를 공유
			
			
			if(dto.getMyrole().equals("ADMIN")){
				response.sendRedirect("adminmain.jsp");
			}else if(dto.getMyrole().equals("USER")){
				response.sendRedirect("usermain.jsp");
			}
			
		}else{
			//실패
			request.setAttribute("msg", "login 실패");
			request.setAttribute("url", "index.jsp");
			pageContext.forward("result.jsp");
		}
	}else if (command.equals("logout")){
		//session에 저장된 정보를 삭제
		session.invalidate();
		
		request.setAttribute("msg", "로그아웃 완료");
		request.setAttribute("url", "index.jsp");
		pageContext.forward("result.jsp");
	}else if(command.equals("userlist")){
		List<MyMemberDto> list = dao.selectAll();
		
		request.setAttribute("list", list);
		pageContext.forward("userlistall.jsp");
	}else if(command.equals("updateroleform")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		MyMemberDto dto = dao.selectUser(myno);

		request.setAttribute("selectone", dto);
		pageContext.forward("updateroleform.jsp");
	}else if(command.equals("updaterole")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		String myrole = request.getParameter("myrole");
		
		int res = dao.updateRole(myno, myrole);
		if(res>0){
			request.setAttribute("msg", "회원 등급 변경 완료");
			request.setAttribute("url", "logincontroller.jsp?command=userlist");
		}else{
			request.setAttribute("msg", "회원 등급 변경 실패");
			request.setAttribute("url", "logincontroller.jsp?command=updateroleform&myno="+myno);
		}
		pageContext.forward("result.jsp");
	}else if(command.equals("userinfo")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		MyMemberDto dto = dao.selectUser(myno);
		
		request.setAttribute("dto", dto);
		pageContext.forward("userinfo.jsp");
	}else if(command.equals("deleteuser")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		boolean res = dao.deleteMemeber(myno);
		
		if(res){
			request.setAttribute("msg","회원 탈퇴 성공");
			request.setAttribute("url","logincontroller.jsp?command=logout");
		}else{
			request.setAttribute("msg","회원 탈퇴 실패");
			request.setAttribute("url","usermain.jsp");
		}
		pageContext.forward("result.jsp");
	}else if(command.equals("updateform")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		MyMemberDto dto = dao.selectUser(myno);
		
		request.setAttribute("dto", dto);
		pageContext.forward("updateuser.jsp");
	}else if(command.equals("updateuser")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		String myaddr = request.getParameter("myaddr");
		String myphone = request.getParameter("myphone");
		String myemail = request.getParameter("myemail");
		
		MyMemberDto dto = new MyMemberDto();
		dto.setMyaddr(myaddr);
		dto.setMyphone(myphone);
		dto.setMyemail(myemail);
		dto.setMyno(myno);
		
		boolean res = dao.updateUser(dto);
		
		if(res){
			request.setAttribute("msg","내 정보 수정 성공");
			request.setAttribute("url","usermain.jsp");
		}else{
			request.setAttribute("msg","내 정보 수정 실패");
			request.setAttribute("url","logincontroller.jsp?command=userinfo&myno="+myno);
		}
		pageContext.forward("result.jsp");
	}
	
%>
</body>
</html>