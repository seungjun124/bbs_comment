<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String code = null;
	String userEmail = null;
	UserDAO userDAO = new UserDAO();
	
	if(session.getAttribute("userEmail") != null) {
		userEmail = (String)session.getAttribute("userEmail");
	}
	
	if(userEmail == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('로그인을 해주세요.')");
		sc.println("location.href='login.jsp'");
		sc.println("</script>");
		sc.close();
	}
	
	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	if(request.getParameter("code") != null) {
		code = request.getParameter("code");
	}

	System.out.println(userEmail);
	System.out.println(code);
	
	boolean result = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;

	if(result == true) {
		userDAO.setUserEmailChecked(userEmail);
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('인증에 성공하였습니다.')");
		sc.println("location.href='index.jsp'");
		sc.println("</script>");
		sc.close();
	} else {
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("alert('유효하지 않은 코드입니다.')");
			sc.println("location.href='index.jsp'");
			sc.println("</script>");
			sc.close();
	}
%>