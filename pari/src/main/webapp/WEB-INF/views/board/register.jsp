<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/header.jsp"%>



<div class="row">
	<div class="col-lg-12">
	<div style="text-align: center; left3:30%; margin: 0 auto;">
		<h1 class="page-header">문의 하기</h1>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		

		
			
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>제목</label> <input  style="width: 70%;" class="form-control" name='title'>
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" style="width: 70%; height:300px;  " rows="3" name='content'></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label> <input style="width: 70%;"class="form-control" name="writer">
					</div>
					<button type="submit" class="btn btn-default"> 등록</button>
					<button type="reset" class="btn btn-default">취소</button>
				</form>
			</div>
		</div>
	</div>
</div>