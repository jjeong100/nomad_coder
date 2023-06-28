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
<title>검사상세정보관리</title>
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
			}).on("focus", function() {
				this.select();
			});

			//-------------------------------------------------------------
			// 검사구분값 변경
			//-------------------------------------------------------------
			$("#searchInspSmeCd").change(function(e) {
				if( $("#searchInspSmeCd").val() != "" ) {
					$.ajax({
	                    url : "<c:url value='/getInspDaySeq.do'/>",
	                    type: 'POST',
	                    data: $("#objForm").serialize(),
	                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	                    context:this,
	                    dataType:'json',
	                    beforeSend:function(){
	                        $("#layoutSidenav").loading();
	                    },
	                    success: function(data) {
	                    	if (!cfCheckRtnObj(data.rtn))
	        					return;

	                    	document.objForm.searchInspDaySeq.value = data.rtn.obj.inspDaySeq;

	                    	var frm = document.objForm;
	        				frm.action = "<c:url value='/productionInspDtlPage.do'/>";
	        				frm.submit();
	                    },
	                    error: function(request, status, error){
	                        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
	                        cfAlert('시스템 오류입니다.');
	                    },
	                    complete:function(){
	                        $("#layoutSidenav").loadingClose();
	                    }
	                });
				}
			});

			//-------------------------------------------------------------
			// 측정값변경
			//-------------------------------------------------------------
			$("input[name$='measureVal'], input[name$='inspRltCd']").change(function(e) {
				if ($("#searchInspSmeCd").val().trim() == '') {
					alert("검사구분값을 먼저 선택해 주십시요.");
					$("#searchInspSmeCd").focus();
					return false;
				}

				fn_changeMeasure();
			});

			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//-------------------------------------------------------------
			$('#btnUpdateClose, #btnCreateClose').click(function() {
				var frm = document.objForm;
				frm.action = "<c:url value='/productionInspListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$("#btnEnableUpdate").click(function() {
				document.objForm.crudType.value = "U";
				fn_btn_show_hide();
			});

			//-------------------------------------------------------------
			// 수정 취소 버튼 클릭
			//-------------------------------------------------------------
			$("#btnEnableUpdateCancel").click(function() {
				document.objForm.crudType.value = "R";
				fn_btn_show_hide();
			});

			//-------------------------------------------------------------
			// 변경 이벤트
			//-------------------------------------------------------------
			$("#btnUpdate").click(function() {
				var frm = document.objForm;

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
						document.objForm.crudType.value = "U";

						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""));
						});

						cfAjaxCallAndGoLink("<c:url value='/productionInspSaveAct.do'/>"
								, $("#objForm").serialize(), '수정 되었습니다.', "searchForm"
								, "<c:url value='/productionInspListPage.do'/>");
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
			$("#btnCreate").click(function() {
				var frm = document.objForm;

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
						document.objForm.crudType.value = "C";

						$(".input_number, .input_number1").each(function() {
							$(this).val(this.value.replace(/,/gi, ""));
						});

						cfAjaxCallAndGoLink("<c:url value='/productionInspSaveAct.do'/>"
								, $("#objForm").serialize(), '생성 되었습니다.', "searchForm"
								, "<c:url value='/productionInspListPage.do'/>");
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
				fn_init_value();
			});
		});
	})(jQuery);

	//-------------------------------------------------------------
	// 버튼 컨트롤
	//-------------------------------------------------------------
	function fn_btn_show_hide() {
		if (document.objForm.crudType.value == "R") {
			$("#viewUpdateDisable").show();
			$("#viewProductionInfo").show();
			$("#viewUpdateEnable").hide();
			$("#viewCreate").hide();
			$(".card-body select").attr("disabled", true);
			$(".card-body select").css("background-color", "#e9ecef");
			$(".card-body input").attr("readOnly", true);

			$("#searchInspSmeCd").attr("disabled", true);
            $("#searchInspSmeCd").css("background-color", "#e9ecef");
		} else if (document.objForm.crudType.value == "U") {
			$("#viewUpdateDisable").hide();
			$("#viewUpdateEnable").show();
			$("#viewCreate").hide();
			$(".card-body input").attr("readOnly", false);

			$("#searchInspSmeCd").attr("disabled", true);
            $("#searchInspSmeCd").css("background-color", "#e9ecef");
		} else if (document.objForm.crudType.value == "C") {
			$("#viewUpdateDisable").hide();
			$("#viewUpdateEnable").hide();
			$("#viewCreate").show();
		}
	}

	//-------------------------------------------------------------
	// 초기화
	//-------------------------------------------------------------
	function fn_init_value() {
		fn_chkInspRslt();
	}

	//-------------------------------------------------------------
	// 저장 유효성 체크
	//-------------------------------------------------------------
	function fn_submit_validation() {
		if ($("#searchInspSmeCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 검사구분"));
			$("#searchInspSmeCd").focus();
			return false;
		}

		$("#searchInspSmeCd").attr("disabled", false);

		return true;
	}

	//-------------------------------------------------------------
	// 측정값변경
	//-------------------------------------------------------------
	function fn_changeMeasure() {
		$("input[name$='measureVal']").each(function(idx, obj) {
			var highVal = $("span[name='objList[" + idx + "].highVal']").text();
			var lowVal = $("span[name='objList[" + idx + "].lowVal']").text();
			var measureVal = $("input[name='objList[" + idx + "].measureVal']").val();

			if( Number(lowVal) <= Number(measureVal) && Number(measureVal) <= Number(highVal) ) {
				$("input[name='objList[" + idx + "].inspRltCd'][value='OK']").prop("checked", true);
				$("input[name='objList[" + idx + "].inspRltCd'][value='NG']").prop("checked", false);
			} else {
				if( measureVal != '' ) {
					$("input[name='objList[" + idx + "].inspRltCd'][value='OK']").prop("checked", false);
					$("input[name='objList[" + idx + "].inspRltCd'][value='NG']").prop("checked", true);
				}
			}
		});

		fn_chkInspRslt();
	}

	//-------------------------------------------------------------
	// 전체판정
	//-------------------------------------------------------------
	function fn_chkInspRslt() {
		var totCnt = $("input[name$='.inspRltCd'][value='OK']").length;
		var okCnt = $("input[name$='.inspRltCd'][value='OK']:checked").length;
		var ngCnt = $("input[name$='.inspRltCd'][value='NG']:checked").length;

		if( totCnt == okCnt ) {
			$("span[name='spaMstRsltCd']").html("OK");
		} else if( $("input[name$='.inspRltCd'][value='NG']:checked").length > 0 ) {
			$("span[name='spaMstRsltCd']").html("NG");
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
				<h1 class="mt-4">검사 상세 정보</h1>
				<form:form commandName="obj" id="objForm" name="objForm">
					<input type="hidden" id="crudType"	name="crudType"	value="${search.crudType}" />

					<input type="hidden" name="workactMstSeq"	value="${search.workactMstSeq}" />
				    <input type="hidden" name="searchProdSeq" 	value="${search.searchProdSeq}"/>
					<input type="hidden" name="prodSeq"			value="${search.prodSeq}" />
					<input type="hidden" name="itemCd"			value="${search.itemCd}" />
					<input type="hidden" name="operCd"			value="${search.operCd}" />
					<input type="hidden" name="searchWorkactSeq"	value="${search.searchWorkactSeq}" />
					<input type="hidden" name="searchInspTypeCd"	value="${search.searchInspTypeCd}" />

					<div class="card" style="margin-top: 30px;">
						<div class="card-body">
							<!-- body-header [S] -->
							<div class="row">
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td width="10%" class="bg-light title11b text_center">검사구분</td>
												<td width="10%" class="bg-light title11b text_center">검사회차</td>
												<td width="10%" class="bg-light title11b text_center">검사일시</td>
												<td width="10%" class="bg-light title11b text_center">전체판정</td>
											</tr>
											<tr>
												<td width="10%" class="title11 text_center align-middle">
													<div class="col-sm-12">
														<select class="form-control2 mt-n1 mb-n1" id="searchInspSmeCd" name="searchInspSmeCd">
															<option value="">검사구분 선택</option>
															<c:forEach items="${insp_sme_cd_list}" var="item" varStatus="status">
																<c:choose>
																	<c:when test="${item.scode == searchInsp.inspSmeCd}">
																		<option value="${item.scode}" selected>${item.codeNm}</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${item.scode}">${item.codeNm}</option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
														</select>
													</div>
												</td>
												<td width="10%" class="title11 text_center align-middle"><input type="hidden" class="from-control" name="searchInspDaySeq" value="${rtn.obj[0].inspDaySeq == null ? 0:rtn.obj[0].inspDaySeq}" />${rtn.obj[0].inspDaySeq}</td>
												<td width="10%" class="title11 text_center align-middle">${rtn.obj[0].inspDt}</td>
												<td width="10%" class="title11 text_center align-middle"><span name="spaMstRsltCd"></span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!-- body-header [E] -->

							<!-- grid row [S] -->
							<div class="row" style="margin-bottom: 5px;">
								<table class="table table-borderless table-borderbottom dataTable table-hover" width="100%" style="table-layout:fixed;">
									 <thead class="thead-dark">
										<tr class="text-center">
											<th style="width:15%;">검사항목</th>
											<th style="width:10%;">상한값</th>
											<th style="width:10%;">하한값</th>
											<th style="width:10%;">측정값</th>
											<th style="width:10%;">단위</th>
											<th style="width:15%;">판정</th>
										</tr>
									</thead>
									<tbody id="workactListBody">
										<c:forEach items="${rtn.obj}" var="item" varStatus="status">
											<tr role="row" class="odd">
												<td class="text-center">
													<span class="">${item.inspItemNm}</span>
													<input type="hidden" name="objList[${status.index}].workactSeq" value="${item.workactSeq}"/>
													<input type="hidden" name="objList[${status.index}].inspDaySeq" value="${item.inspDaySeq}"/>
													<input type="hidden" name="objList[${status.index}].inspTypeCd" value="${item.inspTypeCd}"/>
													<input type="hidden" name="objList[${status.index}].inspSmeCd" value="${item.inspSmeCd}"/>
													<input type="hidden" name="objList[${status.index}].inspItemCd" value="${item.inspItemCd}"/>
												</td>
												<td class="text-center"><span class="" name="objList[${status.index}].highVal"><fmt:formatNumber value="${item.highVal}" pattern="#,##0.0"/></span></td>
												<td class="text-center"><span class="" name="objList[${status.index}].lowVal"><fmt:formatNumber value="${item.lowVal}" pattern="#,##0.0"/></span></td>
												<td class="text-center">
													<input type="text" class="form-control form-control-sm input_number col-md-8 m-auto text-center" data-index="${status.index}" name="objList[${status.index}].measureVal" value="<fmt:formatNumber value="${item.measureVal}" pattern="#,##0.0"/>"/>
												</td>
												<td class="text-center"><span class="">${item.inspDanwiNm}</span></td>
												<td class="text-center">
													<label class="radio-inline mr-2">
														<input type="radio" class="mr-1" value="OK" data-index="${status.index}" name="objList[${status.index}].inspRltCd" <c:if test="${item.inspRltCd == 'OK'}">checked</c:if>/>OK
													</label>
													<label class="radio-inline mr-2">
														<input type="radio" class="mr-1" value="NG" data-index="${status.index}" name="objList[${status.index}].inspRltCd" <c:if test="${item.inspRltCd == 'NG'}">checked</c:if>/>NG
	                                   				</label>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- grid row [E] -->
						</div>
					</div>

					<div class="card" style="margin-top: 30px;">
						<div class="card-body">
							<!-- 변경 최초 버튼 상태 -->
							<div id="viewUpdateDisable" class="col-md-12" style="display: none;">
								<div class="form-row">
									<div class="col-md-6">
										<div id="btnEnableUpdate" class="btn btn-primary btn-block">수정</div>
									</div>
									<div class="col-md-6">
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
				</form:form>
			</div>
			</main>
		</div>
	</div>

	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" id="crudType"	name="crudType"	value="${search.crudType}" />
		<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
		<input type="hidden" name="pageSize" value="${search.pageSize}" />
		<input type="hidden" name="sortCol" value="${search.sortCol}" />
		<input type="hidden" name="sortType" value="${search.sortType}" />

		<input type="hidden" name="workactMstSeq"	value="${search.workactMstSeq}" />
	    <input type="hidden" name="searchProdSeq" 	value="${search.searchProdSeq}"/>
		<input type="hidden" name="prodSeq"			value="${search.prodSeq}" />
		<input type="hidden" name="itemCd"			value="${search.itemCd}" />
		<input type="hidden" name="operCd"			value="${search.operCd}" />
		<input type="hidden" name="searchWorkactSeq"	value="${search.searchWorkactSeq}" />
		<input type="hidden" name="searchInspTypeCd"	value="${search.searchInspTypeCd}" />
		<input type="hidden" name="searchInspSmeCd"	value="" />
	</form:form>

	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
</body>
</html>