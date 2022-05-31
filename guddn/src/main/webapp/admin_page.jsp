<%@ page contentType = "text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="guddn.Tool" %>
<%@ page import="guddn.board" %>
<%@ page import="guddn.boardDAO" %>
<%@ page import="guddn.commentDAO" %>
<%@ page import="guddn.UserDAO" %>
<%@ page import="guddn.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<html>
  <head>
    <meta charset="utf-8">
    <title>JSP 팀별과제 - 헤네시스</title>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <style>

/****************************** 배경 영역 제어 부분임 ******************************/

      body{
        margin: 0px;
        background-image: url(image/bg.png);
  		background-repeat: no-repeat;
  		background-size: cover;
  		margin: 0 auto;
  		width: 1519.2px;
      }

/****************************** 헤더 영역 제어 부분임 ******************************/

      .header{
        width: 100%;
        height: 40px;
      }

/****************************** 메뉴바 영역 제어 부분임 ******************************/

      .menu{
        width: 100%;
        height: 80px;
        display: flex;
      }

	  .menu_left,.menu_right{
	  	width: 20%;
	  	height: 80px;
	  }

	  .menu_area{
	  	width: 60%;
	  }

/****************************** 메인페이지 영역 제어 부분임 ******************************/
	  h1{
	  	text-align: center;
	  }
		
      .main_split{
        display: flex;
      }

      .main_left,.main_right{
        width: 20%;
        height: 760px;
        text-align: center;
      }

      .main_area{
        width: 60%;
        height: 900px;
      }
 
	  .board_split{
	  	display: flex;
	  }
	  
	  .table1{
	  	margin: auto;
	  	width: 90%;
	  	background: #000000;
	  }
	  
	  .table2{
	  	margin: auto;
	  	width: 90%;
	  	background: #337882;
	  	border-width: 2px 2px 0px 2px;
	  	border-style: solid;
	  	border-color: black; 
	  }
	  
	  form[name="search"]{
	  	margin-bottom: 0px;
	    padding-top: 20px;
	  }
	  
	  thead{
	  	background: #337882;
	  	font-weight: 700;
	  	color: white;
	  	height: 40px;
	  }
	  
	  tbody[class="tbody"]{
	  	background: #d6e4e6;
	  	hegiht: 30px;
	  }
	  

	  .page1, .page2{
	  	width: 50%;
	  	height: 900px;
	  	background-color: #ffeeff;
	  	bottom: 0;
	  	left: 0;
	  }
	  
	  .goto{
	  	cursor: pointer;
	  }
	  
	  .gotoPage{
	  	background: #337882;
	  	font-weight: 700;
	  	color: white;
	  	height: 20px;
	  }
	  
	  .del{
	  	background-color: #ff00000;
	  	font-weight: 700;
	  	text-align: center;
	  }
	  
	  #nonDel{
	  	color: #20835e;
	  	text-align: center;
	  }
	  
	  #Deleted{
	  	color: #ff0000;
	  	text-align: center;
	  }
	  
	  .btn{
	  	margin: 0 auto;
	  	margin-top: 5px;
	  	margin-bottom: 5px;
	  }
	  
	  .text{
	  	max-width: 200px;
	  	overflow:hidden;
	  	text-overflow:ellipsis;
	  	-webkit-line-clamp:1;
	  	-webkit-bos-orient:vertical;
	  	white-space:nowrap;
	  }
	  
/****************************** 푸터 영역 제어 부분임 ******************************/

      .footer_split{
        display: flex;
      }

      .footer_left,.footer_right{
        width: 20%;
        height: 100px;
      }

      .footer{
        width: 60%;
        height: 90px;
      }

    </style>

  </head>

  <body>
