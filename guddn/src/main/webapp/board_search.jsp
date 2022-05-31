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
 
	  .board_split{
	  	display: flex;
	  }

	  .page{
	  	width: 100%;
	  	height: 760px;
	  	background-color: #ffeeff;
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
	boardDAO boardDAO = new boardDAO();
	
	int cnt = boardDAO.boardcount();
	
	
	int pageSize = 10; // 한 페이지에 출력되는 게시글 수
	String pageNum = request.getParameter("page");
	if(pageNum == null){
		pageNum = "1";
	}
	
	ArrayList<board> list = boardDAO.getNotice();
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
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
        	<div class="page">
        	
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
  </body>
</html>
