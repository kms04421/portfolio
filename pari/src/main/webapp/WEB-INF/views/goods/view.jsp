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



<style>
p.cartStock input {
	width: 50px;
	padding: 5px;
	margin: 0;
	border: 1px solid #eee;
}

div.goods div.gdsDes {
	font-size: 18px;
	clear: both;
	padding-top: 30px;
}

p.cartStock button {
	font-size: 26px;
	border: none;
	background: none;
}

html {
	height: 100%;
}

body {
	margin: 0;
	height: 100%;
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
</style>
<meta charset="UTF-8">
<meta name="_csrf_header" id="_csrf_header"
	content="${_csrf.headerName}">
<meta name="_csrf" id="_csrf" content="${_csrf.token}">

<title>조회</title>
</head>
<div>
	<div class="form-froup">
		<input type="hidden" name='pdId' value="${goods.pdId}" />
	</div>
	<form role="form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="gdsNum" value="${goods.gdsNum}" /> <input
			type="hidden" name="pageNum" value="${cri.pageNum }" /> <input
			type="hidden" name="amount" value="${cri.amount }" /> <input
			type="hidden" name="type" value="${cri.type }"> <input
			type="hidden" name="keyword" value="${cri.keyword }"> <input
			type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
		<div style="text-align: center">
			<div class="upload-img"></div>

			<div class="box int_id">
				<label>성별:</label> <span class="category">${goods.cateCode}</span> <label>&nbsp;&nbsp;&nbsp;분류:</label>
				<span class="category1">${goods.cateCode1}</span> <label>&nbsp;&nbsp;&nbsp;계절:</label>
				<span class="category2">${goods.cateCode2}</span>

			</div>
			<br>
			<div id="uploadImg" data-pdId="${goods.pdId}"></div>
			<div class="uploadResult">
				<ul></ul>
			</div>

			<div class="inputArea">
				<label for="gdsName">상품 명:</label> <span>${goods.gdsName}</span>
			</div>

			<div class="inputArea">
				<label for="gdsPrice">상품 가격:</label> <span> <fmt:formatNumber
						value="${goods.gdsPrice}" pattern="###,###,###" /></span>
			</div>
			<p class="cartStock">

				<label for="gdsStock">구매 수량:</label>
				<button type="button" class="plus">+</button>
				<input type="number" class="numBox" cmin="1" max="${goods.gdsStock}"
					min="1" value="1">
				<button type="button" class="minus">-</button>
			</p>

			<div class="gdsDes">
				<label for="gdsDes">상품소개:</label> <span>${goods.gdsDes}</span>
			</div>

			<sec:authentication property="principal" var="pinfo" />
			<!-- 프린서펄 정보를 pinfo라는 이름으로 jsp 에서 이용. -->
			<sec:authorize access="isAuthenticated()">
				<!-- 인증된 사용자만 허가 -->
				<c:if test="${pinfo.username eq goods.userId }">
					<!-- 인증되었으면서 작성자가 본인 일때 수정 버튼 표시 -->


					<button type="button" data-oper="modify" id=modify
						class="btn btn-warning">수정</button>
					<button type="submit" data-oper='remove' id="remove"
						class="btn btn-danger">삭제</button>
				</c:if>
			</sec:authorize>
			<button type="submit" data-oper='sum' id="sum" class="btn btn">구입</button>
			<button type="button" data-oper='shoping' id="shoping"
				class="btn btn">장바구니 담기</button>
			<div class="inputArea"></div>

		</div>

	</form>
	<form id='operForm' action="/goods/modify" method="get">
		<input type='hidden' id='gdsNum' name='gdsNum'
			value="${goods.gdsNum }" /> <input type="hidden" name="pageNum"
			value="${cri.pageNum }" /> <input type="hidden" name="amount"
			value="${cri.amount }" /> <input type="hidden" name="type"
			value="${cri.type }"> <input type="hidden" name="keyword"
			value="${cri.keyword }">
	</form>
</div>

<!-- 댓글 목록 시작 -->
<br />
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>댓글
				<sec:authorize access="isAuthenticated()">
					<button id="addReplyBtn" class="btn btn-primary btn-xs float-right">새
						댓글</button>
				</sec:authorize>

			</div>
			<br />
			<div class="panel-body">
				<ul class="chat">
					<li>good</li>
				</ul>
			</div>
			<div class="panel-footer"></div>
		</div>
	</div>
</div>
<!-- 댓글 목록 끝 -->

<!-- 댓글 입력 모달창 시작 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				&times;
				<h4 class="modal-title" id="myModalLabel">댓글 창</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>댓글</label> <input class="form-control" name="reply"
						value="새 덧글">
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name="replyer"
						value="replyer">
				</div>
				<div class="form-group">
					<label>댓글 작성일</label> <input class="form-control" name="replyDate"
						value="">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btnwarning">수정</button>
				<button id="modalRemoveBtn" type="button" class="btn btndanger">삭제</button>
				<button id="modalRegisterBtn" type="button" class="btn btnprimary">등록</button>
				<button id="modalCloseBtn" type="button" class="btn btndefault">닫기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<!-- 덧글 입력 모달창 끝 -->
<script>
	$(document).ready(function() {
						var modal = $("#myModal");
						var csrfHeaderName = "${_csrf.headerName}";
						var csrfTokenValue = "${_csrf.token}";
						$(document).ajaxSend(
								function(e, xhr, options) {
									xhr.setRequestHeader(csrfHeaderName,
											csrfTokenValue);
								});
						var formObj = $("form[role='form']");
						var uploadImg = $("#uploadImg");						
						var replyer=null;
						<sec:authorize access="isAuthenticated()">
						replyer='${pinfo.username}';
						userId='${pinfo.username}';
						</sec:authorize>
						
						
						
						
						
						(function() {
							var pdId = '<c:out value="${goods.pdId}"/>';

							// /goods/getImgList/pdId=s20220106171422239

							$.get("/goods/getImgList?pdId=" + pdId,
											function(arr) {
												var img = arr[0];
												var str = "";
												var fileCallPath = encodeURIComponent(img.uploadPath
														+ "\\s_" + img.fileName);
												str += "<img src='/detail?fileName="
														+ fileCallPath + "'>";
												uploadImg.html(str)
											});

						})();
						
						  $(".plus").click(function(){
							   var num = $(".numBox").val();
							   var plusNum = Number(num) + 1;
							   
							   if(plusNum >= ${goods.gdsStock}) {
							    $(".numBox").val(num);
							   } else {
							    $(".numBox").val(plusNum);          
							   }
							  });
							  
						  
							  $(".minus").click(function(){
							   var num = $(".numBox").val();
							   var minusNum = Number(num) - 1;
							   
							   if(minusNum <= 0) {
							    $(".numBox").val(num);
							   } else {
							    $(".numBox").val(minusNum);          
							   }
							  });
						var operForm=$("#operForm");

						var bnoValue = '<c:out value="${goods.gdsNum}"/>';
					
						var modalInputReplyDate = modal.find("input[name='replyDate']");
						var modalRegisterBtn = $("#modalRegisterBtn");
						var modalInputReply = modal.find("input[name='reply']");
						var modalInputReplyer = modal.find("input[name='replyer']");
						var modalModBtn = $("#modalModBtn");
						var modalRemoveBtn = $("#modalRemoveBtn");

						
						$("#addReplyBtn").on("click", function(e) {

							modal.find("input").val("");
							modal.find("input[name='replyer']").val(replyer);
							modal.find("input[name='replyer']").attr("readonly","readonly")
							modalInputReplyDate.closest("div").hide();
							modal.find("button[id != 'modalCloseBtn']").hide();
							console.log("addReplyBtn");
							modalRegisterBtn.show();
							$("#myModal").modal("show");
						});
						console.log("show");

						$("#modalCloseBtn").on("click", function(e) {
							modal.modal("hide");
							console.log("hide");
						});

						modalRegisterBtn.on("click", function(e) {
							console.log("클릭");
							var reply = {
								reply : modalInputReply.val(),
								replyer : modalInputReplyer.val(),
								gdsNum : bnoValue
							};

							// ajax로 전달할 reply 객체 선언 및 할당
							replyService.add(reply, function(result) {
								alert(result);
								modal.find("input").val("");
								modal.modal("hide");
								modalInputReplyDate.closest("div").show();

								showList(-1);
							});
						});

						var replyUL = $(".chat");

						function showList(page) {
							replyService
									.getList(
											{
												gdsNum : bnoValue,
												page : page || 1
											},
											function(replyCnt, list) {
												var str = "";
												console.log("getList" + list);
												if (page == -1) {
													pageNum = Math
															.ceil(replyCnt / 10.0);

													showList(pageNum)
													return;

												}

												for (var i = 0, len = list.length || 0; i < len; i++) {
													str += "<li class='left ";
													str+="clearfix' data-rno='";
													str+=list[i].rno+"'>";
													str += "<div><div class='header' ";
													str+="><strong class='";
													str+="primary-font'>";
													str += list[i].replyer
															+ "</strong>";
													str += "<small class='float-sm-right '>";
													str += list[i].replyDate
															+ "</small></div>";
													str += "<p>"
															+ list[i].reply;
													str += "</p></div></li>";
												}

												replyUL.html(str);
												showReplyPage(replyCnt);
											});
						}
						showList(-1);

						var pageNum = 1;
						var replyPageFooter = $(".panel-footer");
						function showReplyPage(replyCnt) {
							var endNum = Math.ceil(pageNum / 10.0) * 10;
							var startNum = endNum = endNum - 9;
							var prev = startNum != 1;
							var next = false;
							if (endNum * 10 >= replyCnt) {
								endNum = Math.ceil(replyCnt / 10.0);

							}
							if (endNum * 10 < replyCnt) {
								next = true;
							}
							var str = "<ul class= 'pagination"
								str+=" justify-content-center'>";
							if (prev) {
								str += "<li class='page-item'><a ";
								str += "class='page-link' href='";
								str += (startNum - 1);
								str += "'>이전</a></li>";
							}

							for (var i = startNum; i <= endNum; i++) {
								var active = pageNum == i ? "active" : "";
								str += "<li class='page-item "+ active +"'><a class='page-link' ";
							str+="href='"+i+"'>"
										+ i + "</a></li>";
							}

							if (next) {
								str += "<li class='page-item'>";
								str += "<a class='page-link' href='";
								str += (endNum + 1) + "'>다음</a></li>";
							}
							str += "</ul>";
							console.log(str);
							replyPageFooter.html(str);
						}
						replyPageFooter.on("click", "li a", function(e) {
							e.preventDefault();

							var targetPageNum = $(this).attr("href");
							pageNum = targetPageNum;
							showList(pageNum);
						});

						$(".chat").on("click","li",function(e) {
											var rno = $(this).data("rno");
											console.log("chat 클릭:" + rno);
											replyService.get(rno,function(reply) {
												modalInputReply.val(reply.reply);
												modalInputReplyer.val(reply.replyer);
												modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
														.attr("readonly","readonly");
											modal.data("rno",reply.rno);
											console.log("chat 클릭 rno:"+ rno);
											console.log(reply);
																modal.find("button[id!='modalCloseBtn']").hide();
																modalModBtn.show();
																modalRemoveBtn.show();
																$("#myModal").modal("show");
															});
											
										});
						
						modalModBtn.on("click", function(e) {
							var originalReplyer = modalInputReplyer.val();
							console.log("originalReplyer:"+originalReplyer);
							var reply = {
								rno : modal.data("rno"),
								reply : modalInputReply.val(),
								replyer : originalReplyer
							};
							console.log(replyer);
							if(!replyer){
								alert("로그인후 수정 가능");
								modal.modal("hide");
								return;
							}
							
							if(replyer != originalReplyer){
								alert("자신이 작성한 댓글만 수정 가능");
								modal.modal("hide");
								return;
							}
							
							replyService.update(reply, function(result) {
								alert(result);
								modal.modal("hide");
								//showList(-1);
								showList(pageNum);
							});
						});
						// 덧글 삭제 처리.
						modalRemoveBtn.on("click", function(e) {
							var rno = modal.data("rno");
							var originalReplyer = modalInputReplyer.val();
							
							if(!replyer){
								alert("로그인후 수정 가능");
								modal.modal("hide");
								return;
							}
							
							if(replyer != originalReplyer){
								alert("자신이 작성한 댓글만 수정 가능");
								modal.modal("hide");
								return;
							}
							
							replyService.remove(rno, originalReplyer, function(result) {
								alert(result);
								modal.modal("hide");
								showList(pageNum);
							});
						});
						$("#remove").on("click", function(e) {
							e.preventDefault();
							var operation = $(this).data("oper");
							console.log(operation);
							if (operation === 'remove') {
								var con = confirm("정말로 삭제하시겠습니까?");
								if (con) {
									formObj.attr("action", "/goods/remove");

								} else {
									return false;
								}
							}
						});
						$("#modify").on("click", function(e) {
							console.log("작동 수정");
							operForm.attr("action","/goods/modify").submit();

						});
						$("#sum").on("click", function(e) {
							var str="";
							var gdsStock = $(".numBox").val();
							
							str+="<input type='hidden' name='gdsStock' value='"+gdsStock;
							str+="'>";
							
							formObj.append(str);	
							formObj.attr("action", "/goods/bue");
							formObj.attr("method", "get")
							

						});
						$("#shoping").on("click", function(e) {
							var cartStock = $(".numBox").val();
							console.log(cartStock);
							var data={
									gdsNum:bnoValue,
									userId:replyer,
									cartStock:cartStock
							};						
							$.ajax({
								url:"/shop/shoping",
								type:"post",
								data:data,	
							
								success:function(){
									alert("카트담기");
									
								},
								error:function(){
									alert("카트에 담았습니다");
								}
							});
						

						});
					});
</script>
</html>