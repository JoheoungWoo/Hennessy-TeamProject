<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import="guddn.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<html>
  <head>
    <meta charset="utf-8">
    <title>header</title>
    <style>  
      button{
  		background-color:transparent;
   		border : 0;
   		outline : 0;
   		padding-top : 5px;
	  }
	  
	  button[type="submit"],button[onclick] {
	  	cursor: pointer;
	  }

	  .input {
	  	height: 20px;
	  	padding-top: 5px;	  	
	  }
	  
	  .msg {
	  	padding-top: 9px;
	  	padding-right: 9px;
	  }

	  .super{
	  	display: flex;
	  }

	  .header1{
	  	width: 30%;
	  	background-color: #eeeeee;
	  	display: flex;
	  }

      .header2{
        width: 70%;
        height: 40px;
        text-align: right;
        background-color: #eeeeee;
        display: flex;
        justify-content: flex-end;
      }
      
      .account{
      	display : flex;
      }
       
      .join, .logout{
      	margin-right: 20px;
      }
       
      .table{
      	font-size: 12px;
      }
    </style>
  </head>
  <body>  
	<% 
		UserDAO user = new UserDAO();
		String userID = null; 
		String isAdmin = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			isAdmin = (String) session.getAttribute("isAdmin");
		} // 세션 영역에 userID가 존재한다면 값을 불러와 저장함 + userID 를 rankUp에 보내서 특정 exp에 도달하면 레벨 업을 시켜줌
	%>
	<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		String myInf = "SELECT user_nickname, user_email, user_rank, user_exp, user_point FROM user_table WHERE user_id = ?";
		String userNickName = null;
		String userEmail = null;		
		int userRank = 0;
		int userExp = 0;
		int userPoint = 0;
			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
				try {
					String URL = "jdbc:mysql://localhost:3306/game_schema";
					String ID = "root";
					String Password = "1234";
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(URL, ID, Password);
					pstmt = conn.prepareStatement(myInf);
					pstmt.setString(1, userID);
					rs = pstmt.executeQuery();
					while(rs.next()){  				
						userNickName = (String) rs.getString(1);
						userEmail = (String) rs.getString(2);
						userRank = (int) rs.getInt(3);
						userExp = (int) rs.getInt(4);
						userPoint = (int) rs.getInt(5);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			  	
			} // DB를 불러오고 세선 영역에 저장된 userID를 끌고와서 정보를 조회시킴
	%>
	<%
		int result = user.rankUp(userID);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('축하드립니다! 레벨 업을 하셨습니다!')");
			script.println("location.reload(true);");
			script.println("</script>");
		}
	%>
	<div class="super" id="app">
	
		<div class="header1">
			<img src="image/jeiu.png">
			<table class="table"><tr><td><b>재능대학교 인공지능 컴퓨터정보과&nbsp;<% if(isAdmin == "YES"){ %>[관리자 모드]<% } %></b></td></tr></table>    
    	</div>
    	
	    <div class="header2">
	    <% if(userID == null){ %>
	    	<form method="post" action="loginAction.jsp">
				<div class="account">
					<div class="input">
						ID <input type="text" name="userID" placeholder="아이디 입력">
			    		PS <input type="password" name="userPassword" placeholder="비밀번호 입력">
					</div>
			    	<button type="submit" name="login" class="login"><img src="image/but01.png"></button>
			    	<button type="button" name="join" class="join" onclick="location.href = 'joinPage.jsp'"><img src="image/but02.png"></button>
			    </div>
		    </form>
	    <% } else { %>
	    	<div class="msg">
	    		<%= userNickName %> 님 환영합니다!
	    	</div>
	    	<button type="button" name="userPage" class="userPage" onclick="location.href = '<% if(isAdmin == "YES"){ %>admin_page.jsp<% }else{ %>userPage.jsp<% } %>'"><img src="image/but06.png"></button>
	    	<button type="button" name="logout" class="logout" onclick="location.href = 'logoutAction.jsp'"><img src="image/but05.png"></button>
	    <% } %>
	    </div>
    
    </div>
  </body>
</html>
