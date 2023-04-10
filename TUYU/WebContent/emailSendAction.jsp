<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.*" %>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userName = null;
	String userEmail = null;
	String userPW = null;
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
		return;
	}
	
	int emailChecked = userDAO.getUserEmailChecked(userEmail);
	if(emailChecked == 1) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('이미 인증 된 회원입니다.')");
		sc.println("location.href='index.jsp'");
		sc.println("</script>");
		sc.close();
		return;
	}
	
	String host = "http://121.143.109.68:8090/TUYU/";
	String from = "hy21639@sonline20.sen.go.kr";
	String to = userEmail;
	String subject = "이메일 인증 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 확인을 진행하세요." + "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
	
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

	try {
	    Authenticator auth = new Gmail();
	    Session ses = Session.getInstance(p, auth);
	    ses.setDebug(true);
	    MimeMessage msg = new MimeMessage(ses); 
	    msg.setSubject(subject);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr);
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	    msg.setContent(content, "text/html;charset=UTF-8");
	    Transport.send(msg);
	} catch (Exception e) {
		e.printStackTrace();
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('오류가 발생했습니다.')");
		sc.println("history.back()");
		sc.println("</script>");
		sc.close();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>이메일 인증</title>
</head>
<body>
	<div class="alert alert-primary" role="alert">
  		이메일 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일을 확인해주세요.
	</div>	
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>