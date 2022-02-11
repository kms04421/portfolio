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
.flex_container { 
display: flex; 

flex-direction: row;
flex-wrap: wrap;
justify-content:space-between;

}
.child{
margin: 50px;
}

table {
	margin-left: auto;
	margin-right: auto;
}
.ese{
position: absolute;

}

</style>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="${path}/resources/css/main.css" />
<link rel="stylesheet" href="${path}/resources/css/normalpackage.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />



</head>
<body>
	<div id="header"></div>
	<div class="wrapper">
		<div class="wrap">
			<div class="Event_area">
				<div class="slideshow-container">

					<div class="mySlides fade">
						<div class="numbertext"></div>
						<img src="/resources/img/1.jpg"onclick="location.href='/board/Event';"
							style="width: 1080px; height: 380px;">
						<div class="text">이벤트 1</div>
					</div>

					<div class="mySlides fade">
						<div class="numbertext"></div>
						<img src="/resources/img/2.jpg" onclick="location.href='/board/Event1';"
							style="width: 1080px; height: 380px;">
						<div class="text">이벤트 2</div>
					</div>

					<div class="mySlides fade">
						<div class="numbertext"></div>
						<img src="/resources/img/3.jpg " onclick="location.href='/board/Event2';"
							style="width: 1080px; height: 380px;">
						<div class="text">이벤트 3</div>
					</div>
					<div style="text-align: center">
						<span class="dot"></span> <span class="dot"></span> <span
							class="dot"></span>
					</div>
				</div>
				<br>


			</div>
		</div>
		<br> <br>
		<div class="wrapper">
		<div class="wrap">
		<div class="con">

		
			
		<section class="flex_container"  cellspacing="0">
					<c:forEach items="${list}" var="list">
						
					<div class="child">
						<div class="image_wrap" 
							data-pdid="${list.imgList[0].pdId}" 
							data-path="${list.imgList[0].uploadPath}" 
							data-filename="${list.imgList[0].fileName}"><img id=imgi style="width: 200px ;height: 200px; position: static;"></div> 	
							<div class="ese">
							<a href="${list.gdsNum}" class="move"><c:out
										value="${list.gdsName }" /> <c:if
										test="${list.replyCnt ne 0 }">
										<span style="color: red;">[<c:out
												value="${list.replyCnt }" />]
										</span>
									</c:if></a>
							<br>
								성별 :${list.cateCode} |
								분류 :${list.cateCode1} |
								계절	:${list.cateCode2}<br>
								
							가격 :<fmt:formatNumber value="${list.gdsPrice}"
									pattern="###,###,###" /> 원<br>남은 수량 :${list.gdsStock}
							</div>
						</div>
		
			
					</c:forEach>
		</section>
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
				<input type="hidden" name="pageNum"
					value="${pageMaker.cri.pageNum }"> <input type="hidden"
					name="amount" value="${pageMaker.cri.amount }"> <input
					type="hidden" name="type" value="${pageMaker.cri.type }"> <input
					type="hidden" name="keyword" value="${pageMaker.cri.type }">
			</form>


		</div>
	</div>
</div>
</div>



</body>
<script>
	
	var slideIndex = 0;
	showSlides();
	function showSlides() {
		var i;
		var slides = document.getElementsByClassName("mySlides");
		var dots = document.getElementsByClassName("dot");
		for (i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}
		slideIndex++;
		if (slideIndex > slides.length) {
			slideIndex = 1
		}
		for (i = 0; i < dots.length; i++) {
			dots[i].className = dots[i].className.replace(" active", "");
		}
		slides[slideIndex - 1].style.display = "block";
		dots[slideIndex - 1].className += " active";
		setTimeout(showSlides, 3000);
	}

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
