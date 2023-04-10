<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDAO" %>
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
	UserDAO userDAO = new UserDAO();
	
	if(session.getAttribute("userEmail") != null) {
		userEmail = (String)session.getAttribute("userEmail");
		userName = userDAO.getUserName(userEmail);
	}
	
	int emailChecked = userDAO.getUserEmailChecked(userEmail);
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">
    <img src="https://tuyu-official.jp/images/logo.png" width="100" class="d-inline-block align-top" alt="">
  </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">홈</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="bbs.jsp">커뮤니티</a>
      </li>

      <li class="nav-item dropdown" class="collapse navbar-collapse">
      <%
      	if (userEmail != null) {
      %>
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
          <%= userName %>
          
          <%
          if (emailChecked != 1) {
        	
       	  %>
       		(이메일 인증이 안 되어 있습니다.)  
          <%
          } else {
          %>
          	님 어서오세요!
          <% } %>
          
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
    <div class="container">
        <!-- Bootstrap table, table-dark and table-hover classes -->
        <button type="button" class="btn btn-light" style="margin: 5px;">공지</button>
		<button type="button" class="btn btn-light" style="margin: 5px;">일반</button>
		<button type="button" onclick="location.href='bbsWrite.jsp'" class="btn btn-dark btn-sm btn float-right" style="margin-top: 5px; margin-top: 15px;"> 글쓰기</button>
		
        <table class="table table-white table-hover table-sm">
            <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">말머리</th>
                    <th scope="col">제목</th>
                    <th scope="col">글쓴이</th>
                    <th scope="col">작성일</th>
                    <th scope="col">조회</th>
                    <th scope="col">추천</th>
                </tr>
            </thead>
            <tbody>

                <%
			    	BbsDAO bbsDAO = new BbsDAO();
			    	ArrayList<BbsDTO> list = bbsDAO.getList();
			    	for(int i = 0; i < list.size(); i++) {
			    %>
			                <tr>
			                    <th scope="row"><%=list.get(i).getID() %></th>
			                    <th scope="row"><%=list.get(i).getTitle() %></th> 
			                    <th scope="row"><a href="viewAction.jsp?ID=<%=list.get(i).getID() %>"><%=list.get(i).getSubject() %><a></a></th>
			                    <th scope="row"><%=list.get(i).getUserName()+"("+list.get(i).getUserEmail()+")" %></th>
			                    <th scope="row"><%=list.get(i).getDay() %></th>
			                    <th scope="row"><%=list.get(i).getViews() %></th>
			                    <th scope="row"><%=list.get(i).getLikes() %></th>
			                </tr>
			    <% 
			    	}
			    %>
            </tbody>
        </table>

    </div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>