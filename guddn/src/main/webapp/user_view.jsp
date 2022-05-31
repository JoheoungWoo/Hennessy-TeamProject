<%@ page contentType = "text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="guddn.UserDAO" %>
<%@ page import="guddn.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	body{
		width: 400px;
		margin: 0 auto;
	}
	#a {
		border: 1px solid black;
		padding: 10px;
		font-size: 16px;
		font-weight: 700;
		height: 210px;
		margin-top:5px;
	}
	#b {
		border: 1px solid black;
		padding: 10px;
		font-size: 16px;
		font-weight: 700;
		height: 200px;
	}
	textarea {
	    width: 100%;
	    height:100px;
	    resize: none;
  	}
  	#un {
  		color: red;
  		font-weight: 700;
  		display: inline;
  	}
  	
  	.inputA{
  		width: 20%;
		text-align: right;
		float: left;
  	}
  	.inputB{
  		width: 80%;
  		float: left;
  		text-align: left;
  	}
  	.inputC{
  		width: 40%;
  	}
  	input{
  		margin-left: 10px;
  		margin-right: 10px;
  	}
  	label{
  		margin-left: 10px;
  		margin-right: 10px;
  		font-weight: 400;
  		font-size: 12px;
  	}
  	
  	input[type="submit"]{
  		margin-top: 20px;
  		width: 90%;
  		
  	}
  	
</style>
<meta charset="EUC-KR">
<% 
	int userIDNum = -1; // 0은 관리자 아이디여서 -1로 변경
	if (request.getParameter("user_id_num") != null) {
		userIDNum = Integer.parseInt(request.getParameter("user_id_num"));
	}
	User user = new UserDAO().getUser(userIDNum); 
%>
<title><%= user.getUserID() %> 님의 정보 변경</title>
</head>
<body>
<%
	String isAdmin = null;
	String userID = null;
	if (session.getAttribute("isAdmin") != null) {
		isAdmin = (String) session.getAttribute("isAdmin");
	} 
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('세션이 만료되었습니다.')");
		script.println("location.href = 'mainPage.jsp'");
		script.println("</script>");
	}
	if (userIDNum < 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 정보입니다.')");
		script.println("location.href = 'mainPage.jsp'");
		script.println("</script>");
	}
	if ((!userID.equals("관리자"))  && (!isAdmin.equals("YES"))) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자 권한이 존재하지 않습니다.')");
		script.println("location.href = 'mainPage.jsp'");
		script.println("</script>");
	} 
	if(user == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('정보가 올바르게 불려지지 않았습니다.')");
		script.println("location.href = 'mainPage.jsp'");
		script.println("</script>");
	}
	
%>
	<div id="a">
		<form method="post" action="admin_update.jsp?user_id_num=<%= userIDNum %>" enctype="multipart/form-data">
			<div class="inputA">아이디</div>
			<div class="inputB"><input type="text" name="user_id" value="<%= user.getUserID() %>" disabled></div>
			<div class="inputA">비밀번호</div>
			<div class="inputB"><input type="text" name="user_password" value="<%= user.getUserPassword() %>"></div>
			<div class="inputA">닉네임</div>
			<div class="inputB"><input type="text" name="user_nickname" value="<%= user.getUserNickName() %>"></div>
			<div class="inputA">이름</div>
			<div class="inputB"><input type="text" name="user_name" value="<%= user.getUserName() %>"></div>
			<div class="inputA">성별</div>
			<div class="inputB">
				<label>
					남자<input type="radio" name="user_gender" value="남자">
				</label>
				<label>
					여자<input type="radio" name="user_gender" value="여자"> [현재 : <%= user.getUserGender() %>]
				</label>
			</div>
			<div class="inputA">이메일</div>
			<div class="inputB"><input type="text" name="user_email" value="<%= user.getUserEmail() %>"></div>
			<div class="inputA">프로필</div>
			<div class="inputB"><input type="file" name="user_file"></div>
			<input type="submit" value="정보 변경">
		</form>
	</div>
</body>
</html>