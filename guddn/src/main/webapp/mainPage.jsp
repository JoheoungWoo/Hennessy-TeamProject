<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import="guddn.board" %>
<%@ page import="guddn.boardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<html>
  <head>
    <meta charset="utf-8">
    <title>JSP 팀별과제 - 헤네시스</title>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <style>

/****************************** 슬라이드 패널 제어 부분임 ******************************/

	   .post-slider .post-wrapper{
  		  margin:0px auto;
  		  border:1px ;
	   }
		
		.post-slider .post-wrapper .post{
  		  display:inline-block;
  		  background:gray;
	   }
	   	   
		.post-slider{
  		  width: 100%;
          height: 400px;
	   }
	   
		.img{
  		  width: 912px;
  		  height: 320px;
	   }
	   
	   .post{
	   	height: 320px;
	   }

		.slick-dots{
 		  width: 300px;
  		  margin: 0 auto;
	   }
	   
		.slick-dots li{
		  list-style: none;
 		  float:left;
	   }
	   
		.slick-dots li button {
    	  background-color: Transparent;
    	  background-repeat:no-repeat;
    	  border: none;
    	  cursor:pointer;
    	  overflow: hidden;
	   }

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
        height: 760px;
      }
      
      .slide{
      	height: 320px;
      	background-color: #ef00fe;
      }

	  .board_split{
	  	display: flex;
	  }

	  .board1{
	  	width: 50%;
	  	height: 440px;
	  	background-color: #ffeeff;
	  }
	  
	  .board2{
	  	width: 50%;
	  	height: 440px;
	  	background-color: #ffeeff;
	  }

	  .board1_tb{
	  	width: 90%;
	  	height: 300px;
	  	margin-left: 20px;
	  	border-collapse: collapse;
	  }
	  
	  .board2_tb{
	  	width: 90%;
	  	height: 300px;
	  	margin-left: 20px;
	  	border-collapse: collapse;
	  }
	  
	  #main_board{
	  	color: red;
	  }
	  
	  .goto{
	  	cursor: pointer;
	  }
	  
	  .text{
	  	max-width: 370px;
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
	int pageNumber = 1;
	if (request.getParameter("page") != null) {
		pageNumber = Integer.parseInt(request.getParameter("page"));
	}
	int boardID = 0;
	if (request.getParameter("boardID") != null) {
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
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
         
        <!-- --------------------------슬라이드 영역 (시작부분)--------------------------  -->
        <div class="slide">
        	
        	<script src="lib/jquery-1.11.0.min.js"></script>     	
        	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
        	
        	<div class="post-slider">
        		<div class="post-wrapper">
          			<div class="post"><a href="https://maplestory.nexon.com/Home/Main?utm_source=naver&utm_medium=search&utm_campaign=19th2nd&utm_content=pcbrand_home"><img src="image/slide01.png" class="img"></a></div>
          			<div class="post"><a href="https://maplestory.nexon.com/Home/Main?utm_source=naver&utm_medium=search&utm_campaign=19th2nd&utm_content=pcbrand_home"><img src="image/slide02.png" class="img"></a></div>
          			<div class="post"><a href="https://maplestory.nexon.com/Home/Main?utm_source=naver&utm_medium=search&utm_campaign=19th2nd&utm_content=pcbrand_home"><img src="image/slide03.png" class="img"></a></div>
        		</div>
			</div>
        
        	<script>
				$('.post-wrapper').slick({
				dots: false,
				arrow: true,
				slidesToShow: 1,
  				slidesToScroll: 1,
  				autoplay: true,
  				autoplaySpeed: 4000,
  				prevArrow: $('.prev'),
  			  	nextArrow: $('.next')
				});
			</script>
        
        </div>
        <!-- --------------------------슬라이드 영역 (종료부분)--------------------------  -->
            	
        <div class="board_split">    
        	<!-- --------------------------공지사항 영역------------------- -->         	
        	<div class="board1">
        	<img src="image/board1.png">
        	<table class="board1_tb" border="1">
        	<% 
				boardDAO boardDAO = new boardDAO(); // 리스트를 불러오는 객체를 사용하기 위해 DAO를 호출
				int comments = 0; // 댓글 갯수를 카운트하는 변수이나 아직 미구현
				int m_board = 0; // equals을 통해서 공지사항마다 각각 값을 넣을 것임
				int a_board = 0; // (자유 게시판) 마찬가지
				ArrayList<board> list = boardDAO.getList(pageNumber);
				ArrayList<board> noticeList = boardDAO.getNotice();
				ArrayList<board> postList = boardDAO.getPost();
				if (noticeList.size() > 0){
					for(int i = 0; i < noticeList.size(); i++) {
						m_board++;
						if(m_board <= 7){
			%>
        		<tr><td id="main_board" class="goto text" onclick="location.href='rmf.jsp?boardID=<%= noticeList.get(i).getB_id() %>'">[공지사항] <%= noticeList.get(i).getB_title() %></td></tr>
			<%
				}}} if(m_board < 7) { // 만약 공지사항이 예정된 7칸보다 부족하다면
					for(int i = 0; i < 7-m_board; i++) { // 7 빼기 공지사항을 한 값만큼 반복문 실행
			%>
				<tr><td>빈 공간 [<%= i+1 %>]</td></tr>
			<% 
				}} // 남은 7칸을 채울 수 있도록 빈 공간을 추가 생성해주고 종료
			%>
        	</table>
        	</div>
        	<!-- --------------------------공지사항 영역 (종료부분)------------------- -->     	
        	
			<!-- --------------------------자유 게시판 영역------------------- -->     	
        	<div class="board2">
        	<img src="image/board2.png">
        	<table class="board2_tb" border="1">
			<%
				if (postList.size() > 0){
					for(int n = 0; n < postList.size(); n++) {
						a_board++;
						if(a_board <= 7){
			%>
        		<tr><td class="goto text" onclick="location.href='rmf.jsp?boardID=<%= postList.get(n).getB_id() %>'">[자유] <%= postList.get(n).getB_title() %></td></tr>
			<%
				}}} if(a_board < 7) { // 만약 자유게시판이 예정된 7칸보다 부족하다면
					for(int n = 0; n < 7 - postList.size(); n++) {
			%>
				<tr><td>빈 공간 [<%= n+1 %>]</td></tr>
			<% 
				}}
			%> 
			
        	</table>
        	</div>
        	<!-- --------------------------자유 게시판 영역 (종료부분)------------------- -->     	
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
  </body>
</html>
