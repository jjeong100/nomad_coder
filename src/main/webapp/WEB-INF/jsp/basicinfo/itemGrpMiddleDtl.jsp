<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
<title>제품 중분류 관리</title>
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
			$(".input_number, .input_number1").on("keyup", function(event) {
				$(this).val($(this).val().replace(/[^0-9,.+-]/g,""));
				fn_changePerformance();
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
				frm.action = "<c:url value='/itemGrpMiddleListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdate').click(function() {
				$('.card-body select').attr("disabled", false);
				$('.card-body select').css("background-color", "");
				$('.card-body input').attr("readOnly", false);
				$('#departCd').attr("readOnly", true);
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

						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""))
						});

						cfAjaxCallAndGoLink("<c:url value='/itemGrpMiddleSaveAct.do'/>", $('#objForm').serialize(), '삭제 되었습니다.', 'searchForm', "<c:url value='/itemGrpMiddleListPage.do'/>");
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

						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""))
						});
						
						$("select[id^='performanceTypeCd']").attr("disabled", false);
						
						cfAjaxCallAndGoLink("<c:url value='/itemGrpMiddleSaveAct.do'/>", $('#objForm').serialize(), '수정 되었습니다.', 'searchForm', "<c:url value='/itemGrpMiddleListPage.do'/>");
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

						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""))
						});
						
						$("select[id^='performanceTypeCd']").attr("disabled", false);
						
						cfAjaxCallAndGoLink("<c:url value='/itemGrpMiddleSaveAct.do'/>", $('#objForm').serialize(), '생성 되었습니다.', 'searchForm', "<c:url value='/itemGrpMiddleListPage.do'/>");
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
				
				if( ${rtn.obj.performanceTypeCnt == null} ) {
					$("#performanceTypeCnt").val(0);
				}
				
				fn_changePerformance();
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
		} else if (document.objForm.crudType.value == 'U') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').show();
			$('#viewCreate').hide();
			fn_changePerformance();
		} else if (document.objForm.crudType.value == 'C') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').show();
		}
	}
	
	function fn_changePerformance() {
		var performanceTypeCnt = cfIsNullString($("#performanceTypeCnt").val(), "0");
		
		if (document.objForm.crudType.value == 'R') {
			return false;
		}
		
		$("select[id^='performanceTypeCd']").each(function(idx, obj) {
			if( parseInt(performanceTypeCnt) < idx + 1 ) {
				$(obj).val("").attr("disabled", true).css("background-color", "#e9ecef");
			} else {
				$(obj).attr("disabled", false).css("background-color", "");
			}
		});
	}
	
	function fn_submit_validation() {
		if ($("#matgpCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 대분류명"));
			$("#matgpCd").focus();
			return false;
		}
		
		if ($("#itmgpNm").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 중분류명"));
			$("#itmgpNm").focus();
			return false;
		}
		
		var checkBool = true;
		$("select[id^='performanceTypeCd']").each(function(idx, obj) {
			if( cfIsNull($(obj).attr("disabled")) ) {
				if ($(obj).val().trim() == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 성능구분" + (idx+1) + "값"));
					$(obj).focus();
					checkBool = false;
					return false;
				}
			}
		});
		
		if( !checkBool ) {
			return checkBool;
		}
		
		return true;
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
				<h1 class="mt-4">제품 중분류</h1>
				<form name="objForm" id="objForm">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">상세정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="matgpCd">대분류명</label>
										<select class="form-control2" id="matgpCd" name="matgpCd">
											<option value="">대분류 선택</option>
											<c:forEach items="${itemGrpMainList}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.matgpCd == rtn.obj.matgpCd}">
														<option value="${item.matgpCd}" selected>${item.matgpNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.matgpCd}">${item.matgpNm}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="departNm">중분류명</label>
										<input class="form-control" id="itmgpCd" name="itmgpCd" type="hidden" value="${rtn.obj.itmgpCd}">
										<input class="form-control" id="itmgpNm" name="itmgpNm" type="text" value="${rtn.obj.itmgpNm}" placeholder="중분류명을 입력하세요">
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="addRate">생산추가비율</label>
										<input class="form-control input_number" id="addRate" name="addRate" type="text" value="${rtn.obj.addRate}" placeholder="생산추가비율을 입력하세요">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="performanceTypeCnt">성능구분개수</label>
										<input class="form-control input_number" id="performanceTypeCnt" name="performanceTypeCnt" type="text" maxlength="1" value="<fmt:formatNumber value="${rtn.obj.performanceTypeCnt}" pattern="#,###"/>" placeholder="성능구분개수를 입력하세요">
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-2">
									<div class="form-group">
										<label class="small mb-1" for="performanceTypeCd1">성능구분1</label>
										<select class="form-control2" id="performanceTypeCd1" name="performanceTypeCd1">
											<option value="">성능구분 선택</option>
											<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.performanceTypeCd1}">
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
								<div class="col-md-2">
									<div class="form-group">
										<label class="small mb-1" for="performanceTypeCd2">성능구분2</label>
										<select class="form-control2" id="performanceTypeCd2" name="performanceTypeCd2">
											<option value="">성능구분 선택</option>
											<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.performanceTypeCd2}">
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
								<div class="col-md-2">
									<div class="form-group">
										<label class="small mb-1" for="performanceTypeCd3">성능구분3</label>
										<select class="form-control2" id="performanceTypeCd3" name="performanceTypeCd3">
											<option value="">성능구분 선택</option>
											<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.performanceTypeCd3}">
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
								<div class="col-md-2">
									<div class="form-group">
										<label class="small mb-1" for="performanceTypeCd4">성능구분4</label>
										<select class="form-control2" id="performanceTypeCd4" name="performanceTypeCd4">
											<option value="">성능구분 선택</option>
											<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.performanceTypeCd4}">
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
								<div class="col-md-2">
									<div class="form-group">
										<label class="small mb-1" for="performanceTypeCd5">성능구분5</label>
										<select class="form-control2" id="performanceTypeCd5" name="performanceTypeCd5">
											<option value="">성능구분 선택</option>
											<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.performanceTypeCd5}">
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
										<input class="form-control" id="bigo" name="bigo" type="text" value="${rtn.obj.bigo}" placeholder="비고를 입력하세요">
									</div>
								</div>
							</div>
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
		<input type="hidden" name="matgpNm" value="${search.matgpNm}" />
		<input type="hidden" name="itmgpNm" value="${search.itmgpNm}" />
	</form:form>
	<script>
		
	</script>
</body>
</html>