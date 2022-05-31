<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="guddn.UserDAO" %>
<%@ page import="guddn.User" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
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
		// 해당 폴더에 이미지를 저장시킨다
		String uploadDir = this.getClass().getResource("").getPath();
		uploadDir = uploadDir.substring(1,uploadDir.indexOf(".metadata"))+"guddn/src/main/webapp/uploadImage";
	
		// 총 50M 까지 저장 가능하게 함
		int maxSize = 1024 * 1024 * 5;
		String encoding = "UTF-8";
	
		
		// 사용자가 전송한 파일정보 토대로 업로드 장소에 파일 업로드 수행할 수 있게 함
		MultipartRequest multipartRequest
		= new MultipartRequest(request, uploadDir, maxSize, encoding,
				new DefaultFileRenamePolicy());
		
		String isAdmin = null;
		if (session.getAttribute("isAdmin") != null) {
			isAdmin = (String) session.getAttribute("isAdmin");
		} 
		String userID = null;
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
		int userIDNum = -1; // 0은 관리자 아이디여서 -1로 변경
    	if (request.getParameter("user_id_num") != null) {
    		userIDNum = Integer.parseInt(request.getParameter("user_id_num"));
    	}
    	if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('세션이 만료되었습니다.')");
			script.println("location.href = 'mainPage.jsp'");
			script.println("</script>");
		}
    	if (userIDNum == 0) {
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
    	} else if ((userID.equals("관리자"))  && (isAdmin.equals("YES"))){
			String u_password = multipartRequest.getParameter("user_password");
			String u_nickname = multipartRequest.getParameter("user_nickname");
			String u_name = multipartRequest.getParameter("user_name");
			String u_gender = multipartRequest.getParameter("user_gender");
			String u_email = multipartRequest.getParameter("user_email");
			if (u_password == null || u_nickname == null || u_name == null || u_gender == null || u_email == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				UserDAO user = new UserDAO();
				
		                // 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일

		                // fineName은 사용자가 올린 파일의 이름이다

				// 이전 클래스 name = "file" 실제 사용자가 저장한 실제 네임
				String fileName = multipartRequest.getOriginalFileName("user_file");
				// 실제 서버에 업로드 된 파일시스템 네임
				String fileRealName = multipartRequest.getFilesystemName("user_file");
				
				int result = user.adminUpdate(userIDNum, u_password, u_nickname, u_name, u_gender, u_email, fileName, fileRealName);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('정보 변경에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('정보 변경에 성공했습니다.')");
					script.println("location.href = document.referrer;");
					script.println("</script>");
				}
			}
		}
		
	%>
</body>
</html>