<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="${path}/resources/css/main.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
html {
	height: 100%;
}

body {
	margin: 0;
	height: 100%;
	background: #f5f6f7;
}

#logo {
	width: 240px;
	height: 44px;
	cursor: pointer;
}

#header {
	padding-top: 62px;
	padding-bottom: 20px;
	text-align: center;
}

#wrapper {
	position: relative;
	height: 100%;
}

#content {
	position: absolute;
	left: 50%;
	transform: translate(-50%);
	width: 460px;
}

h3 {
	margin: 19px;
	font-size: 14px;
	font-weight: 700;
}

.box {
	display: block;
	width: 100%;
	height: 51px;
	border: solid 1px #dadada;
	padding: 10px 14px 10px 14px;
	box-sizing: border-box;
	background: #fff;
	position: relative;
}

.int {
	display: block;
	width: 100%;
	hight: 100%;
	border: none;
	position: relative;
	background: #fff;
	font-size: 15px
}

#bir_wrap {
	display: table;
	width: 100%;
	margin: 60%:
}

#bir_yy {
	display: table-cell;
	width: 147px;
}

#bir_mm {
	display: table-cell,;
	width: 147px;
	padding-left: 20px;
}

#bir_dd {
	display: table-cell;
	width: 147px;
}

select {
	width: 100%;
	height: 29px;
	font-size: 15px;
	background: #fff
		url(https://static.nid.naver.com/images/join/pc/sel_arr_2x.gif) 100%
		50% no-repeat;
	background-size: 20px 8px;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	text-align: start;
	border: none;
	cursor: default;
	font-family: Dotum, '돋움', Helvetica, sans-serif;
}

#alertTxt {
	position: absolute;
	top: 19px;
	right: 38px;
	font-size: 12px;
	color: red;
	display: none;
}

.btn_area {
	margin: 30px;
}

.error_next_box {
	margin-top: 9px;
	font-size: 12px;
	color: red;
	display: none;
}

.success_next_box {
	margin-top: 9px;
	font-size: 12px;
	color: green;
	display: none;
}

.login-button-wrap {
	padding-top: 13px;
}

.login-button-wrap button {
	width: 465px;
	height: 48px;
	font-size: 22px;
	background: #00FF00;
	color: white;
	border: solid 1px #dadada;
}
</style>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<div id="header">
	<a href="/board/main">
	<h1>PARI</h1></a>
	<h2>비밀번호 찾기</h2>
	<div id="wrapper">
		<div id="content">


			<span>비밀번호를 찾으시는 아이디와 이메일을 입력해 주십시오.</span>
			<div>
				<span class="box int_idpw"> <input placeholder="아이디"
					type="text" id="userid" class="int" name="userid" maxlength="50"
					required>
				</span>
			</div>
			<div>
				<span class="box int_Mailpw"> <input placeholder="이메일"
					type="text" id="userMailPw" class="int" maxlength="30"
					name="userMail" required>

				</span>
			</div>
				<div class="login-button-wrap">
					<button id="pwFindBtn" name="pwFindBtn">비밀번호 찾기</button>
				</div>
					
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" />
		</div>
	</div>
</div>
<script >
$(document).ready(function() {
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="{_csrf.token}";
 
	$("#pwFindBtn").on("click",function(e){
		e.preventDefault();
		console.log("clicked pwFindBtn");
		var userid= $("#userid").val();
		var userMailPw =$("#userMailPw").val();
		console.log("id :"+userid);
		console.log("email :"+userMailPw);
		
		var promise= 			
			$.ajax({
			type: "get",
			url: "/member/findAccount/pw",
			data:{
				userid:userid,
				userMailPw:userMailPw
			},
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);				
			}			
		});
		
		promise.then(successFunction);
		
		function successFunction(result){
			if(result == 'found'){
				if(confirm("입력하신 이메일로 임시 비밀번호를 발급받으시겠습니까?")==true){
					$.ajax({
						url:"/member/findAccount/pwMail",
						type:"get",
						data:{
							userid: userid,
							userMailPw: userMailPw
						},
						beforeSend: function(xhr){
							xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
						},
						success:function(result){
							if(result =='success'){
								alert("이메일로 임시 비밀번호를 발급해드렸으니 확인해 주세요");
							}else if(result== 'fail'){
								alert("임시 비밀번호를 발급 도중 문제가 발생했습니다");
							}else{
								alert("입력하신 정보가 정확한지 확인 해주세요 ");
								return false;
							}
						}
					});
				}
			}else{
				alert("입력하신 정보가 정확한지 확인 해주세요");
				return false;
			}
			
		}		
		
		
	});
	
});
</script>
</html>