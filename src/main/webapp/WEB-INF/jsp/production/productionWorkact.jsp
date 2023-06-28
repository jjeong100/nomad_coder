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
<title>생산 실적 관리</title>
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
			$( "#workstYmd" ).datepicker({
			    showOn: "button",
			    buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
			    buttonImageOnly: true,
			    buttonText: "Select date"
			});
			$( "#workstYmd" ).datepicker("option", "dateFormat", "yy/mm/dd");

			$("#poQty").on("keyup", function(event) {
            	$(this).val($(this).val().replace(/[^0-9.]/g,""));
            }).on("focus", function() {
            	$(this).select();
            });

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			// 작업자팝업
			$(".worker").click(function() {
				// 시스템권한자만 작업자 수정 가능
            	if( ${sessionData.roleId != 'SYSTEM'} ) {
            		return false;
            	}

            	var kindId = $(this).attr("id");
            	$("#popWorker").data("kindId", kindId).dialog("open").dialog("widget").position({
            		my: "center top",
                	at: "top+70",
                    of: window
            	});
            });

			// 뒤로가기
			$("#btnClose").click(function() {
				// 숫자콤마제거
				$(".input_number, .input_number1").each(function() {
					$(this).val(this.value.replace(/,/gi, ""))
				});

				var frm = document.objForm;
				frm.action = "<c:url value='/productionMstActListPage.do'/>";
				frm.submit();
			});

			//실적추가
			$("#btnAdd").click(function() {
				fn_start_work();
			});

			//-------------------------------------------------------------
			// 생산 시작 팝업
			//-------------------------------------------------------------
			$( "#start_work_confirm" ).dialog({
			    autoOpen: false,
			    modal: true,
			    width: 500,
			    buttons: [
			        {
			            text: "등록",
			            click: function() {

			            	if($("#equipCd").val().trim() == ''){
			                    alert(MSG_COM_ERR_001.replace("[@]", " : 작업설비"));
			                    $("#equipCd").focus();
			                    return false;
			                }

			            	if($("#sabunId").val().trim() == ''){
			                    alert(MSG_COM_ERR_001.replace("[@]", " : 작업자"));
			                    $("#sabunId").focus();
			                    return false;
			                }

			            	if($("#poQty").val().trim() == ''){
			                    alert(MSG_COM_ERR_001.replace("[@]", " : 작업수량"));
			                    $("#poQty").focus();
			                    return false;
			                }

			            	if( $("#poQty").val() <= 0 ) {
			            		alert("작업수량은 0보다 커야 합니다.");
			                    $("#poQty").focus();
			                    return false;
			            	}

			        		document.objForm.sabunId.value = $("#sabunId").val();
			        		document.objForm.equipCd.value = $("#equipCd").val();
			        		document.objForm.poQty.value = $("#poQty").val();
			                document.objForm.workDt.value = $("#workstYmd").val().replace(/[^0-9]/gi, "");
			                document.objForm.workstDt.value = $("#workstYmd").val().replace(/[^0-9]/gi, "") + $("#workstTm").val() + $("#workstMm").val() + new Date().getSeconds().toString().padStart(2, "0");
			                document.objForm.prodTypeCd.value = 'ING';
 		                    document.objForm.crudType.value = 'C';

			             	// 숫자콤마제거
			   				$(".input_number, .input_number1").each(function() {
			   				    $(this).val(this.value.replace(/,/gi, ""));
			   				});

			   				cfAjaxCallAndGoLink("<c:url value='/productionActSaveAct.do'/>"
                                    ,$('#objForm').serialize(),'등록 되었습니다.'
                                    ,'objForm'
                                    ,"<c:url value='/productionWorkactPage.do'/>");
			            }
			        },
			        {
			            text: "취소",
			            click: function() {
			                $( this ).dialog( "close" );
			            }
			        }
			    ]
			});

			$("#glv_confirm").dialog({
                autoOpen: false,
                modal: true,
                width: 400,
                open:function(){
                	$("#glv-confirm-msg").text("확정하시겠습니까?");
                },
                buttons: [
                	{
                        text: "확정",
                        click: function() {
                            $( this ).dialog( "close" );
                            cfAjaxCallAndGoLink("<c:url value='/productionActConfirmSaveAct.do'/>"
                                    ,$('#objForm').serialize(),'확정 되었습니다.'
                                    ,'objForm'
                                    ,"<c:url value='/productionWorkactPage.do'/>");
                        }
                    },
                    {
                        text: "취소",
                        click: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                ]
            });

			// 확정
			$("span[name='btnConfirm']").click(function() {
				var frm = document.objForm;
				frm.workactSeq.value = $(this).data("key");

				if( $(this).data("status") != "END" ) {
					cfAlert("작업종료 후 확정 가능합니다.");
					return false;
				}

				$("#glv_confirm").dialog("open");
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {

			});
		});
	})(jQuery);

	function fn_start_work() {
		var workstDt = document.objForm.workstDt.value;
		workstDt = cfIsNullString(workstDt, "");
		workstDt = workstDt.replace(/[^0-9]/gi, "");

		if( cfIsNull(workstDt) ) {
			var today = new Date();
	    	var date = today.getFullYear() + "/" + (today.getMonth()+1).toString().padStart(2, "0") + "/" + today.getDate().toString().padStart(2, "0");

	    	$("#workstYmd").val(date);
	    	$("#workstTm").val(today.getHours().toString().padStart(2, "0"));
	    	$("#workstMm").val(today.getMinutes().toString().padStart(2, "0"));
		} else {
			$("#workstYmd").val(workstDt.substring(0,8).replace(/(\d{4})(\d{2})(\d{2})/, '$1/$2/$3'));
	    	$("#workstTm").val(workstDt.substring(8,10));
	    	$("#workstMm").val(workstDt.substring(10,12));
		}

		$("#sabunId").val("${sessionData.sabunId}");
		$("#sabunNm").val("${sessionData.userName}");
		$("#poQty").val("");

		$( "#start_work_confirm" ).dialog( "open" );
	}

	function fn_popWorker_callback(worker) {
		switch(worker.kindId) {
			case "sabunNm":	// 작성자
				$("#sabunId").val(worker.sabunId);
				$("#sabunNm").val(worker.loginName);
				break;
			default:
				break;
		}
	}

	function fn_work_act(workactSeq, prodSeq, operCd) {
		fn_popWorkactEnd(workactSeq, prodSeq, operCd);
	}

	function fn_workact_insp(inspTypeCd, workactSeq) {
		var frm = document.objForm;
		frm.searchWorkactSeq.value = workactSeq;
		frm.searchInspTypeCd.value = inspTypeCd;
		frm.action = "<c:url value='/productionInspListPage.do'/>";
		frm.submit();
	}

