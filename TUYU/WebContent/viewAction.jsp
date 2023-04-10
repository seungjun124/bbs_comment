<%@page import="comment.CommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.BbsDTO"%>
<%@ page import="views.ViewsDAO"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.CommentDTO" %>
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

	ViewsDAO viewsDAO = new ViewsDAO();
	int ID = 0;
	
	if(request.getParameter("ID") != null) {
		ID = Integer.parseInt(request.getParameter("ID"));
	}
	
	
	String userComment = null;
	if (request.getParameter("userComment") != null) {
		userComment = request.getParameter("userComment");
	}
	
	System.out.println(ID);
	System.out.println(getClientIp(request));
	
	int result = viewsDAO.view(ID, getClientIp(request));
	
	if (result == 1) {
		BbsDAO bbsDAO = new BbsDAO();
		bbsDAO.view(ID);
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<style>
      .comment {
          margin-bottom: 20px;
          border: 1px solid #ddd;
          padding: 10px;
      }
      .comment-info {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 5px;
      }
      .comment-info span {
          font-weight: bold;
      }
      .comment-text {
          margin-bottom: 10px;
      }
      .comment-reply-link {
          color: blue;
          text-decoration: underline;
          cursor: pointer;
      }
      .comment-form {
          margin-top: 20px;
          border: 1px solid #ddd;
          padding: 10px;
      }
      .comment-form label, .comment-form textarea {
          display: block;
          margin-bottom: 5px;
      }
      .comment-form textarea {
          width: 100%;
          height: 100px;
          padding: 5px;
          border: 1px solid #ddd;
          border-radius: 5px;
          resize: none;
      }
      .comment-form input[type=submit] {
          background-color: #008CBA;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
      }
      .comment-form input[type=submit]:hover {
          background-color: #006D87;
      }
  </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function() {
            $(".comment-reply-link").click(function(e) {
                e.preventDefault();
                $(this).next(".comment-form").toggle();
            });
        });
    </script>

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
	
	BbsDAO bbsDAO = new BbsDAO();
	BbsDTO bbs = bbsDAO.getBbs(ID);
	
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
	<br>
    <h5><%="["+bbs.getTitle() + "] " + bbs.getSubject() %></h5>
    <p><%=bbs.getUserName()+"("+bbs.getUserEmail()+")"+" | "+bbs.getDay()+" | 추천:"+ bbs.getLikes() + " | 조회: " + bbs.getViews() %></p>
    <hr>
    <p><%=bbs.getContent() %></p>
    <hr>
    <button type="button" class="btn btn-light" onclick="location.href='likeAction.jsp?ID=<%=ID %>'">추천</button>
    <button type="button" class="btn btn-light" onclick="location.href='bbsUpdate.jsp?ID=<%=ID %>'">수정</button>
	<button type="button" class="btn btn-light" onclick="location.href='deleteAction.jsp?ID=<%=ID %>'">삭제</button>
    <br>
    <br>
    <div class="container">
    </div>
    
        <form action="commentAction.jsp" method="post">
                <input style="display : none; type="text" name="ID" id="ID" value="<%= ID%>">
                <input style="display : none; type="text" name="userComment" id="userComment" value="<%= userComment%>">

 
    	</form>
	<%
             	
       	int Division = 0;
       	CommentDAO com = new CommentDAO();
       	ArrayList<CommentDTO> list2 = com.getList(ID);
    	for(int j = 0; j < list2.size(); j++) {
    	int divisionResult = com.division(list2.get(j).getID2());
    	System.out.println(divisionResult);
    %>
    
    	<% if(divisionResult == 1) { %>
    	<div class="comments">
        <div class="comment">
          
            <div class="comment-info">
                <span><%= list2.get(j).getUserName()+"("+list2.get(j).getUserEmail()+")"%></span>
                <span><%= list2.get(j).getDay()%></span>
            </div>
            <div class="comment-text">
                <%= list2.get(j).getUserComment()%>
            </div>
            <div class="comment-reply">
            
                <button type="button" class="btn btn-light" onclick="location.href='commentUpdate.jsp?ID2=<%=list2.get(j).getID2()%>'">수정</button>
                <button type="button" class="btn btn-light" onclick="location.href='commentDeleteAction.jsp?ID=<%= list2.get(j).getID()%>&ID2=<%=list2.get(j).getID2()%>'">삭제</button>
                <button class="btn btn-light comment-reply-link">답글 작성</button>
                <div class="comment-form" style="display: none;">
                    <form action="commentAction2.jsp" method="post">
                    	<label for="message">닉네임: <%= userName%></label>
                        <label for="message">메시지:</label>
                        <textarea id="userComment" name="userComment"></textarea>
                        <input type="hidden" id="parent_id" name="parent_id" value="1">
                        <input type="submit" value="작성" onclick="location.reload()">
                        <input style="display: none;" type="text" name="ID" id="ID" value="<%=list2.get(j).getID()%>"><br>
    					<input style="display: none;" type="text" name="ID2" id="ID2" value="<%=list2.get(j).getID2()%>"><br>
                    </form>
                </div>
            </div>
        
        </div>
    </div>
    <% } else { %>
            	<div class="reply-comments" style="margin-left: 50px">
                <div class="comment reply-comment">
                    <div class="comment-info">
	                <span><%= list2.get(j).getUserName()+"("+list2.get(j).getUserEmail()+")"%></span>
	                <span><%= list2.get(j).getDay()%></span>
	            </div>
	            <div class="comment-text">
	                <%= list2.get(j).getUserComment()%>
	            </div>
	            <button type="button" class="btn btn-light" onclick="location.href='commentUpdate.jsp?ID=ID2=<%=list2.get(j).getID2()%>'">수정</button>
                <button type="button" class="btn btn-light" onclick="location.href='commentDeleteAction2.jsp?ID=<%= list2.get(j).getID()%>&ID2=<%=list2.get(j).getID2()%>'">삭제</button>
                </div>
            </div>
            <% } %>
    <% } %>
    <div class="comment-reply">
                <div class="comment-form">
                    <form action="commentAction.jsp" method="post">
                    	<label for="message">닉네임: <%= userName%></label>
                        <label for="message">메시지:</label>
                        <textarea id="userComment" name="userComment"></textarea>
                        <input type="hidden" id="parent_id" name="parent_id" value="1">
                        <input type="submit" value="작성" onclick="location.reload()">
						<input style="display: none;" type="text" name="ID" id="ID" value="<%= ID%>"><br>
    					<input style="display: none;" type="text" name="ID2" id="ID2" value="<%= ID * 10000%>"><br>
                    </form>
                </div>
            </div>
    </div>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$("#userComment2").keydown(function(){
    $('#userComment').val($(this).val());
});

$("#userComment2").change(function(){
    $('#userComment').val($(this).val());
});

</script>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>