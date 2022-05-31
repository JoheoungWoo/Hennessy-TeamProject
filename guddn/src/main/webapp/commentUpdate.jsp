<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String c_content = request.getParameter("c_content");
	int getBoardId = 0;
	if (request.getParameter("boardID") != null) {
		getBoardId = Integer.parseInt(request.getParameter("boardID"));
	}
%>
	<div style="display: none;">
		<form method="post" action="commentUpdateAction.jsp?boardID=<%= getBoardId %>">
			<textarea class="form-control" placeholder="댓글 내용" name="commentContent" maxlength="2048"></textarea>
			<input type="file" name="file"><br/>
			<hr>
			<input type="submit" class="btn btn-primary pull-right" value="댓글수정">
		</form>
	</div>
</body>
</html>