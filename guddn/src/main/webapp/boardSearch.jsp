<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="guddn.board" %>
<%@ page import="guddn.boardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="info" class="guddn.boardDAO" scope="page"/>
<jsp:setProperty name="info" property="*" />
<!DOCTYPE html>
<html>
<head>
<style>
	a {
		margin-bottom: 0px;
	}
	#b {
		border: 1px solid black;
		padding: 10px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int pageNumber = 1;
if (request.getParameter("page") != null) {
	pageNumber = Integer.parseInt(request.getParameter("page"));
}
int boardID = 0;
if (request.getParameter("boardID") != null) {
	boardID = Integer.parseInt(request.getParameter("boardID"));
}
%>
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="boardSearch.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="board_title">제목</option>
								<option value="board_user">작성자</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>

				</table>
			</form>
		</div>
	</div> <br>
<% 
	boardDAO boardDAO = new boardDAO();
	ArrayList<board> list = boardDAO.getSearch(request.getParameter("searchField"),
			request.getParameter("searchText"));
	if (list.size() == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('검색결과가 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	for (int i = 0; i < list.size(); i++) {
%>
	<div id="b">
	[<%= list.get(i).getB_id() %>]
	<%= list.get(i).getB_user() %>
	<a href="rmf.jsp?boardID=<%= list.get(i).getB_id() %>" ><%= list.get(i).getB_title() %> [<%= list.get(i).getB_comment() %>]</a>
	<%= list.get(i).getB_date() %>
	[View : <%= list.get(i).getB_view() %>]</div><br/>
<%
	}
%>
<%
	if(pageNumber != 1) {
%>
	<input type="button" onclick="location.href= 'boardView.jsp?page=<%= pageNumber - 1 %>'" value="이전" />
<%
	} if(boardDAO.nextPage(pageNumber + 1)) {
%>
	<input type="button" onclick="location.href= 'boardView.jsp?page=<%= pageNumber + 1 %>'" value="다음" />
<% 
	} 
%>

	<br/><br/>
	<input type="button" onclick="location.href = 'login.jsp'" value="로그인으로" />
	<input type="button" onclick="location.href = 'board.jsp'" value="글쓰기" />
</body>
</html>