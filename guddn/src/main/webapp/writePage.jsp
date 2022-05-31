<%@ page contentType = "text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="guddn.Tool" %>
<%@ page import="guddn.board" %>
<%@ page import="guddn.boardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<head >
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
        height: 720px;
        text-align: center;
      }

      .main_area{
        width: 60%;
        height: 720px;
        background-color: #ffeeff;
        display: flex;
        margin: 0 auto;
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
	  }
	  
	  .p_img{
	  	margin-top: 10px;
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
	  	width: 100px;
	  	text-align: center;
	  }
	  
	  .writed_tb_td_c{
	  	height: 30px;
	  	width: 30px;
	  	text-align: center;
	  }
	  
	  #board_tag{
	  	margin-bottom: 10px;
	  }
	  
	  #board_title{
	  	margin-bottom: 10px;
	  }
	  
	  #board_area{
	  	width: 100%;
	  	margin: 50px;
	  }
	  
	  #board_send{
	  	margin-top:10px;
	  }
	  
	  body[class="se2_inputarea"]{
	  	background-color:#ffffff;
	  }
	  
	  input[name="b_title"]{
	  	margin: 0 auto;
	  	border-radius: 10px;
	  	width: 100%;
	  	height: 40px;
	  	font-weight: 400;
	  	font-size: 12px;
	  }
	  
	  select[name="b_tag"]{
	  	width:100%;
	  	height:40px;
	  	font-size:18px;
	  	font-weight:500;
	  }
	  
	  button[id="savebutton"]{
	  	cursor: pointer;
	  	float: right;
	  }
	  
	  input[type="submit"]{
	  	background-image: url('image/but07.png');
	  	background-position:top right; 
		background-repeat:no-repeat;
		width: 90px;
		height: 30px;
	  	float:right;
	  	margin: 0 auto;
	  }
	  
	  input[type="file"]{
	  	background-color:white;
	  	border: 1px solid black;
	  	padding:5px;
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
    <link rel="apple-touch-icon-precomposed" href="favicon.ico">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/favicon.ico" type="image/x-icon">
    <script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
<!-- --------------------------스크립트릿 선언 영역--------------------------  -->
<% 
String userID = null; 
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID"); } // 세션 영역에 userID가 존재한다면 값을 불러와 저장함
%>
<%
if (userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 해주세요.')");
	script.println("location.href = 'mainPage.jsp'");
	script.println("</script>");
} // 만약에 userID 가 null이 아닌 아이디로 저장이 되어있다면 해당 페이지에서 쫓아냄
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
		<div id="board_area" class="jsx-2303464893 editor">
			<form method="post" action="boardAction.jsp" enctype="multipart/form-data">
				<div id="board_tag">
					<select name="b_tag" id="selected">
						<option value="">-----</option>
						<option value="자유 게시판">자유 게시판</option>
						<option value="질문 게시판">질문 게시판</option>
						<option value="직업 게시판">직업 게시판</option>
					</select>
				</div>
				<div id="board_title"><input type="text" name="b_title" id="title" placeholder="제목을 입력해 주세요."></div>
				<div class="fr-box fr-basic fr-top" role="application" style="background-color:white;">
					<div class="fr-wrapper show-placeholder" dir="auto" style="overflow: scroll;">
						<textarea name="b_content" id="smartEditor"
							style="width:100%; height: 412px; "></textarea>
					</div>
				</div>
				<div><input type="file" name="b_file"></div>
				<div id="b_send">
					<button id="savebutton" name="b_send"><img src="image/but07.png"></button>
				</div>
			</form>
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
    <script type="text/javascript">
	    
    </script>

</body>
</html>

<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	oAppRef : oEditors,
	elPlaceHolder : "smartEditor", //저는 textarea의 id와 똑같이 적어줬습니다.
	sSkinURI : "se2/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
	fCreator : "createSEditor2",
	htParams : {
		// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseToolbar : true,

		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : false,

		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : false
		}
	});
	$("#savebutton").click(function(){ // 내용 보내는 스크립트임, 절대 수정 금지
		oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#savebutton").submit();
	})
</script>