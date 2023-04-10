<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.BbsDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="views.ViewsDAO"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%!
public static String getClientIp(HttpServletRequest request) {
	String ip = request.getHeader("X-Forwarded-For");

	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("WL-Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_CLIENT_IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }
        
        return ip;
}

%>
<% 
	request.setCharacterEncoding("UTF-8");
	int Division = 1;
	String userName = null;
	String userEmail = null;
	String userComment = null;
	int ID = 0;
	int ID2 = 0;
	int ID3 = 0;
	
	String Title = null;
	String Content = null;
	
	int Likes = 0;
	
	UserDAO userDAO = new UserDAO();
	
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
	
	if(request.getParameter("ID3") != null) {
		ID3 = Integer.parseInt(request.getParameter("ID3"));
	}
	
	if(request.getParameter("userComment") != null) {
		userComment = request.getParameter("userComment");
	}
	
	if (userComment == null) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('입력을 해주세요.')");
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
	
	CommentDAO commentDAO = new CommentDAO();
	int commentResult = commentDAO.commentWrite(Division, ID, ID2, ID3, userName, userEmail, userComment, getClientIp(request));
	if(commentResult == -1) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('디비 오류')");
		sc.println("location.href='bbs.jsp'");
		sc.println("</script>");
		sc.close();
	} else {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	}
%>