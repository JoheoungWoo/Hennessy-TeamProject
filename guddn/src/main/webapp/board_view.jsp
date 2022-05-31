<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" errorPage="error.jsp" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="guddn.boardDAO" %>
<%@ page import="guddn.board" %>
<%@ page import="guddn.commentDAO" %>
<%@ page import="guddn.comment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<!DOCTYPE html>
<html>
<head>
<style>
	body{
		width: 650px;
		margin: 0 auto;
	}
	#a {
		border: 1px solid black;
		padding: 10px;
		margin-bottom: 30px;
	}
	#b {
		border: 1px solid black;
		padding: 10px;
	}
	#c {
		border: 1px solid black;
		padding: 10px;
		margin-top: 30px;
	}
	textarea {
	    width: 100%;
	    height:100px;
	    resize: none;
  	}
  	#un {
  		color: red;
  		font-weight: 700;
  		display: inline;
  	}
  	img {
  		margin: 0 auto;
  		width: 100%;
  		height: auto;
  	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		commentDAO commentDAO = new commentDAO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;

		request.setCharacterEncoding("utf-8");
		
		
		
		String getUserId = null;
		String getTitle = null;
		String getContent = null;
		String getTag = null;
		String getDate = null;
		String getNickName = null;
		String getFileName = null;
		String getCommImg = null;
		String commentNickName = null;
		int getView = 0;
		int getAvailable = -1;
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String isAdmin = null;
		if (session.getAttribute("isAdmin") != null) {
			isAdmin = (String) session.getAttribute("isAdmin");
		}
		int pageNumber = 1;
		if (request.getParameter("page") != null) {
			pageNumber = Integer.parseInt(request.getParameter("page"));
		}
		int getBoardId = 0;
		int comments = 0;
		if (request.getParameter("boardID") != null) {
			getBoardId = Integer.parseInt(request.getParameter("boardID"));
			comments = commentDAO.count(getBoardId);
		}
		if (getBoardId == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'boardView.jsp'");
			script.println("</script>");
		}
		board board = new boardDAO().getBoard(getBoardId); // 이제 새로고침이나 게시판에 들어오면 조회수가 새로 갱신된다 
	    String boardCon = board.getB_content();
	    String boardContent = boardCon.replace("\r\n","<br>"); // DB에 저장된 줄바꿈 단어를 html로 표현하기 위해서 <br>로 바꾸는 모습
	    
	    
		String url = "jdbc:mysql://localhost:3306/game_schema";
		String id= "root";
		String pwd = "1234";
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pwd);
		
		
		String query = "SELECT * FROM board_table order by board_id = ?";
		String getNick = "SELECT user_nickname FROM user_table ORDER BY user_id = ?";
		//String query2 = "INSERT INTO guddn.board_table(board_user,board_title,board_content,board_tag,board_date,board_available)"+ "VALUES('"+b_user+"','"+b_title+"','"+b_content+"','"+b_tag+"','"+now_dt+"','"+b_avilable+"')";
	
		pstmt = conn.prepareStatement(query);
		pstmt.setInt(1, getBoardId);
		stmt = conn.createStatement();
		rs = pstmt.executeQuery();
		while(rs.next()){ // rs에 저장된 값들을 연속해서 찾아온다.
					getUserId = rs.getString("board_user"); // DB의 id라는 이름의 열을 getID라는 변수에 저장함
					getTitle = rs.getString("board_title"); // DB의 password라는 이름의 열을 getTitle라는 변수에 저장함.
					getContent = rs.getString("board_content"); // DB의 password라는 이름의 열을 getContent라는 변수에 저장함.
					getTag = rs.getString("board_tag"); // DB의 password라는 이름의 열을 getTag라는 변수에 저장함.
					getView = rs.getInt("board_view"); // DB의 password라는 이름의 열을 getView라는 변수에 저장함.
					getDate = rs.getString("board_date"); // DB의 password라는 이름의 열을 getDate라는 변수에 저장함.
					getFileName = rs.getString("board_filerealname"); // DB의 password라는 이름의 열을 getFileName라는 변수에 저장함.
					getAvailable = rs.getInt("board_available"); // DB의 password라는 이름의 열을 getFileName라는 변수에 저장함.
		}
		pstmt = conn.prepareStatement(getNick);
		pstmt.setString(1, getUserId);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			getNickName = rs.getString(1);
		}	
	%>
	<% 	 
		 String path = session.getServletContext().getRealPath("/");
		 String b_fullpath = "uploadImage/" + getFileName;

	%>
	<div>
		<div id="c">
			[<%= getTag %>] <%= getTitle %> <% if(getAvailable == 0) { %><div id="un">[비활성화]</div><% } %><br>
			nickname : <%= getNickName %>(<%= getUserId %>) (View : <%= getView %>)
			
			<br> date : <%= getDate %><br><br>
			
			<div id="b" style="height:auto;">
				content :<br> 
				<% if(getFileName != null) { %>
				<img src="<%= b_fullpath %>" alt="<%= b_fullpath %>"></img><br>
				<% } %>
				<%= getContent %>
			</div>

			<br><br>
			
			<% if (getUserId != null && (getUserId.equals(userID) || (isAdmin.equals("YES") && userID.equals("관리자")))) { %>
			<a href="update.jsp?boardID=<%= getBoardId %>"><input type="button" value="수정하기"></a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="board_delete.jsp?boardID=<%= getBoardId %>"><input type="button" value="삭제하기"></a>
			<% } %>
		</div>	
	</div> <br/>
	<div id="b">
		<form method="post" action="commentAction.jsp?boardID=<%= getBoardId %>" enctype="multipart/form-data">
			<textarea class="form-control" placeholder="댓글 내용" name="c_content" maxlength="2048"></textarea>
			<input type="file" name="c_file"><br/>
			<hr>
			<input type="submit" class="btn btn-primary pull-right" value="댓글작성">
		</form>
	</div> <br/>
	<div id="a">
		Comment (<%= comments %>)
		<hr><br>
		<% 
			ArrayList<comment> list = commentDAO.getList(getBoardId, pageNumber);
			for(int i = 0; i < list.size(); i++) {
				pstmt = conn.prepareStatement("SELECT user_nickname FROM user_table ORDER BY user_id = ?");
				pstmt.setString(1, list.get(i).getC_user());
				rs = pstmt.executeQuery();
				while(rs.next()) {
					commentNickName = rs.getString(1);
				}
				String c_fullpath = "uploadImage/" + list.get(i).getC_filerealname();
				String comm = list.get(i).getC_content();
       			String comment = comm.replace("\r\n","<br>");
			%>
			<div id="b" style="margin-bottom:5px; height:auto;">
				<%= commentNickName %>(<%= list.get(i).getC_user() %>) - (<%= list.get(i).getC_date() %>)<br><br>
				<% if((list.get(i).getC_filerealname() != null)) { %>
				<img src="<%= c_fullpath %>" alt="<%= c_fullpath %>" width="100%" height="auto"></img><br>
				<%= comment %>
				<jsp:include page="commentUpdate.jsp"/>
				<% } else { %>
				<%= comment %>
				<jsp:include page="commentUpdate.jsp"/>
				<% } %>
			</div>
		<%
			}
		%>
	</div>
	

</body>
</html>