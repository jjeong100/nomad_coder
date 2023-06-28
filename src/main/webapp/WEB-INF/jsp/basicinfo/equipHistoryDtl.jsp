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
<title>설비 점검 내역</title>
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
			$("#equipDt").datepicker({
				showOn : "button",
				dateFormat : "yy/mm/dd",
				buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
				buttonImageOnly : true,
				buttonText : "Select date"
			});

			//-------------------------------------------------------------
			// jqery event 
			//-------------------------------------------------------------
			
			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//------------------------------------------------------------- 
			$('#btnUpdateClose,#btnCreateClose').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/equipHistoryListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdate').click(function() {
				document.objForm.crudType.value = 'U'
				fn_btn_show_hide();
			});

			//-------------------------------------------------------------
			// 수정 취소 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdateCancel').click(function() {
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
						cfAjaxCallAndGoLink("<c:url value='/equipHistorySaveAct.do'/>", $('#objForm').serialize(), '삭제 되었습니다.', 'searchForm', "<c:url value='/equipHistoryListPage.do'/>");
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
						cfAjaxCallAndGoLink("<c:url value='/equipHistorySaveAct.do'/>", $('#objForm').serialize(), '수정 되었습니다.', 'searchForm', "<c:url value='/equipHistoryListPage.do'/>");
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
						cfAjaxCallAndGoLink("<c:url value='/equipHistorySaveAct.do'/>", $('#objForm').serialize(), '생성 되었습니다.', 'searchForm', "<c:url value='/equipHistoryListPage.do'/>");
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
				
				// 입력길이제한
                $("#equipCont").prop("maxlength", 2000);
				
				$("#selEquipCd").selectpicker();
                $("#selEquipCd").parent().addClass("col-sm-12");
                $("#selEquipCd").next("button").addClass("form-control2");
                $("#selEquipCd").parent().wrap("<div class='row'></div>");
                
                $("#selEquipCd.selectpicker").on("change", function() {
                	$.ajax({
                        url : "<c:url value='/getEquipData.do'/>",
                        type: 'POST',
                        data: {equipSeq:$("#selEquipCd").find("option:selected").data("seq")},
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            if(data.rtn.obj != null) {
                            	$("#equipSeq").val(data.rtn.obj.equipSeq);
                            	$("#equipCd").val(data.rtn.obj.equipCd);
                            	$("#equipModelNo").val(data.rtn.obj.equipModelNo);
                            	$("#equipCorpNm").val(data.rtn.obj.equipCorpNm);
                            	$("#equipGetDt").val(data.rtn.obj.equipGetDt);
                            	$("#equipIp").val(data.rtn.obj.equipIp);
                            }
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                });
                				
			});
		});
	})(jQuery);

	function fn_btn_show_hide() {
		if (document.objForm.crudType.value == 'R') {
			$('#viewUpdateDisable').show();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').hide();

			$('.card-body textarea').attr("disabled", true);
			$('.card-body select').attr("disabled", true);
			$('.card-body select').css("background-color", "#e9ecef");
			$('.card-body input').attr("readOnly", true);

			$(".hasDatepicker").each(function(idx, obj) {
				$(obj).datepicker('option', 'disabled', true);
				$(obj).css("background-color", "#e9ecef");
			});
			
			$('.selectpicker').prop('disabled', true);
			$('.selectpicker').selectpicker('refresh');
		} else if (document.objForm.crudType.value == 'U') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').show();
			$('#viewCreate').hide();
			
			$("#equipCont").attr("disabled", false);
			$(".hasDatepicker").each(function(idx, obj) {
				$(obj).datepicker('option', 'disabled', false);
				$(obj).css("background-color", "");
			});
		} else if (document.objForm.crudType.value == 'C') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').show();
		}
	}

	function fn_submit_validation() {

		if ($("#equipDt").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 장비점검일자"));
			$("#equipDt").focus();
			return false;
		}

		if ($("#equipCont").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 장비점검내용"));
			$("#equipCont").focus();
			return false;
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
				<h1 class="mt-4">설비 상세정보</h1>
				<form name="objForm" id="objForm">
					<input type="hidden" name="crudType" value="${search.crudType}" /> 
					<input type="hidden" name="equipHisSeq" value="${rtn.obj.equipHisSeq}" />
					
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">설비정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="custCd">설비코드</label> 
										<input id="equipSeq" name="equipSeq" type="hidden" value="${equipVo.equipSeq}" readonly>
										<input class="form-control" id="equipCd" name="equipCd" type="text" value="${equipVo.equipCd}" readonly>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="equipSeq">장비명</label> 
										<select class="selectpicker" id="selEquipCd" name="selEquipCd" data-size="7" data-live-search="true">
											<option value="">장비선택</option>
											<c:forEach items="${equip_list}" var="item" varStatus="status">
												<c:choose>
                                                	<c:when test="${item.equipSeq == equipVo.equipSeq}">
                                                    	<option data-seq="${item.equipSeq}" value="${item.equipCd}" selected>${item.equipNm}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                    	<option data-seq="${item.equipSeq}" value="${item.equipCd}">${item.equipNm}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="custNm">장비모델번호</label> 
										<input class="form-control" id="equipModelNo" name="equipModelNo" type="text" value="${equipVo.equipModelNo}" readonly>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="equipCorpNm">제조사</label> 
										<input class="form-control" id="equipCorpNm" name="equipCorpNm" type="text" value="${equipVo.equipCorpNm}" readonly>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="equipGetDt" style="display: block;">구입일자</label> 
										<input class="form-control" id="equipGetDt" name="equipGetDt" type="text" value="${equipVo.equipGetDt}" readonly>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="equipIp">설비IP</label> 
										<input class="form-control" id="equipIp" name="equipIp" type="text" value="${equipVo.equipIp}" readonly>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">상세정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="equipDt">장비점검일자</label> 
										<input class="form-control3" id="equipDt" name="equipDt" type="text" value="${rtn.obj.equipDt}" placeholder="장비점검일자을 입력하세요">
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<label class="small mb-1" for="equipCont">장비점검내용</label> 
										<%-- <input class="form-control" id="equipCont" name="equipCont" type="text" value="${rtn.obj.equipCont}" placeholder="장비점검내용을 입력하세요"> --%>
										<textarea class="form-control h-100" rows="4" id="equipCont" name="equipCont" placeholder="장비점검내용을 입력하세요">${rtn.obj.equipCont}</textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card mb-4" style="">
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
		<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
		<input type="hidden" name="pageSize" value="${search.pageSize}" />
		<input type="hidden" name="sortCol" value="${search.sortCol}" />
		<input type="hidden" name="sortType" value="${search.sortType}" />
		<input type="hidden" name="searchEquipNm" value="${search.searchEquipNm}" />
	</form:form>
	<script>
		
	</script>
</body>
</html>