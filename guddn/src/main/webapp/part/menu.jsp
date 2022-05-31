<%@ page contentType = "text/html; charset=utf-8" %>
<html>
  <head>
    <meta charset="utf-8">
    <title>menu</title>
    <style>
		@font-face {
	      	font-family: 'baemin';
	      	src: url('lib/BMJUA_ttf.ttf')
      	}
      .menubar{
	    width: 100%;
	    height: 80px;
	    display: flex;
      }
       
      button{
  		background-color:transparent;
   		border : 0;
   		outline : 0;
	  }
	  
	  div[class="logo_area"]{
	  	cursor: pointer;
	  }
      
      .logo_area{
      	width: 25%;
      	margin-top: 10px;
      }
      
      .space_area{
      	width: 45%;
      	margin-left:60px;
      	margin-top:30px;
      }
     
      .search_area{
      	width: 30%;
      	display: flex;
      	margin-top: 18px;
		justify-content: flex-end;
      }
      
      .s_box{
      	width: 300px;
      	height: 45px;
      	border-radius: 10px 10px 10px 10px;
      	border-color: #ff0000;
		border-width: 7px;
		border-style: solid;
      }
      
      .s_button{
      	width: 45x;
      	height: 45px;
      }
      
      .menuClick{
      	cursor: pointer;
      	font-family: 'baemin';
      	font-size: 24px;
      	color: white;
      }
    </style>
  </head>
  <body>
  <%
  	String path=request.getContextPath();
  %>
	<form method="get" action="board_search.jsp">
    
	      <div class="menubar">
	      	
	      	<div class="logo_area" onclick="location.href = 'mainPage.jsp'"><img src="image/logo.png"></div>
	      	
	      	<div class="space_area">
	      		<div class="menuClick" onclick="location.href='<%= path %>/postPage.jsp'">자유 게시판</div>
	      	</div>
	      	
	      	<div class="search_area">
	      		<input type="search" name="s_box" class="s_box" placeholder="검색어를 입력해주세요.">
	      		<button type="submit" class="s_button"><img src="image/s_button.png"></button>
	      	</div>
	      	
		  </div>
    
	</form>
  </body>
</html>
