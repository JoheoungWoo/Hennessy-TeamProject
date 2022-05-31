<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import="java.io.PrintWriter" %>
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
        height: 900px;
        background-color: #ffeeff;
        text-align: center;
      }
      
      .textarea{
      	width: 500px;
      	height: 250px;
      	resize: none;
      	outline: none;
      	border-width: 3px;
      }

	  .cb{
	  	width: 30px;
	  	height: 30px;
	  	margin-top: 10px;
	  }

	  .check{
	  	height: 50px;
	  	display: flex;
	  	justify-content: center;
	  }
	  
	  .ac_tb{
	  	height: 270px;
	  	display: flex;
	  	justify-content: center;
	  }
	  
	  .account_table{
	  	width: 500px;
	  	height: 270px;
	  	border-collapse: collapse;
	  	text-align: right;
	  }
	  
	  .ac_tb_td{
	  	height:45px;
	  	width: 350px;
	  }
	  
	  .ac_tb_td2{
	  	height:45px;
	  	width: 150px;
	  }
	  
	  .ac_tb_td3{
	  	height:45px;
	  	width: 150px;
	  	text-align: center;
	  }
	  
	  .select_btn{
	  	text-align: center;
	  }
	  
	  .j_text{
	  	width: 250px;
	  	height: 35px;
	  	border-width: 3px;
	  	border-radius: 5px 5px 5px 5px;
	  }
	  
	  .overlab_img{
	  	margin-right: 30px;
	  	cursor: pointer;
	  }
	  
	  label{
	  	height: 50px;
	  	padding-right: 5px;
	  	padding-left: 5px;
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
/******************************* 한영키 변경 제어 부분 ******************************/
	.not-kor {
		-webkit-ime-mode: disabled;
		-moz-ime-mode: disabled;
		-ms-ime-mode: disabled;
		ime-mode: disabled;
	}
    </style>
</head>
<body>
<!-- -------------------------시스템 영역-------------------------- -->
<% 
	String userID = null; 
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID"); } // 세션 영역에 userID가 존재한다면 값을 불러와 저장함
%>
<%
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
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
        
        <br>
        <h2>이용 약관</h2>
        
        <textarea readonly class="textarea">
        
        1.경고
        
        메이플스토리 디렉터 강원기는 지금 당장 극성비를 뿌려라!
        하루도 빠짐없이 일퀘를 해야 하는 이 미친 시스템에서 벗
        어나고 싶습니다. 차라리 시스템 개편을 하지 않을 거면
        사료라도 많이 뿌려주길 바랍니다. 밸패도 너무 못해서 퓨
        어 딜러들이 서포터인 비숍보다도 딜이 안나오는 상황입니
        다. 그럼에도 불구하고 이 게임을 하시겠습니까?
        
        2. 약관
        
        해당 사이트는 메이플스토리를 플레이하는 유저들간의 커뮤니
        티입니다. 게임이 망겜인건 다들 알고 가입하는것인지? 인지
        하시고 있다면 반드시 약관 동의를 눌러주기 바랍니다. 또한
        이 게임과 커뮤니티를 하면서 만나는 골수 방구석 커뮤넷찐들
        로 인한 정신적 피해는 본 사이트에서 보상해주지 않습니다.
        </textarea>
        
		<div class="check">
		<input type="checkbox" class="cb terms" id="terms" required>
		<table><tr><td>해당 약관에 동의합니다</td></tr></table>
		</div> 
      
      	<h2>회원 정보 입력</h2>
      	<div class="ac_tb">
      	<form method="post" action="joinAction.jsp" name="join">
      	<table class="account_table" border=3 rules="none">
      		<tr><td class="ac_tb_td"></td><td class="ac_tb_td2"></td></tr>
      		<tr>	
      			<td class="ac_tb_td">아이디  <input type="text" name="userID" id="userID" class="j_text not-kor" placeholder="아이디를 입력해주세요." onkeydown="inputID()"  required></td>
      			<td class="ac_tb_td2">
      				<button type="button" name="id_overlab" id="idCheck"><img src="image/but03.png" class="overlab_img"></button>
      				<button type="hidden" name="idDuplication" value="idUnCheck"></button>
      			</td>
      		</tr>
      		
      		<tr>
      			<td class="ac_tb_td">비밀번호 <input type="password" name="userPassword" class="j_text" placeholder="비밀번호를 입력해주세요." required></td>
      			<td class="ac_tb_td2"></td>
      		</tr>
      		
      		<tr>
      			<td class="ac_tb_td">닉네임 <input type="text" name="userNickName" class="j_text" placeholder="닉네임을 입력해주세요." required></td>
      			<td class="ac_tb_td2"></td>
      		</tr>
      		
      		<tr>
      			<td class="ac_tb_td">이름 <input type="text" name="userName" class="j_text" placeholder="닉네임을 입력해주세요." required></td>
      			<td class="ac_tb_td2"></td>
      		</tr>
      		
      		<tr class="select_btn">
	      		<td class="ac_tb_td">			
	      			<label>
						남자<input type="radio" name="userGender" value="남자" required>
					</label>
					
					<label>
						여자<input type="radio" name="userGender" value="남자" required>
					</label>
	      		</td>
	      		<td class="ac_tb_td2"></td>
      		</tr>
      		
      		<tr>
      			<td class="ac_tb_td">이메일 <input type="text" name="userEmail" class="j_text" placeholder="maple @ naver.com" required></td>
      			<td class="ac_tb_td2"></td>
      		</tr>
      		
      		<tr>
      			<td class="ac_tb_td3" colspan=2><button type="submit" id="gotoJoin"><img src="image/but04.png"></button></td>     			
      		</tr>
      		<tr><td class="ac_tb_td"></td><td class="ac_tb_td2"></td></tr>
      	</table>
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
<!-- ----------------------------스크립트 영역----------------------- -->
    <script type="text/javascript" src="lib/jquery-1.11.0.min.js"></script>     	
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script>	
		$(document).ready(function(){		
			$("button:submit[id='gotoJoin']").click(function(){
				if (!$("input:checked[id='terms']").is(":checked")){
					alert("약관 동의를 하지 않으셨습니다.");
				}
			})
			$("button:button[id='idCheck']").click(function(){
				if(document.join.userID.value =="" || document.join.userID.value.length < 0){
					alert("아이디를 먼저 입력해주세요.")
					document.join.userID.focus();
				}else{
					window.open("joinIdCheck.jsp?userID="+document.join.userID.value,"","width=500, height=300, toolbar=no, location=no, status=no, memubar=no, scrollbars=no, resizable=no");
				}
			})
			
			function inputID(){
				document.join.idDuplication.value = "idUnCheck";
			}
			
			$(".not-kor").keyup(function(e) { 
				if (!(e.keyCode >=37 && e.keyCode<=40)) {
					var v = $(this).val();
					$(this).val(v.replace(/[^a-z0-9]/gi,''));
				}
			});
		});
    </script>
</body>
</html>