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
<title>완제품 QM</title>
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
			$("#qmCheckdt").datepicker({
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

			$("input[name=checkQty]").on("keyup", function(event) {
				$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				var actbadQtysum = Number($("#checkQty").val().replace(",",""))-Number($("#actokQty").val().replace(",",""))
				$("#actbadQty").val(Number(actbadQtysum));
			});

			$("input[name=actokQty]").on("keyup", function(event) {
				$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				var actbadQtysum = Number($("#checkQty").val().replace(",",""))-Number($("#actokQty").val().replace(",",""))
				$("#actbadQty").val(Number(actbadQtysum));		
			});

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------

			//-------------------------------------------------------------
			// 파일 행추가
			//-------------------------------------------------------------
			$("#btnAddRow").click(function() {
				var idx = $("select[id^='badCd']").length;

				var html = "";
				html += "<div id=\"badRow" + idx + "\" class=\"row col-md-12\">";
				html += "	<div class=\"col-md-3\">";
				html += "		<div class=\"form-group\">";
				html += "			<label class=\"small mb-1\" for=\"badCd" + idx + "\">불량코드</label>";
				html += "			<select class=\"form-control2\" id=\"badCd" + idx + "\" name=\"objList[" + idx + "].badCd\">";
				html += "				<option value=\"\">불량 코드 선택</option>";

				<c:forEach items="${bad_cd_list}" var="item" varStatus="status">
					html += "			<option value=\"${item.scode}\">${item.codeNm}</option>";
				</c:forEach>

				html += "			</select>";
				html += "		</div>";
				html += "	</div>";
				html += "	<div class=\"col-md-3\">";
				html += "		<div class=\"form-group\">";
				html += "			<label class=\"small mb-1\" for=\"badQty" + idx + "\">불량수량</label>";
				html += "			<input class=\"form-control input_number\" id=\"badQty" + idx + "\" name=\"objList[" + idx + "].badQty\" type=\"text\" value=\"\" placeholder=\"불량수량을 입력 하세요\" onkeyup=\"javascript:fn_sum_qty(this);\"/>";
				html += "			<input type=\"hidden\" name=\"objList[" + idx + "].mqcBadSeq\" value=\"\" />";
				html += "		</div>";
				html += "	</div>";

				html += "	<div class=\"col-md-3\">";
				html += "		<div class=\"form-group\">";
				html += "			<div class=\"m-4\">";
				html += "				<span class=\"btn btn-sm btn-danger\" onclick=\"javascript:fn_DelRowFinishQmBad(''," + idx + ")\">행삭제</span>";
				html += "			</div>";
				html += "		</div>";
				html += "	</div>";

				html += "</div>";
				$("#divBadRow").append(html);
			});

			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//-------------------------------------------------------------
			$('#btnCreateClose, #btnUpdateClose, #btnClose').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/finishQmListPage.do'/>";
				frm.submit();
			});



			 var remActokQty=parseInt($('#remActokQty').val());
             var checkQty=parseInt($('#checkQty').val());
			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdate').click(function() {
				$('.card-body select').attr("disabled", false);
				$('.card-body select').css("background-color", "");
				$('.card-body input').attr("readOnly", false);
				$('#departCd').attr("readOnly", true);
				document.objForm.crudType.value = 'U'
				$('#remActokQty').val(remActokQty+checkQty);
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
				$('#remActokQty').val(remActokQty);
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
						cfAjaxCallAndGoLink("<c:url value='/finishQmSaveAct.do'/>", $('#objForm').serialize()
								, '삭제 되었습니다.', 'searchForm'
								, "<c:url value='/finishQmListPage.do'/>");
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
						cfAjaxCallAndGoLink("<c:url value='/finishQmSaveAct.do'/>", $('#objForm').serialize()
								, '수정 되었습니다.', 'searchForm'
								, "<c:url value='/finishQmListPage.do'/>");
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
						// 숫자콤마제거
						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""))
						});

						document.objForm.crudType.value = 'C';
						cfAjaxCallAndGoLink("<c:url value='/finishQmSaveAct.do'/>", $('#objForm').serialize()
								, '생성 되었습니다.', 'searchForm'
								, "<c:url value='/finishQmListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});

			//-------------------------------------------------------------
			// 불량 코드 변경 이벤트
			//-------------------------------------------------------------
			$('#badCd').on('change', function() {
				if (cfIsNull($(this).val())) {
					$('#actbadQty').val(0);
					$('#actbadQty').attr("readOnly", true);
				} else {
					$('#actbadQty').attr("readOnly", false);
				}
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
				fn_btn_show_hide();
				fn_init_value();
			});
		});
	})(jQuery);

	function fn_init_value() {
		$("#qmCheckdt").val('${rtn.obj.qmCheckdt}');

		if (cfCheckDigit(document.objForm.poQty.value)) {
			document.objForm.poQty.value = parseFloat(document.objForm.poQty.value);
		}

		if( ${rtn.obj.qmStateCd == null} ) {
			$("#qmStateCd  option:eq(2)").prop("selected", true);
		}
	}

	//-------------------------------------------------------------
	// validation
	//-------------------------------------------------------------
	function fn_submit_validation() {
		if ($("#checkQty").val().trim() == '' ||$("#checkQty").val().trim() == 0 ) {
			alert(MSG_COM_ERR_001.replace("[@]", " : 검품수량"));
			$("#checkQty").focus();
			return false;
		}
		if ($("#actokQty").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 양품수량"));
			$("#actokQty").focus();
			return false;
		}
		if ($("#qmStateCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 상태코드"));
			$("#qmStateCd").focus();
			return false;
		}

		if (!cfCheckDigit($("#checkQty").val())) {
			alert(MSG_COM_ERR_008.replace("[@]", " : 검품수량"));
			$("#checkQty").focus();
			return false;
		}
		if (!cfCheckDigit($("#actokQty").val())) {
			alert(MSG_COM_ERR_008.replace("[@]", " : 양품수량"));
			$("#actokQty").focus();
			return false;
		}
		if (!cfCheckDigit($("#actbadQty").val())) {
			alert(MSG_COM_ERR_008.replace("[@]", " : 불량수량"));
			$("#actbadQty").focus();
			return false;
		}

		var checkBadRow = true;
		$("div[id^='badRow']").each(function(idx, obj) {
    	    if($("#badCd" + idx).val() == ""){
    	        alert(MSG_COM_ERR_001.replace("[@]", " : " + (idx+1) + "번째 불량코드"));
    	        $("#badCd" + idx).focus();
    	        checkBadRow = false;
    	        return false;
    	    }

    	    if($("#badQty" + idx).val() == ""){
    	        alert(MSG_COM_ERR_001.replace("[@]", " : " + (idx+1) + "번째 불량수량"));
    	        $("#badQty" + idx).focus();
    	        checkBadRow = false;
    	        return false;
    	    }
    	});
		if( !checkBadRow ) return false;

		//검품 가능 조건 (작업지시수량 - 현재까지검품수량 = 검품가능수량)
		//검품가능수량 - 검품수량 > 0
		//검품가능수량 - 양품수량 > 0
		var remActokQty = parseInt(cfIsNullString($("#remActokQty").val(), "0").replace(/[^0-9]/g, ""));
		var checkQty = parseInt(cfIsNullString($("#checkQty").val(), "0").replace(/[^0-9]/g, ""));
		var actokQty = parseInt(cfIsNullString($("#actokQty").val(), "0").replace(/[^0-9]/g, ""));
		var actbadQty = parseInt(cfIsNullString($("#actbadQty").val(), "0").replace(/[^0-9]/g, ""));
		var crudType = document.objForm.crudType.value;

		//검품가능수량 - 검품수량
		if (remActokQty < checkQty) {
			alert("검품수량은 검품 가능 수량을 넘을수 없습니다.");
			$("#checkQty").focus();
			return false;
		}

		// 검품수량 체크
		if (parseInt(checkQty) < (parseInt(actokQty) + parseInt(actbadQty))) {
			alert("양품+불량수량은 검품수량보다 클 수 없습니다.");
			$("#checkQty").focus();
			return false;
		}

		// 완료시에는 수량 체크
		if ($("#qmStateCd").val() != "QM_WAT") {
			//검품수량은 = (양품수량  + 불량)
			if (parseInt(checkQty) != (parseInt(actokQty) + parseInt(actbadQty))) {
				alert("양품수량,불량수량 합은 검품수량과 같아야 됩니다.");
				$("#checkQty").focus();
				return false;
			}
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
			$("#qmCheckdt").datepicker('option', 'disabled', true);
			$("#qmCheckdt").css("background-color", "#e9ecef");
			$('#qmCheckNm').attr("readOnly", true);
			$('#prodPoNo').attr("readOnly", true);
			$('#prodActokQty').attr("readOnly", true);
			$('#poCalldt').attr("readOnly", true);
			$('#itemNm').attr("readOnly", true);
			$('#poQty').attr("readOnly", true);
			$('#remActokQty').attr("readOnly", true);
			$("#btnAddRow").hide();
			$("span[id^='spaDelBadRow']").hide();

			// 입고처리된 qm건 수정,삭제 불가 처리
			if( ${rtn.obj.inokQty > 0} ) {
				$("#btnEnableUpdate, #btnDelete").addClass("disabled");

				$("#btnEnableUpdate, #btnDelete").unbind().click(function(){
					cfAlert("입고완료처리되어 수정 또는 삭제 할 수 없습니다.");
					return false;
				});
			}
		} else if (document.objForm.crudType.value == 'U') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').show();
			$('#viewCreate').hide();
			$("#qmCheckdt").datepicker('option', 'disabled', false);
			$("#qmCheckdt").css("background-color", "");
			$('#qmCheckNm').attr("readOnly", true);
			$('#actbadQty').attr("readOnly", true);
			$('#prodPoNo').attr("readOnly", true);
			$('#prodActokQty').attr("readOnly", true);
			$('#poCalldt').attr("readOnly", true);
			$('#itemNm').attr("readOnly", true);
			$('#poQty').attr("readOnly", true);
			$('#remActokQty').attr("readOnly", true);
			$("#btnAddRow").show();
			$("span[id^='spaDelBadRow']").show();
		} else if (document.objForm.crudType.value == 'C') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').show();
			$("#btnAddRow").show();
			$("span[id^='spaDelBadRow']").show();
		}
	}

	//-----------------------------------------------------------------------
    // 숫자만 입력 가능
    //-----------------------------------------------------------------------
	function fn_sum_qty(obj) {
		var val = obj.value;
		obj.value = val.replace(/[^0-9]/g,"");

		var sumBadQty = 0;
		$("input[name$='.badQty']").each(function(index, obj) {
			var tempVal = $(obj).val();
			sumBadQty += Number(tempVal);
		});

		$("#actbadQty").val(sumBadQty);
	}

	function fn_DelRowFinishQmBad(mqcBadSeq, index) {
		if( cfIsNull(mqcBadSeq) ) {
			$("#badRow"+index).remove();

			var sumBadQty = 0;
			$("input[name$='.badQty']").each(function(index, obj) {
				var tempVal = $(obj).val();
				sumBadQty += Number(tempVal);
			});

			$("#actbadQty").val(sumBadQty);
		} else {
			document.objForm.mqcBadSeq.value = mqcBadSeq;

			var param = {};
	        param.url = "<c:url value='/delFinishQmBad.do'/>",
	        param.data = $("#objForm").serialize();
	        param.msg = "삭제 되었습니다.";
	        param.callback = function(result) {
	        	$( "#glvForm" ).html("searchForm");
	        	$( "#glvLink" ).html("<c:url value='/finishQmDtlPage.do'/>");
	        	cfAlertAnGo("삭제 되었습니다.");
			};

			var callback = function() {
				cfAjaxCallAndCallback(param);
			}

			cfConfirm("행삭제 하시겠습니까?", callback);
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
				<h1 class="mt-4">완제품 QM 관리</h1>
				<form name="objForm" id="objForm">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<input type="hidden" name="prodSeq" value="${prodOrderVo.prodSeq}" />
					<input type="hidden" name="workactSeq" value="${search.workactSeq}" />
					<input type="hidden" name="mqcSeq" value="${search.mqcSeq}" />
					<input type="hidden" name="itemCd" value="${prodOrderVo.itemCd}" />
					<input type="hidden" name="mqcBadSeq" value="" />

					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">작업지시 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="prodWaNo">생산실적번호</label>
										<input class="form-control" id="prodWaNo" name="prodWaNo" type="text" value="${prodOrderVo.prodWaNo}" readonly />
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="poCalldt">작업지시 일자</label>
										<input class="form-control" id="poCalldt" name="poCalldt" type="text" value="${prodOrderVo.poCalldt}" readonly />
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="itemNm">제품명</label>
										<input class="form-control" id="itemNm" name="itemNm" type="text" value="${prodOrderVo.itemNm}" readonly />
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="poQty">작업지시 수량</label>
										<input class="form-control input_number" id="poQty" name="poQty" type="text" value="<fmt:formatNumber value="${prodOrderVo.poQty}" pattern="###,###"/>" readonly />
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="poQty">양품 수량</label>
										<input class="form-control input_number" id="prodActokQty" name="prodActokQty" type="text" value="<fmt:formatNumber value="${prodOrderVo.actokQty}" pattern="###,###"/>" readonly />
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="remActokQty">검품 가능 수량</label>
										<input class="form-control input_number" id="remActokQty" name="remActokQty" type="text" value="<fmt:formatNumber value="${prodOrderVo.qmStockQty}" pattern="###,###"/>" readonly />
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">완제품 QM 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="checkQty">검품수량</label>
										<input class="form-control input_number" id="checkQty" name="checkQty" type="text" value="<fmt:formatNumber value="${rtn.obj.checkQty != null ? rtn.obj.checkQty:0}" pattern="###,###"/>" placeholder="작업수량을 입력 하세요" />
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="actokQty">양품수량</label>
										<input class="form-control input_number" id="actokQty" name="actokQty" type="text" value="<fmt:formatNumber value="${rtn.obj.actokQty != null ? rtn.obj.actokQty:0}" pattern="###,###"/>" placeholder="양품수량을 입력 하세요" />
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="actbadQty">불량수량</label>
										<input class="form-control input_number" id="actbadQty" name="actbadQty" type="text" value="<fmt:formatNumber value="${rtn.obj.actbadQty}" pattern="###,###"/>" readonly placeholder="불량수량을 입력 하세요" />
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="qmStateCd">QM 상태 코드</label>
										<select class="form-control2" id="qmStateCd" name="qmStateCd">
											<option value="">상태 코드 선택</option>
											<c:forEach items="${qm_state_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.qmStateCd}">
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
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="qmCheckdt" style="display: block;">검품일자</label>
										<input class="form-control3" id="qmCheckdt" name="qmCheckdt" type="text" value="${rtn.obj.qmCheckdt}" />
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="qmCheckid" style="display: block;">검품자</label>
										<input class="form-control" id="qmCheckNm" name="qmCheckNm" type="text" value="${rtn.obj.qmCheckNm}" readonly />
										<input id="qmCheckid" name="qmCheckid" type="hidden" value="${rtn.obj.qmCheckid}" />
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="qmRem" style="display: block;">비고</label>
										<input class="form-control" id="qmRem" name="qmRem" type="text" value="${rtn.obj.qmRem}" placeholder="비고를 입력하세요" />
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">
								불량정보
								<div class="float-right">
									<div id="btnAddRow" class="btn btn-primary btn-sm mr-2">행추가</div>
								</div>
							</h3>
						</div>
						<div class="card-body">
							<div id="divBadRow" class="form-row">
								<c:forEach items="${finishQmBadList}" var="badList" varStatus="badStatus">
									<div id="badRow${badStatus.index}" class="row col-md-12">
										<div class="col-md-3">
											<div class="form-group">
												<label class="small mb-1" for="badCd${badStatus.index}">불량코드</label>
												<select class="form-control2" id="badCd${badStatus.index}" name="objList[${badStatus.index}].badCd">
													<option value="">불량 코드 선택</option>
													<c:forEach items="${bad_cd_list}" var="item" varStatus="status">
														<option value="${item.scode}" ${badList.badCd == item.scode ? 'selected':''}>${item.codeNm}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<label class="small mb-1" for="badQty${badStatus.index}">불량수량</label>
												<input class="form-control input_number" id="badQty${badStatus.index}" name="objList[${badStatus.index}].badQty" type="text" value="<fmt:formatNumber value="${badList.badQty}" pattern="###,###"/>" placeholder="불량수량을 입력 하세요" onkeyup="javascript:fn_sum_qty(this);"/>
												<input type="hidden" name="objList[${badStatus.index}].mqcBadSeq" value="${badList.mqcBadSeq}" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<div class="m-4">
													<span id="spaDelBadRow${badStatus.index}" class="btn btn-sm btn-danger" onclick="javascript:fn_DelRowFinishQmBad('${badList.mqcBadSeq}', ${badStatus.index});">행삭제</span>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="card mb-4" style="">
						<div class="card-body">
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
		<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
		<input type="hidden" name="pageSize" value="${search.pageSize}" />
		<input type="hidden" name="sortCol" value="${search.sortCol}" />
		<input type="hidden" name="sortType" value="${search.sortType}" />
		<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
		<input type="hidden" name="mqcSeq" value="${search.mqcSeq}" />
		<input type="hidden" name="crudType" value="${search.crudType}" />
	</form:form>
</body>
</html>