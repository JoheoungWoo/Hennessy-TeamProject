<%@ page contentType = "text/html; charset=utf-8" %>
<html>
  <head>
    <meta charset="utf-8">
    <title>menu</title>
    <style>

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
      
      .logo_area{
      	width: 25%;
      	margin-top: 10px;
      }
      
      .space_area{
      	width: 45%;
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
      }
      
      .s_button{
      	width: 45x;
      	height: 45px;
      }
   
    </style>
  </head>
  <body>
  <form>
    
      <div class="menubar">
      	
      	<div class="logo_area"><img src="image/logo.png"></div>
      	
      	<div class="space_area"></div>
      	
      	<div class="search_area">
      		<input type="search" name="s_box" class="s_box" placeholder="검색어를 입력해주세요.">
      		<button type="submit" name="s_button" class="s_button"><img src="image/s_button.png"></button>
      	</div>
      	
	  </div>
    
    </form>
  </body>
</html>
