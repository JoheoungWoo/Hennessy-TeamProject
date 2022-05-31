<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="guddn.boardDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="info" class="guddn.board" scope="page"/>
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			String b_title = multipartRequest.getParameter("b_title");
			String b_tag = multipartRequest.getParameter("b_tag");
			String b_content = multipartRequest.getParameter("b_content");
			if (b_tag.equals("") || b_title.equals(null) || b_title.equals("&nbsp;") || b_title.equals("") || b_title.equals("&nbsp;") ||
					b_title.equals("<br>") || b_title.equals("<br/>") || b_title.equals("<p>&nbsp;</p>") ||
						b_content.equals(null) || b_content.equals("&nbsp;") || b_content.equals("") || b_content.equals("&nbsp;") ||
								b_content.equals("<br>") || b_content.equals("<br/>") || b_content.equals("<p>&nbsp;</p>")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				//script.println("history.back()");
				script.println("</script>");
				out.println("제목 : "+b_title+"<br>");
				out.println("내용 : "+b_content+"<br>");
				out.println("태그 : "+b_tag+"<br>");
				out.println("info 파라미터 내용 : "+info.getB_content()+"<br>");
				out.println("리퀘스트 파라미터 내용 : "+request.getParameter("b_content")+"<br>");
			} else {
				boardDAO boardDAO = new boardDAO();
				
		                // 중복된 파일이름이 있기에 fileRealName이 실제로 서버에 저장된 경로이자 파일

		                // fineName은 사용자가 올린 파일의 이름이다

				// 이전 클래스 name = "file" 실제 사용자가 저장한 실제 네임
				String fileName = multipartRequest.getOriginalFileName("b_file");
				// 실제 서버에 업로드 된 파일시스템 네임
				String fileRealName = multipartRequest.getFilesystemName("b_file");
				
				int result = boardDAO.write(userID, b_title, b_content, b_tag, fileName, fileRealName);
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
					script.println("location.href = 'postPage.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body>
</html>