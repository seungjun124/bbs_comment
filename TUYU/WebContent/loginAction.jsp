<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String userEmail = null;
	String userPW = null;

	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}

	if(request.getParameter("userPW") != null) {
		userPW = request.getParameter("userPW");
	}
	
	if (userEmail == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('이메일을 입력해주세요.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
		return;
	}

	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userEmail, userPW);
	
	if(result == 1) {
		session.setAttribute("userEmail", userEmail);
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("location.href='index.jsp'");
		sc.println("</script>");
		sc.close();
	} else if(result == 0) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('비밀번호가 틀립니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	} else if(result == -1) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('이메일을 찾을 수 없습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	} else if(result == -2) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('데이터베이스 오류')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	}
%>
</body>
</html>