<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<style >
.content_area table td{
width:100px;
}
table {
    margin-left:auto; 
    margin-right:auto;
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



</head>
<body>
	<div id="header"></div>
	<div class="wrapper">
		<div class="wrap">
<div class="content_area">

			<table class="table table-bordered" id="dataTable" cellspacing="0">
				<thead>
					<tr>
						<th>번호</th>
						<th></th>
						<th>제품명</th>
						<th>성별</th>
						<th>가격</th>
					

					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="list">
						<tr>
							<td>${list.gdsNum}</td>
							 <td>
						<div class="image_wrap" 
							data-pdid="${list.imgList[0].pdId}" 
							data-path="${list.imgList[0].uploadPath}" 
							data-filename="${list.imgList[0].fileName}"><img id=imgi></div></td> 
							
							<td><a href="${list.gdsNum}" class="move"><c:out value="${list.gdsName }" />
							<c:if test="${list.replyCnt ne 0 }">
							<span style="color:red;">[<c:out value="${list.replyCnt }"/>]
							</span></c:if></a></td>
								<td>성별 :${list.cateCode}<br>
									분류 :${list.cateCode1}<br>
									계절	:${list.cateCode2}</td>
								
							<td>가격 :<fmt:formatNumber value="${list.gdsPrice}"
									pattern="###,###,###" /> 원<br>남은 수량 :${list.gdsStock}</td>
							
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

			<form id="actionForm" action="/goods/main" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<input type="hidden" name="type" value="${pageMaker.cri.type }">
				<input type="hidden" name="keyword" value="${pageMaker.cri.type }">
			</form>


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

$(".move").on("click",function(e) {

			e.preventDefault();
			actionForm.append("<input type='hidden' name= 'gdsNum'"
					+ "value='" + $(this).attr("href") + "'>");

			actionForm.attr("action", "/goods/view");
			actionForm.submit();
		});
		
		
	$(document).ready(function(){
		var img = $("#imgi");
	$(".image_wrap").each(function(i, obj){		
		
		const bobj = $(obj);	
		if(bobj.data("pdid")){
		const uploadPath = bobj.data("path");
		const fileName = bobj.data("filename");
		console.log( uploadPath);			
		const fileCallPath = encodeURIComponent(uploadPath
				+ "\\s_" + fileName);
		
		$(this).find("img").attr('src', '/detail?fileName=' + fileCallPath);
		}else {
			$(this).find("img").attr('src', '/resources/img/goodsNoImage.jpg');
		}
	});
}); 

</script>
</html>