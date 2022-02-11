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
				
				</sec:authorize>
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
				<button type="button" class="btm_image" id="img_btn">
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
			<form role="form1" method="post" >
			<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" />
			<input type="hidden" name="gdsNum" value="${goods.gdsNum}" />
			
			<div class="cate">
				<div class="dropdown">
					<button type="button" class="btm_image" id="img_btn">
						<img src="/resources/img/memu.png" width="50" height="50">

					</button>
					<div class="dropdown-content">
						<a href="/board/QnA">고객센터</a> <a href="#">마이페이지</a> <a
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
	
	
	
	<div id="header"></div>
	<div class="wrapper">
		<div class="wrap">
			<div class="Event_area" >
				
			<table class="table bordered"  cellspacing="0">
				<thead>
					<tr>
						<th>마이페이지</th>
						<th></th>
						
					</tr>
					
					<tr>
					<th> 회원정보</th>
					<th> </th>
					</tr>
					</thead>
						</table>
				
					<table class="table bordered" id="dataTable1" cellspacing="0">
					<thead>
					
					<tr>				
					<th><img src="/resources/img/memberj.png" width="100" height="100"> </th>
					<th>이메일&emsp; :${vo.userMail}<br>전화번호 :${vo.userPhon} <br> 회원 이름:${vo.userName}
					<br> 회원 권한:${vo.auth}<br></th>
					<th>&emsp;&emsp;&emsp;&emsp;&emsp;
					<c:if test="${vo.admin == 1}">
					<a href="/admin/admin">관리자 화면</a> </c:if></th>
					<th>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</th>
					<th>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</th>
					<th>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</th>
					
					</tr>
				</thead>
			
			</table>
					<table class="table bordered"  cellspacing="0">
					<thead>
					<tr>
					<th>주문 목록</th>
					</tr>
					</thead>
					</table>
				<table class="table table-bordered" id="dataTable" cellspacing="0">
				<thead>
					<tr>
						<th>주문 번호</th>
						<th>주소 </th>
					
						<th>제품명</th>
						
						<th>가격</th>

					</tr>
				</thead>
				<tbody>
					<c:set var="sum" value="0" />
					<c:forEach items="${olist}" var="olist" >

						<tr>
							<td>${olist.orderId}</td>
							
								<td>${olist.userAddr1}<br>
								${olist.userAddr2}<br>
								${olist.userAddr3}<br></td>
							<td>
								

					

							<td>가격 :<fmt:formatNumber value="${olist.amount}"
									pattern="###,###,###" /> 원
									<br><br>
									<button type="button" class="deletebtn" name="delbtn" data-cartNum="${olist.orderId}" id="delete_btn">반품</button>
							</td>
							

						</tr>
						<c:set var="sum" value="${sum + olist.amount }" />
					</c:forEach>
				</tbody>
			</table>
			<div class="listResult">
				<div class="sum">
					총 합계 :
					<fmt:formatNumber pattern="###,###,###" value="${sum}" />
					원
				</div>
			</div>
				
				
				
				
			</div>
			</div>
			</div>
			
	
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
		
	

		$(document)
				.ready(
						function() {
						
							
							var formObj = $("form[role='form']");
							var csrfHeaderName = "${_csrf.headerName}";
							var csrfTokenValue = "${_csrf.token}";
							$(document).ajaxSend(
									function(e, xhr, options) {
										xhr.setRequestHeader(csrfHeaderName,
												csrfTokenValue);
									});
							var img = $("#imgi");
							$(".image_wrap")
									.each(
											function(i, obj) {

												const bobj = $(obj);
												if (bobj.data("pdid")) {
													const uploadPath = bobj.data("path");
													const fileName = bobj.data("filename");
													console.log(uploadPath);
													const fileCallPath = encodeURIComponent(uploadPath
															+ "\\s_" + fileName);

													$(this).find("img").attr(
															'src',
															'/detail?fileName='
																	+ fileCallPath);
												} else {
													$(this)
															.find("img")
															.attr('src','/resources/img/goodsNoImage.jpg');
												}
											});
							
							
							 $(".deletebtn").click(function(){
								   var confirm_val = confirm("정말 반품하시겠습니까?");
								  
								   if(confirm_val) {
										<sec:authorize access="isAuthenticated()">
										userId='${pinfo.username}';
										</sec:authorize>
										
								    
								   var orderId=($(this).attr("data-cartNum"));
								            
								    $.ajax({
								     url : "/shop/deleteorder",
								     type : "post",
								     data : { orderId : orderId ,userId:userId},
								     success : function(result){
								      if(result == 1) {     
								    		location.reload();
								      } else {
								    	  location.reload();
								      }
								     }
								    });
								   } 
								  });
							
							
							
							
						});
	</script>
	</html>