<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="guddn.boardDAO" %>
<%@ page import="guddn.board" %>
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
		String isAdmin = null;
		int boardID = 0;
		
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		} 
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
    	if (boardID == 0) {
    		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'mainPage.jsp'");
			script.println("</script>");
    	}
	
		board board = new boardDAO().getBoard(boardID);
    	if ((!userID.equals(board.getB_user())) && (!isAdmin.equals("YES"))) {
    		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('요청자와 작성자가 서로 일치하지 않습니다.')");
			script.println("location.href = document.referrer;");
			script.println("</script>");
    	} else if ((!userID.equals(board.getB_user())) && (isAdmin.equals("YES"))){
				boardDAO boardDAO = new boardDAO();
				int result = boardDAO.restore(boardID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 복구에 실패했습니다.')");
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