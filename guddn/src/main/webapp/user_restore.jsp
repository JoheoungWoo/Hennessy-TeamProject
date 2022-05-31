<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="guddn.UserDAO" %>
<%@ page import="guddn.User" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<% 		
		String userID = null;
		int userIDNum = -1;
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (Integer.parseInt(request.getParameter("user_id_num")) > -1) {
			userIDNum = Integer.parseInt(request.getParameter("user_id_num"));
		}
		String isAdmin = null;
		if (session.getAttribute("isAdmin") != null) {
			isAdmin = (String) session.getAttribute("isAdmin");
		} 
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'mainPage.jsp'");
			script.println("</script>");
		} 
    	if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('세션이 만료되었습니다.')");
			script.println("location.href = 'mainPage.jsp'");
			script.println("</script>");
		}
	
		User user = new UserDAO().getUser(userIDNum);
    	if ((!userID.equals(user.getUserID())) && (!isAdmin.equals("YES"))) {
    		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('요청자와 작성자가 서로 일치하지 않습니다.')");
			script.println("location.href = document.referrer;");
			script.println("</script>");
    	} else if ((!userID.equals(user.getUserID())) && (isAdmin.equals("YES")) && (userID.equals("관리자"))){
				UserDAO userDAO = new UserDAO();
				int result = userDAO.restore(userIDNum);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('계정 활성화에 실패했습니다.')");
					script.println("location.href = document.referrer;");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = document.referrer;");
					script.println("</script>");
				}
			}	
		
	%>

</body>
</html>