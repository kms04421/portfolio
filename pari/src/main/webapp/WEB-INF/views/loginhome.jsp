<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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
<title>로그인</title>
</head>
<div id="header">
	<a href="/goods/main"><h1>PARI</h1></a>
	<h2>로그인</h2>

	<div id="wrapper">
		<div id="content">

			<form role="from" action="/login" method="post">

				<div>
					<span class="box int_id"> <input placeholder="아이디"
						type="text" id="username" class="int" name="username"
						maxlength="50" required>
					</span>
				</div>
				<div>
					<span class="box int_password"> <input placeholder="비밀번호"
						type="password" id="password" class="int" maxlength="20"
						name="password" required>

					</span>
				</div>
				<div>
					<a href="/member/idAccount">아이디 찾기</a> | <a href="/member/findAccount">비밀번호
						찾기</a> | <a href="/member/signup">회원 가입</a>
				</div>

				<div class="login-button-wrap">
					<button>로그인</button>
				</div>
				
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" />
			</form>



		</div>

	</div>
</div>

<script>
	$(document).ready(function(e) {
		var formObj = $("form[role='form']")
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$("button[type='submit']").on("click", function(e) {
			e.preventDefault();
			alert("작동중.");

		});

	});
</script>
</html>