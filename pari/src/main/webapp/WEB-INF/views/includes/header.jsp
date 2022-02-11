<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">

<title>쇼핑몰</title>

<link rel="stylesheet" href="${path}/resources/css/main.css" />

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>
<style>
.btn {
	height: 50px;
}
</style>
</head>

<body>
	<div class="top_gnb_area">
		<div class="login">

			<sec:authorize access="isAnonymous()">
				<a href="/loginhome">로그인</a>
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<a href="/member/signup">회원가입</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<button class="btn_log" style="width: 33%"></button>
			</sec:authorize>
			<form role="form" method="post" action="/includes/header">
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" />
				<sec:authentication property="principal" var="pinfo" />
				<!-- 프린서펄 정보를 pinfo라는 이름으로 jsp 에서 이용. -->
				
				<sec:authorize access="isAuthenticated()">
					<button class="btn_log"">로그아웃</button>
				</sec:authorize>
			</form>
			<sec:authorize access="isAuthenticated()">
				<a href="/goods/goodsregister" style="float: right;">상품등록</a>
			</sec:authorize>
			
		</div>
		<div class="jop"></div>
	</div>

	<div class="top_area">

		<div class="mypage_area">

			<div class=" mypage">
				<button type="button" class="btm_image" id="mypage1">
					<img src="/resources/img/mypage.png" width="50" height="50">
				</button>

			</div>


		</div>

		<div class="logo">
			<div class="logo_area">
				<img src="/resources/img/pari.png" width="70" height="50"
					onclick="location.href='/goods/main';">
			</div>
		</div>
		<div class="cate_area">
			<form role="form1" method="post">
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" /> <input type="hidden" name="gdsNum"
					value="${goods.gdsNum}" />

				<div class="cate">
					<div class="dropdown">
						<button type="button" class="btm_image" id="img_btn">
							<img src="/resources/img/memu.png" width="50" height="50">

						</button>
						<div class="dropdown-content">
							<a href="/board/QnA">고객센터</a> <a href="#" id="mypage">마이페이지</a> <a
								href="#" id="cartlist">장바구니</a>
						</div>
					</div>
				</div>
			</form>
		</div>

		<form id="searchForm" action="/goods/list" method="get">
			<div class="search_box">
				<span class="box int_id"> &nbsp;&nbsp;&nbsp; <select
					name="type" style="float: left; width: 20%">
						<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>
							제품명</option>
						<option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>
							내용</option>
						<option value="TC" ${pageMaker.cri.type eq "TC"?"selected":"" }>
							제목+내용</option>
				</select> <input type="text" name="keyword" class="int"
					value="${pageMaker.cri.keyword }" /> <input type="hidden"
					name="pageNum" value="${pageMaker.cri.pageNum }"> <input
					type="hidden" name="amount" value="${pageMaker.cri.amount }">



				</span>
			</div>
			<button class="btn btn-warning">검색</button>
		</form>

	</div>

	<div style="text-align: center; margin: 0 auto;">
		<span class="box int_id"> &nbsp;&nbsp;&nbsp; <a id="man"
			href="/goods/mandress">남성복</a>&nbsp;&nbsp;&nbsp; <a
			href="/goods/femaledress">여성복</a>&nbsp;&nbsp;&nbsp; <a
			href="/goods/topgarments">상의</a> &nbsp;&nbsp;&nbsp;<a
			href="/goods/downgarments">하의</a> &nbsp;&nbsp;&nbsp;<a
			href="/goods/spring">봄 옷</a> &nbsp;&nbsp;&nbsp;<a
			href="/goods/summer">여름 옷</a> &nbsp;&nbsp;&nbsp; <a
			href="/goods/autumn">가을옷</a> &nbsp;&nbsp;&nbsp; <a
			href="/goods/winter">겨울옷</a>
		</span>
	</div>


	<br>
</body>
<script>
	var formObj = $("form[role='form']");
	var formObjz = $("form[role='form1']");
	var searchForm = $("#searchForm");
	
		var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(
			function(e, xhr, options) {
				xhr.setRequestHeader(csrfHeaderName,
						csrfTokenValue);
			});
	$("#searchForm button").on("click", function(e) {

		if (!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요.");
			return false;
		}

		if (!searchForm.find("input[name='keyword']").val()) {

			alert("키워드를 입력하세요.");

			return false;
		}

		searchForm.find("input[name='pageNum']").val(1);
		e.preventDefault();
		searchForm.submit()
	});
 	$("#cartlist").on("click", function(e) {
 		e.preventDefault();
 		var userId=null;
 		<sec:authorize access="isAuthenticated()">
 		userId='${pinfo.username}';
 		</sec:authorize>
 		var ctr=""; 		
 		ctr+="<input type='hidden' name='userId' value='"+userId;
		ctr+="'>";
		
		console.log("str:" +ctr);
		formObjz.append(ctr);
		formObjz.attr("action", "/shop/cartlist");
		formObjz.attr("method", "get");
		formObjz.submit();
		
	}); 
	$("#mypage").on("click", function(e) {
 		e.preventDefault();
 		var userId=null;
 		<sec:authorize access="isAuthenticated()">
 		userId='${pinfo.username}';
 		</sec:authorize>
 		var ctr=""; 		
 		ctr+="<input type='hidden' name='userId' value='"+userId;
		ctr+="'>";
		
		console.log("str:" +ctr);
		formObjz.append(ctr);
		formObjz.attr("action", "/member/mypage");
		formObjz.attr("method", "get");
		formObjz.submit();
		
	}); 
	$("#mypage1").on("click", function(e) {
 		e.preventDefault();
 		var userId=null;
 		<sec:authorize access="isAuthenticated()">
 		userId='${pinfo.username}';
 		</sec:authorize>
 		var ctr=""; 		
 		ctr+="<input type='hidden' name='userId' value='"+userId;
		ctr+="'>";
		
		console.log("str:" +ctr);
		formObjz.append(ctr);
		formObjz.attr("action", "/member/mypage");
		formObjz.attr("method", "get");
		formObjz.submit();
		
	}); 
</script>
</html>