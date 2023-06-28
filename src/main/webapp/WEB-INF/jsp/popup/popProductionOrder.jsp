<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	$(document).ready(function() {
		// datepicker 초기화
		$("#popPoCalldt, #popPoTargetdt").datepicker({
			showOn : "button",
			buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
			buttonImageOnly : true,
			buttonText : "Select date",
			dateFormat : "yy/mm/dd"
		});

		// selectbox search
		$("#popItemCd").selectpicker();
		$("#popItemCd").parent().addClass("col-sm-12");
		$("#popItemCd").next("button").addClass("form-control2");
		$("#popItemCd").parent().wrap("<div class='row'></div>");
		
		// 반제품선택 비활성화
		$("#popItemCd").prop("disabled", true);
		$("#popItemCd").selectpicker("refresh");
		
		// 작업지시상태
		if ($("#popProdTypeCd").val().trim() == '') {
			$("#popProdTypeCd  option:eq(1)").prop("selected", true);
		}
		
		// 작업우선순위
		if ($("#popPoOrd").val().trim() == '') {
			$("#popPoOrd").val(1);
		}

		// 팝업 닫기
		$("#popProductionOrderClose, #btnPopCreateClose").click(function() {
			$("#popProductionOrder").css("display", "none");
		});
		
		// 숫자필드 기본설정
		$("#popPoQty").on("keyup", function(event) {
			$(this).val($(this).val().replace(/[^0-9,.+-]/g,""));
		}).on("focus", function() {
			this.select();
		});
		
		//-------------------------------------------------------------
		// 제품 select 변경
		//------------------------------------------------------------- 
		$("#popItemCd, #popPoQty").change(function() {
			$("#popMatRequireListBody tr").remove();
		});

		//-------------------------------------------------------------
		// 소요량 보기 클릭
		//------------------------------------------------------------- 
		$("#btnPopCalQty").click(function() {
			if ($("#popItemCd").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 제품"));
				$("#popItemCd").focus();
				return false;
			}
			if ($("#popPoQty").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 지시수량"));
				$("#popPoQty").focus();
				return false;
			}

			fn_popMatRequireList();
		});
		
		//-------------------------------------------------------------
		// 생성 클릭
		//------------------------------------------------------------- 
		$("#btnPopCreate").click(function() {
			if ($("#popPoCalldt").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 작업지시일자"));
				$("#popPoCalldt").focus();
				return false;
			}
			if ($("#popPoTargetdt").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 작업완료일자"));
				$("#popPoTargetdt").focus();
				return false;
			}
			if ($("#popPoQty").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 작업완료일자"));
				$("#popPoQty").focus();
				return false;
			}
			if ($("#popProdTypeCd").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 작업지시상태"));
				$("#popProdTypeCd").focus();
				return false;
			}
			if ($("#popPoOrd").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 작업우선순위"));
				$("#popPoOrd").focus();
				return false;
			}
			
			if( $("#popMatRequireListBody tr").length < 1 ) {
				alert("소요량보기 클릭 후 생성 가능합니다.");
				return false;
			}
			
			$("#glv_pop_ins_confirm").dialog("open");
		});
		
		//-------------------------------------------------------------
		// 생성 다이얼로그 팝업
		//------------------------------------------------------------- 
		$("#glv_pop_ins_confirm").dialog({
			autoOpen : false,
			width : 400,
			buttons : [ {
				text : "생성",
				click : function() {
					//$(this).dialog("close");
					document.popProudctionOrderForm.crudType.value = "C";
					$("#popPoQty").each(function() {
						$(this).val(this.value.replace(/,/gi, ""));
					});

					$("#popPoCalldt").val($("#popPoCalldt").val().replaceAll('/', ''));
					$("#popPoTargetdt").val($("#popPoTargetdt").val().replaceAll('/', ''));
					
					$("#popItemCd").prop("disabled", false);
					$("#popItemCd").selectpicker("refresh");
					
					$.ajax({
						url : "<c:url value='/productionOrderSaveAct.do'/>",
						type : 'POST',
						data : $('#popProudctionOrderForm').serialize(),
						contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
						context : this,
						dataType : 'json',
						beforeSend : function() {
							$("#layoutSidenav").loading();
						},
						success : function(data) {
							if (!cfCheckRtnObj(data.rtn)) return;
							
							cfAlert("생성 되었습니다.");
							$("#btnCalQty").click();
							$(this).dialog("close");
							$("#popProductionOrder").css("display", "none");
						},
						error : function(request, status, error) {
							console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
							cfAlert('시스템 오류입니다.');
							$("#popItemCd").prop("disabled", true);
							$("#popItemCd").selectpicker("refresh");
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
	});

	function fn_popProductionOrder(param) {
		// 팝업 호출시 화면 초기화
		$("#popPoCalldt").val("");
		$("#popPoTargetdt").val(param.poCalldt);
		$("#popPoQty").val(param.poQty);
		$("#popItemCd").val(param.matCd);
		$("#popItemCd").selectpicker("refresh");
		$("#popMatRequireListBody tr").remove();
		
		$("#popProductionOrder").css("display", "block");
	}
	
	function fn_popMatRequireList() {
		document.popProudctionOrderForm.searchPoQty.value = cfIsNullString($("#popPoQty").val(), "0").replace(/[^0-9]/gi, "");
		document.popProudctionOrderForm.searchBomTypeCd.value = 'MT';
		document.popProudctionOrderForm.searchItemCd.value = $("#popItemCd").val();

		$.ajax({
			url : "<c:url value='/searchMatRequireListData.do'/>",
			type : 'POST',
			data : $('#popProudctionOrderForm').serialize(),
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			context : this,
			dataType : 'json',
			beforeSend : function() {
				$("#popMatRequireListBody tr").remove();
				$("#layoutSidenav").loading();
			},
			success : function(data) {
				if (!cfCheckRtnObj(data.rtn))
					return;
				var html = "";
				$.each(data.rtn.obj, function(key, val) {
					var rtnObj = JSON.stringify(val).replace(/\"/gi, "\'");

					html = "";
					html += "<tr role=\"row\" class=\"odd\">";
					html += "<td class=\"text-center text-ellipsis\" style=\"width: 25%;\"><span>" + val.matNm + "</span></td>";
					html += "<td class=\"text-center text-ellipsis\" style=\"width: 15%;\"><span>" + val.matTypeNm + "</span></td>";
					html += "<td class=\"text-center text-ellipsis\" style=\"width: 15%;\"><span>" + cfAddComma(cfIsNullString(val.demandQty, "0")) + "</span></td>";
					html += "<td class=\"text-center text-ellipsis\" style=\"width: 15%;\"><span>" + cfAddComma(cfIsNullString(val.remainQty, "0")) + "</span></td>";
					html += "</tr>";
					$("#popMatRequireListBody").append(html);
				});

				$("#popProductionOrder").css("display", "block");
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
</script>

<form:form commandName="popProudctionOrderVO" id="popProudctionOrderForm" name="popProudctionOrderForm">
<input type="hidden" name="crudType" value="" />
<input type="hidden" name="searchItemCd" value=""/>
<input type="hidden" name="searchBomTypeCd" value=""/>
<input type="hidden" name="searchPoQty" value=""/>
	    
	<div id="popProductionOrder" class="modal-container">
		<div class="modal-content">
			<div class="modal-header">
				<div class="txt20">반제품 생산지시 팝업</div>
				<span id="popProductionOrderClose" class="modal-close-button">×</span>
			</div>
			
			<div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
				
				<div class="card-header">
					<h3 class="text-center font-weight-light my-1">반제품 생산지시 추가</h3>
				</div>
				<div class="card-body">
				
					<div class="form-row">
						<div class="col-md-3">
							<div class="form-group">
								<label class="small mb-1" for="popPoCalldt">작업지시일자</label>
								<input class="form-control3" id="popPoCalldt" name="poCalldt" type="text" value="${rtn.obj.poCalldt}" placeholder="작업지시일자" />
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label class="small mb-1" for="popPoTargetdt">작업완료일자</label>
								<input class="form-control3" id="popPoTargetdt" name="poTargetdt" type="text" value="${rtn.obj.poTargetdt}" placeholder="작업완료일자" />
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label class="small mb-1" for="popProdTypeCd">작업지시상태</label>
								<select class="form-control2" id="popProdTypeCd" name="prodTypeCd">
									<option value="">작업지시 선택</option>
									<c:forEach items="${prod_type_cd_list}" var="item" varStatus="status">
										<c:choose>
											<c:when test="${item.scode == rtn.obj.prodTypeCd}">
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
								<label class="small mb-1" for="popPoOrd">작업우선순위</label>
								<input class="form-control input_number" id="popPoOrd" name="poOrd" type="text" value="${rtn.obj.poOrd}" placeholder="작업우선순위" />
							</div>
						</div>
					</div>
					
					<div class="form-row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="small mb-1" for="popItemCd">제품</label>
								<select class="selectpicker" id="popItemCd" name="itemCd" data-size="7" data-live-search="true">
									<option value="">제품 선택</option>
									<c:forEach items="${product_list}" var="item" varStatus="status">
										<c:if test="${item.itemTypeCd == 'H'}">
											<c:choose>
												<c:when test="${item.itemCd == rtn.obj.itemCd}">
													<option value="${item.itemCd}" selected>${item.itemNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${item.itemCd}">${item.itemNm}</option>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-md-2">
							<div class="form-group">
								<label class="small mb-1" for="popPoQty">지시수량</label>
								<input class="form-control input_number" id="popPoQty" name="poQty" type="text" value="<fmt:formatNumber value="${rtn.obj.poQty}" pattern="###,###.##"/>" placeholder="작업지시수량" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group pt-4">
								<div id="btnPopCalQty" class="btn btn-primary btn-block">소요량 보기</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card-header">
					<h3 class="text-center font-weight-light my-1">자재 소요 정보</h3>
				</div>
				
				<div class="card-body">
					<div class="table-responsive">
						<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
							<div class="row" style="overflow-y: auto;">
								<div class="col-sm-12">
									<table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
										<thead class="thead-dark">
											<tr role="row">
												<th class="text-center" style="width: 25%;">자재명</th>
												<th class="text-center" style="width: 15%;">구분</th>
												<th class="text-center" style="width: 15%;">소요수량</th>
												<th class="text-center" style="width: 15%;">재고수량</th>
											</tr>
										</thead>
										<tbody id="popMatRequireListBody" />
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card" style="">
					<div class="card-body">
						<!-- 생성 버튼 -->
						<div id="viewCreate" class="col-md-12">
							<div class="form-row">
								<div class="col-md-6">
									<div id="btnPopCreate" class="btn btn-primary btn-block">생성</div>
								</div>
								<div class="col-md-6">
									<div id="btnPopCreateClose" class="btn btn-primary btn-block">닫기</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
				
		</div>
	</div>
</form:form>

<div id="glv_pop_ins_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p>생성 하시겠습니까 ?</p>
    </div> 
</div>