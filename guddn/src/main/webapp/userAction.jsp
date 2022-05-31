<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="guddn.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="info" class="guddn.User" scope="page"/>
<jsp:setProperty name="info" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
			int result = 0;
			int u_result = 0;
			String userID = null;
			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
			}
			
			String status = request.getParameter("stauts");
			String getPWD = request.getParameter("selectPw");
			String getNickName = request.getParameter("selectNn");
			status = "2";
			UserDAO u = new UserDAO();
			/* if(status.equals("1")) { // 비밀번호 변경을 누른경우
				String getPWD = request.getParameter("selectPw");
				u_result = u.updatepwd(userID,getPWD);
			} else if(status.equals("2")) { //닉네임변경을 누른경우
				String userNickName = request.getParameter("selectNick");
				u_result = u.updateNick(userID, userNickName);
			} else if(status.equals("3")) { //회원탈퇴를 누른경우
				
				
			} */ 

					
			if(status.equals("1")) {
				result = u.updatedata(userID, getNickName,getPWD);
			} else if(status.equals("2")) {
				result = u.u_account_delete(userID);
				result = u.u_board_delete(userID);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제가 완료되었습니다.')");
				session.invalidate();
				script.println("location.href = document.referrer;");
				script.println("</script>");
			} 		
				if (result == 1 || result == 0) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'userPage.jsp'");
					script.println("</script>");
				}
				else if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제 도중 문제가 발생했습니다.)");
					script.println("location.href = document.referrer;");
					script.println("</script>");
				}
%>
</body>
</html>