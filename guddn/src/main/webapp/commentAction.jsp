<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="guddn.commentDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="info" class="guddn.comment" scope="page"/>
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
		int maxSize = 1024 * 1024 * 50;
		String encoding = "UTF-8";
	
		
		// 사용자가 전송한 파일정보 토대로 업로드 장소에 파일 업로드 수행할 수 있게 함
		MultipartRequest multipartRequest
		= new MultipartRequest(request, uploadDir, maxSize, encoding,
				new DefaultFileRenamePolicy());

		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int getBoardId = 0;
		if (request.getParameter("boardID") != null) {
			getBoardId = Integer.parseInt(request.getParameter("boardID"));
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = document.referrer;");
			script.println("</script>");
		} else {
			String c_content = multipartRequest.getParameter("c_content");
			if (c_content == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("location.href = document.referrer;");
				script.println("</script>");
			} else {
				commentDAO commentDAO = new commentDAO();
				
		                // 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일

		                // fineName은 사용자가 올린 파일의 이름이다

				// 이전 클래스 name = "file" 실제 사용자가 저장한 실제 네임
				String fileName = multipartRequest.getOriginalFileName("c_file");
				// 실제 서버에 업로드 된 파일시스템 네임
				String fileRealName = multipartRequest.getFilesystemName("c_file");
				
				int result = commentDAO.write(userID, getBoardId, c_content, fileName, fileRealName);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = document.referrer;");
					script.println("</script>");
				}
			}
		}
		
	%>
</body>
</html>