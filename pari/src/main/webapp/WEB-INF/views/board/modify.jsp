<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">글 수정</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading"></div>
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token}" />
						
					<input type="hidden" name="bno" value="${board.bno}" /> <input
						type="hidden" name="pageNum" value="${cri.pageNum }" /> <input
						type="hidden" name="amount" value="${cri.amount }" /> <input
						type="hidden" name="type" value="${cri.type }"> <input
						type="hidden" name="keyword" value="${cri.keyword }">

					<div class="form-group">
						제목<input class="form-control"style="width: 70%;" name="title"
							value='<c:out value="${board.title }"/>'>
					</div>
					<div class="form-group">
						내용
						<textarea rows="3" class="form-control"style="width: 70%; height:300px; name="content"><c:out
								value="${board.content }" /></textarea>
					</div>
					<div class="form-group">
						작성자<input class="form-control"style="width: 70%;" name="writer"
							value='<c:out value="${board.writer }"/>' readonly>
					</div>
					
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<!-- 인증된 사용자만 허가 -->
						<c:if test="${pinfo.username eq board.writer }">
							<!-- 인증되었으면서 작성자가 본인 일때 수정과 삭제 버튼 표시 -->
							<button type="submit" data-oper='modify' 
							class="btn btn-success">수정</button>
							<button type="submit" data-oper='remove' 
							class="btn btn-danger">삭제</button>
							
						</c:if>
					</sec:authorize>

					<button type="submit" data-oper='list' class="btn btn-info">
						목록</button>

				</form>
			</div>

		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		
		var formObj = $("form");
		$('button').on("click", function(e) {
			
			e.preventDefault();
			var operation = $(this).data("oper");
		
			console.log(operation);
		
			if (operation === 'remove') {
				formObj.attr("action", "/board/remove");
				
			} else if (operation === 'list') {
				
				formObj.attr("action", "/board/list").attr("method", "get");		
				var pageNumTag = $("input[name='pageNum']");
				var amountTag = $("input[name='amount']");
				var keywordTag = $("input[name='keyword']");
				var typeTag = $("input[name='type']");

				formObj.empty();//폼의 내용들 비우기.
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}
			formObj.submit();
		});
		});
			</script>