<!-- --------------------------게시판 영역--------------------------- -->
<%
	String uri = request.getRequestURI().toString()+"?";
	int userIDNum = -1;
	int pageNumber = 1;
	int pageMBN = 1;
	int pageBoardNumber = 1;
	int searchBoardNumber = 1;
	int searchUserNumber = 1;
	if (request.getParameter("pageMBN") != null) {
		pageMBN = Integer.parseInt(request.getParameter("pageMBN"));
		uri += "pageMBN="+pageMBN+"&";
	}
	if (request.getParameter("user_id_num") != null) {
		userIDNum = Integer.parseInt(request.getParameter("user_id_num"));
		uri += "user_id_num="+userIDNum+"&";
	}
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		uri += "pageNumber="+pageNumber+"&";
	}
	if (request.getParameter("pageBoardNumber") != null) {
		pageBoardNumber = Integer.parseInt(request.getParameter("pageBoardNumber"));
		uri += "pageBoardNumber="+pageBoardNumber+"&";
	}
	if (request.getParameter("searchBoardNumber") != null) {
		searchBoardNumber = Integer.parseInt(request.getParameter("searchBoardNumber"));
		uri += "searchBoardNumber="+searchBoardNumber+"&";
	}
	if (request.getParameter("searchUserNumber") != null) {
		searchUserNumber = Integer.parseInt(request.getParameter("searchUserNumber"));
		uri += "searchUserNumber="+searchBoardNumber+"&";
	}
	int boardID = 0;
	if (request.getParameter("boardID") != null) {
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}	
%>
<!-- --------------------------관리자 인식 영역--------------------------- -->
<%
	String userID = null;
	String isAdmin = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(session.getAttribute("isAdmin") != null) {
		isAdmin = (String) session.getAttribute("isAdmin");
	}
	if ((userID == null) || (isAdmin != "YES")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없거나 로그인이 필요합니다.')");
		script.println("location.href = 'mainPage.jsp'");
		script.println("</script>");
	} // 만약에 userID 가 null이거나 관리자 권한이 존재하지 않는다면 메인페이지로 쫒아냄
%>
<!-- --------------------------검색 영역--------------------------- -->
<%	
	boardDAO boardDAO = new boardDAO(); // 리스트를 불러오는 객체를 사용하기 위해 DAO를 호출
	String b_cols = null;
	String b_words = null;
	b_cols = (String) request.getParameter("b_col");
	b_words = (String) request.getParameter("b_word");
	boolean b_col = Tool.isEmpty(request.getParameter("b_col"));
	boolean b_word = Tool.isEmpty(request.getParameter("b_word")); // 만약 아무런 값을 전하지 않고 null값을 보냈다면 true를 반환시킨다.
	if (b_col == true) {
		b_cols = "";
	}
	if (b_word == true) {
		b_words = "";
	}
	
	ArrayList<board> searchBoard = boardDAO.searchBoard(b_cols, b_words, searchBoardNumber);

%>
<%

UserDAO userDAO = new UserDAO(); // 리스트를 불러오는 객체를 사용하기 위해 DAO를 호출
String u_cols = null;
String u_words = null;
u_cols = (String) request.getParameter("u_col");
u_words = (String) request.getParameter("u_word");
boolean u_col = Tool.isEmpty(request.getParameter("u_col"));
boolean u_word = Tool.isEmpty(request.getParameter("u_word")); // 만약 아무런 값을 전하지 않고 null값을 보냈다면 true를 반환시킨다.
if (u_col == true) {
	u_cols = "";
}
if (u_word == true) {
	u_words = "";
}

ArrayList<User> searchUser = userDAO.searchUser(u_cols, u_words, searchUserNumber);


%>
<!-- --------------------------헤더 영역--------------------------  -->
    
    <div class="header">
    <jsp:include page="part/header.jsp"/>
    </div>

<!-- --------------------------메뉴바 영역--------------------------  -->
    
    <div class="menu">
    <div class="menu_left"></div>
    <div class="menu_area">
    <jsp:include page="part/menu.jsp"/>
    </div>
    <div class="menu_right"></div>
    </div>

