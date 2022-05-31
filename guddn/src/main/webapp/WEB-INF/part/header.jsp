<%@ page contentType = "text/html; charset=utf-8" %>
<html>
  <head>
    <meta charset="utf-8">
    <title>header</title>
    <style>
    
      button{
  		background-color:transparent;
   		border : 0;
   		outline : 0;
	  }

	  .super{
	  	display: flex;
	  }

	  .header1{
	  	width: 20%;
	  	background-color: #eeeeee;
	  	display: flex;
	  }

      .header2{
        width: 80%;
        height: 40px;
        text-align: right;
        background-color: #eeeeee;
        display: flex;
        justify-content: flex-end;
      }
      
      .account{
      	margin-top: 8px;
      }
       
      .join{
      	margin-right: 20px;
      }
       
      .table{
      	font-size: 12px;
      }
      
    </style>
  </head>
  <body>
  <form>
    
    <div class="super">
    
    <div class="header1">
		<img src="image/jeiu.png">
		<table class="table"><tr><td><b>재능대학교 인공지능 컴퓨터정보과</b></td></tr></table>    
    </div>
    
    <div class="header2">
      
      <div class="account">
      ID <input type="text" name="id" placeholder="아이디 입력zz">
      PS <input type="password" name="password" placeholder="비밀번호 입력">
      </div>
      
      <button type="submit" name="login" class="login"><img src="image/but01.png"></button>
      <button type="button" name="join" class="join"><a href="joinPage.jsp"><img src="image/but02.png"></a></button>
    </div>
    
    </div>
    
  </form>
  </body>
</html>
