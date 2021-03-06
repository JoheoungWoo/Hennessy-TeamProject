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
			script.println("alert('???????????? ?????? ????????????.')");
			script.println("location.href = 'boardView.jsp'");
			script.println("</script>");
		}
		board board = new boardDAO().getBoard(getBoardId); // ?????? ?????????????????? ???????????? ???????????? ???????????? ?????? ???????????? 
	    String boardCon = board.getB_content();
	    String boardContent = boardCon.replace("\r\n","<br>"); // DB??? ????????? ????????? ????????? html??? ???????????? ????????? <br>??? ????????? ??????
	    
	    
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
		while(rs.next()){ // rs??? ????????? ????????? ???????????? ????????????.
					getUserId = rs.getString("board_user"); // DB??? id?????? ????????? ?????? getID?????? ????????? ?????????
					getTitle = rs.getString("board_title"); // DB??? password?????? ????????? ?????? getTitle?????? ????????? ?????????.
					getContent = rs.getString("board_content"); // DB??? password?????? ????????? ?????? getContent?????? ????????? ?????????.
					getTag = rs.getString("board_tag"); // DB??? password?????? ????????? ?????? getTag?????? ????????? ?????????.
					getView = rs.getInt("board_view"); // DB??? password?????? ????????? ?????? getView?????? ????????? ?????????.
					getDate = rs.getString("board_date"); // DB??? password?????? ????????? ?????? getDate?????? ????????? ?????????.
					getFileName = rs.getString("board_filerealname"); // DB??? password?????? ????????? ?????? getFileName?????? ????????? ?????????.
					getAvailable = rs.getInt("board_available"); // DB??? password?????? ????????? ?????? getFileName?????? ????????? ?????????.
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
			[<%= getTag %>] <%= getTitle %> <% if(getAvailable == 0) { %><div id="un">[????????????]</div><% } %><br>
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
			
			<% if (getUserId != null && (getUserId.equals(userID) || (isAdmin.equals("YES") && userID.equals("?????????")))) { %>
			<a href="update.jsp?boardID=<%= getBoardId %>"><input type="button" value="????????????"></a>
			<a onclick="return confirm('????????? ?????????????????????????')" href="board_delete.jsp?boardID=<%= getBoardId %>"><input type="button" value="????????????"></a>
			<% } %>
		</div>	
	</div> <br/>
	<div id="b">
		<form method="post" action="commentAction.jsp?boardID=<%= getBoardId %>" enctype="multipart/form-data">
			<textarea class="form-control" placeholder="?????? ??????" name="c_content" maxlength="2048"></textarea>
			<input type="file" name="c_file"><br/>
			<hr>
			<input type="submit" class="btn btn-primary pull-right" value="????????????">
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