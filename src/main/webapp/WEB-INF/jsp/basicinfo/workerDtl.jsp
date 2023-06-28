<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
<title>작업자 상세정보 관리</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
	//=====================================================================
	// jquery logic
	//=====================================================================
	(function($) {
		$(function() {
			//-------------------------------------------------------------
			// declare gloval
			//-------------------------------------------------------------
			$(".input_number, .input_number1, .input_number_mobile").on("keyup", function(event) {
				$(this).val($(this).val().replace(/[^0-9,.+-]/g,""));
			}).on("focus", function() {
				this.select();
			});

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//-------------------------------------------------------------
			$('#btnUpdateClose,#btnCreateClose').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/workerListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdate').click(function() {
				$('.card-body select').attr("disabled", false);
				$('.card-body select').css("background-color", "");
				$('.card-body input').attr("readOnly", false);
				$('#loginId').attr("readOnly", true);
				document.objForm.crudType.value = 'U'
				fn_btn_show_hide();

				if ('${roleId}' != 'SYSTEM' && '${roleId}' != 'MANAGER') {
					$("#sabunId").attr("disabled", true);
					$("#sabunId").css("background-color", "#e9ecef");
					$("#shortId").attr("disabled", true);
					$("#shortId").css("background-color", "#e9ecef");
					$("#levelCd").attr("disabled", true);
					$("#levelCd").css("background-color", "#e9ecef");
					$("#operAuthCd").attr("disabled", true);
					$("#operAuthCd").css("background-color", "#e9ecef");
				}
			});

			//-------------------------------------------------------------
			// 수정 취소 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdateCancel').click(function() {
				$('.card-body select').attr("disabled", true);
				$('.card-body select').css("background-color", "#e9ecef");
				$('.card-body input').attr("readOnly", true);
				document.objForm.crudType.value = 'R'
				fn_btn_show_hide();
			});

			//-------------------------------------------------------------
			// 삭제 이벤트
			//-------------------------------------------------------------
			$('#btnDelete').click(function() {
				$("#glv_del_confirm").dialog("open");
			});

			$("#glv_del_confirm").dialog({
				autoOpen : false,
				width : 400,
				buttons : [ {
					text : "확인",
					click : function() {
						$(this).dialog("close");
						document.objForm.crudType.value = 'D';
						cfAjaxCallAndGoLink("<c:url value='/workerSaveAct.do'/>", $('#objForm').serialize(), '삭제 되었습니다.', 'searchForm', "<c:url value='/workerListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});

			//-------------------------------------------------------------
			// 변경 이벤트
			//-------------------------------------------------------------
			$('#btnUpdate').click(function() {
				if ($("#loginId").val().trim() == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 아이디"));
					$("#loginId").focus();
					return false;
				}
				if ($("#loginName").val().trim() == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 이름"));
					$("#loginName").focus();
					return false;
				}
				/* if ($("#shortId").val().trim() == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 숏아이디"));
					$("#shortId").focus();
					return false;
				}
				if ($("#shortId").val() == "${rtn.obj.shortId}") {
					$("#glv_upd_confirm").dialog("open");
				} else {
					getUserNameByShortId("U");
				} */

				$("#glv_upd_confirm").dialog("open");
			});

			$("#glv_upd_confirm").dialog({
				autoOpen : false,
				width : 400,
				buttons : [ {
					text : "변경",
					click : function() {
						$(this).dialog("close");
						document.objForm.crudType.value = 'U';
						cfAjaxCallAndGoLink("<c:url value='/workerSaveAct.do'/>", $('#objForm').serialize(), '수정 되었습니다.', 'searchForm', "<c:url value='/workerListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});

			//-------------------------------------------------------------
			// 생성 이벤트
			//-------------------------------------------------------------
			$('#btnCreate').click(function() {
				if ($("#loginId").val().trim() == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 아이디"));
					$("#loginId").focus();
					return false;
				}
				if ($("#loginName").val().trim() == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 이름"));
					$("#loginName").focus();
					return false;
				}

				/* if ($("#shortId").val().trim() == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 숏아이디"));
					$("#shortId").focus();
					return false;
				} */
				//getUserNameByShortId("C");

				$("#glv_ins_confirm").dialog("open");
			});

			$("#glv_ins_confirm").dialog({
				autoOpen : false,
				width : 400,
				buttons : [ {
					text : "생성",
					click : function() {
						$(this).dialog("close");
						document.objForm.crudType.value = 'C';
						cfAjaxCallAndGoLink("<c:url value='/workerSaveAct.do'/>", $('#objForm').serialize(), '생성 되었습니다.', 'searchForm', "<c:url value='/workerListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});

			getUserNameByShortId = function(type) {
				$.ajax({
					url : "<c:url value='/getLoginNameByShortId.do'/>",
					type : 'POST',
					data : $('#objForm').serialize(),
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					context : this,
					dataType : 'json',
					beforeSend : function() {
						$("#layoutSidenav").loading();
					},
					success : function(data) {
						$("#layoutSidenav").loadingClose();
						if (data.rtn.rc == 0) {
							alert("존재하는 숏 아이디 입니다.");
							$("#shortId").focus();
						} else {
							if (type == 'C') {
								$("#glv_ins_confirm").dialog("open");
							} else {
								$("#glv_upd_confirm").dialog("open");
							}
						}
					},
					error : function(request, status, error) {
						console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
						cfAlert('시스템 오류입니다.');
					},
					complete : function() {
						$("#layoutSidenav").loadingClose();
					}
				});
			};

			//-------------------------------------------------------------
			// 작업자 페스워드 초기화
			// 20210201 jeonghwan
			//-------------------------------------------------------------
			$('#btnResetPassWord').click(function() {
				$("#glv_reset_password_confirm").dialog("open");
			});

			$("#glv_reset_password_confirm").dialog({
				autoOpen : false,
				width : 400,
				buttons : [ {
					text : "변경",
					click : function() {
						$(this).dialog("close");
						document.objForm.crudType.value = 'U';
						cfAjaxCallAndGoLink("<c:url value='/workerResetPassWord.do'/>", $('#objForm').serialize(), '수정 되었습니다.', 'searchForm', "<c:url value='/workerListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});

			//-------------------------------------------------------------
			// 사용자 패스워드 변경
			// 20201111 jeonghwan
			//-------------------------------------------------------------
			$('#btnPassWordChange').click(function() {
				var inPassWord = $("#inPassWord").val().trim();
				var newPassWord = $("#newPassWord").val().trim();
				var confPassWord = $("#confPassWord").val().trim();

				var reg1 = /^[a-zA-Z0-9]{10,20}$/;
				var reg2 = /[a-zA-Z]/g;
				var reg3 = /[0-9]/g;

				if (inPassWord == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 이전비밀번호"));
					$("#inPassWord").focus();
					return false;
				}
				if (newPassWord == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 신규비밀번호"));
					$("#newPassWord").focus();
					return false;
				}
				if (confPassWord == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 비밀번호확인"));
					$("#confPassWord").focus();
					return false;
				}

				if (newPassWord != confPassWord) {
					alert("신규비밀번호와 비밀번호 확인이 일치 하지 않습니다.");
					$("#confPassWord").focus();
					return false;
				}

				//if (!(reg1.test(newPassWord) && reg2.test(newPassWord) && reg3.test(newPassWord))) {
				//	alert('비밀번호는 영문+숫자 혼합 10자리 이상으로 입력해주십시요');
				//	return false;
				//}

				//그밖에 필요조건..
				if (true) {
					$("#glv_password_upd_confirm").dialog("open");
				}
			});

			$("#glv_password_upd_confirm").dialog({
				autoOpen : false,
				width : 400,
				buttons : [ {
					text : "변경",
					click : function() {
						$(this).dialog("close");
						document.objForm.crudType.value = 'U';
						cfAjaxCallAndGoLink("<c:url value='/workerPassWordSaveAct.do'/>", $('#objForm').serialize(), '수정 되었습니다.', 'searchForm', "<c:url value='/workerListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});

			//-------------------------------------------------------------
			// 팝업 닫기
			//-------------------------------------------------------------
			$('.modal-close-button').click(function() {
				$('.modal-container').css("display", "none");
			});

			//-------------------------------------------------------------
			// 패스워드 변경 팝업
			//-------------------------------------------------------------
			$('#btnPassWord').click(function() {
				$('#passWordChangeModal').css("display", "block");
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
				fn_btn_show_hide();
			});
		});
	})(jQuery);

	function fn_btn_show_hide() {
		if (document.objForm.crudType.value == 'R') {
			$('#viewUpdateDisable').show();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').hide();
			$('.card-body select').attr("disabled", true);
			$('.card-body select').css("background-color", "#e9ecef");
			$('.card-body input').attr("readOnly", true);
			$('#btnPassWord').hide();
			$('#btnResetPassWord').hide();
		} else if (document.objForm.crudType.value == 'U') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').show();
			$('#viewCreate').hide();
			$('#btnPassWord').show();
			$('#btnResetPassWord').show();
		} else if (document.objForm.crudType.value == 'C') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').show();
			$('#btnPassWord').hide();
			$('#btnResetPassWord').hide();
		}
	}
	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
	<div id="layoutSidenav">
		<!-- ==================================================================================================================================== -->
		<!-- menu                                                                                                                                 -->
		<!-- ==================================================================================================================================== -->
		<jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
			<div class="container-fluid">
				<!-- ======================================================================================================================== -->
				<!-- title                                                                                                                    -->
				<!-- ======================================================================================================================== -->
				<!-- <h1 class="mt-4">거래처 관리</h1>  -->
				<!-- ======================================================================================================================== -->
				<!-- menu navigation                                                                                                          -->
				<!-- ======================================================================================================================== -->
				<h1 class="mt-4">작업자 상세정보</h1>
				<form name="objForm" id="objForm" method="post">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<input type="hidden" name="passCd" value="${rtn.obj.passCd}" />
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">필수정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="loginId">아이디</label>
										<input class="form-control" id="loginId" name="loginId" type="text" value="${rtn.obj.loginId}" placeholder="아이디를 입력하세요">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="loginName">이름</label>
										<input class="form-control" id="loginName" name="loginName" type="text" value="${rtn.obj.loginName}" placeholder="이름을 입력하세요">
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="sabunId">사번</label>
										<input class="form-control" id="sabunId" name="sabunId" type="text" value="${rtn.obj.sabunId}" placeholder="사번을 입력하세요">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="levelCd">권한등급</label>
										<select class="form-control2" id="levelCd" name="levelCd">
											<option value="">권한 등급 선택</option>
											<c:forEach items="${level_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.levelCd}">
														<option value="${item.scode}" selected>${item.codeNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.scode}">${item.codeNm}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<%-- <div class="form-group">
										<label class="small mb-1" for="shortId">숏 아이디</label>
										<input class="form-control input_number" id="shortId" name="shortId" type="text" value="${rtn.obj.shortId}" placeholder="숏 아이디를 입력하세요" maxlength="3">
									</div> --%>
								</div>
							</div>
						</div>
					</div>
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">
								상세정보
								<c:choose>
									<c:when test="${(roleId eq 'SYSTEM') or (roleId eq 'MANAGER')}">
										<div id="btnResetPassWord" class="btn btn-primary btn-sm mr-2" style="float: right;">패스워드초기화</div>
									</c:when>
								</c:choose>
								<div id="btnPassWord" class="btn btn-primary btn-sm mr-2" style="float: right;">패스워드변경</div>
							</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="departCd">부서</label>
										<select class="form-control2" id="departCd" name="departCd">
											<option value="">부서 선택</option>
											<c:forEach items="${division_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.departCd == rtn.obj.departCd}">
														<option value="${item.departCd}" selected>${item.departNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.departCd}">${item.departNm}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="jikCd">직급</label>
										<select class="form-control2" id="jikCd" name="jikCd">
											<option value="">직급 선택</option>
											<c:forEach items="${jik_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.jikCd}">
														<option value="${item.scode}" selected>${item.codeNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.scode}">${item.codeNm}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="jikchaekCd">직책</label>
										<select class="form-control2" id="jikchaekCd" name="jikchaekCd">
											<option value="">직책 선택</option>
											<c:forEach items="${jikchaek_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.jikchaekCd}">
														<option value="${item.scode}" selected>${item.codeNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.scode}">${item.codeNm}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="email">이메일</label>
										<input class="form-control" type="text" id="email" name="email" value="${rtn.obj.email}" placeholder="이메일을 입력 하세요">
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="mobileNo">전화번호</label>
										<input class="form-control" type="text" id="mobileNo" name="mobileNo" value="${rtn.obj.email}" placeholder="전화번호를 입력 하세요">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="workCd">작업조</label>
										<select class="form-control2" id="workCd" name="workCd">
											<option value="">부서 선택</option>
											<c:forEach items="${work_group_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.workCd == rtn.obj.workCd}">
														<option value="${item.workCd}" selected>${item.workNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.workCd}">${item.workNm}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<!-- 변경 최초 버튼 상태 -->
							<div id="viewUpdateDisable" class="col-md-12" style="display: none;">
								<div class="form-row">
									<c:choose>
										<c:when test="${(roleId eq 'SYSTEM') or (roleId eq 'MANAGER')}">
											<div class="col-md-4">
												<div id="btnEnableUpdate" class="btn btn-primary btn-block">수정</div>
											</div>
											<div class="col-md-4">
												<div id="btnDelete" class="btn btn-primary btn-block">삭제</div>
											</div>
											<div class="col-md-4">
												<div id="btnUpdateClose" class="btn btn-primary btn-block">닫기</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="col-md-6">
												<div id="btnEnableUpdate" class="btn btn-primary btn-block">수정</div>
											</div>
											<div class="col-md-6">
												<div id="btnUpdateClose" class="btn btn-primary btn-block">닫기</div>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<!-- 변경 가능 상태 버튼 -->
							<div id="viewUpdateEnable" class="col-md-12" style="display: none;">
								<div class="form-row">
									<div class="col-md-6">
										<div id="btnEnableUpdateCancel" class="btn btn-primary btn-block">수정 취소</div>
									</div>
									<div class="col-md-6">
										<div id="btnUpdate" class="btn btn-primary btn-block">수정 완료</div>
									</div>
								</div>
							</div>
							<!-- 생성 버튼 -->
							<div id="viewCreate" class="col-md-12" style="display: none;">
								<div class="form-row">
									<div class="col-md-6">
										<div id="btnCreate" class="btn btn-primary btn-block">생성</div>
									</div>
									<div class="col-md-6">
										<div id="btnCreateClose" class="btn btn-primary btn-block">닫기</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 패스워드 변경 팝업 20201111 jeonghwan-->
					<div id="passWordChangeModal" class="modal-container">
						<div class="modal-content3">
							<div class="modal-header">
								<div class="txt20">패스워드 변경</div>
								<span class="modal-close-button">×</span>
							</div>
							<div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
								<div class="card-header">
									<h3 class="text-left font-weight-light my-1">
										사번 : ${rtn.obj.sabunId}
										&nbsp;
										&nbsp;
										&nbsp;
										&nbsp;
										&nbsp;
										이름 :${rtn.obj.loginName}
										<div id="btnPassWordChange" class="btn btn-primary btn-sm mr-2" style="float: right;">패스워드변경</div>
									</h3>
								</div>
								<div id="previewPassWordChange">
									<div class="form-group">
										<label class="small mb-1" for="inPassWord">이전비밀번호</label>
										<input class="form-control" id="inPassWord" name="inPassWord" type="password" autocomplete="new-password" placeholder="이전비밀번호을 입력하세요">
									</div>
									<div class="form-group">
										<label class="small mb-1" for="newPassWord">신규비밀번호</label>
										<input class="form-control" id="newPassWord" name="newPassWord" type="password" autocomplete="new-password" placeholder="신규비밀번호을 입력하세요">
									</div>
									<div class="form-group">
										<label class="small mb-1" for="confPassWord">비밀번호확인</label>
										<input class="form-control" id="confPassWord" name="confPassWord" type="password" autocomplete="new-password" placeholder="비밀번호확인을 입력하세요">
									</div>
								</div>
							</div>
						</div>
					</div>

				</form>
			</div>
			</main>
		</div>
	</div>


	<!-- 20201111 jeonghwan -->
	<div id="glv_password_upd_confirm" title="확인" style="display: none;">
		<div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
			<p>변경 하시겠습니까 ?</p>
		</div>
	</div>
	<!-- 20210104 jeonghwan -->
	<div id="glv_reset_password_confirm" title="확인" style="display: none;">
		<div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
			<p>페스워드 초기화 하시겠습니까 ?</p>
		</div>
	</div>
	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" name="pageIndex" value="1" />
		<input type="hidden" name="searchLoginName" value="${search.searchLoginName}" />
		<input type="hidden" name="searchSabunId" value="${search.searchSabunId}" />
	</form:form>
	<script>

	</script>
</body>
</html>