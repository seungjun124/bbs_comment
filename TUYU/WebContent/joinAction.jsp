<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userName = null;
	String userEmail = null;
	String userPW = null;
	
	if(request.getParameter("userName") != null) {
		userName = request.getParameter("userName");
	}

	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	
	if(request.getParameter("userPW") != null) {
		userPW = request.getParameter("userPW");
	}
	
	if(session.getAttribute("userEmail") != null) {
		userEmail = (String)session.getAttribute("userEmail");
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userName, userEmail, userPW, SHA256.getSHA256(userEmail), 0));
	
	System.out.println(userName);
	System.out.println(userEmail);
	System.out.println(userPW);
	
	if(userName == null || userEmail == null || userPW == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('입력이 안 되어 있습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
		return;
	} else {
		if(result == -1) {
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("alert('이미 존재하는 이메일 입니다.')");
			sc.println("history.back()");
			sc.println("</script>");
			sc.close();
		} else {
			session.setAttribute("userEmail", userEmail);
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("location.href='emailSendAction.jsp'");
			sc.println("</script>");
			sc.close();
		}
	}
%>