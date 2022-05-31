<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<style>
	label {
		border : 1px solid black;
		margin : 10px;
		margin-top: 12px;
	}
</style>
<meta charset="UTF-8">
<title>회원가입 시도</title>
</head>
<body>
<% 
String userID = null; 
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID"); } // 세션 영역에 userID가 존재한다면 값을 불러와 저장함
%>
<%
if (userID != null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인이 되어있습니다.')");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
} // 만약에 userID 가 null이 아닌 아이디로 저장이 되어있다면 해당 페이지에서 쫓아냄
%>
	<form method="post" action="joinAction.jsp">
		<input type="text" name="userID" maxlength="20" placeholder="아이디입력"> <br/>
		<input type="password" name="userPassword" maxlength="20" placeholder="비밀번호입력"> <br/>
		<input type="text" name="userNickName" maxlength="20" placeholder="닉네임"> <br/>
		<input type="text" name="userName" maxlength="10" placeholder="이름"> <br/>
		
		<label>
			남자 <input type="radio" name="userGender" value="남자">
		</label>
		<label>
			여자 <input type="radio" name="userGender" value="여자">
		</label> <br/>
		
		<input type="email" name="userEmail" maxlength="50" placeholder="이메일"> <br/><br/>  
		<input type="submit" value="제출하기입니다" >
	</form>
</body>
</html>