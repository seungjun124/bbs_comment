<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="likey.LikeyDAO"%>
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

	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userEmail, ID, getClientIp(request));
	if (result == 1) {
		BbsDAO bbsDAO = new BbsDAO();
		result = bbsDAO.like(ID);
		if(result == 1) {
			PrintWriter sc = response.getWriter();
			sc.println("<script>");
			sc.println("alert('추천이 완료되었습니다.')");
			sc.println("history.back()");
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
		sc.println("alert('이미 추천을 누른 글 입니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	}
%>