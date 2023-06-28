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
<title>출고 관리</title>
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
			$("#iteminDt, #itemoutDt").datepicker({
				showOn : "button",
				buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
				buttonImageOnly : true,
				buttonText : "Select date",
				dateFormat : "yy/mm/dd"
			});

			$(".input_number, .input_number1").on("keyup", function(event) {
				$(this).val($(this).val().replace(/[^0-9,.+-]/g,""));
			}).on("focus", function() {
				this.select();
			});
            $("input[name=outQty]").on("keyup", function(event) {
				$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			});

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//-------------------------------------------------------------
			$('#btnUpdateClose, #btnClose').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileItemOutListPage.do'/>";
				frm.submit();
			});
			 var stockQty=parseInt($('#stockQty').val());
             var outQty=parseInt($('#outQty').val());
			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdate').click(function() {
				$('.card-body select').attr("disabled", false);
				$('.card-body select').css("background-color", "");
				$('.card-body input').attr("readOnly", false);
				$('#departCd').attr("readOnly", true);
				document.objForm.crudType.value = 'U'
					$('#stockQty').val(outQty+stockQty);
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
				$('#stockQty').val(stockQty);
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
						// 숫자콤마제거
						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""))
						});
						cfAjaxCallAndGoLink("<c:url value='/itemOutSaveAct.do'/>", $('#objForm').serialize()
								, '삭제 되었습니다.', 'searchForm', "<c:url value='/mobileItemOutListPage.do'/>");
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
						// 숫자콤마제거
						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""))
						});
						cfAjaxCallAndGoLink("<c:url value='/itemOutSaveAct.do'/>", $('#objForm').serialize()
								, '수정 되었습니다.', 'searchForm', "<c:url value='/mobileItemOutListPage.do'/>");
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
						// 숫자콤마제거
						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""))
						});
						cfAjaxCallAndGoLink("<c:url value='/itemOutSaveAct.do'/>", $('#objForm').serialize()
								, '생성 되었습니다.', 'searchForm', "<c:url value='/mobileItemOutListPage.do'/>");
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
				fn_init_value();
				fn_btn_show_hide();
			});
		});
	})(jQuery);

	function fn_init_value() {

		if ($("#itemOutTypeCd").val().trim() == "") {
			$("#itemOutTypeCd").val("OUT_WAIT");
		}
		// selectbox search
		$(".selectpicker").selectpicker();
		$(".selectpicker").parent().addClass("col-sm-12");
		$(".selectpicker").next("button").addClass("form-control2");
		$(".selectpicker").parent().wrap("<div class='row'></div>");
	}

	function fn_submit_validation() {

		if ($("#itemoutDt").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 출고일자"));
			$("#itemoutDt").focus();
			return false;
		}

		if ($("#custCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 납품처"));
			$("#custCd").focus();
			return false;
		}

		if ($("#itemOutTypeCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 출고구분"));
			$("#itemOutTypeCd").focus();
			return false;
		}

		if ($("#outQty").val().trim() == '' || $("#outQty").val().trim() == 0) {
			alert(MSG_COM_ERR_001.replace("[@]", " : 출고수량"));
			$("#outQty").focus();
			return false;
		}

		if (!cfCheckDigit($("#outQty").val())) {
			alert(MSG_COM_ERR_008.replace("[@]", " : 출고수량"));
			$("#outQty").focus();
			return false;
		}

		var stockQty = parseInt(cfIsNullString($("#stockQty").val().replace(/[^0-9]/gi, ""), 0));
		var outQty = parseInt(cfIsNullString($("#outQty").val().replace(/[^0-9]/gi, ""), 0));

		var crudType = document.objForm.crudType.value;


		//미입고수량
		if (parseInt(outQty) > parseInt(stockQty)) {
			alert("출고수량은 잔여수량을 넘을수 없습니다.");
			$("#outQty").focus();
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

			$('#prodPoNo').attr("readOnly", true);
			$('#itemNm').attr("readOnly", true);
			$("#iteminDt").datepicker('option', 'disabled', true);
			$("#iteminDt").css("background-color", "#e9ecef");
			$("#itemoutDt").datepicker('option', 'disabled', true);
			$("#itemoutDt").css("background-color", "#e9ecef");
			$("#stockQty").datepicker('option', 'disabled', true);
			$("#stockQty").css("background-color", "#e9ecef");
			$('.selectpicker').prop('disabled', true);
			$('.selectpicker').selectpicker('refresh');
			if( ${rtn.obj.itemOutTypeCd =='OUT'} ) {
				$("#btnEnableUpdate, #btnDelete").addClass("disabled");

				$("#btnEnableUpdate, #btnDelete").unbind().click(function(){
					cfAlert("출고처리되어 수정 또는 삭제 할 수 없습니다.");
					return false;
				});
			}
		} else if (document.objForm.crudType.value == 'U') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').show();
			$('#viewCreate').hide();

			$('#prodPoNo').attr("readOnly", true);
			$('#itemNm').attr("readOnly", true);
			$("#iteminDt").datepicker('option', 'disabled', true);
			$("#iteminDt").css("background-color", "#e9ecef");
			$("#inokQty").datepicker('option', 'disabled', true);
			$("#inokQty").css("background-color", "#e9ecef");
			$("#stockQty").datepicker('option', 'disabled', true);
			$("#stockQty").css("background-color", "#e9ecef");

			$('#lotid').attr("readOnly", true);
			$("#lotid").css("background-color", "");
			$('#lotOutId').attr("readOnly", true);
			$("#lotOutId").css("background-color", "");
			$('.selectpicker').prop('disabled', false);
			$('.selectpicker').selectpicker('refresh');
		} else if (document.objForm.crudType.value == 'C') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').show();

			$('#prodPoNo').attr("readOnly", true);
			$('#itemNm').attr("readOnly", true);
			$("#iteminDt").datepicker('option', 'disabled', true);
			$("#iteminDt").css("background-color", "#e9ecef");
			$("#stockQty").datepicker('option', 'disabled', true);
			$("#stockQty").css("background-color", "#e9ecef");
		}
	}
	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<!-- container [S] -->
	<div id="container">
		<!-- card [S] -->
		<div class="card">
			<!-- card-body [S] -->
			<div class="card-body card-roundbox">
				<div class="container-fluid">
					<h1>출고 관리</h1>
				</div>
				<form:form commandName="obj" id="objForm" name="objForm">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
					<input type="hidden" name="itemoutSeq" value="${search.itemoutSeq}" />
					<div class="card card-mobile">
						<div class="card-header card-header-mobile">
							<h3 class="text-center font-weight-light my-1">입고 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="iteminDt">입고일자</label>
										<input class="form-control3 align-top" id="iteminDt" name="iteminDt" type="text" value="${itemInVo.iteminDt}" readonly />
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="itemNm">제품명</label>
										<input class="form-control" id="itemCd" name="itemCd" type="hidden" value="${itemInVo.itemCd}" />
										<input class="form-control" id="itemNm" name="itemNm" type="text" value="${itemInVo.itemNm}" readonly />
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="lotid">입고LOT</label>
										<input class="form-control" id="lotid" name="lotid" type="text" value="${itemInVo.lotid}" readonly />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="inokQty">입고수량</label>
										<input class="form-control input_number" id="inokQty" name="inokQty" type="text" value="<fmt:formatNumber value="${itemInVo.inokQty}" pattern="###,###"/>" readonly />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="stockQty">잔여수량</label>
										<input class="form-control input_number" id="stockQty" name="stockQty" type="text" value="<fmt:formatNumber value="${itemInVo.stockQty}" pattern="###,###"/>" readonly />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card card-mobile">
						<div class="card-header card-header-mobile">
							<h3 class="text-center font-weight-light my-1">출고 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="itemoutDt" style="display: block;">출고일자</label>
										<input class="form-control3 align-top" id="itemoutDt" name="itemoutDt" type="text" value="${rtn.obj.itemoutDt}" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="custCd">납품처</label>
										<select class="selectpicker" id="custCd" name="custCd" data-size="7" data-live-search="true">
											<option value="">납품처 선택</option>
											<c:forEach items="${cust_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.custCd == rtn.obj.custCd}">
														<option value="${item.custCd}" selected>${item.custNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${item.custCd}">${item.custNm}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="itemOutTypeCd">출고구분</label>
										<select class="form-control2" id="itemOutTypeCd" name="itemOutTypeCd">
											<option value="">상태 코드 선택</option>
											<c:forEach items="${item_out_type_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.itemOutTypeCd}">
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
										<label class="small mb-1" for="outQty">출고수량</label>
										<input class="form-control input_number" id="outQty" name="outQty" type="text" value="<fmt:formatNumber value="${rtn.obj.outQty == null ? 0:rtn.obj.outQty}" pattern="###,###"/>" />
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="lotOutId">출고Lot</label>
										<input class="form-control" id="lotOutId" name="lotOutId" type="text" value="${rtn.obj.lotOutId}" readonly />
									</div>
								</div>
							</div>
							<!-- 변경 최초 버튼 상태 -->
							<div id="viewUpdateDisable" class="col-md-12" style="display: none;">
								<div class="form-row">
									<div class="col-md-4">
										<div id="btnEnableUpdate" class="btn btn-dark btn-block">수정</div>
									</div>
									<div class="col-md-4">
										<div id="btnDelete" class="btn btn-dark btn-block">삭제</div>
									</div>
									<div class="col-md-4">
										<div id="btnUpdateClose" class="btn btn-dark btn-block">닫기</div>
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
										<div id="btnClose" class="btn btn-primary btn-block">닫기</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form:form>
			</div>
			</main>
		</div>
	</div>

	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
		<input type="hidden" name="pageSize" value="${search.pageSize}" />
		<input type="hidden" name="sortCol" value="${search.sortCol}" />
		<input type="hidden" name="sortType" value="${search.sortType}" />
		<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
		<input type="hidden" name="lotid" value="${search.lotid}" />
		<input type="hidden" id="searchFromDate" name="searchFromQmCheckdt" type="text" value="${param.searchFromQmCheckdt}" />
		<input type="hidden" id="searchToDate" name="searchToQmCheckdt" type="text" value="${param.searchToQmCheckdt}" />
		<input type="hidden" id="searchType" name="searchType" value="${param.searchType}">
	</form:form>
</body>
</html>