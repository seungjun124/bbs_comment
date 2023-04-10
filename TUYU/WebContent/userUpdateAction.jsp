<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	String userName = null;
	String userEmail = null;
	
	if (request.getParameter("userName") != null) {
		userName = request.getParameter("userName");
	}
	
	if (request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	
	System.out.println(userName);
	System.out.println(userEmail);
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.userUpdate(userName, userEmail);
	if (result == -1) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('데이터 베이스 오류')");
		sc.println("</script>");
		sc.close();
	} else {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('변경 되었습니다.')");
		sc.println("location.href='index.jsp'");
		sc.println("</script>");
		sc.close();
	}
%>