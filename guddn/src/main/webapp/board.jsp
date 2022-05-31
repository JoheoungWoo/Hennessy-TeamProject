<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<style>
	#b {
		border: 1px solid black;
		padding: 10px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
String userID = null; 
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID"); } // 세션 영역에 userID가 존재한다면 값을 불러와 저장함
%>
<%
if (userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 해주세요.')");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
} // 만약에 userID 가 null이 아닌 아이디로 저장이 되어있다면 해당 페이지에서 쫓아냄
%>
	<div id="b">
		<table>
			<form action="boardAction.jsp" method="post"  enctype="multipart/form-data">
				<tbody>
					<tr>
						<td colspan="2"><input type="button" onclick="location.href = 'boardView.jsp'" value="게시판으로" /><hr></td>
					</tr>	
					<tr>
						<td>title :</td>
						<td><input type="text" name="b_title"><br></td>
					</tr>
					<tr>
						<td>tag :</td>
						<td>
						<select name="b_tag">
							<option value="자유 게시판">자유 게시판</option>
							<option value="직업 게시판">직업 게시판</option>
							<option value="질문 게시판">질문 게시판</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>content :</td>
						<td><textarea name="b_content" maxlength="2048" style="hegiht:350px;"></textarea><br></td>
					</tr>
					<tr>
						<td>File :</td>
						<td><input type="file" name="b_file"></td>
					</tr>
					<tr>
						<td><input type="submit" value="제출버튼"></td>
					</tr>
				</tbody>
			</form>
		</table>
	</div>
</body>
</html>