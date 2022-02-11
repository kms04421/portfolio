<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="/resources/ckeditor/ckeditor.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
</head>
<div id="header">

	<div id="wrapper">
		<div id="content">
			<div>
				<br>
			</div>

			<div class="content_area">
				<input type="hidden" name='pdId' value="${goods.pdId}" />
				<form role="form" method="post" action="/goods/modify">
					<input type="hidden" name="gdsNum" value="${goods.gdsNum}" /> <input
						type="hidden" name="pageNum" value="${cri.pageNum }" /> <input
						type="hidden" name="amount" value="${cri.amount }" /> <input
						type="hidden" name="type" value="${cri.type }"> <input
						type="hidden" name="keyword" value="${cri.keyword }"> <input
						type="hidden" name="${_csrf.parameterName }"value="${_csrf.token}" />
					<div style="text-align: center">
						<h1>상품 수정</h1>
						<div class="inputArea">
							<label>&nbsp;&nbsp;&nbsp;▽&nbsp;&nbsp;성별&nbsp;&nbsp;▽</label> <select
								class="category1" name="cateCode">
								<option value="전체">전체</option>
								<option value="남자">남자</option>
								<option value="여자">여자</option>
							</select> <label>▽&nbsp;&nbsp;분류&nbsp;&nbsp;▽</label> <select
								class="category2" name="cateCode1">
								<option value="전체">전체</option>
								<option value="상의">상의</option>
								<option value="하의">하의</option>
								<option value="기타">기타</option>
							</select> <label>▽&nbsp;&nbsp;계절&nbsp;&nbsp;▽</label> <select
								class="category3" name="cateCode2">
								<option value="전체">전체</option>
								<option value="봄">봄</option>
								<option value="여름">여름</option>
								<option value="가을">가을</option>
								<option value="겨울">겨울</option>
							</select>
						</div>
						
						</div>
						<div class="form-group">
							<table id="uploadResult" class="upload-tb">
								<tr class="img-view">
									<td class="file-box"><label for="file">섬네일 이미지</label> <input
										type="file" id="File" name="uploadFile" multiple /></td>
								</tr>

							</table>
							<div id="uploadImg" data-pdId="${goods.pdId}"></div>
							<div class="uploadResult">
								<ul></ul>
							</div>
							<div class="inputArea">
								<label for="gdsName">상품명 &nbsp;&nbsp; :</label> <input
									type="text" class="goods1" id="gdsName" name="gdsName"
									value=" ${goods.gdsName}" />
							</div>

							<div class="inputArea">
								<label for="gdsPrice">상품가격:</label> <input type="text"
									id="gdsPrice" class="goods1" name="gdsPrice"
									value="${goods.gdsPrice}" />
							</div>

							<div class="inputArea">
								<label for="gdsStock">상품수량:</label> <input type="text"
									class="goods1" id="gdsStock" name="gdsStock"
									value="${goods.gdsStock}" />
							</div>

							<div class="inputArea">
								<label for="gdsDes">상품소개:</label>
								<textarea rows="5" cols="50" id="gdsDes" class="goods2"
									name="gdsDes">${goods.gdsDes}</textarea>
							</div>
		
							<div style="text-align: center">
					
							<div class="inputArea">
								<button type="submit" id="updata_Btn" class="btn btn-primary">등록</button>

								<button type="button" id="back_Btn" class="btn btn-primary">취소</button>
							</div>
							</div>
						</div>
				</form>

			</div>
		</div>
	</div>