</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<form:form commandName="obj" id="objForm" name="objForm">
		<input type="hidden" name="pageIndex" value="1"/>
	    <input type="hidden" name="searchProdSeq" value="${search.searchProdSeq}"/>
	    <input type="hidden" name="searchPoCalldt" value="${search.searchPoCalldt}"/>

		<input type="hidden" name="crudType"		value="" />
		<input type="hidden" name="prodSeq"			value="${productionMstActVo.prodSeq}" />
		<input type="hidden" name="itemCd"			value="${productionMstActVo.itemCd}" />
		<input type="hidden" name="operCd"			value="${productionMstActVo.operCd}" />
		<input type="hidden" name="workactMstSeq"	value="${productionMstActVo.workactMstSeq}" />
		<input type="hidden" name="workactSeq"		value="" />
		<input type="hidden" name="prodTypeCd"		value="" />
		<input type="hidden" name="sabunId"			value="" />
		<input type="hidden" name="poQty"			value="" />
		<input type="hidden" name="workDt"			value="" />
		<input type="hidden" name="workstDt"		value="" />
		<input type="hidden" name="equipCd"		    value="" />

		 <input type="hidden" name="searchInspTypeCd"	value="" />
	    <input type="hidden" name="searchWorkactSeq"	value="" />
	</form:form>

	<jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
	<div id="layoutSidenav">
		<!-- ==================================================================================================================================== -->
		<!-- menu                                                                                                                                 -->
		<!-- ==================================================================================================================================== -->
		<jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<div class="container-fluid">
				<!-- ======================================================================================================================== -->
				<!-- title                                                                                                                    -->
				<!-- ======================================================================================================================== -->
				<h1 class="mt-4">생산 실적 관리</h1>
				<!-- ========================================================================================================================= -->
				<!-- taable list                                                                                                              -->
				<!-- ======================================================================================================================== -->
				<div class="card mb-4">
					<div class="card-header">
						<sapn>실적목록</sapn>
					</div>
					<div class="card-body">
						<!-- body-header [S] -->
						<div class="row">
							<div class="table-responsive">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<td width="10%" class="bg-light title11b">제품명</td>
											<td width="20%" class="title11">${productionMstActVo.itemNm}</td>
											<td width="10%" class="bg-light title11b">배정</td>
											<td width="10%" class="bg-light title11b">작업</td>
											<td width="10%" class="bg-light title11b">양품</td>
											<td width="10%" class="bg-light title11b">불량</td>
											<td width="10%" class="bg-light title11b">확정</td>
										</tr>
										<tr>
											<td width="10%" class="bg-light title11b">공정명</td>
											<td width="20%" class="title11">${productionMstActVo.operNm}</td>
											<td width="10%" class="title11"><fmt:formatNumber value="${productionMstActVo.assignQty}" pattern="###,###"/></td>
											<td width="10%" class="title11"><fmt:formatNumber value="${productionMstActVo.workQty}" pattern="###,###"/></td>
											<td width="10%" class="title11"><fmt:formatNumber value="${productionMstActVo.actokQty}" pattern="###,###"/></td>
											<td width="10%" class="title11"><fmt:formatNumber value="${productionMstActVo.actbadQty}" pattern="###,###"/></td>
											<td width="10%" class="title11"><fmt:formatNumber value="${productionMstActVo.confirmQty}" pattern="###,###"/></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- body-header [E] -->

						<div class="row">
							<div class="col-sm-12">
								<div class="btn btn-dark float-right">
									<div id="btnAdd">실적추가</div>
								</div>
							</div>
						</div>

						<!-- grid row [S] -->
						<div class="row" style="margin-bottom: 5px;">
							<!-- <div class="table-responsive"> -->
								<table class="table table-borderless table-borderbottom dataTable table-hover" width="100%" style="table-layout:fixed;">
									 <thead class="thead-dark">
										<tr class="text-center">
											<th style="width:10%;">설비</th>
											<th style="width:10%;">작업자</th>
											<th style="width: 8%;">확정</th>
											<th style="width: 8%;">작업</th>
											<th style="width: 8%;">양품</th>
											<th style="width: 8%;">불량</th>
											<th style="width:15%;">시작</th>
											<th style="width:15%;">종료</th>
											<th style="width:12%;">패트롤검사</th>
											<th style="width:12%;">자주검사</th>
										</tr>
									</thead>
									<tbody id="workactListBody">
										<c:forEach items ="${productionActList}" var="item" varStatus="status">
											<tr role="row" class="odd" data-row="${item.workactSeq}">
												<td class="text-center"><span class="">${item.equipNm}</span></td>
												<td class="text-center"><span class="">${item.sabunNm}</span></td>
												<td class="text-center">
													<c:if test="${item.confirmYn == 'Y'}"><span class="">완료</span></c:if>
													<c:if test="${item.confirmYn != 'Y'}"><span name="btnConfirm" class="btn btn-primary btn-sm" data-key="${item.workactSeq}" data-status="${item.prodTypeCd}" title="확정">확정</span></c:if>
												</td>
												<td class="text-center"><span class=""><fmt:formatNumber value="${item.poQty}" pattern="###,###"/></span></td>
												<td class="text-center"><span class=""><fmt:formatNumber value="${item.actokQty}" pattern="###,###"/></span></td>
												<td class="text-center"><span class=""><fmt:formatNumber value="${item.actbadQty}" pattern="###,###"/></span></td>
												<td class="text-center"><span class="">${item.workstDt}</span></td>
												<td class="text-center">
													<c:choose>
														<c:when test="${item.confirmYn != 'Y'}">
															<span><a href="javascript:fn_work_act('${item.workactSeq}', '${item.prodSeq}', '${item.operCd}')">${item.workedDt != null ? item.workedDt:'종료'}</a></span>
														</c:when>
														<c:otherwise>
															<span class="">${item.workedDt}</span>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="text-center">
													<span><a href="javascript:fn_workact_insp('PT', '${item.workactSeq}')">보기</a></span>
												</td>
												<td class="text-center">
													<span><a href="javascript:fn_workact_insp('JJ', '${item.workactSeq}')">보기</a></span>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							<!-- </div> -->
						</div>
						<!-- grid row [E] -->

						<!-- footer row [S] -->
						<div class="row my-2">
							<div class="col-sm-10"></div>
							<div class="col-sm-2">
								<div class="btn btn-dark btn-block">
									<div id="btnClose">닫기</div>
								</div>
							</div>
						</div>
						<!-- footer row [E] -->

					</div>
				</div>
				<!-- table card end -->
			</div>
		</div>
		<!-- layoutSidenav_content end -->

	</div>
	<!-- layoutSidenav end -->

	<div id="start_work_confirm" title="작업자배정" style="display:none;overflow:hidden;">
	    <div class="col-md-12">
	    <div class="form-row">
	        	<div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="workstYmd">시작일자</label>
	                    <div class="form-row">
		                    <input class="form-control2 col-9" id="workstYmd" name="workstYmd" type="text" style="margin-bottom:4px;"/>
	                    </div>
	                </div>
	            </div>
	        	<div class="col-md-3">
	                <div class="form-group">
	                    <label class="small mb-1" for="workstTm">시간</label>
	                    <select class="form-control2 " id="workstTm" name="workstTm">
		                    <c:forEach var="i" begin="0" end="23">
		                    	<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}" type="number"/>">${i}</option>
		                    </c:forEach>
	                    </select>
	                </div>
	            </div>
	        	<div class="col-md-3">
	                <div class="form-group">
	                    <label class="small mb-1" for="workstMm">분</label>
	                    <select class="form-control2 " id="workstMm" name="workstMm">
		                    <c:forEach var="i" begin="0" end="59">
		                    	<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}" type="number"/>">${i}</option>
		                    </c:forEach>
	                    </select>
	                </div>
	            </div>
	        </div>
	        <div class="form-row">
	           <div class="col-md-4">
	                <div class="form-group">
	                    <label class="small mb-1" for="equipCd">작업설비</label>
						<select class="form-control2" id="equipCd" name="equipCd" data-size="7" data-live-search="true">
							<option value="">설비 선택</option>
							<c:forEach items="${equipList}" var="item" varStatus="status">
                            <option value="${item.equipCd}">${item.equipNm}</option>
							</c:forEach>
						</select>
					</div>
	            </div>
	            <div class="col-md-4">
	                <div class="form-group">
	                    <label class="small mb-1" for="sabunNm">작업자</label>
		                    <input id="sabunId" name="sabunId" type="hidden"/>
		                    <input class="form-control2 worker" id="sabunNm" name="sabunNm" type="text"/>
	                </div>
	            </div>
	            <div class="col-md-4">
	                <div class="form-group">
	                    <label class="small mb-1" for="poQty">작업수량</label>
	                    	<input class="form-control2" id="poQty" name="poQty" type="text"/>
	                </div>
	            </div>
	        </div>


	    </div>
	</div>

	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>
	<jsp:include flush="false" page="/WEB-INF/jsp/popup/popWorker.jsp" ></jsp:include>
	<jsp:include flush="false" page="/WEB-INF/jsp/popup/popWorkactEnd.jsp" ></jsp:include>
	<script>

	</script>
</body>
</html>