<!-- --------------------------메인페이지 영역--------------------------  -->

    <div class="main_split">
      <div class="main_left"></div>
      <!-- --------------------------실질적인 메인페이지 영역 (시작부분)--------------------------  -->
      <div class="main_area">       	
        <div class="board_split">    
        	<!-- --------------------------어드민 페이지 영역------------------- -->         	
        	<div class="page1">
        		<form method="post" name="search" action="<%= uri %>">
					<table class="table2">
						<tr>
							<td style="text-align: right;">
								<select name="u_col">
									<option value="all">전체</option>
									<option value="user_id">아이디</option>
									<option value="user_nickname">닉네임</option>
									<option value="user_name">이름</option>
								</select>
							</td>
							<td><input type="text" class="form-control"
								placeholder="검색어 입력" name="u_word" maxlength="100"></td>
							<td><input type="submit" value="검색"></td>
						</tr>
	
					</table>
				</form>
        		<table class="table1" style="margin-bottom: 20px;">
        			<colgroup>
        				<col width="60%">
        				<col width="40%">
        			</colgroup>
        			<thead>
        				<tr><td colspan="3" style="text-align: center;">유저 리스트</td></tr>
        			</thead>
        			<tbody class="tbody">
        				<tr style="text-align: center;">
							<td>번호/닉네임</td>
							<td colspan="2">아이디</td>
						</tr>
						
						
						
						
		        	<% 
						int u_list = 0; // equals을 통해서 공지사항마다 각각 값을 넣을 것임
						if ((u_cols == null) && (u_words == null)){
						ArrayList<User> list = userDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
							if(!list.get(i).getUserID().equals("YES")) {
								u_list++;
								if(u_list <= 10){
					%>
		        		<tr>
		        			<td id="main_board" class="goto text" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= list.get(i).getUserIDNum() %>'">[<%= list.get(i).getUserIDNum() %>] <%= list.get(i).getUserNickName() %></td>
		        			<td><%= list.get(i).getUserID() %></td>
		        			<td>
		        			<% if(list.get(i).getUserAvailable() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>
					<%
						}}} if(u_list <= 10) { // 만약 공지사항이 예정된 10칸보다 부족하다면
							for(int i = 0; i < 10-u_list; i++) { // 7 빼기 공지사항을 한 값만큼 반복문 실행
					%>
						<tr>
							<td>-----</td>
							<td>-----</td>
							<td id="Deleted">○</td>
						</tr>
					<!-- ---------------------------------------검색 유저 시작창---------------------------------- -->
					<% 
						}}} else if ((u_cols != null) && (u_words != null)){ // 남은 7칸을 채울 수 있도록 빈 공간을 추가 생성해주고 종료
									u_list = 0;
									for(int i = 0; i < searchUser.size(); i++) {
										if(searchUser.get(i).getUserIDNum() != 0) {
											u_list++;
											if(u_list <= 10){				
					%>
						<tr>
		        			<td id="main_board" class="goto text" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= searchUser.get(i).getUserIDNum() %>&pageMBN=<%= pageMBN %>&searchBoardNumber=<%= searchBoardNumber %>&searchUserNumber=<%= searchUserNumber %>'">[<%= searchUser.get(i).getUserIDNum() %>] <%= searchUser.get(i).getUserNickName() %></td>
		        			<td><%= searchUser.get(i).getUserID() %></td>
		        			<td>
		        			<% if(searchUser.get(i).getUserAvailable() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>
					
					<%
						}}} if(u_list <= 10) { // 만약 공지사항이 예정된 10칸보다 부족하다면
							for(int i = 0; i < 10-u_list; i++) { // 7 빼기 공지사항을 한 값만큼 반복문 실행
					%>
						<tr>
							<td>-----</td>
							<td>-----</td>
							<td id="Deleted">○</td>
						</tr>
					<% }} %>
					<tr style="height: 40px;">
						<td class="gotoPage" colspan="3" style="text-align: center;">
							<%	
							if ((u_cols == null) && (u_words == null)){
		                    	if(pageNumber != 1) {
		                    %>
		                    <input type="button" value="이전" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber - 1 %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>'">
		                    <%
		                    	} if(userDAO.nextPage(pageNumber + 1)) {
		                    %>
		                    <input type="button" value="다음" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber + 1 %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>'">
		                    <% }} else if ((b_cols != null) && (b_words != null)){ 
		                    				if(searchUserNumber != 1) {
		                    %>
		                    <input type="button" value="이전" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>&searchBoardNumber=<%= searchBoardNumber %>&searchUserNumber=<%= searchUserNumber - 1 %>'">
							<% 
								} if(userDAO.nextPage(searchUserNumber + 1)) { 
							%>
							<input type="button" value="이전" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>&searchBoardNumber=<%= searchBoardNumber %>&searchUserNumber=<%= searchUserNumber + 1 %>'">
							<% } %>
						</td>
					</tr>
					</tbody>
	        	</table>
	        	<!-- ---------------------------------------검색 유저 시작창(종료)---------------------------------- -->
	        	<form method="post" name="search" action="<%= uri %>">
					<table class="table2">
						<tr>
							<td style="text-align: right;">
								<select name="b_col">
									<option value="all">전체</option>
									<option value="user">유저</option>
									<option value="title">제목</option>
									<option value="content">내용</option>
								</select>
							</td>
							<td><input type="text" class="form-control"
								placeholder="검색어 입력" name="b_word" maxlength="100"></td>
							<td><input type="submit" value="검색"></td>
						</tr>
	
					</table>
				</form>
	        	<table class="table1">
        			<colgroup>
        				<col width="60%">
        				<col width="40%">
        			</colgroup>
        			<thead>
        				<tr><td colspan="3" style="text-align: center;">전체 게시판 리스트</td></tr>
        			</thead>
        			<tbody class="tbody">
        				<tr style="text-align: center;">
							<td>게시판/제목</td>
							<td colspan="2">아이디</td>
						</tr>
		        	<%
						commentDAO commentDAO = new commentDAO();
						int comments = 0; 
						int board = 0;
						if ((b_cols == null) && (b_words == null)){
						ArrayList<board> boardlist = boardDAO.getList2(pageBoardNumber);
						for(int i = 0; i < boardlist.size(); i++) {
							comments = commentDAO.count(boardlist.get(i).getB_id());
							if(boardlist.get(i).getB_tag().equals("자유 게시판")) {
								board += 1;
					%>
		        		<tr>
		        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= boardlist.get(i).getB_id() %>)">[자유] <%= boardlist.get(i).getB_title() %> [<%= comments %>]</td>
		        			<td><%= boardlist.get(i).getB_user() %></td>
		        			<td>
		        			<% if(boardlist.get(i).getB_available() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>
					<%
						} else if(boardlist.get(i).getB_tag().equals("질문 게시판")) {
							board += 1;
					%>	
						<tr>
		        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= boardlist.get(i).getB_id() %>)">[질문] <%= boardlist.get(i).getB_title() %> [<%= comments %>]</td>
		        			<td><%= boardlist.get(i).getB_user() %></td>
		        			<td>
		        			<% if(boardlist.get(i).getB_available() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>
						
					<%	} else if(boardlist.get(i).getB_tag().equals("직업 게시판")) {
							board += 1;
					%>
						<tr>
		        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= boardlist.get(i).getB_id() %>)">[직업] <%= boardlist.get(i).getB_title() %> [<%= comments %>]</td>
		        			<td><%= boardlist.get(i).getB_user() %></td>
		        			<td>
		        			<% if(boardlist.get(i).getB_available() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>	
					<% }else if(boardlist.get(i).getB_tag().equals("공지사항")) {continue;}} 
						if(board < 10) { // 만약 공지사항이 예정된 10칸보다 부족하다면
							for(int i = 0; i < 10 - board; i++) { // 7 빼기 공지사항을 한 값만큼 반복문 실행
					%>
						<tr>
							<td>-----</td>
							<td>-----</td>
							<td id="Deleted">○</td>
						</tr>
					<!-- ----------------------------------검색 등장창---------------------------------- -->
					<% 
						}}} else if ((b_cols != null) && (b_words != null)) {
								board = 0;
								for(int i = 0; i < searchBoard.size(); i++) {
									comments = commentDAO.count(searchBoard.get(i).getB_id());
									if(searchBoard.get(i).getB_tag().equals("자유 게시판")) { board += 1;
										if(board <= 10){
					%>
						<tr>
		        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= searchBoard.get(i).getB_id() %>)">[자유] <%= searchBoard.get(i).getB_title() %> [<%= comments %>]</td>
		        			<td><%= searchBoard.get(i).getB_user() %></td>
		        			<td>
		        			<% if(searchBoard.get(i).getB_available() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>
					
					<% }} if(searchBoard.get(i).getB_tag().equals("질문 게시판")) { board += 1; 
							if(board <= 10){%>
					
						<tr>
		        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= searchBoard.get(i).getB_id() %>)">[질문] <%= searchBoard.get(i).getB_title() %> [<%= comments %>]</td>
		        			<td><%= searchBoard.get(i).getB_user() %></td>
		        			<td>
		        			<% if(searchBoard.get(i).getB_available() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>
					
					<% }} if(searchBoard.get(i).getB_tag().equals("직업 게시판")) { board += 1; 
							if(board <= 10){%>
					
						<tr>
		        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= searchBoard.get(i).getB_id() %>)">[직업] <%= searchBoard.get(i).getB_title() %> [<%= comments %>]</td>
		        			<td><%= searchBoard.get(i).getB_user() %></td>
		        			<td>
		        			<% if(searchBoard.get(i).getB_available() == 1){ %>
		        				<div id="nonDel">●</div>
		        			<% } else { %>
		        				<div id="Deleted">●</div>
		        			<% } %>
							</td>
		        		</tr>
					
					<% }} %>
						
					<% }} //검색기능 사용했을 시 + 반복문  
						if(board < 10) { // 만약 공지사항이 예정된 10칸보다 부족하다면
							for(int i = 0; i < 10 - board; i++) { // 7 빼기 공지사항을 한 값만큼 반복문 실행
					%>
						<tr>
							<td>-----</td>
							<td>-----</td>
							<td id="Deleted">○</td>
						</tr>
					<% }} %>
					<!-- ----------------------------------검색 등장창 (종료)---------------------------------- -->
					<tr style="height: 40px;">
						<td class="gotoPage" colspan="3" style="text-align: center;">
							<% if ((b_cols == null) && (b_words == null)){
		                    	if(pageBoardNumber != 1) {
		                    %>
		                    <input type="button" value="이전" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber - 1 %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>'">
		                    <%
		                    	} if(boardDAO.nextPage(pageBoardNumber + 1)) {
		                    %>
		                    <input type="button" value="다음" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber + 1 %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>'">
		                    <% }} else if ((b_cols != null) && (b_words != null)) { 
		                    				if(searchBoardNumber != 1) {
		                    %>
		                    <input type="button" value="이전" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>&searchBoardNumber=<%= searchBoardNumber - 1 %>'">
							<% 
		                    	} if(boardDAO.nextPage(searchBoardNumber + 1)) {
							%>
							<input type="button" value="이전" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN %>&searchBoardNumber=<%= searchBoardNumber + 1 %>'">
							<% }} %>
						</td>
					</tr>
					</tbody>
	        	</table>
        	</div>
        	<div class="page2">
        	<% 
        		if(!(userIDNum < 0)){ 	
        			ArrayList<User> list = userDAO.getList(pageNumber);
	        		for(int i = 0; i < list.size(); i++) {
	        			if(list.get(i).getUserIDNum() == userIDNum){
	        				
	        %>
        		<table class="table1" style="margin-top:20px;">
        			<colgroup>
        				<col width="70%">
        				<col width="25%">
        				<col width="5%">
        			</colgroup>
        			<thead>
        				<tr>
        					<td colspan="3" style="text-align: center;">
        						<div><%= list.get(i).getUserID() %> 님의 정보</div>
        					</td>
        				</tr>
        			</thead>
        			<tbody class="tbody">
        				<tr>
        					<td colspan="3">
        						<div style="width:5%; float:left; margin-top: 5px;">
        						<% if(list.get(i).getUserAvailable() == 1){ %>
        							<div id="nonDel">●</div>
        						<% } else if(list.get(i).getUserAvailable() < 1){ %>
        							<div id="Deleted">●</div>
        						<% } %>
        						</div>
        						<div style="width:55%; float:left; margin-top: 5px; margin-bottom: 5px;">
        							아이디 : <%= list.get(i).getUserID() %><br>
        							비밀번호 : <%= list.get(i).getUserPassword() %><br>
        							닉네임 : <%= list.get(i).getUserNickName() %><br>
        							이름 : <%= list.get(i).getUserName() %><br>
        							성별 : <%= list.get(i).getUserGender() %><br>
        							이메일 : <%= list.get(i).getUserEmail() %><br>
        						</div>
        						<div style="width:160px; float:right; text-align: center;">
        						<% if(list.get(i).getUserAvailable() == 1){ %>
        							<a onclick="return confirm('정말로 비활성화 하시겠습니까?\n일반적인 접근이 불가능해집니다.')" 
        							href="user_delete.jsp?user_id_num=<%= list.get(i).getUserIDNum() %>"><input type="button" value="비활성화"></a><br>
        							<input type="button" class="btn" value="정보 변경" onclick="gotoUser(<%= list.get(i).getUserIDNum() %>)">
        						<% } else if(list.get(i).getUserAvailable() < 1){ %>
        							<a onclick="return confirm('정말로 활성화 하시겠습니까?\n일반적인 접근이 가능해집니다.')" 
        							href="user_restore.jsp?user_id_num=<%= list.get(i).getUserIDNum() %>"><input type="button" value="활성화"></a><br>
        							<input type="button" class="btn" value="정보 변경" onclick="gotoUser(<%= list.get(i).getUserIDNum() %>)">
        						<% } %>
        						</div>
        					</td>
        				</tr>
        				<tr>
        				<% 
	        				int my_list = 0;
        					int my_board = 0;
        					ArrayList<board> myboardlist = boardDAO.getList2(pageMBN);
	        				for(int n = 0; n < myboardlist.size(); n++) { 
	        					if(myboardlist.get(n).getB_user().equals(list.get(i).getUserID())){
	        						my_board ++;	
	        						if(myboardlist.get(n).getB_tag().equals("자유 게시판")) {
	        							my_list ++;	
	        							if(my_list <= 10){
						%>
							<tr>
			        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= myboardlist.get(n).getB_id() %>)"><input type="hidden" id="gotoBoard" value="<%= myboardlist.get(n).getB_id() %>">[자유] <%= myboardlist.get(n).getB_title() %></td>
			        			<td class="del">
			        			<% if(myboardlist.get(n).getB_available() == 1){ %>
			        				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="board_delete.jsp?boardID=<%= myboardlist.get(n).getB_id() %>"><input type="button" value="삭제하기"></a>
			        			<% } else { %>
			        				<a onclick="return confirm('정말로 복구하시겠습니까?')" href="board_restore.jsp?boardID=<%= myboardlist.get(n).getB_id() %>"><input type="button" value="복구하기"></a>
			        			<% } %>
			        			</td>
			        			<td>
			        			<% if(myboardlist.get(n).getB_available() == 1){ %>
			        				<div id="nonDel">●</div>
			        			<% } else { %>
			        				<div id="Deleted">●</div>
			        			<% } %>
								</td>
			        		</tr>	
							
        				<% }} if(myboardlist.get(n).getB_tag().equals("질문 게시판")) { my_list ++; 
        						if(my_list <= 10){%>
        					<tr>
			        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= myboardlist.get(n).getB_id() %>)"><input type="hidden" id="gotoBoard" value="<%= myboardlist.get(n).getB_id() %>">[질문] <%= myboardlist.get(n).getB_title() %></td>
			        			<td class="del">
			        			<% if(myboardlist.get(n).getB_available() == 1){ %>
			        				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="board_delete.jsp?boardID=<%= myboardlist.get(n).getB_id() %>"><input type="button" value="삭제하기"></a>
			        			<% } else { %>
			        				<a onclick="return confirm('정말로 복구하시겠습니까?')" href="board_restore.jsp?boardID=<%= myboardlist.get(n).getB_id() %>"><input type="button" value="복구하기"></a>
			        			<% } %>
			        			</td>
			        			<td>
			        			<% if(myboardlist.get(n).getB_available() == 1){ %>
			        				<div id="nonDel">●</div>
			        			<% } else { %>
			        				<div id="Deleted">●</div>
			        			<% } %>
								</td>
			        		</tr>	
        				<% }} if(myboardlist.get(n).getB_tag().equals("직업 게시판")) { my_list ++; 
        						if(my_list <= 10){%>	
        					<tr>
			        			<td id="main_board" class="goto text" onclick="gotoBoard(<%= myboardlist.get(n).getB_id() %>)"><input type="hidden" id="gotoBoard" value="<%= myboardlist.get(n).getB_id() %>">[직업] <%= myboardlist.get(n).getB_title() %></td>
			        			<td class="del">
			        			<% if(myboardlist.get(n).getB_available() == 1){ %>
			        				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="board_delete.jsp?boardID=<%= myboardlist.get(n).getB_id() %>"><input type="button" value="삭제하기"></a>
			        			<% } else { %>
			        				<a onclick="return confirm('정말로 복구하시겠습니까?')" href="board_restore.jsp?boardID=<%= myboardlist.get(n).getB_id() %>"><input type="button" value="복구하기"></a>
			        			<% } %>
			        			</td>
			        			<td>
			        			<% if(myboardlist.get(n).getB_available() == 1){ %>
			        				<div id="nonDel">●</div>
			        			<% } else { %>
			        				<div id="Deleted">●</div>
			        			<% } %>
								</td>
			        		</tr>	
        				<% }}}}
        					 if(my_board <= 0) { // 만약 게시물이 하나도 없다면 %> 
        					<tr><td colspan="3" style="height:40px; text-align:center;">등록된 게시물이 존재하지 않습니다.</td></tr>
        				<% } if(my_list < 10) { // 만약 게시글이 10칸보다 부족하다면
							for(int s = 0; s < 10 - my_list; s++) { // 10 빼기 공지사항을 한 값만큼 반복문 실행
								if(my_board <= 0){
									break;
								} else{
						%>
							<tr>
								<td>-----</td>
								<td>-----</td>
								<td id="Deleted">○</td>
							</tr>	
        				<% }}} %>
        				<tr style="height: 40px;">
						<td class="gotoPage" colspan="3" style="text-align: center;">
							<%
		                    	if(pageMBN != 1) {
		                    %>
		                    <input type="button" value="이전" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN - 1 %>'">
		                    <%
		                    	} if(boardDAO.nextPage(pageMBN + 1)) {
		                    %>
		                    <input type="button" value="다음" onclick="location.href= 'admin_page.jsp?pageNumber=<%= pageNumber %>&pageBoardNumber=<%= pageBoardNumber %>&user_id_num=<%= userIDNum %>&pageMBN=<%= pageMBN + 1 %>'">
		                    <% }}}}}} %>
						</td>
					</tr>
        			</tbody>
        		</table>
        	</div>
        	<!-- --------------------------어드민 페이지 영역 (종료부분)------------------- -->     	
        </div>            
      </div>
      <!-- --------------------------실질적인 메인페이지 영역 (종료부분)--------------------------  -->
      <div class="main_right"></div>
    </div>

<!-- --------------------------푸터 영역--------------------------  -->

    <div class="footer_split">
      <div class="footer_left"></div>
      
      	<div class="footer">
      	<jsp:include page="part/footer.jsp"/>
      	</div>
      
      <div class="footer_right"></div>
    </div>
<!-- ----------------------------스크립트 영역----------------------- -->
    <script type="text/javascript" src="lib/jquery-1.11.0.min.js"></script>     	
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script>	
		$(document).ready(function(){
			
		});
		function gotoBoard(boardID){
			window.open("board_view.jsp?boardID="+boardID,"",'width=700, height=1000, scrollbars=no, resizable=no, toolbars=no, menubar=no');
		}
		function gotoUser(userIDNum){
			window.open("user_view.jsp?user_id_num="+userIDNum,"",'width=410, height=240, scrollbars=no, resizable=no, toolbars=no, menubar=no');
		}
    </script>
  </body>
</html>
