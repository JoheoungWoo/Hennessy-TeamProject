<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import="guddn.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 팀별과제 - 헤네시스</title>

	<style>

/****************************** 배경 영역 제어 부분임 ******************************/

      body{
        margin: 0px;
        background-image: url(image/bg.png);
  		background-repeat: no-repeat;
  		background-size: 2000px 1000px;
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
        background-color: #ffeeff;
        display: flex;
      }
      
       .my_left,.my_right{
      	width: 20%;
      }

	   .my_main{
	   	width: 60%;
	   }
	   
	   .my_address_tb{
	   	width: 600px;
	   	height: 300px;
	   	border-collapse: collapse;
	   }
	   
	   .my_address_tb_td1{
	   	width: 370px;
	   	height: 50px;
	   	text-align: right;
	   }
	   
	   .my_address_tb_td2{
	   	width: 230px;
	   	height: 50px;
	   	text-align: center;
	   }
	   
	   .my_address_tb2{
	   	 width: 600px;
	   	 height: 50px;
	   	 margin-top: 20px;
	   	 border-collapse: collapse;
	   }
	   
	   .m_text{
	  	 width: 250px;
	  	 height: 35px;
	  	 border-width: 3px;
	  	 border-radius: 5px 5px 5px 5px;
	   }
	  	
	   .myad_btn{
	  	 width: 130px;
	  	 height: 35px;
	  	 background-color: #cccccc;
	  	 font-weight: bold;
	   }
	   
	  .myad_tb_td_a{
	  	height: 40px;
	  	width: 20px;
	  	text-align: center;
	  }
	  
	  .myad_tb_td_b{
	  	height: 40px;
	  	width: 100px;
	  	text-align: center;
	  }
	  
	  .myad_tb_td_c{
	  	height: 40px;
	  	width: 30px;
	  	text-align: center;
	  }
	  
	   .my_address_tb3{
	   	 width: 600px;
	   	 height: 50px;
	   	 border-collapse: collapse;
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
<% 
		UserDAO user = new UserDAO();
		String userID = null; 
		String isAdmin = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			isAdmin = (String) session.getAttribute("isAdmin");
		} // 세션 영역에 userID가 존재한다면 값을 불러와 저장함 + userID 를 rankUp에 보내서 특정 exp에 도달하면 레벨 업을 시켜줌
		
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'mainPage.jsp'");
			script.println("</script>");
		}
	%>
	<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		String myInf = "SELECT user_nickname, user_email, user_rank, user_exp, user_point,user_pw FROM user_table WHERE user_id = ?";
		String myInf2 = "SELECT board_id,board_title,board_user FROM board_table WHERE board_user = ? LIMIT 7";
		String userNickName = null;
		String userEmail = null;	
		String userPassword = null;
		//추가
		String userBid = null;
		String userBtitle = null;
		String userBuser = null;
		String bNum[] = new String[7];
		String bTitle[] = new String[7];
		String bId[] = new String[7];
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
						userPassword = (String) rs.getString(6);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				try {
					int i = 0;
					pstmt = conn.prepareStatement(myInf2);
					pstmt.setString(1, userID);
					rs = pstmt.executeQuery();
					while(rs.next()){  			
						userBid = (String)rs.getString(1);
						userBtitle = (String)rs.getString(2);
						userBuser = (String)rs.getString(3);
						bNum[i] = null;
						bTitle[i] = null;
						bId[i] = null;						
						bNum[i] = userBid;
						bTitle[i] = userBtitle;
						bId[i] = userBuser;
						i++;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			  	
			} // DB를 불러오고 세선 영역에 저장된 userID를 끌고와서 정보를 조회시킴
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
        <div class="my_left"></div>
        <div class="my_main">
        
        <table class="my_address_tb2" align=center><tr><td><h2>마이페이지</h2></td></tr></table>
        <form action="userAction.jsp">
        
        <table class="my_address_tb" border=3 align=center rules=none>
        
        <tr>
        <td class="my_address_tb_td1">아이디 <input type="text" name=selectId class="m_text" value="<%=userID %>" readonly></td>
        <td class="my_address_tb_td2"></td>
        </tr>
        
        <tr>
        <td class="my_address_tb_td1">비밀번호 <input type="password" name=selectPw class="m_text" value="<%=userPassword %>" placeholder="기존 비밀번호 표시"></td>
        <td class="my_address_tb_td2"><button type="submit" class="myad_btn">비밀번호 변경하기</button></td>
        </tr>
        
        <tr>
        <td class="my_address_tb_td1">닉네임 <input type="text" name=selectNn class="m_text" value="<%=userNickName %>" placeholder="기존 닉네임 표시"></td>
        <td class="my_address_tb_td2"><button type="submit" class="myad_btn">닉네임 변경하기</button></td>
        </tr>
        
        <tr>
        <td class="my_address_tb_td1">이메일 <input type="text" name=selectEm class="m_text" value="<%= userEmail%>"readonly></td>
        <td class="my_address_tb_td2"></td>
        </tr>

        <tr>
        <td class="my_address_tb_td1"></td><input type="hidden" name="stauts" value="1">
        <td class="my_address_tb_td2"><input type="button" class="myad_btn" onClick="bye()" value="회원탈퇴2"></td>
        </tr>
        </form>
        </table>
        
        <table class="my_address_tb2" align=center><tr><td><h2>내가 쓴 글</h2></td></tr></table>
        
        <table class="my_address_tb3" border=3 align=center>
        
        <tr>
        <td class="myad_tb_td_a"><b>번호</b></td>
		<td class="myad_tb_td_b"><b>제목</b></td>
		<td class="myad_tb_td_c"><b>작성자</b></td>
		</tr>
		
		<tr onclick="test(<%=bNum[5]%>)">
        <td class="myad_tb_td_a"><%=bNum[5] %></td>
		<td class="myad_tb_td_b"><%=bTitle[5] %></td>
		<td class="myad_tb_td_c"><%=bId[5] %></td>
		</tr>
		
		<tr onclick="test(<%=bNum[4]%>)">
        <td class="myad_tb_td_a"><%=bNum[4] %></td>
		<td class="myad_tb_td_b"><%=bTitle[4] %></td>
		<td class="myad_tb_td_c"><%=bId[4] %></td>
		</tr>
		
		<tr onclick="test(<%=bNum[3]%>)">
        <td class="myad_tb_td_a"><%=bNum[3] %></td>
		<td class="myad_tb_td_b"><%=bTitle[3] %></td>
		<td class="myad_tb_td_c"><%=bId[3] %></td>
		</tr>
		
		<tr onclick="test(<%=bNum[2]%>)">
        <td class="myad_tb_td_a"><%=bNum[2] %></td>
		<td class="myad_tb_td_b"><%=bTitle[2] %></td>
		<td class="myad_tb_td_c"><%=bId[2] %></td>
		</tr>
		
		<tr onclick="test(<%=bNum[1]%>)">
        <td class="myad_tb_td_a"><%=bNum[1] %></td>
		<td class="myad_tb_td_b"><%=bTitle[1] %></td>
		<td class="myad_tb_td_c"><%=bId[1] %></td>
		</tr>
		
		<tr onclick="test(<%=bNum[0]%>)">
         <td class="myad_tb_td_a"><%=bNum[0] %></td>
		<td class="myad_tb_td_b"><%=bTitle[0] %></td>
		<td class="myad_tb_td_c"><%=bId[0] %></td>
		</tr>
		
        </table>
        
        </div>
        
        <div class="my_right"></div>
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
<script>
function test(bnum) {
	location.href="rmf.jsp?boardID="+bnum;
}
function bye() {
	confirm("정말로 삭제하시겠습니까?")
	return location.href="userAction.jsp?stauts=2&=<%=userID%>";
	//location.href="naver.com";
}
</script>
</body>
</html>