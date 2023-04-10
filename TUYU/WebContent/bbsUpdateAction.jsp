<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userName = null;
	String userEmail = null;
	UserDAO userDAO = new UserDAO();
	int ID = 0;
	
	String Title = null;
	String Content = null;
	
	if(request.getParameter("userName") != null) {
		userName = request.getParameter("userName");
	}
	
	if(session.getAttribute("userEmail") != null) {
		userEmail = (String)session.getAttribute("userEmail");
		userName = userDAO.getUserName(userEmail);
	}
	
	if(request.getParameter("ID") != null) {
		ID = Integer.parseInt(request.getParameter("ID"));
	}
	
	if(request.getParameter("Title") != null) {
		Title = request.getParameter("Title");
	}
	
	if(request.getParameter("Content") != null) {
		Content = request.getParameter("Content");
	}
	
	if (Title == null || Content == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('입력이 안 된 사항이 있습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
		return;
	}
	
	if (userEmail == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('로그인을 해주세요.')");
		sc.println("location.href='login.jsp'");
		sc.println("</script>");
		sc.close();
		return;
	}
	
	BbsDAO bbsDAO = new BbsDAO();
	if(userEmail.equals(bbsDAO.getUserEmail(ID))) {
		int result = new BbsDAO().update(Title, Content, ID);
		if(result == 1) {
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("alert('삭제 되었습니다.')");
			sc.println("location.href='bbs.jsp'");
			sc.println("</script>");
			sc.close();
		} else {
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("alert('데이터 베이스 오류가 발생했습니다.')");
			sc.println("</script>");
			sc.close();
		}
	} else {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('자신이 쓴 글만 수정 가능합니다.')");
		sc.println("location.href='bbs.jsp'");
		sc.println("</script>");
		sc.close();
	}
%>