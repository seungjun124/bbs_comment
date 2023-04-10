<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String Subject = null;
	String Title = null;
	String Content = null;
	String userName = null;
	int Views = 0;
	int Likes = 0;
	
	if(session.getAttribute("userName") != null) {
		userName = (String)session.getAttribute("userName");
	} else {
		userName = null;
	}

	if(request.getParameter("Subject") != null) {
		Subject = request.getParameter("Subject");
	}

	if(request.getParameter("Title") != null) {
		Title = request.getParameter("Title");
	}
	
	if(request.getParameter("Content") != null) {
		Content = request.getParameter("Content");
	}
	
	if(request.getParameter("userName") != null) {
		userName = request.getParameter("userName");
	}
	
	UserDAO userDAO = new UserDAO();
	String userEmail = userDAO.getUserEmail(userName);
	
	if (userName == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('로그인을 해주세요.')");
		sc.println("location.href='login.jsp'");
		sc.println("</script>");
		sc.close();
		return;
	}
	
	if (Subject == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('말머리를 선택해주세요.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
		return;
	}
	
	if (Title == null || Content == null || userName == null|| userEmail == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('입력이 안 된 사항이 있습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
		return;
	}

	BbsDAO bbsDAO = new BbsDAO();
	int result = bbsDAO.bbsWrite(Subject, Title, Content, userName, userEmail);
	
	if(result == -1) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('오류')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	} else {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("location.href='bbs.jsp'");
		sc.println("</script>");
		sc.close();
	}
%>
</body>
</html>