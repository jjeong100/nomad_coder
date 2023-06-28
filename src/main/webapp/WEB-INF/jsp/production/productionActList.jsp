<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"       uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <title>생산 실적  관리</title>
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
				$("#workstYmd, #workedYmd, #searchFromDate, #searchToDate, #takeOverPopWorkstYmd").datepicker({
					showOn : "button",
					buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
					buttonImageOnly : true,
					buttonText : "Select date",
					dateFormat : "yy/mm/dd"
				});
				
				// 숫자필드 자동 선택
				$("input[type='number'], .input_number, .input_number1").click(function() {
					this.select();
				});
				
				//-------------------------------------------------------------
				// jqery event 
				//-------------------------------------------------------------
				$("#popShortId, #popShortId2, #popShortId3").keyup(function() {
					if ($(this).val().length < 2) {
						$("#popName").val('');
					} else if ($(this).val().length == 2) {
						document.workerForm.shortId.value = $(this).val();
						getUserNameByShortId();
					}
				});
				
				//-------------------------------------------------------------
	            // 사원 팝업
	            //-------------------------------------------------------------
	            $(".sign").click(function() {
	            	fn_popUserList("");
	            });
	
				$(".input_number").on("keyup", function(event) {
					$(this).val($(this).val().replace(/[^0-9.]/g, ""));
				});
	
				getUserNameByShortId = function() {
					$.ajax({
						url : "<c:url value='/getLoginNameByShortId.do'/>",
						type : 'POST',
						data : $('#workerForm').serialize(),
						contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
						context : this,
						dataType : 'json',
						beforeSend : function() {
							$("#layoutSidenav").loading();
						},
						success : function(data) {
							if (data.rtn.rc == 0) {
								$("#popName").val(data.rtn.obj.loginName);
								$("#popName2").val(data.rtn.obj.loginName);
								$("#popName3").val(data.rtn.obj.loginName);
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
				// 검색 이벤트
				//-------------------------------------------------------------
				$('#btnSearch').click(function() {
					var frm = document.searchForm;
					frm.pageIndex.value = 1;
					frm.action = "<c:url value='/productionActListPage.do'/>";
					frm.submit();
				});
	
				//-------------------------------------------------------------
				// 페이징 사이즈 변경 이벤트
				//-------------------------------------------------------------
				$('#pageSizeItem').on('change', function() {
					var frm = document.searchForm;
					frm.pageIndex.value = 1;
					frm.pageSize.value = $("#pageSizeItem").val();
					frm.action = "<c:url value='/productionActListPage.do'/>";
					frm.submit();
				});
	
				//-------------------------------------------------------------
				// 불량 코드 변경 이벤트
				//-------------------------------------------------------------
				$('#popBadCd').on('change', function() {
					if (cfIsNull($(this).val())) {
						$('#popActbadQty').val(0);
						$('#popActbadQty').attr("readOnly", true);
					} else {
						$('#popActbadQty').attr("readOnly", false);
					}
				});
	
				//-------------------------------------------------------------
				// 작업 상태 코드 변경 이벤트
				//-------------------------------------------------------------
				$('#popProdTypeCd').on('change', function() {
					if ($(this).val() == GLV_PROD_TYPE_CD) {
						$('#popWorkactBigo').val('');
						$('#popWorkactBigo').attr("readOnly", true);
					} else {
						$('#popWorkactBigo').attr("readOnly", false);
					}
				});
	
				//-------------------------------------------------------------
				// 컬럼 소트 이벤트
				//------------------------------------------------------------- 
				$('#dataTable').find('th').not('.no-sort').click(function() {
					var frm = document.searchForm;
					var sortCol = $(this).attr("id");
					frm.sortCol.value = sortCol;
					var sortColType = $(this).attr('class');
					if (sortColType == 'sorting_asc') {
						frm.sortType.value = 'desc'
					} else {
						frm.sortType.value = 'asc'
					}
					frm.action = "<c:url value='/productionActListPage.do'/>";
					frm.submit();
				});
	
				//-------------------------------------------------------------
				// 엑셀 다운로드 이벤트
				//-------------------------------------------------------------
				$('#btnExcel').click(function() {
					downloadExcelFromTable($('#dataTable'));
				});
	
				//-------------------------------------------------------------
				// 소요량 목록 Draw
				//-------------------------------------------------------------
				drawMatRequireList = function(prodSeq) {
					document.matRequireForm.searchProdSeq.value = prodSeq;
					$.ajax({
						url : "<c:url value='/getMatRequireListData.do'/>",
						type : 'POST',
						data : $('#matRequireForm').serialize(),
						contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
						context : this,
						dataType : 'json',
						beforeSend : function() {
							$("#matRequireListBody tr").remove();
							$("#layoutSidenav").loading();
						},
						success : function(data) {
							console.log(data.rtn)
							if (!cfCheckRtnObj(data.rtn))
								return;
							var html = "";
							$.each(data.rtn.obj, function(key, val) {
								html = "";
								html += "<tr role=\"row\" class=\"odd\">";
								html += "<td class=\"text-ellipsis\"><span>" + val.rnum + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + val.operNm + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + val.matCd + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + val.matNm + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(val.matLength) + val.matDanwiNm + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(val.confirmQty) + "개</span></td>";
	
								if (cfIsNull(val.lotid)) {
									html += "<td class=\"text-ellipsis\"><span></span></td>";
								} else {
									html += "<td class=\"text-ellipsis\"><span>" + val.lotid + "</span></td>";
								}
								if (cfIsNull(val.matOutCnt)) {
									html += "<td class=\"text-ellipsis\"><span></span></td>";
								} else {
									html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(parseInt(val.matOutCnt)) + " 개</span></td>";
								}
								if (cfIsNull(val.matOutDt)) {
									html += "<td class=\"text-ellipsis\"><span></span></td>";
								} else {
									html += "<td class=\"text-ellipsis\"><span>" + val.matOutDt + "</span></td>";
								}
								if (cfIsNull(val.matOutNm)) {
									html += "<td class=\"text-ellipsis\"><span></span></td>";
								} else {
									html += "<td class=\"text-ellipsis\"><span>" + val.matOutNm + "</span></td>";
								}
	
								html += "</tr>";
								$("#matRequireListBody").append(html);
							});
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
				// 생산 실적 목록 Draw
				//-------------------------------------------------------------
				drawProductionActList = function(prodSeq) {
					document.productionActForm.searchProdSeq.value = prodSeq;
					$.ajax({
						url : "<c:url value='/getProductionActListData.do'/>",
						type : 'POST',
						data : $('#matRequireForm').serialize(),
						contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
						context : this,
						dataType : 'json',
						beforeSend : function() {
							$("#productionActListBody tr").remove();
							$("#layoutSidenav").loading();
						},
						success : function(data) {
							if (!cfCheckRtnObj(data.rtn))
								return;
							var html = "";
							$.each(data.rtn.obj, function(key, val) {
								var valObj = JSON.stringify(val).replace(/\"/gi, "\'");
	
								html = "";
								html += "<tr role=\"row\" class=\"odd\">";
								// No
								html += "<td class=\"text-ellipsis\"><span>" + val.rnum + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + cfIsNullString(val.workDt) + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + val.equipNm + "</span></td>";
	
								// 상태
								if (val.prodTypeCd == 'END') {
									html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_change_actbad_update(eval(" + valObj + "))\" style=\"color:#007bff\">" + val.prodTypeNm + "</a></span></td>";
								} else if (val.prodTypeCd == 'END') {
									html += "<td class=\"text-ellipsis\"><span>" + val.prodTypeNm + "</span></td>";
								} else {
									html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_change_prod_type('" + val.workactSeq + "','" + val.prodTypeCd + "','" + val.equipCd + "','" + val.prodSeq + "')\" style=\"color:#007bff\">"
											+ val.prodTypeNm + "</a></span></td>";
								}
	
								html += "<td class=\"text-ellipsis\"><span>" + val.operNm + "</span></td>"; // 공정
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(cfIsNullString(val.poQty, "0")) + "개</span></td>"; // 작지수량
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(cfIsNullString(val.equipQty, "0")) + "개</span></td>"; // 배정수량
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(cfIsNullString(val.actokQty, "0")) + "개</span></td>"; // 양품
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(cfIsNullString(val.actbadQty, "0")) + "개</span></td>"; //불량
								html += "<td class=\"text-ellipsis\"><span>" + cfIsNullString(val.sabunNm) + "</span></td>"; // 작업자
	
								html += "<td class=\"text-ellipsis text-center p-1\">";
								if (val.prodTypeCd == 'ING') {
									//html += "	<span name=\"btnDisabled\" class=\"btn btn-primary btn-sm\" style=\"background-color:#777;width:30px;\" onclick=\"javascript:fn_take_over(eval(" + valObj + "));\">+</span>"; // 이어받기
									html += "	<div class=\"btn btn-primary btn-sm mr-3\" onclick=\"javascript:fn_take_over(eval(" + valObj + "));\">배정</div>";
								} else {
									html += "";
								}
								html += "</td>";
	
								if (cfIsNull(val.workstDt) && (val.prodTypeCd == 'WAT' || val.prodTypeCd == 'ING')) { // 작업시작
									html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_start_work('" + val.workactSeq + "','" + val.operCd + "','" + val.equipCd + "'," + val.poQty + ",'" + val.workstDt
											+ "')\" style=\"color:#007bff\">작업시작</a></span></td>";
								} else {
									html += "<td class=\"text-ellipsis\"><span>" + cfIsNullString(val.workstDt, "") + "</span></td>";
								}
	
								if (cfIsNull(val.workedDt) && cfIsNull(val.workstDt) && (val.prodTypeCd == 'WAT' || val.prodTypeCd == 'ING')) { // 작업 종료
									html += "<td class=\"text-ellipsis\"><span></span></td>";
								} else if (cfIsNull(val.workedDt) && !cfIsNull(val.workstDt)) {
									html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_end_work(eval(" + valObj + "))\" style=\"color:#007bff\">작업종료</a></span></td>";
								} else {
									html += "<td class=\"text-ellipsis\"><span>" + cfIsNullString(val.workedDt, "") + "</span></td>";
								}
	
								html += "<td class=\"text-ellipsis\"><span>" + cfIsNullString(val.workactBigo) + "</span></td>"; // 비고
								html += "</tr>";
								$("#productionActListBody").append(html);
							});
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
				// 생산 시작 팝업
				//-------------------------------------------------------------
				$("#start_work_confirm").dialog({
					autoOpen : false,
					width : 400,
					buttons : [ {
						text : "확인",
						click : function() {
							if ($("#popShortId").val().trim() == '') {
								alert(MSG_COM_ERR_001.replace("[@]", " : 숏 아이디"));
								$("#popShortId").focus();
								return;
							}
							$(this).dialog("close");
	
							//확인 버튼 후 처리
							var workYmd = $("#workstYmd").val().replace(/[^0-9]/gi, "");
							var workTm = $("#workstTm").val();
							var workMm = $("#workstMm").val();
							var workSec = new Date().getSeconds().toString().padStart(2, "0");
	
							//작업자 팝업 추가
							document.productionActForm.shortId.value = $("#popShortId").val();
	
							document.productionActForm.workDt.value = workYmd;
							document.productionActForm.workstDt.value = getDateTimeValue(workYmd, workTm, workMm, workSec);
	
							$.ajax({
								url : "<c:url value='/productionActUpdateAct.do'/>",
								type : 'POST',
								data : $('#productionActForm').serialize(),
								contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
								context : this,
								dataType : 'json',
								beforeSend : function() {
									$("#layoutSidenav").loading();
								},
								success : function(data) {
									if (!cfCheckRtnObj(data.rtn))
										return;
									//cfAlert("작업 시작 되었습니다.");
									//document.searchForm.prodSeq.value = GLV_PRODSEQ;
									//fn_paging("${search.pageIndex}");
									//drawProductionActList(GLV_PRODSEQ);
	
									var frm = document.searchForm;
									frm.prodSeq.value = GLV_PRODSEQ;
									frm.pageIndex.value = "${search.pageIndex}";
									$("#glvForm").html("searchForm");
									$("#glvLink").html("<c:url value='/productionActListPage.do'/>");
									cfAlertAnGo("작업 시작 되었습니다.");
								},
								error : function(request, status, error) {
									console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
									cfAlert('시스템 오류입니다.');
								},
								complete : function() {
									$("#layoutSidenav").loadingClose();
								}
							});
						}
					}, {
						text : "취소",
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
	
				//-------------------------------------------------------------
				// 생산 종료 팝업
				//-------------------------------------------------------------
				$("#end_work_confirm").dialog({
					autoOpen : false,
					width : 400,
					buttons : [ {
						text : "확인",
						click : function() {
							if ($("#popShortId2").val().trim() == '') {
								alert(MSG_COM_ERR_001.replace("[@]", " : 숏 아이디"));
								$("#popShortId2").focus();
								return;
							}
							$(this).dialog("close");
	
							var equipQty = document.productionActForm.equipQty.value;
							var actokQty = cfIsNullString($("#endWorkPopActokQty").val(), "0");
							var actbadQty = cfIsNullString($("#endWorkPopActbadQty").val(), "0");
	
							if (parseInt(equipQty) != parseInt(actokQty) + parseInt(actbadQty)) {
								alert("양품+불량수량이 배정수량과 같아야 합니다.");
								return false;
							}
	
							//확인 버튼 후 처리
							var workedYmd = $("#workedYmd").val().replace(/[^0-9]/gi, "");
							var workedTm = $("#workedTm").val();
							var workedMm = $("#workedMm").val();
							var workedSec = new Date().getSeconds().toString().padStart(2, "0");
	
							//작업자 팝업 추가
							document.productionActForm.shortId.value = $("#popShortId2").val();
							document.productionActForm.workedDt.value = getDateTimeValue(workedYmd, workedTm, workedMm, workedSec);
							document.productionActForm.actokQty.value = actokQty;
							document.productionActForm.actbadQty.value = actbadQty;
	
							//작업일시 validation
							if (!fn_compareDate(document.productionActForm.workstDt.value, document.productionActForm.workedDt.value))
								return false;
							$.ajax({
								url : "<c:url value='/productionActUpdateAct.do'/>",
								type : 'POST',
								data : $('#productionActForm').serialize(),
								contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
								context : this,
								dataType : 'json',
								beforeSend : function() {
									$("#layoutSidenav").loading();
								},
								success : function(data) {
									if (!cfCheckRtnObj(data.rtn))
										return;
									//cfAlert("작업 종료 되었습니다.");
									//document.searchForm.prodSeq.value = GLV_PRODSEQ;
									//fn_paging("${search.pageIndex}");
									//drawProductionActList(GLV_PRODSEQ);
	
									var frm = document.searchForm;
									frm.prodSeq.value = GLV_PRODSEQ;
									frm.pageIndex.value = "${search.pageIndex}";
									$("#glvForm").html("searchForm");
									$("#glvLink").html("<c:url value='/productionActListPage.do'/>");
									cfAlertAnGo("작업 종료 되었습니다.");
								},
								error : function(request, status, error) {
									console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
									cfAlert('시스템 오류입니다.');
								},
								complete : function() {
									$("#layoutSidenav").loadingClose();
								}
							});
						}
					}, {
						text : "취소",
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
	
				//-------------------------------------------------------------
				// 작업 상태 변경 팝업
				//-------------------------------------------------------------
				$("#change_prod_type_confirm").dialog({
					autoOpen : false,
					width : 400,
					buttons : [ {
						text : "확인",
						click : function() {
	
							var frm = document.productionActForm;
							if ($("#popWorkactBigo").val().trim() == '') {
								alert(MSG_COM_ERR_001.replace("[@]", " : 변경 사유"));
								$("#popWorkactBigo").focus();
								return;
							}
	
							frm.prodTypeCd.value = $("#popProdTypeCd").val();
							frm.workactBigo.value = $("#popWorkactBigo").val();
	
							if (frm.prodTypeCd.value == 'WAT') {
								frm.workstDt.value = "";
							}
	
							$(this).dialog("close");
	
							$.ajax({
								url : "<c:url value='/productionActUpdateAct.do'/>",
								type : 'POST',
								data : $('#productionActForm').serialize(),
								contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
								context : this,
								dataType : 'json',
								beforeSend : function() {
									$("#layoutSidenav").loading();
								},
								success : function(data) {
									if (!cfCheckRtnObj(data.rtn))
										return;
									cfAlert('작업 상태 변경 되었습니다.');
									drawProductionActList(GLV_PRODSEQ);
								},
								error : function(request, status, error) {
									console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
									cfAlert('시스템 오류입니다.');
								},
								complete : function() {
									$("#layoutSidenav").loadingClose();
								}
							});
						}
					}, {
						text : "취소",
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
	
				// 팝업 닫기
				$('.modal-close-button').click(function() {
					$('.modal-container').css("display", "none");
				});
	
				$('#btnMatOutConfirm').click(function() {
					if (cfIsNull($("input:radio[name=matOutRadioBox]:checked").val())) {
						alert("출고 자재를 선택해 주세요");
						return false;
					}
					document.matRequireForm.matoutSeq.value = $("input:radio[name=matOutRadioBox]:checked").val();
	
					$("#mat_confirm").dialog("open");
				});
	
				//-------------------------------------------------------------
				// 불량 수정 팝업
				//-------------------------------------------------------------
				$("#actbad_update_confirm").dialog({
					autoOpen : false,
					width : 400,
					buttons : [ {
						text : "확인",
						click : function() {
							$(this).dialog("close");
	
							document.productionActForm.actokQty.value = $("#actbadPopActokQty").val();
							document.productionActForm.actbadQty.value = $("#actbadPopActbadQty").val();
	
							var actbadPopActokQty = cfIsNullString($("#actbadPopActokQty").val(), "0").replace(/[^0-9]/g, "");
							var actbadPopActbadQty = cfIsNullString($("#actbadPopActbadQty").val(), "0").replace(/[^0-9]/g, "");
							var actPopEquipQty = cfIsNullString($("#actPopEquipQty").val(), "0").replace(/[^0-9]/g, "");
	
							if (parseInt(actbadPopActokQty) + parseInt(actbadPopActbadQty) > parseInt(actPopEquipQty)) {
								alert("양품수량은 배정수량을 넘을수 없습니다.");
								return;
							}
	
							if (parseInt(actbadPopActokQty) + parseInt(actbadPopActbadQty) != parseInt(actPopEquipQty)) {
								alert("양품+불량수량이 배정수량과 같아야 합니다.");
								return;
							}
	
							$.ajax({
								url : "<c:url value='/updateActbadQtyAct.do'/>",
								type : 'POST',
								data : $('#productionActForm').serialize(),
								contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
								context : this,
								dataType : 'json',
								beforeSend : function() {
									$("#layoutSidenav").loading();
								},
								success : function(data) {
									if (!cfCheckRtnObj(data.rtn))
										return;
									cfAlert('변경 되었습니다.');
									drawProductionActList(GLV_PRODSEQ);
								},
								error : function(request, status, error) {
									console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
									cfAlert('시스템 오류입니다.');
								},
								complete : function() {
									$("#layoutSidenav").loadingClose();
								}
							});
						}
					}, {
						text : "취소",
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
				
				//-------------------------------------------------------------
				// 이어받기 팝업
				//-------------------------------------------------------------
				$("#take_over_confirm").dialog({
					autoOpen : false,
					width : 400,
					buttons : [ {
						text : "확인",
						click : function() {
							if ($("#popShortId3").val().trim() == '') {
								alert(MSG_COM_ERR_001.replace("[@]", " : 숏 아이디"));
								$("#popShortId3").focus();
								return;
							}
							
							//확인 버튼 후 처리
							var workYmd = $("#takeOverPopWorkstYmd").val().replace(/[^0-9]/gi, "");
							var workTm = $("#takeOverPopWorkstTm").val();
							var workMm = $("#takeOverPopWorkstMm").val();
							var workSec = new Date().getSeconds().toString().padStart(2, "0");
							
							document.productionActForm.shortId.value = $("#popShortId3").val();
								
							document.productionActForm.workDt.value = workYmd;
							document.productionActForm.workstDt.value = getDateTimeValue(workYmd, workTm, workMm, workSec);
							
							document.productionActForm.actokQty.value = cfIsNullString($("#takeOverPopActokQty").val(), "0");
							document.productionActForm.actbadQty.value = cfIsNullString($("#takeOverPopActbadQty").val(), "0");
							
							$.ajax({
								url : "<c:url value='/productionActTackOverSaveAct.do'/>",
								type : 'POST',
								data : $('#productionActForm').serialize(),
								contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
								context : this,
								dataType : 'json',
								beforeSend : function() {
									$("#layoutSidenav").loading();
								},
								success : function(data) {
									if (!cfCheckRtnObj(data.rtn))
										return;
									
									var frm = document.searchForm;
									frm.prodSeq.value = GLV_PRODSEQ;
									frm.pageIndex.value = "${search.pageIndex}";
									$("#glvForm").html("searchForm");
									$("#glvLink").html("<c:url value='/productionActListPage.do'/>");
									cfAlertAnGo("배정(이어받기) 되었습니다.");
								},
								error : function(request, status, error) {
									console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
									cfAlert('시스템 오류입니다.');
								},
								complete : function() {
									$("#layoutSidenav").loadingClose();
									$(this).dialog("close");
								}
							});
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
					$("#tabs").tabs();
					$("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
					if (document.searchForm.sortType.value == 'asc') {
						$("#${search.sortCol}").attr('class', 'sorting_asc');
					} else {
						$("#${search.sortCol}").attr('class', 'sorting_desc');
					}
	
					// 생산시작 후 화면 재조회 에서 마스터 리스트의 상태 재조회
					if ("${search.prodSeq}" != "") {
						var index = $('#tabs a[href="#tabs-2"]').parent().index();
						console.log(index)
						$("#tabs").tabs("option", "active", index);
						fn_go_dtl_page("${search.prodSeq}");
						document.searchForm.prodSeq.value = "";
					}
	
					$("#searchFromDate").val("${search.searchFromDate}");
					$("#searchToDate").val("${search.searchToDate}");
	
					$('[data-toggle="tooltip"]').tooltip();
				});
			});
		})(jQuery);
	
		//=====================================================================
		// button action funtion
		//=====================================================================
		var GLV_PRODSEQ;
		function fn_go_dtl_page(id) {
			drawMatRequireList(id);
			drawProductionActList(id);
			GLV_PRODSEQ = id;
		}
	
		//=====================================================================
		// 날짜 시간 분 
		//=====================================================================
		function getDateTimeValue(yyyymmdd, hh24, mi, sec) {
			var date = "";
			date = date + yyyymmdd;
			date = date + (hh24 < 10 ? "0" + hh24 : hh24);
			date = date + (mi < 10 ? "0" + mi : mi);
			date = date + sec;
			return date;
		}
	
		//-------------------------------------------------------------
		//
		//-------------------------------------------------------------
		function fn_start_work(workactSeq, operCd, equipCd, poQty, workstDt) {
			$('#popShortId').val(SHORT_ID);
			$('#popName').val(LOGIN_USER_NAME);
			document.productionActForm.prodSeq.value = GLV_PRODSEQ;
			document.productionActForm.workactSeq.value = workactSeq;
			document.productionActForm.operCd.value = operCd;
			document.productionActForm.equipCd.value = equipCd;
			if ('MIX' == operCd) {
				$('#startEndMsg').html("배합 작업 처리 하시겠습니까?");
				document.productionActForm.actokQty.value = poQty;
			} else {
				$('#startEndMsg').html("생산 시작 하시겠습니까?");
				document.productionActForm.actokQty.value = 0;
			}
	
			if (workstDt == null || workstDt == "undefine" || workstDt == "null")
				workstDt = "";
	
			workstDt = cfIsNullString(workstDt, "");
	
			if (cfIsNull(workstDt)) {
				var today = new Date().format("yyyy/MM/dd-HH:mm:ss");
	
				$("#workstYmd").val(today.substring(0, 10));
				$("#workstTm").val(parseInt(today.substring(11, 13)));
				$("#workstMm").val(parseInt(today.substring(14, 16)));
				//                 $("#workstTm").val(0);
				//                 $("#workstMm").val(0);
	
				$("#startEndMsg").text("작업 시작 하시겠습니까?");
			} else {
				$("#workstYmd").val(workstDt.substring(0, 10));
				$("#workstTm").val(parseInt(workstDt.substring(11, 13)));
				$("#workstMm").val(parseInt(workstDt.substring(14, 16)));
	
				$("#startEndMsg").text("작업 시간을 수정 하시겠습니까?");
			}
	
			document.productionActForm.shortId.value = $("#popShortId").val();
			document.productionActForm.prodTypeCd.value = 'ING';
			$("#start_work_confirm").dialog("open");
		}
	
		//-------------------------------------------------------------
		// 작업종료
		//-------------------------------------------------------------
		function fn_end_work(workactObj) {
			$('#popShortId2').val(SHORT_ID);
			$('#popName2').val(LOGIN_USER_NAME);
			document.productionActForm.prodSeq.value = GLV_PRODSEQ;
			document.productionActForm.workactSeq.value = workactObj.workactSeq;
			document.productionActForm.operCd.value = workactObj.operCd;
			document.productionActForm.equipCd.value = workactObj.equipCd;
			document.productionActForm.equipQty.value = workactObj.equipQty;
			$('#startEndMsg').html("생산 종료 하시겠습니까?");
			document.productionActForm.shortId.value = $("#popShortId2").val();
			document.productionActForm.prodTypeCd.value = 'END';
	
			//추가 작업시작
			document.productionActForm.workDt.value = workactObj.workDt.replace(/[^0-9]/g, "");
			document.productionActForm.workstDt.value = workactObj.workstDt.replace(/[^0-9]/g, "");
			
			$("#endWorkPopActokQty").val(workactObj.actokQty);
			$("#endWorkPopActbadQty").val(workactObj.actbadQty);
			
			if (cfIsNull(workactObj.workedDt)) {
				var today = new Date().format("yyyy/MM/dd-HH:mm:ss");
	
				$("#workedYmd").val(today.substring(0, 10));
				$("#workedTm").val(parseInt(today.substring(11, 13)));
				$("#workedMm").val(parseInt(today.substring(14, 16)));
				//                 $("#workedTm").val(0);
				//                 $("#workedMm").val(0);
	
				$("#startEndMsg").text("생산 종료 하시겠습니까?");
			} else {
				$("#workedYmd").val(workactObj.workedDt.substring(0, 10));
				$("#workedTm").val(parseInt(workactObj.workedDt.substring(11, 13)));
				$("#workedMm").val(parseInt(workactObj.workedDt.substring(14, 16)));
	
				$("#startEndMsg").text("생산 종료 시간을 수정 하시겠습니까?");
			}
	
			$("#end_work_confirm").dialog("open");
		}
	
		//-------------------------------------------------------------
		//
		//-------------------------------------------------------------
		var GLV_PROD_TYPE_CD;
		function fn_change_prod_type(workactSeq, prodTypeCd, equipCd, prodSeq) {
			GLV_WORKACT_SEQ = workactSeq;
			GLV_PROD_TYPE_CD = prodTypeCd;
			$('#popProdTypeCd').val(prodTypeCd).prop("selected", true);
			$('#popWorkactBigo').val('');
			$('#popWorkactBigo').attr("readOnly", true);
			document.productionActForm.prodSeq.value = prodSeq;
			document.productionActForm.workactSeq.value = workactSeq;
			document.productionActForm.equipCd.value = equipCd;
			document.productionActForm.crudType.value = 'UPD_PROD_TYPE_CD';
			$("#change_prod_type_confirm").dialog("open");
		}
	
		//-------------------------------------------------------------
		//
		//-------------------------------------------------------------
		function fn_change_actbad_update(paramVo) {
			document.productionActForm.prodTypeCd.value = paramVo.prodTypeCd;
			document.productionActForm.operCd.value = paramVo.operCd;
			document.productionActForm.workactSeq.value = paramVo.workactSeq;
			document.productionActForm.equipCd.value = paramVo.equipCd;
			document.productionActForm.prodSeq.value = paramVo.prodSeq;
	
			$("#actbadPopActokQty").val(paramVo.actokQty);
			$("#actbadPopActbadQty").val(paramVo.actbadQty);
			$("#actPopEquipQty").val(paramVo.equipQty);
			if ('${userId }' == 'admin') {
				$("#actbad_update_confirm").dialog("open");
			} else {
				alert('관리자만 수정할 수 있습니다.');
			}
		}
	
		//=====================================================================
		// 시작일시 종료일시 비교
		//===================================================================== 
		function fn_compareDate(fromDate, toDate) {
			fromDate = fromDate.replace(/[^0-9]/g, "");
			fromDate = fromDate == null ? "0" : fromDate;
			toDate = toDate.replace(/[^0-9]/g, "");
			toDate = toDate == null ? "0" : toDate;
	
			if (parseInt(fromDate) > parseInt(toDate)) {
				alert("작업시작 일시가 종료일시보다 큽니다.");
				document.productionActForm.workedDt.value = "";
				return false;
			}
			return true;
		}
	
		//=====================================================================
		// paging
		//===================================================================== 
		function fn_paging(pageIndex) {
			var frm = document.searchForm;
			frm.pageIndex.value = pageIndex;
			frm.action = "<c:url value='/productionActListPage.do'/>";
			frm.submit();
		}
	
		//-------------------------------------------------------------
		// 작업자 선택 팝업 callback
		//-------------------------------------------------------------
		function fn_popUser_callback(obj) {
			$("#popShortId").val(obj.shortId);
			$("#popShortId2").val(obj.shortId);
			$("#popShortId3").val(obj.shortId);
	
			$("#popName").val(obj.loginName);
			$("#popName2").val(obj.loginName);
			$("#popName3").val(obj.loginName);
		}
		
		//-------------------------------------------------------------
		// 이어받기
		//-------------------------------------------------------------
		function fn_take_over(obj) {
			document.productionActForm.prodSeq.value = obj.prodSeq;
			document.productionActForm.workactSeq.value = obj.workactSeq;
			document.productionActForm.operCd.value = obj.operCd;
			document.productionActForm.equipCd.value = obj.equipCd;
			
			var workstDt = "";
			var today = new Date().format("yyyy/MM/dd-HH:mm:ss");
			$("#takeOverPopWorkstYmd").val(today.substring(0, 10));
			$("#takeOverPopWorkstTm").val(parseInt(today.substring(11, 13)));
			$("#takeOverPopWorkstMm").val(parseInt(today.substring(14, 16)));
			
			$("#takeOverMsg").text("작업을 이어받으시겠습니까?");
			
			document.productionActForm.shortId.value = $("#popShortId3").val();
			//document.productionActForm.actokQty.value = obj.actokQty;
			//document.productionActForm.actbadQty.value = obj.actbadQty;
			
			$("#takeOverPopActokQty").val(obj.actokQty);
			$("#takeOverPopActbadQty").val(obj.actbadQty);
			$("#take_over_confirm").dialog("open");
		}
		-->
    </script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp" ></jsp:include> 
    <div id="layoutSidenav">
        <!-- ==================================================================================================================================== -->
        <!-- menu                                                                                                                                 -->
        <!-- ==================================================================================================================================== -->
        <jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp" ></jsp:include>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <!-- ======================================================================================================================== -->
                    <!-- title                                                                                                                    -->
                    <!-- ======================================================================================================================== -->
                    <h1 class="mt-4">생산실적 관리</h1>
                   
                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>작업지시 목록</sapn>
                           <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">  <!-- @@@ style="min-width:3000px;"  -->
                                   <div class="row">
                                       <div class="col-sm-12 col-md-2" style="padding-top:5px;">
                                           <div class="dataTables_length" id="dataTable_length">
                                               <label>Show 
                                               <select id="pageSizeItem" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                                                   <option value="3">3</option>
                                                   <option value="5">5</option>
                                                   <option value="15">15</option>
                                               </select> entries
                                               </label>
                                           </div>
                                       </div>
                                       
                                       <div class="col-sm-12 col-md-10" style="margin-bottom:5px;">
                                           <div id="dataTable_filter" class="dataTables_wrapper">
                                               <form:form commandName="search" id="searchForm" name="searchForm">
                                                   <input type="hidden" name="crudType" value="R"/>
                                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                                   <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                                                   <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                                                   <input type="hidden" name="sortType" value="${search.sortType}"/>
                                                   <input type="hidden" name="prodSeq" value="${search.prodSeq}"/>
                                                   
                                                    <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                                                   </div>
                                                   <div style="float: right; margin: 6px 5px;" data-toggle="tooltip" data-placement="top" title="작업지시번호">
                                                       <input type="text" class="form-control col-xs-2 input-lg radius" size="35" placeholder="작업지시번호" id="searchProdPoNo" name="searchProdPoNo" value="${search.searchProdPoNo}" />
                                                   </div>
                                                   
                                                   <div class="float-right margin-dt" data-toggle="tooltip" data-placement="top" title="생산지시일자 종료">
                                                       <input class="form-control3 dt-w55 col-xs-2" id="searchToDate"   name="searchToDate"  type="text" value="${search.searchToDate}"   placeholder="지시일자종료"/>
                                                   </div>
                                                   
                                                   <div class="float-right margin-dt" data-toggle="tooltip" data-placement="top" title="생산지시일자 시작">
                                                       <input class="form-control3 dt-w55 col-xs-2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="지시일자시작"/>
                                                   </div>
                                                   
                                                   <div style="float: right; margin: 6px 5px;" data-toggle="tooltip" data-placement="top" title="제품">
                                                       <select class="form-control2" id="searchItemCd" name="searchItemCd">
                                                               <option value="">제품 선택</option>
                                                               <c:forEach items="${product_list}" var="item" varStatus="status">
                                                                    <c:choose>
                                                                        <c:when test="${item.itemCd == search.searchItemCd}">
                                                                            <option value="${item.itemCd}" selected>${item.itemNm}</option>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <option value="${item.itemCd}">${item.itemNm}</option>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                       </select>
                                                   </div>
                                               </form:form>
                                           </div> 
                                       </div>
                                   </div>
                                   
                                   <div class="row">
                                       <!-- style="min-width:3000px;" -->
                                       <div class="col-sm-12" style="min-width:1200px;">
                                           <!-- table table-striped table-bordered table-hover -->
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                              <thead class="thead-dark">
                                                  <tr role="row">
                                                      <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                      <th id="rnum"          class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">No</th>
                                                      <th id="po_calldt"     class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작지일자</th>
                                                      <th id="prod_po_no"    class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">작지번호</th>
                                                      <th id="prod_type_nm"  class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">상태</th>
                                                      <th id="cust_nm"       class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">납품처</th>
                                                      <th id="item_nm"       class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">제품명</th>
                                                      <th id="oper_nm"       class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">공정</th>
                                                      <th id="po_qty"        class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">지시수량</th>
                                                      <th id="po_weight"     class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">중량</th>
                                                      <th id="rem_equip_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">배정잔량</th>
                                                      <th id="workst_dt"     class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">시작</th>
                                                      <th id="worked_dt"     class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">종료</th>
                                                  </tr>
                                              </thead>

                                              <tbody>
                                                  <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">${item.rnum}</span></td>
                                                        <td class="text-ellipsis"><span class="po_calldt">${item.poCalldt}</span></td>
                                                        <td class="text-ellipsis"><span class="prod_po_no"><a href="javascript:fn_go_dtl_page('${item.prodSeq}')">${item.prodPoNo}</a></span></td>
                                                        <td class="text-ellipsis"><span class="prod_type_nm">${item.prodTypeNm}</span></td>
                                                        <td class="text-ellipsis"><span class="cust_nm">${item.custNm}</span></td>
                                                        <td class="text-ellipsis"><span class="item_nm">${item.itemNm}</span></td>
                                                        <td class="text-ellipsis"><span class="oper_nm">${item.operNm}</span></td>
                                                        <td class="text-ellipsis"><span class="po_qty"><fmt:formatNumber value="${item.poQty}" pattern="###,###"/>개</span></td>
                                                        <td class="text-ellipsis"><span class="po_weight"><fmt:formatNumber value="${item.poWeight}" pattern="###,###.##"/>${item.poWeightNm}</span></td>
                                                        <td class="text-ellipsis"><span class="rem_equip_qty"><fmt:formatNumber value="${item.remEquipQty}" pattern="###,###"/>개</span></td>
                                                        <td class="text-ellipsis"><span class="workst_dt">${item.workstDt}</span></td>
                                                        <td class="text-ellipsis"><span class="worked_dt">${item.workedDt}</span></td>
                                                    </tr>
                                                  </c:forEach>
                                                  <c:if test="${fn:length(rtn.obj) le 0}">
                                                    <tr>
                                                        <td colspan="11" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                    </tr>
                                                  </c:if>
                                              </tbody>
                                              
                                           </table>
                                       </div>
                                   </div>
                                   <!-- ======================================================================================================================== -->
                                   <!-- paging                                                                                                                   -->
                                   <!-- ======================================================================================================================== -->
                                   <div class="row">
                                       <div class="col-sm-12 col-md-5">
                                           <c:if test="${rtn.totCnt > 0}">
                                               <div class="dataTables_info" id="dataTable_info">Showing ${search.firstIndex+1} to ${search.lastIndex} of ${rtn.totCnt} entries</div>
                                           </c:if>
                                       </div>
                                       
                                       <div class="col-sm-12 col-md-7">
                                           <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                                               <ul class="pagination">
                                               
                                                   <c:set var="isLoof" value="true" />
                                                   <c:if test="${rtn.totCnt > 0}">
                                                       <c:if test="${search.pageIndex > 1}">
                                                           <li class="paginate_button page-item previous" id="dataTable_previous"><a href="javascript:fn_paging(${search.pageIndex-1})" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
                                                       </c:if>
                                                       <c:forEach begin="${search.startPage}" end="${search.endPage}" step="1" var="i">
                                                           <c:if test="${isLoof}">
                                                               <c:choose>
                                                                   <c:when test="${i == search.pageIndex}">
                                                                       <li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="${i}" tabindex="0" class="page-link">${i}</a></li>
                                                                   </c:when>
                                                                   <c:otherwise>
                                                                       <li class="paginate_button page-item "><a href="javascript:fn_paging(${i})" aria-controls="dataTable" data-dt-idx="${i}" tabindex="0" class="page-link">${i}</a></li>
                                                                   </c:otherwise>
                                                               </c:choose>
                                                               <c:if test="${rtn.totCnt <= (search.pageSize*i)}"><c:set var="isLoof" value="false" /></c:if>
                                                           </c:if>
                                                       </c:forEach>
                                                       <c:if test="${rtn.totCnt > (search.pageSize*search.pageIndex)}">
                                                           <li class="paginate_button page-item next" id="dataTable_next"><a href="javascript:fn_paging(${search.pageIndex+1})" aria-controls="dataTable" data-dt-idx="11" tabindex="0" class="page-link">Next</a></li>
                                                       </c:if>
                                                   </c:if> 
                                               </ul>
                                           </div>
                                       </div>
                                   </div>
                                   <!-- page end -->
                               </div>
                           </div>
                       </div>
                   </div>
                   <!-- table card end -->
                   <!-- ==================================================================================================== -->
                   <!--  소요량 / 실적 목록                                                                                                                                                                                                     -->
                   <!-- ==================================================================================================== -->
                   <div id="tabs">
                       <ul>
                           <li><a href="#tabs-1">자재투입</a></li>
                           <li><a href="#tabs-2">생산실적</a></li>
                       </ul>
                       <div id="tabs-1">                 
                           <div class="card mb-4" style="margin-top:10px; margin-left:10px; margin-right:10px;">
                                <div class="card-header">
                                    <sapn class="txt20">자재 투입 정보</sapn>
                                </div>
                                
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                        <thead class="thead-dark">
                                                            <tr role="row">
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">NO</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">공정</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재코드</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재명</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재길이</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">소요량</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">LOT-NO</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">투입수량</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">투입일시</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">투입자</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="matRequireListBody"/>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- table card end -->
                        </div>
                        <div id="tabs-2">
                            <div class="card mb-4" style="margin-top:10px; margin-left:10px; margin-right:10px;">
                                <div class="card-header">
                                    <sapn class="txt20">생산 실적 정보</sapn>
                                </div>
                                
                                <div class="card-body">
                                    <div class="table-responsive" style="overflow-y:auto; height:200px;">
                                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                        <thead class="thead-dark">
                                                            <tr role="row">
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">NO</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업일자</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">호기</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">상태</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">공정</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">작지수량</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">배정수량</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">양품</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">불량</th>
<!--                                                                 <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">금속불량</th> -->
<!--                                                                 <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">중량불량</th> -->
<!--                                                                 <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">육안불량</th> -->
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">작업자</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">이어받기</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 14%;">작업시작</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 14%;">작업종료</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">비고</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="productionActListBody"/>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- table card end -->
                        </div>
                        <!-- tap2 end -->        
                    </div>
                    <!-- tab end -->   
                </div>
            </main>
        </div>
    </div>
    
<form:form commandName="matRequire" id="matRequireForm" name="matRequireForm">
    <input type="hidden" name="searchProdSeq" value=""/>
    <input type="hidden" name="opmatSeq" value=""/>
    <input type="hidden" name="shortId" value=""/>
    <input type="hidden" name="matoutSeq" value=""/>
    <input type="hidden" name="prodSeq" value=""/>
    <input type="hidden" name="operCd" value=""/>
</form:form>
<form:form commandName="matOut" id="matOutForm" name="matOutForm">
    <input type="hidden" name="searchMatCd" value=""/>
    <input type="hidden" name="searchProdSeqNull" value="Y"/>
</form:form>
<form:form commandName="productionAct" id="productionActForm" name="productionActForm">
    <input type="hidden" name="searchProdSeq" value=""/>
    <input type="hidden" name="searchOperCd" value=""/>
    <input type="hidden" name="prodSeq" value=""/>
    <input type="hidden" name="workactSeq" value=""/>
    <input type="hidden" name="prodTypeCd" value=""/>
    <input type="hidden" name="shortId" value=""/>
    <input type="hidden" name="actokQty" value=""/>
    <input type="hidden" name="actbadQty" value=""/>
    <input type="hidden" name="badCd" value=""/>
    <input type="hidden" name="crudType" value=""/>
    <input type="hidden" name="operCd" value=""/>
    <input type="hidden" name="equipCd" value=""/>
    <input type="hidden" name="workactBigo" value=""/>
    <input type="hidden" name="actbadMetalQty" value=""/>
    <input type="hidden" name="actbadUnderQty" value=""/>
    <input type="hidden" name="actbadViewQty" value=""/>
    
    <input type="hidden" name="workDt" value=""/>
    <input type="hidden" name="workstDt" value=""/>
    <input type="hidden" name="workedDt" value=""/>
    <input type="hidden" name="equipQty" value=""/>
</form:form>

<form:form commandName="worker" id="workerForm" name="workerForm">
    <input type="hidden" name="shortId" value=""/>
</form:form>


<div id="start_work_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p id="startEndMsg"></p>
    </div> 
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popShortId">SHORT ID</label>
                    <input class="form-control" id="popShortId" name="popShortId" type="text" value="" maxlength="2" placeholder="숏 아이디를 입력하세요"/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popName">성명</label>
                    <div id="btnSearchStartPopUser" class="button-cr radius blue sign" style="float:right;margin: 20px 0px 0px -44px;">
                       <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                    </div>
                    <input class="form-control" id="popName" name="popName" type="text" value="" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="workstYmd">시작일자</label>
                    <div class="form-row">
                        <input class="form-control3 col-8" id="workstYmd" name="workstYmd" type="text" style="margin-bottom:4px;"/>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label class="small mb-1" for="workstTm">시간</label>
                    <select class="form-control2" id="workstTm" name="workstTm">
                        <c:forEach var="i" begin="0" end="23">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label class="small mb-1" for="workstMm">분</label>
                    <select class="form-control2" id="workstMm" name="workstMm">
                        <c:forEach var="i" begin="0" end="59">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div> 

<div id="end_work_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p id="startEndMsg"></p>
    </div> 
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popShortId2">SHORT ID</label>
                    <input class="form-control" id="popShortId2" name="popShortId2" type="text" value="" maxlength="2" placeholder="숏 아이디를 입력하세요"/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popName2">성명</label>
                    <div id="btnSearchEndPopUser" class="button-cr radius blue sign" style="float:right;margin: 20px 0px 0px -44px;">
                       <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                    </div>
                    <input class="form-control" id="popName2" name="popName2" type="text" value=""/>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popShortId2">양품수량</label>
                    <input class="form-control input_number" id="endWorkPopActokQty" name="endWorkPopActokQty" type="text" value="" placeholder="양품수량을 입력하세요"/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popName2">불량수량</label>
                    <input class="form-control input_number" id="endWorkPopActbadQty" name="endWorkPopActbadQty" type="text" value="" placeholder="불량수량을 입력하세요"/>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="workedYmd">종료일자</label>
                    <div class="form-row">
                        <input class="form-control3 col-8" id="workedYmd" name="workedYmd" type="text" style="margin-bottom:4px;"/>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label class="small mb-1" for="workedTm">시간</label>
                    <select class="form-control2" id="workedTm" name="workedTm">
                        <c:forEach var="i" begin="0" end="23">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label class="small mb-1" for="workedMm">분</label>
                    <select class="form-control2" id="workedMm" name="workedMm">
                        <c:forEach var="i" begin="0" end="59">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div> 

<div id="change_prod_type_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p>작업 상태 변경을  하시겠습니까 ?</p>
    </div> 
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="small mb-1" for="popProdTypeCd">작업 상태</label>
                    <select class="form-control2" id="popProdTypeCd" name="popProdTypeCd">
                        <c:forEach items="${prod_type_cd_list}" var="item" varStatus="status">
                            <option value="${item.scode}">${item.codeNm}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="small mb-1" for="popWorkactBigo">변경 사유</label>
                    <input class="form-control" id="popWorkactBigo" name="popWorkactBigo" type="text" value="" placeholder="변경 사유을 입력하세요"/>
                </div>
            </div>
        </div>
    </div>
</div> 

<div id="actbad_update_confirm" title="확인" style="display:none;">
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-8">
                <div class="form-group">
                    <label class="small mb-1" for="actbadPopActokQty">양품수량</label>
                    <input class="form-control input_number" id="actbadPopActokQty" name="actbadPopActokQty" type="text" value="" placeholder="양품수량을 입력하세요"/>
                    <input type="hidden" id="actPopEquipQty" name="actPopEquipQty"/>
                </div>
            </div>
            <div class="col-md-8">
                <div class="form-group">
                    <label class="small mb-1" for="actbadPopActbadMetalQty">불량수량</label>
                    <input class="form-control input_number" id="actbadPopActbadQty" name="actbadPopActbadQty" type="text" value="" placeholder="불량수량을 입력하세요"/>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="take_over_confirm" title="확인" style="display:none;">
	<div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p id="takeOverMsg"></p>
    </div>
    
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="takeOverPopActokQty">양품수량(현재실적)</label>
                    <input class="form-control input_number" id="takeOverPopActokQty" name="takeOverPopActokQty" type="text" value="" placeholder="양품수량"/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="takeOverPopActbadQty">불량수량(현재실적)</label>
                    <input class="form-control input_number" id="takeOverPopActbadQty" name="takeOverPopActbadQty" type="text" value="" placeholder="불량수량"/>
                </div>
            </div>
        </div>
    </div>
    
	<div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popShortId3">SHORT ID</label>
                    <input class="form-control" id="popShortId3" name="popShortId3" type="text" value="" maxlength="2" placeholder="숏 아이디를 입력하세요"/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="popName3">성명(이어받는작업자)</label>
                    <div id="btnTakeOverPopUser" class="button-cr radius blue sign" style="float:right;margin: 20px 0px 0px -44px;">
                       <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                    </div>
                    <input class="form-control" id="popName3" name="popName3" type="text" value="" readonly/>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="small mb-1" for="takeOverPopWorkstYmd">시작일자</label>
                    <div class="form-row">
                        <input class="form-control3 col-8" id="takeOverPopWorkstYmd" name="takeOverPopWorkstYmd" type="text" style="margin-bottom:4px;"/>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label class="small mb-1" for="takeOverPopWorkstTm">시간</label>
                    <select class="form-control2" id="takeOverPopWorkstTm" name="takeOverPopWorkstTm">
                        <c:forEach var="i" begin="0" end="23">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label class="small mb-1" for="takeOverPopWorkstMm">분</label>
                    <select class="form-control2" id="takeOverPopWorkstMm" name="takeOverPopWorkstMm">
                        <c:forEach var="i" begin="0" end="59">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div> 

<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include> 
<jsp:include flush="false" page="/WEB-INF/jsp/popup/popUser.jsp"></jsp:include>  <!-- 작업자 선택 팝업 -->

</body>
</html>