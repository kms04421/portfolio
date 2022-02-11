<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매</title>
<style>
.listResult {
	padding: 20px;
	background: #eee;
}

.listResult .sum {
	float: left;
	width: 45%;
	font-size: 22px;
}

.listResult::after {
	content: "";
	display: block;
	clear: both;
}

.image_wrap {
	width: 70pt;
	height: 70pt;
	margin-bottom: 18pt;
}

.image_wrap img {
	max-width: 70pt;
	height: auto;
	display: block;
}

.orderInfo {
	border: 5px solid #eee;
	padding: 20px;
}

.orderInfo .inputArea {
	margin: 10px 0;
}

.orderInfo .inputArea label {
	display: inline-block;
	width: 120px;
	margin-right: 10px;
}

.orderInfo .inputArea input {
	font-size: 14px;
	padding: 5px;
}

#userAddr2, #userAddr3 {
	width: 250px;
}

.orderInfo .inputArea:last-child {
	margin-top: 30px;
}

.orderInfo .inputArea button {
	font-size: 20px;
	border: 2px solid #ccc;
	padding: 5px 10px;
	background: #fff;
	margin-right: 20px;
}

.input {
	border-color: LightGray;
	border-style: solid;
	border-width: 0 0 2px 8px;
	padding: 12px;
	margin: 5px;
	width: 60%;
	word-break: break-all;
}

.inputa {
	border-color: LightGray;
	border-style: solid;
	border-width: 0 0 2px 8px;
	padding: 12px;
	margin: 5px;
	width: 47%;
	word-break: break-all;
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<div class="wrap">
		<div class="content_area">
			<table class="table table-bordered" id="dataTable" cellspacing="0">
				<thead>
					<tr>
						<th>번호</th>
						<th></th>
						<th>제품명</th>
						<th>가격/수량</th>
					

					</tr>
				</thead>
				<tbody>
					<c:set var="sum" value="0" />
					<c:forEach items="${list}" var="list">

						<tr>
							<td>${list.gdsNum}</td>
							<td>
								<div class="image_wrap" data-pdid="${list.imgList[0].pdId}"
									data-path="${list.imgList[0].uploadPath}"
									data-filename="${list.imgList[0].fileName}">
									<img id=imgi>
								</div>
							</td>

							<td><a href="/goods/view?gdsNum=${list.gdsNum}" ><c:out value="${list.gdsName }" /> 
									</a></td>

					

							<td>가격 :<fmt:formatNumber value="${list.gdsPrice}"
									pattern="###,###,###" /> 원<br>남은 수량 :${list.cartStock}
									<br><br>
									<button type="button" class="deletebtn" name="delbtn" data-cartNum="${list.cartNum}" id="delete_${list.cartNum}_btn">삭제</button>
							</td>
							

						</tr>
						<c:set var="sum" value="${sum + (list.gdsPrice * list.cartStock)}" />
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
			<div class="orderInfo">
				<form role="form" method="post" action="/shop/bues"
					autocomplete="off">

					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token}" /> <input type="hidden" name="sumbue"
						value="${sum}" />

					<div class="inputArea">
						<label for="">수령인:</label> <input type="text" name="orderRec"
							class="inputa" id="orderRec" required="required" />
					</div>

					<div class="inputArea">
						<label for="orderPhon">수령인 연락처:</label> <input type="text"
							class="inputa" name="orderPhon" id="orderPhon"
							required="required" />
					</div>
					<sec:authentication property="principal" var="pinfo" />
					<!-- 프린서펄 정보를 pinfo라는 이름으로 jsp 에서 이용. -->
					<sec:authorize access="isAuthenticated()">
					</sec:authorize>

					<div class="input_Addr">
						<input class="input" name="userAddr1" id="member_post" type="text"
							placeholder="주소입력" readonly onclick="findAddr()"
							required="required"> <input class="input"
							name="userAddr2" id="member_addr" type="text" placeholder="주소"
							readonly required="required"> <br> <input
							class="input" name="userAddr3" type="text" placeholder="상세주소 입력">
					</div>
					<div class="inputArea">
						<button type="submit" id=bue class="order_btn">주문</button>
						<button type="button" class="cancel_btn">취소</button>
					</div>


				</form>
			</div>
		<form id="actionForm" action="/shop/cartlist" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<input type="hidden" name="type" value="${pageMaker.cri.type }">
				<input type="hidden" name="keyword" value="${pageMaker.cri.type }">
			</form>


		</div>
	</div>
</body>
<script>
var actionForm = $("#actionForm");
	function findAddr() {
		new daum.Postcode({
			oncomplete : function(data) {

				console.log(data);
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var jibunAddr = data.jibunAddress; // 지번 주소 변수
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('member_post').value = data.zonecode;
				if (roadAddr !== '') {
					document.getElementById("member_addr").value = roadAddr;
				} else if (jibunAddr !== '') {
					document.getElementById("member_addr").value = jibunAddr;
				}
			}
		}).open();
	}
	$(".move").on(
			"click",
			function(e) {

				e.preventDefault();
				actionForm.append("<input type='hidden' name= 'gdsNum'"
						+ "value='" + $(this).attr("href") + "'>");

				actionForm.attr("action", "/goods/view");
				actionForm.submit();
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
						
						$("#bue").on("click", function(e) {
							
							var userId=null;
							var str="";
							
							<sec:authorize access="isAuthenticated()">
							userId='${pinfo.username}';
							</sec:authorize>
							console.log("userId: "+userId);
							str+="<input type='hidden' name='userId' value='"+userId;
							str+="'>";
							
							console.log("str:" +str);
							formObj.append(str);
							formObj.attr("action", "/shop/bues");
							formObj.attr("method", "post");
						
						});
						 $(".deletebtn").click(function(){
							   var confirm_val = confirm("정말 삭제하시겠습니까?");
							  
							   if(confirm_val) {
									<sec:authorize access="isAuthenticated()">
									userId='${pinfo.username}';
									</sec:authorize>
									console.log("userId: "+userId);
							    
							   var cartNum=($(this).attr("data-cartNum"));
							               console.log(cartNum);
							    $.ajax({
							     url : "/shop/deleteCart",
							     type : "post",
							     data : { cartNum : cartNum ,userId:userId},
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