</div>
<script>
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
						var ckeditor_config = {
								   resize_enaleb : false,
								   enterMode : CKEDITOR.ENTER_BR,
								   shiftEnterMode : CKEDITOR.ENTER_P,
							   
								   filebrowserUploadUrl : '<c:url value="/ckUpload" />?${_csrf.parameterName}=${_csrf.token}'


								   
								 };
								 
								 CKEDITOR.replace("gdsDes", ckeditor_config);
						var uploadImg = $("#uploadImg");
						var pdId = '<c:out value="${goods.pdId}"/>';
						console.log("작동확인:" + pdId);
						(function() {
							var pdId = '<c:out value="${goods.pdId}"/>';
							
							// /goods/getImgList/pdId=s20220106171422239
							$.get("/goods/getImgList?pdId=" + pdId,
											function(arr) {
												

												var img = arr[0];
												var str = "";
												var fileCallPath = encodeURIComponent(img.uploadPath
														+ "\\s_" + img.fileName);
											
									
												str += "<img src ='/detail?fileName="+ fileCallPath + "'>";
												str += "<div><span>"+ img.fileName+ "</span>";
												str += "<b id='deleteBtn' data-file='"+fileCallPath;
												str += "'data-type='file'>[x]</b>";
												str += "</div></td>";
											
												uploadImg.html(str)
												$("#deleteBtn").on("click",function() {

														console.log(" 클릭 ");
														var targetFile = $(this).data("file");
														var type = $(this).data("type");

																	$.ajax({
																		url : '/deleteFile',
																		data : {
																			fileName : targetFile,
																					type : type
																				},
																				dataType : 'text',
																				type : 'GET',
																				success : function(
																						result) {
																					alert(result);
																					uploadImg
																							.remove();
																				}
																			})
																});
											});

						})();

						$("input[type='file']")
								.change(
										function(e) {
											var formData = new FormData();
											//console.log("formData:" + formData);
											var inputFile = $("input[name='uploadFile']");
											var files = inputFile[0].files;
											console.log("files.length :"
													+ files.length);
											var maxSize = 5242880;
											var regex = new RegExp(
													"(.*?)\.(exe|sh|zip|alz)$");
											// 특정 확장자 제외 있데, 허용으로 잘못 보고 있었네요.		

											function checkExtension(fileName,
													fileSize) {
												if (fileSize >= maxSize) {
													alert("파일 크기 초과");
													return false;
												}
												if (regex.test(fileName)) {
													alert("해당 확장자 업로드 불가");
													return false;
												}
												return true;
											}
											for (var i = 0; i < files.length; i++) {
												if (!checkExtension(
														files[i].name,
														files[i].size)) {
													return false;
												}
												formData.append("uploadFile",files[i]);
												//console.log("uploadFile:" + uploadFile);
												console.log("files[" + i + "]:"+ files[i]);
											}
											//console.log("uploadFile:" + formData);
											$.ajax({
												url : '/fileUploadAjax',
												processData : false,
												contentType : false,
												beforeSend : function(xhr) {
													xhr.setRequestHeader(
															csrfHeaderName,
															csrfTokenValue);
												},
												data : formData,
												type : 'POST',
												dataType : 'json',
												success : function(result) {
													console.log(result);
													showLoadImage(result);

												},
												error : function(result) {
													//console.log("error" + result);
													alert("upload fail");
												}

											});
										});

						function showLoadImage(uploadResultArr) {

							if (!uploadResultArr || uploadResultArr.length == 0) {
								alert("이미지 불러오기 실패");
								return false;
							}

							let uploadResult = $("uploadResult tr td");
							var uploadResultCnt = ($("#uploadResult td").length);
							var str = "";
							var obj = uploadResultArr[0];
							console.log("uploadResultCnt : " + uploadResultCnt);

							var fileCallPath = encodeURIComponent(obj.uploadPath
									+ "\\s_" + obj.fileName);
							console.log(" fileCallPath" + fileCallPath);
							if ((uploadResultCnt != 0)
									&& (uploadResultCnt % 4 == 0)) {
								str += "<tr class = 'img-view'>";
							}
							str += "<td id='imgFile' data-uuid='" +obj.uuId;
							str +="' data-path='"+ obj.uploadPath;
							str +="' data-fileName='" + obj.fileName;
							str +="'><img src ='/detail?fileName="+ fileCallPath + "'>";
							str += "<div><span>" + obj.fileName + "</span>";
							str += "<b id='deleteBtn' data-file='"+fileCallPath;
							str += "'data-type='file'>[x]</b>";
							str += "</div></td>";
							console.log(" str :" + str);
							if ((uploadResultCnt != 0)
									&& (uploadResultCnt % 4 == 0)) {
								$("#uploadResult tr:last").after(str);

							} else {

								$("#uploadResult td:last").after(str);
							}
							$("#deleteBtn").on("click", function() {

								console.log(" 클릭 ");
								var targetFile = $(this).data("file");
								var type = $(this).data("type");
								var targetLi = $(this).closest("td");
								$.ajax({
									url : '/deleteFile',
									data : {
										fileName : targetFile,
										type : type
									},
									dataType : 'text',
									type : 'GET',
									success : function(result) {
										alert(result);
										targetLi.remove();
									}
								})
							});

						}

						$("button[type='submit']")
								.on(
										"click",
										function(e) {
											// 게시글 등록을 눌렀을때,
											<sec:authorize access="isAuthenticated()">
											userId='${pinfo.username}';
											</sec:authorize>
							
											console.log("userId: "+userId);
											str+="<input type='hidden' name='userId' value='"+userId;
											str+="'>";
											e.preventDefault();// 기본이벤트는 차단하고,
											console.log("submit clicked");
											// 글 등록 버튼을 누르면 첨부파일의 정보도 함께 전송 되도록 수정.
											var str = "";
											$("#uploadResult td")
													.each(
															function(i, obj) {
																var jobj = $(obj);
																console.dir(jobj);//console.dir() JavaScript 객체의 모든 속성을 보는 방법.

																console.log(i);
																console.log("-----------------");
																console.log(jobj.data("filename"));
																str += "<input type='hidden' name='ImgList[";
																str += i+ "].fileName' value='"+ jobj.data("filename");
																str += "'>";
																str += "<input type='hidden' name='ImgList[";
																str += i+ "].uuId' value='"+ jobj.data("uuid");
																str += "'>";
																str += "<input type='hidden' name='ImgList[";
																str += i+ "].uploadPath' value='"+ jobj.data("path");
																str += "'>";
																str += "<input type='hidden' name='ImgList[";
																str += i+ "].pdId' value='"+ pdId;
																str += "'>";		
															});
											//console.log("-----------------");
											console.log(str);
											//console.log("-----------------");

											formObj.append(str).submit();
											// 첨부파일의 정보들을 li 의 data 	값으로 가지고 있다가
											// hidden 으로 폼에 포함.
										});

						$("#back_Btn").click(function() {
							formObj.attr("action","/goods/main").attr("method","get");
							var pageNumTag=$("input[name='pageNum']");
							var amountTag=$("input[name='amount']");
							var keywordTag = $("input[name='keyword']");
							var typeTag = $("input[name='type']");
							formObj.empty();//폼의 내용들 비우기.
							formObj.append(pageNumTag);
							formObj.append(amountTag);
							formObj.append(keywordTag);
							formObj.append(typeTag);
						});
					});
</script>
</html>