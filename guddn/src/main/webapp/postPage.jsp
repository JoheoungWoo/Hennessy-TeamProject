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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 팀별과제 - 헤네시스</title>

	<style>

/****************************** 배경 영역 제어 부분임 ******************************/

      body{
        margin: 0 auto;
        background-image: url(image/bg.png);
  		background-repeat: no-repeat;
  		background-size: cover;
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

      .main_split{
        display: flex;
      }

      .main_left,.main_right{
        width: 20%;
        height: 680px;
        text-align: center;
      }

      .main_area{
        width: 60%;
        height: 680px;
        background-color: #ffeeff;
        display: flex;
      }
      
      .post_left, .post_right{
      	width: 20%;
      }

	  .post_main{
	  	width: 60%;
	  }

	  .post_notice_board{
	    height: 80px;
	    margin-top: 30px;
	    text-align: center;
	  }
	  
	  .post_writed_board{
	  	height: 450px;
	  }
	  
	  .post_num_board1{
	  	height: 30px;
		text-align: center;
	  }
	  
	  .post_num_board2{
	  	height: 50px;
	  	text-align: right;
	  	cursor: pointer;
	  }
	  
	  .pn_tb{
	  	border-collapse: collapse;
	  	width: 480px;
	  	text-align:center;
	  }
	  
	  .pn_text1{
	  	width: 80px;
	  	height: 60px;
	  	border-width: 7px;
	  	border-color: red;
	  	margin-top: 10px;
	  	margin-right: -13px;
	  	text-align: center;
	  	background-color: red;
	  	border-style: hidden;
	  	border-radius: 10px 0px 0px 10px;
	  	outline: none;
	  	font-weight: bold;
	  	color: #ffffff;
	  }
	  
	  .pn_text2{
	  	width: 400px;
	  	height: 60px;
	  	border-width: 7px;
	  	border-color: red;
	  	margin-top: 10px;
	  	margin-left: 0px;
	  	border-style: solid;
	  	border-radius: 10px 10px 10px 10px;
	  	outline: none;
	  	color: #ff0000;
	  	cursor: pointer;
	  }
	  
	  .pn_text3{
	  	width: 400px;
	  	height: 60px;
	  	border-width: 7px;
	  	border-color: red;
	  	margin-top: 10px;
	  	margin-left: 0px;
	  	border-style: solid;
	  	border-radius: 10px 10px 10px 10px;
	  	outline: none;
	  	color: #ff0000;
	  }
	  
	  .p_img{
	  	margin-top: 10px;
	  }
	  
	  .writed_tr_clicked:hover{
	  	cursor: pointer;
	  	background-color: #fff4ff;
	  }
	  
	  .writed_tb{
	  	border-collapse: collapse;
	  	width: 80%;
	  	margin-top: 10px;
	  }
	  	  
	  .writed_tb_td_a{
	  	height: 30px;
	  	width: 20px;
	  	text-align: center;
	  }
	  
	  .writed_tb_td_b{
	  	height: 30px;
	  	max-width: 230px;	
	  	overflow:hidden;
	  	text-overflow:ellipsis;
	  	-webkit-line-clamp:1;
	  	-webkit-bos-orient:vertical;
	  	white-space:nowrap;
	  }
	  
	  .writed_tb_td_c{
	  	height: 30px;
	  	width: 30px;
	  	text-align: center;
	  }
/****************************** 푸터 영역 제어 부분임 ******************************/

      .footer_split{
        display: flex;
      }

      .footer_left,.footer_right{
        width: 20%;
        height: 90px;
      }

      .footer{
        width: 60%;
        height: 90px;
      }

    </style>
</head>
<body>
<!-- --------------------------스크립트릿 선언 영역--------------------------  -->
<%
	boardDAO boardDAO = new boardDAO();
	ArrayList<board> list = boardDAO.getNotice();
	
	int cnt = boardDAO.boardcount(); // DB로부터 자유 게시판의 총 갯수를 카운트한다. (tag, available 조건 붙음)
	
	
	int pageSize = 10; // 한 페이지에 출력되는 게시글 수
	String pageNum = request.getParameter("page"); // ?page=n 으로부터 값을 받아옴
	if(pageNum == null){ // 만약에 처음 들어올 때 page값이 null 상태라면
		pageNum = "1"; // 첫페이지 1 값을 부여해준다
	}
	
	int currentPage = Integer.parseInt(pageNum); // page에 값을 받아온 뒤, currnet에 정수형태로 전달한다.
	int startRow = (currentPage-1)*pageSize+1;  // (현재 페이지 - 1) * 페이지당 게시글 갯수 + 1
												// ex 2페이지, 10개 ) ((2 - 1) * 10) + 1 = 11번째 게시글부터 표시
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
        
        <div class="post_left"></div>
        <div class="post_main">
        	
        	<div class="post_notice_board">
        		<table class="pn_tb" align=center><tr>
        		<td><input type="text" class="pn_text1" value="공지" readonly></td>
        		<% 
        			if (list.size() > 0) { // 만약 공지사항이 0개가 아니라면 혹은 그것보다 크다면
        				for(int i = 0; i < 1; i++) {        				
        		%>
        		<td><input type="text" name="first_notice" class="pn_text2" 
        		value="[<%= list.get(i).getB_id() %>] <%= list.get(i).getB_title() %>" 
        		onclick="location.href = 'rmf.jsp?boardID=<%= list.get(i).getB_id() %>'" readonly></td>
        		<% 
        			} } else {
        		%>
        		<td><input type="text" name="first_notice" class="pn_text3" value="아직 등록되지 않았습니다."></td>
        		<% } %>
        		</tr></table>
        	</div>
        	
        	<div class="post_writed_board">
        		<img src="image/board2.png" class="p_img">
        		<table class="writed_tb" border=3 align=center >
        		
        		<thead style="height:40px;">
        			<tr>
	        		<td class="writed_tb_td_a"><b>번호</b></td>
	        		<td class="writed_tb_td_b"><b>제목</b></td>
	        		<td class="writed_tb_td_c"><b>작성자</b></td>
	        		</tr>
        		</thead>

        		<tbody>
        		<%
				if(cnt != 0){ // 만약 자유 게시판이 0 이상 존재한다면
					int pageCount = (int)(Math.ceil((double)cnt/pageSize)); // 표시될 페이지 값이면서도 끝페이지 값 (ceil = 반올림)
					
					int pageBlock = 10; // 10개의 페이지가 표시되도록 하고
					
					int startPage = ((currentPage-1)/pageBlock)*pageBlock+1; // ex 11페이지부터, pageBlock = 10) ((11-1) / 10) * 10 + 1 = 11
																			// 시작 페이지 값을 구하고
					int endPage = startPage + pageBlock-1; // 마지막 페이지를 구한다
					
					if(endPage > pageCount){ // 만약 마지막 페이지가 끝페이지보다 크다면
						endPage = pageCount; // 마지막 페이지를 끝페이지로 저장한다.
					}
				
				%>
        		<% 
        			ArrayList<board> boardList = boardDAO.getBoardList2(startRow, pageSize); // DAO에다 현재 페이지 수와 표시될 게시글 수를 전달
        			for(int i = 0; i < boardList.size(); i++) {
        		%>
        			<tr style="height:30px;" class="writed_tr_clicked" onclick="location.href = 'rmf.jsp?boardID=<%= boardList.get(i).getB_id() %>'">
	        		<td class="writed_tb_td_a"><%= boardList.get(i).getB_id() %></td>
	        		<td class="writed_tb_td_b"><%= boardList.get(i).getB_title() %></td>
	        		<td class="writed_tb_td_c"><%= boardList.get(i).getB_user() %></td>
	        		</tr>
	        	<% } %>
        		</tbody>        		

        		</table>
        	</div>
        	
        	<div class="post_num_board1">
        	<% if(startPage>pageBlock){ // 만약 현재 페이지가 10(pageBlock)보다 큰 상태라면... %>
        		<a href="postPage.jsp?page=<%=startPage-pageBlock%>">< prev</a>
        	<% } for(int i=startPage;i<=endPage;i++){ // 현재 페이지부터 시작해서 마지막 페이지까지 반복적으로 표시한다 %>
        		<a href="postPage.jsp?page=<%=i%>"><%= i %></a>
        	<% } if(endPage<pageCount){ // 만약 현재 마지막페이지가 끝페이지보다 작다면... %>
        		<a href="postPage.jsp?page=<%=startPage+pageBlock%>">next ></a>
        	<% }} %>
        	</div>
        	
        	<div class="post_num_board2">
        		<button type="button" name="write" onclick="location.href='writePage.jsp'"><img src="image/but07.png"></button>
        	</div>
        
        </div>
        <div class="post_right"></div>
        
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

</body>
</html>