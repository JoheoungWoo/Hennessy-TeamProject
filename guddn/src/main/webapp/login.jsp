<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="guddn.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<html>
<head>
	<title>로그인 시도</title>
</head>
<body>
<% 
UserDAO user = new UserDAO();
String userID = null; 
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID"); 
} // 세션 영역에 userID가 존재한다면 값을 불러와 저장함 + userID 를 rankUp에 보내서 특정 exp에 도달하면 레벨 업을 시켜줌
%>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = null;
String myInf = "SELECT user_nickname, user_email, user_rank, user_exp, user_point FROM user_table WHERE user_id = ?";
String userNickName = null;
String userEmail = null;
int userRank = 0;
int userExp = 0;
int userPoint = 0;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		try {
			String URL = "jdbc:mysql://localhost:3306/game_schema";
			String ID = "root";
			String Password = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, ID, Password);
			pstmt = conn.prepareStatement(myInf);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()){  				
				userNickName = (String) rs.getString(1);
				userEmail = (String) rs.getString(2);
				userRank = (int) rs.getInt(3);
				userExp = (int) rs.getInt(4);
				userPoint = (int) rs.getInt(5);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	  	
	} // DB를 불러오고 세선 영역에 저장된 userID를 끌고와서 정보를 조회시킴
%>
<%
int result = user.rankUp(userID);
if (result == 1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('축하드립니다! 레벨 업을 하셨습니다!')");
	script.println("location.reload(true);");
	script.println("</script>");
}
%> 
<%
if (userID != null) {
%>
<h1>어서오세요 <%= userNickName %> 님!</h1>
<h4 style="margin-bottom:5px;">Lv.<%= userRank %> <progress value="<%= userExp %>" max="100"></progress></h4>
<h5 style="margin-left:90px; margin-top:5px;">Exp : <%= userExp %></h5>
<h4>포인트 : <%= userPoint %></h4>
<h4>이메일 : <%= userEmail %></h4>
<input type="button" onclick="location.href = 'logoutAction.jsp'" value="로그아웃" >
<input type="button" onclick="location.href = 'boardView.jsp'" value="게시판 이동" >
<% } else { %>
<form method="post" action="loginAction.jsp">
	<input type="text" name="userID" maxlength="20" placeholder="아이디입력">
	<input type="text" name="userPassword" maxlength="20" placeholder="비밀번호입력">
	<input type="submit" value="제출하기입니다" >
</form>
<input type="button" onclick="location.href = 'join.jsp'" value="회원가입" >
<% } %>
</body>
</html>