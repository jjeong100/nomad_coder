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
<title>외주거래 정보 관리</title>
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
			$(".input_number").on("keyup", function(event) {
				$(this).val($(this).val().replace(/[^0-9,.+-]/g, ""));
			});
			
			$("#outSocSdt").datepicker({
				showOn : "button",
				buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
				buttonImageOnly : true,
				buttonText : "Select date",
				dateFormat : "yy/mm/dd"
			});
			
			//달력(calendar) 위치
			$(".ui-datepicker").css({ "margin-left" : "141px", "margin-top": "-38px"});

			//-------------------------------------------------------------
			// jqery event 
			//-------------------------------------------------------------
			$("#matgpCd").change(function(event) {
				var matgpCd = $(this).val();

				if (matgpCd == "") {
					$("#itmgpCd > option").show();
				} else {
					$("#itmgpCd").val("");
					$("#itmgpCd > option").hide();
					$("#itmgpCd option[value='']").show();
					$("#itmgpCd > option[data-key='" + matgpCd + "']").show();
				}
			});

			$("#itmgpCd").change(function(event) {
				var matgpCd = $("#itmgpCd > option:selected").data("key");
				$("#matgpCd").val(matgpCd);
			});

			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//------------------------------------------------------------- 
			$('#btnUpdateClose,#btnCreateClose').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/outSocListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 수정 가능 버튼 클릭
			//-------------------------------------------------------------
			$('#btnEnableUpdate').click(function() {
				$('.card-body select').attr("disabled", false);
				$('.card-body select').css("background-color", "");
				$('.card-body input').attr("readOnly", false);
				$('#itemCd').attr("readOnly", true);
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
						cfAjaxFileCallAndGoLink("<c:url value='/outSocSaveAct.do'/>", $("#objForm"), '삭제 되었습니다.', 'searchForm', "<c:url value='/outSocListPage.do'/>");
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
						cfAjaxFileCallAndGoLink("<c:url value='/outSocSaveAct.do'/>", $("#objForm"), '수정 되었습니다.', 'searchForm', "<c:url value='/outSocListPage.do'/>");
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
						cfAjaxFileCallAndGoLink("<c:url value='/outSocSaveAct.do'/>", $("#objForm"), '생성 되었습니다.', 'searchForm', "<c:url value='/outSocListPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});
			
			//-------------------------------------------------------------
			// 자재입고 이벤트
			//-------------------------------------------------------------
			$("#btnMaterialIn").click(function() {
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
							cfAjaxFileCallAndGoLink("<c:url value='/outSocSaveAct.do'/>", $("#objForm"), '생성 되었습니다.', 'searchForm', "<c:url value='/outSocListPage.do'/>");
						}
					}, {
						text : "취소",
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
			});
			
			//-------------------------------------------------------------
			// 입고취소 이벤트
			//-------------------------------------------------------------
			$("#btnMaterialCancle").click(function() {
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
							cfAjaxFileCallAndGoLink("<c:url value='/outSocSaveAct.do'/>", $("#objForm"), '생성 되었습니다.', 'searchForm', "<c:url value='/outSocListPage.do'/>");
						}
					}, {
						text : "취소",
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
			});
			
			//-------------------------------------------------------------
			// onLoad  
			//-------------------------------------------------------------
			$(document).ready(function() {
				fn_btn_show_hide();
				
				if( ${fn:length(comFileList) > 0} ) {
					$("#divFileBox").hide();
				} else {
					$("#divFileBox").show();
				}
				
				if( ${rtn.obj.outMatQty == null} ) {
					$("#outMatQty").val(0);
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
		if ($("#outSocSdt").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 거래일자"));
			$("#outSocSdt").focus();
			return false;
		}
		if ($("#outCustCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 외주자재처"));
			$("#outCustCd").focus();
			return false;
		}
		if ($("#outMatCd").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 외주자재"));
			$("#outMatCd").focus();
			return false;
		}
		if ($("#outMatQty").val().trim() == '') {
			alert(MSG_COM_ERR_001.replace("[@]", " : 수량"));
			$("#outMatQty").focus();
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
			$("#outSocSdt").datepicker('option', 'disabled', true);
			$("#outSocSdt").css("background-color", "#e9ecef");
			$('.card-body input[type="file"]').attr("disabled", true);
			$("#btnMaterialIn, #btnMaterialCancle").show();
			$('.selectpicker').prop('disabled', true);
			$('.selectpicker').selectpicker('refresh');
		} else if (document.objForm.crudType.value == 'U') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').show();
			$('#viewCreate').hide();
			$("#outSocSdt").datepicker('option', 'disabled', false);
			$("#outSocSdt").css("background-color", "");
			if( ${fn:length(comFileList) == 0} ) {
				$('.card-body input[type="file"]').attr("disabled", false);
				$("#divFileBox").show();
			}
			$("#btnMaterialIn, #btnMaterialCancle").hide();
			$('.selectpicker').prop('disabled', false);
			$('.selectpicker').selectpicker('refresh');
		} else if (document.objForm.crudType.value == 'C') {
			$('#viewUpdateDisable').hide();
			$('#viewUpdateEnable').hide();
			$('#viewCreate').show();
			$("#btnMaterialIn, #btnMaterialCancle").hide();
		}
	}
	
	//-------------------------------------------------------------
	// 파일선택 callback
	//-------------------------------------------------------------
	function fn_fileCallback(obj) {
		var fileName = $(obj).val().split("\\").pop();
		$(obj).next(".custom-file-label").addClass("selected").html(fileName);
	}
	
	//-------------------------------------------------------------
	// fn_fileBtnClick
	//-------------------------------------------------------------
	function fn_fileBtnClick(div, url, key, obj) {
		if( div == "delete" && document.objForm.crudType.value == "R" ) {
			alert("수정상태일때만 삭제 가능합니다.");
			return false;
		}
		
		cfComFile(url, key, obj);
	}
	
	//-------------------------------------------------------------
	// 파일삭제 callback
	//-------------------------------------------------------------
	function fn_fileDeleteCallback() {
		$('.card-body input[type="file"]').attr("disabled", false);
		$("#divFileBox").show();
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
				<h1 class="mt-4">외주거래 상세정보</h1>
				<form name="objForm" id="objForm" method="post" enctype="multipart/form-data">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<input type="hidden" name="outSocSeq" value="${rtn.obj.outSocSeq}" />
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">
								거래 상세 정보
								<!-- <div class="float-right mr-2">
									<div id="btnMaterialCancle" class="btn btn-primary btn-block">입고취소</div>
								</div>
								<div class="float-right mr-2">
									<div id="btnMaterialIn" class="btn btn-primary btn-block">자재입고</div>
								</div> -->
							</h3>
						</div>
						<div class="card-body">
						
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="outSocSdt" style="display: block;">거래일자</label> 
										<input class="form-control3" id="outSocSdt" name="outSocSdt" type="text" value="${rtn.obj.outSocSdt}" placeholder="거래일자를 입력하세요" />
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="outCustCd">외주자재처</label>
										<select class="selectpicker" id="outCustCd" name="outCustCd" data-size="7" data-live-search="true">
											<option value="">자재처 선택</option>
											<c:forEach items="${mat_cust_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.custCd == rtn.obj.outCustCd}">
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
							</div>
							
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="outMatCd">외주자재</label>
										<select class="selectpicker" id="outMatCd" name="outMatCd" data-size="7" data-live-search="true">
											<option value="">자재 선택</option>
											<c:forEach items="${material_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.matCd == rtn.obj.outMatCd}">
														<option value="${item.matCd}" selected>${item.matNm}(${item.matGrpNm})</option>
													</c:when>
													<c:otherwise>
														<option value="${item.matCd}">${item.matNm}(${item.matGrpNm})</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="outMatQty">수량</label>
										<input class="form-control input_number" id="outMatQty" name="outMatQty" type="text" value="<fmt:formatNumber value="${rtn.obj.outMatQty}" pattern="#,###"/>" placeholder="안전재고수량을 입력하세요">
									</div>
								</div>
							</div>
							
							<div class="form-row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="small mb-1" for="bigo">비고</label>
										<input class="form-control" id="bigo" name="bigo" type="text" value="${rtn.obj.bigo}" placeholder="비고룰 입력하세요">
									</div>
								</div>
							</div>
							
							<div class="form-row">
								<div class="col-md-9">
									<label class="small mb-1" for="comFileupload0">첨부파일</label>
                                	<div id="divFile" class="form-group">
                                		<c:if test="${fn:length(comFileList) > 0}">
                                			<ul class="list-group col-sm-9 mb-2 pr-0">
	                                			<c:forEach items="${comFileList}" var="item" varStatus="status">
	                                				<li class="list-group-item d-flex justify-content-between align-items-center p-2">
	                                					<div class="mr-auto">${item.fileOrgNm}</div>
	                                					
	                                					<div class="">
	                                						<span class="btn btn-sm btn-blue" onclick="javascript:fn_fileBtnClick('download', '<c:url value='/downloadComFile.do'/>', '${item.fileSeq}', this)">다운로드</span>
	                                						<span class="btn btn-sm btn-danger" onclick="javascript:fn_fileBtnClick('delete', '<c:url value='/deleteComFile.do'/>', '${item.fileSeq}', this)">삭제</span>
	                                					</div>
	                                				</li>
	                                			</c:forEach>
                                			</ul>
                                		</c:if>
	                                	<div id="divFileBox" class="form-group">
	                                       	<div class="custom-file col-md-9 mb-2">
	                                       		<input type="file" class="custom-file-input" id="comFileupload0" name="filename0" lang="kr" onchange="javascript:fn_fileCallback(this);">
	                                       		<label class="custom-file-label" for="comFileupload0">파일을 선택하세요</label>
	                                       	</div>
                                       	</div>
                                	</div>
                                </div>
							</div>
							
							<div class="form-row">
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
					</div>
				</form>
			</div>
			</main>
		</div>
	</div>
	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" name="pageIndex" value="1" />
		<input type="hidden" name="searchOutMatNm" value="${search.searchOutMatNm}" />
		<input type="hidden" name="searchOutCustNm" value="${search.searchOutCustNm}" />
	</form:form>
	<script>
		
	</script>
</body>
</html>