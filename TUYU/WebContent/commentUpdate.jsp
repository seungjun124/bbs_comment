<%@page import="comment.CommentDAO"%>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDTO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<style>
	th {
		height: 10px;
	}
</style>

</head>
<body>

<%
	String userEmail = null;
	String userName = null;
	CommentDAO com = new CommentDAO();
	UserDAO userDAO = new UserDAO();
	
	int ID2 = 0;
	
	if(request.getParameter("ID2") != null) {
		ID2 = Integer.parseInt(request.getParameter("ID2"));
	}
	
	if(session.getAttribute("userEmail") != null) {
		userEmail = (String)session.getAttribute("userEmail");
		userName = com.getUserEmail(ID2);
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
	
	int emailChecked = userDAO.getUserEmailChecked(userEmail);
	if(emailChecked != 1) {
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('이메일 인증을 해주세요.')");
		sc.println("location.href='emailSendAction.jsp'");
		sc.println("</script>");
		sc.close();
	}
	
	
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">
    <img src="https://tuyu-official.jp/images/logo.png" width="100" class="d-inline-block align-top" alt="">
  </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">홈</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">커뮤니티</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">SNS</a>
      </li>
      <li class="nav-item dropdown" class="collapse navbar-collapse">
      <%
      	if (userEmail != null) {
      %>
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
          <%= userName %>님 환영합니다!
        </a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="logout.jsp">로그아웃</a>
        </div>
      <%
      	} else {
      %>
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
          로그인을 해주세요.
        </a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="login.jsp">로그인</a>
        </div>
      <%
      	}
      %>
      </li>
    </ul>
  </div>
  
</nav>

    <form action="commentUpdateAction.jsp" method="post">

        <input type="text" name="Content" id="Content"><br>
        
        <input type="text" style="display : none;" name="ID2" id="ID2" value="<%= ID2 %>"><br>

        <input type="submit" style="display : none;" value="제출">
        
        <div class="container" style="margin-top: -60px;">
	        <div class="input-group mb-3 mw-100 ">
			  	<button class="btn btn-outline-dark float-right" type="submit">글 쓰기</button>
			</div>
				<textarea class="form-control" placeholder="글 내용" name="Content2" id="Content2" maxlength="2048" style="height: 350px;"></textarea>
		</div>
    </form>
    
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

$("#Content2").keydown(function(){
    $('#Content').val($(this).val());
});

$("#Content2").change(function(){
    $('#Content').val($(this).val());
});

</script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>