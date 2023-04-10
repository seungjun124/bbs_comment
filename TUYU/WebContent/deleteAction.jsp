<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="views.ViewsDAO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%

	String userName = null;
	String userEmail = null;
	UserDAO userDAO = new UserDAO();
	int ID = 0;
	
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
	
	System.out.println(userName);
	System.out.println(userEmail);
	System.out.println(ID);
	
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
		int result = new BbsDAO().delete(ID);
		if(result == 1) {
			LikeyDAO likeyDAO = new LikeyDAO();
			likeyDAO.likeDelete(ID);
			ViewsDAO viewsDAO = new ViewsDAO();
			viewsDAO.viewDelete(ID);
			CommentDAO commentDAO = new CommentDAO();
			commentDAO.commentDelete(ID);
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
		sc.println("alert('자신이 쓴 글만 삭제 가능합니다.')");
		sc.println("location.href='bbs.jsp'");
		sc.println("</script>");
		sc.close();
	}
%>