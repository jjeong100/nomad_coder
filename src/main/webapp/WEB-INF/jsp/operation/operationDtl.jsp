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
<title>공정코드 상세정보 관리</title>
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

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//-------------------------------------------------------------
			$('#btnUpdateClose,#btnCreateClose').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/operationListPage.do'/>";
				frm.submit();
			});

			$('#outcustYn').change(function() {
				if (cfIsNull($(this).val())) {
					$('#custCd').val('');
					$('#custCd').attr("disabled", true);
					$('#custCd').css("background-color", "#e9ecef");
				} else if ($(this).val() == 'Y') {
					$('#custCd').attr("disabled", false);
					$('#custCd').css("background-color", "");
				} else {
					$('#custCd').val('');
					$('#custCd').attr("disabled", true);
					$('#custCd').css("background-color", "#e9ecef");
				}
			});

			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdate').click(function() {
				$('.card-body select').attr("disabled", false);
				$('.card-body select').css("background-color", "");
				$('.card-body input').attr("readOnly", false);
				$('#operCd').attr("readOnly", true);

				if (cfIsNull($('#outcustYn').val())) {
					$('#custCd').attr("disabled", true);
					$('#custCd').css("background-color", "#e9ecef");
				} else if ($('#outcustYn').val() == 'Y') {
					$('#custCd').attr("disabled", false);
					$('#custCd').css("background-color", "");
				} else {
					$('#custCd').attr("disabled", true);
					$('#custCd').css("background-color", "#e9ecef");
				}
				document.objForm.crudType.value = 'U'
				fn_btn_show_hide();
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
						cfAjaxCallAndGoLink("<c:url value='/operationSaveAct.do'/>", $('#objForm').serialize(), '삭제 되었습니다.', 'searchForm', "<c:url value='/operationListPage.do'/>");
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
				if (!fn_submit_validation()) {
					return false;
				}
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
						cfAjaxCallAndGoLink("<c:url value='/operationSaveAct.do'/>", $('#objForm').serialize(), '수정 되었습니다.', 'searchForm', "<c:url value='/operationListPage.do'/>");
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
				if (!fn_submit_validation()) {
					return false;
				}
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
						cfAjaxCallAndGoLink("<c:url value='/operationSaveAct.do'/>", $('#objForm').serialize(), '생성 되었습니다.', 'searchForm', "<c:url value='/operationListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
				fn_btn_show_hide();

				if( ${rtn.obj.outcustYn == null} ) {
					$("#outcustYn  option:eq(2)").prop("selected", true);
				}

				// selectbox search
				$(".selectpicker").selectpicker();
				$(".selectpicker").parent().addClass("col-sm-12");
				$(".selectpicker").next("button").addClass("form-control2");
				$(".selectpicker").parent().wrap("<div class='row'></div>");
			});
		});
	})(jQuery);

	function fn_submit_validation() {
		if ($("#operCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 공정 코드"));
			$("#operCd").focus();
			return false;
		}
		if ($("#operNm").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 공정명"));
			$("#operNm").focus();
			return false;
		}
		if ($("#visionYn").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 비전검사여부"));
			$("#visionYn").focus();
			return false;
		}
		return true;
	}

	function fn_btn_show_hide() {
		if (document.objForm.crudType.value == 'R') {
			$('#viewUpdateDisable').show();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').hide();
			$('.card-body select').attr("disabled", true);
			$('.card-body select').css("background-color", "#e9ecef");
			$('.card-body input').attr("readOnly", true);
			$('.selectpicker').prop('disabled', true);
			$('.selectpicker').selectpicker('refresh');
		} else if (document.objForm.crudType.value == 'U') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').show();
			$('#viewCreate').hide();
			$('.selectpicker').prop('disabled', false);
			$('.selectpicker').selectpicker('refresh');
		} else if (document.objForm.crudType.value == 'C') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').show();
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
				<h1 class="mt-4">공정코드 상세정보</h1>
				<form name="objForm" id="objForm">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<input type="hidden" name="operSeq" value="${rtn.obj.operSeq}" />

					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">기본정보</h3>
						</div>

						<div class="card-body">

							<div class="form-row">
							<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="operCd">공정코드</label>
										<input class="form-control" id="operCd" name="operCd" type="text" value="${rtn.obj.operCd}" placeholder="공정코드를 입력하세요" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="operNm">공정명</label>
										<input class="form-control" id="operNm" name="operNm" type="text" value="${rtn.obj.operNm}" placeholder="공정명을 입력하세요" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="visionYn">비전검사여부</label>
										<select class="form-control2" id="visionYn" name="visionYn">
											<option value="">비전검사여부 선택</option>
											<c:forEach items="${yn_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.visionYn}">
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
								<div class="col-md-12">
									<div class="form-group">
										<label class="small mb-1" for="bigo">비고</label>
										<input class="form-control" id="bigo" name="bigo" type="text" value="${rtn.obj.bigo}" placeholder="비고를 입력하세요" />
									</div>
								</div>
							</div>

						</div>
					</div>
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header"></div>
						<div class="card-body">
							<!-- 변경 최초 버튼 상태 -->
							<div id="viewUpdateDisable" class="col-md-12" style="display: none;">
								<div class="form-row">
									<div class="col-md-4">
										<div id="btnEnableUpdate" class="btn btn-primary btn-block">수정</div>
									</div>
									<div class="col-md-4">
										<div id="btnDelete" class="btn btn-primary btn-block">삭제</div>
									</div>
									<div class="col-md-4">
										<div id="btnUpdateClose" class="btn btn-primary btn-block">닫기</div>
									</div>
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
				</form>
			</div>
			</main>
		</div>
	</div>
	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" name="pageIndex" value="1" />
		<input type="hidden" name="operSeq" value="${search.operSeq}" />
	</form:form>
	<script>

	</script>
</body>
</html>