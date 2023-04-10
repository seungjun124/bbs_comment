<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userName = null;
	String userEmail = null;
	UserDAO userDAO = new UserDAO();
	int ID = 0;
	int ID2 = 0;

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
	
	if(request.getParameter("ID2") != null) {
		ID2 = Integer.parseInt(request.getParameter("ID2"));
	}
	
	if(request.getParameter("Content") != null) {
		Content = request.getParameter("Content");
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
	
	System.out.println(ID);
	System.out.println(ID2);
	System.out.println(userEmail);
	
	CommentDAO com = new CommentDAO();
	if(userEmail.equals(com.getUserEmail(ID2))) {
		int result = com.commentDelete3(ID, ID2);
		if(result == -1) {
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("alert('데이터 베이스 오류가 발생했습니다.')");
			sc.println("</script>");
			sc.close();
		} else {
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("alert('삭제 되었습니다.')");
			sc.println("history.back()");
			sc.println("</script>");
			sc.close();
		}
	} else {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('자신이 쓴 글만 삭제 가능합니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	}
%>