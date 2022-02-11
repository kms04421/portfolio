<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<style>
.content_area table td {
	width: 100px;
}

table {
	margin-left: auto;
	margin-right: auto;
}
</style>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="${path}/resources/css/main.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
type="text/css">

</head>
<body>
	<div id="header"></div>
	<div class="wrapper">
		<div class="wrap">
			<div class="content_area">
				<button id="regBtn" style="float: right; color: green;">글쓰기</button>
				<table class="table table" id="dataTable" cellspacing="0">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>


						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${list }">
							<tr>
								<td>${board.bno }</td>
								
								<td><a href="${board.bno }" class="move"> 
								
								<c:out value="${board.title }" />
								</a></td>
								
								<td><c:out value="${board.writer }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regdate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.updateDate }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div>
					<ul class="pagination justify-content-center">
						<c:if test="${pageMaker.prev}">
							<li class="page-item prev"><a
								href="${pageMaker.startPage-1 }" class="page-link">이전</a></li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }">
							<li class='page-item ${pageMaker.cri.pageNum==num?"active":"" }'>
								<a href="${num }" class="page-link">${num }</a>
							</li>
						</c:forEach>

						<c:if test="${pageMaker.next }">
							<li class="page-item next"><a href="${pageMaker.endPage+1 }"
								class="page-link">다음</a></li>
						</c:if>
					</ul>
				</div>

					<form id="actionForm" action="/board/QnA" method="get">
				<input type="hidden" name="pageNum"
					value="${pageMaker.cri.pageNum }"> 
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					
					<input type="hidden" name="type" value="${pageMaker.cri.type }"> 
					<input type="hidden" name="keyword" 
					value="${pageMaker.cri.keyword }">
			</form>


			</div>
		</div>
	</div>
	<div>
				<div class="col-lg-12">
					<form id="searchForm1" action="/board/QnA" method="get">
						&nbsp;&nbsp;&nbsp;
						
						<select name="type" style="float: right;width: 10%;">
							<option value="" ${pageMaker.cri.type==null?"selected":"" }>
								--</option>
							<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>
								제목</option>
							<option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>
								내용</option>
							<option value="W" ${pageMaker.cri.type eq "W"?"selected":"" }>
								작성자</option>
							<option value="TC" ${pageMaker.cri.type eq "TC"?"selected":"" }>
								제목+내용</option>
							<option value="TW" ${pageMaker.cri.type eq "TW"?"selected":"" }>
								제목+작성자</option>
							<option value="WC" ${pageMaker.cri.type eq "WC"?"selected":"" }>
								내용+작성자</option>
							<option value="TWC" ${pageMaker.cri.type eq "TWC"?"selected":"" }>
								제목+내용+작성자</option>
						</select>
						<input type="text" style="float: right;"  name="keyword" value="${pageMaker.cri.keyword }"/> 
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<button class="btn btn-warning" id="scbtn"style="float: right;">Search</button> 
					</form>
				</div>
			
			</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header"></div>
				<div class="modal-body" align="center"></div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" data-dismiss="modal">close</button>
				</div>
			</div>
		</div>
	</div>



</body>
<script>
	var actionForm = $("#actionForm");
	$(".page-item a").on("click", function(e) {
		e.preventDefault();
		console.log("click");// 웹 브라우저 검사 창에 클릭을 표시
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});

	$(".move").on(
			"click",
			function(e) {

				e.preventDefault();
				actionForm.append("<input type='hidden' name= 'gdsNum'"
						+ "value='" + $(this).attr("href") + "'>");

				actionForm.attr("action", "/goods/view");
				actionForm.submit();
			});
	
	var searchForm1 = $("#searchForm1");
	
	$("#scbtn").on("click", function(e) {
		if(!searchForm1.find("option:selected").val()){
			alert("검색 종류를 선택하세요.");
			return false;
		}
		if(!searchForm1.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.");
			return false;
		}
		
		searchForm1.find("input[name='pageNum']").val(1);
		e.preventDefault();
		searchForm1.submit();
	
	});

	$(document).ready(function() {

		$("#regBtn").on("click", function() {
			self.location = "/board/register";
	
		});

		var result = '<c:out value="${result}"/>';
		checkModal(result);
		function checkModal(result) {
		if (result === '') {
	
		return;
		}
		if (parseInt(result) > 0) {
		$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록");
		}
		$("#myModal").modal("show");
		}
		var actionForm = $("#actionForm");
		
		$(".page-item a").on(
				"click",
				function(e) {
					e.preventDefault();
					
					
					actionForm.find("input[name='pageNum']").val(
							$(this).attr("href"));
				
					actionForm.submit();
				});

		
		$(".move").on(
				"click",
				function(e) {
					e.preventDefault();
					actionForm
							.append("<input type='hidden' name='bno' "
									+ "value='" + $(this).attr("href")
									+ "'>");
					actionForm.attr("action", "/board/get");
					actionForm.submit();
				});
		
	

		
	});
</script>
</html>