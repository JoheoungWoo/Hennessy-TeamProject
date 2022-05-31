<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="guddn.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="info" class="guddn.User" scope="page"/>
<jsp:setProperty name="info" property="*" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>로그인 액션 </title>
</head>
<body>
	<%
		UserDAO user = new UserDAO();
		int result = user.login(info.getUserID(),info.getUserPassword());
		if(result == 1) {
			session.setAttribute("userID", info.getUserID()); // 로그인 성공 시 세션에다가 유저 아이디 값을 받아옴 (이제 이걸로 DB에 검색하는 용도로 쓰임)
			session.setAttribute("isAdmin", "NO");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href= 'mainPage.jsp'");
			script.println("</script>");
		} else if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 있는지 다시 한번 확인해주세요.')");
			script.println("location.href = document.referrer;");
			script.println("</script>");
			
		} else if (result == 2) {
			session.setAttribute("userID", info.getUserID());
			session.setAttribute("isAdmin", "YES");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 계정에 접근하셨습니다.')");
			script.println("location.href = 'mainPage.jsp'");
			script.println("</script>");
		}
		else if (result == -3) { // 유저 권한이 없는 경우임, 리턴값에 따라 결과를 보여주기 위해 만들어둠
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("location.href = document.referrer;");
			script.println("</script>");
		}
	%>
</body>
</html>