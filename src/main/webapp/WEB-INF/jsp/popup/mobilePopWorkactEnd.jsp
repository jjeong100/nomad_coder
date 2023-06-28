<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	$(document).ready(function() {
		// datepicker 초기화
		$("#popWorkedYmd").datepicker({
			showOn : "button",
			buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
			buttonImageOnly : true,
			buttonText : "Select date",
			dateFormat : "yy/mm/dd"
		});

		// readonly 색상 변경
		$("input[readonly]").css("background-color", "#e9ecef");


		// 팝업 닫기
		$("#popWorkactEndClose, #btnPopWorkactEndCreateClose").click(function() {
			$("#popWorkactEnd").css("display", "none");
			// 메인화면 재조회
			document.popWorkactEndForm.submit();
		});

		// 숫자필드 기본설정
		$("#popPoQty, #popBadQty, #popActokQty, #popPerformanceActokQty, input[id^='popPerformanceVal']").on("keyup", function(event) {
			$(this).val($(this).val().replace(/[^0-9,.+-]/g,""));
		}).on("focus", function() {
			this.select();
		});

		//-------------------------------------------------------------
		// 작업종료 클릭
		//-------------------------------------------------------------
		$("#btnPopWorkactEndCreate").click(function() {
			if ($("#popWorkstYmd").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 시작일자"));
				$("#popWorkstYmd").focus();
				return false;
			}
			if ($("#popWorkstTm").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 시작시간"));
				$("#popWorkstTm").focus();
				return false;
			}
			if ($("#popWorkstMm").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 시작분"));
				$("#popWorkstMm").focus();
				return false;
			}
			if ($("#popWorkedYmd").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 종료일자"));
				$("#popWorkedYmd").focus();
				return false;
			}
			if ($("#popWorkedTm").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 종료시간"));
				$("#popWorkedTm").focus();
				return false;
			}
			if ($("#popWorkedMm").val().trim() == '') {
				alert(MSG_COM_ERR_001.replace("[@]", " : 종료분"));
				$("#popWorkedMm").focus();
				return false;
			}

			var poQty = cfIsNullString($("#popPoQty").val().replace(/[^0-9,.+-]/g,""), 0);
			var actokQty = cfIsNullString($("#popActokQty").val().replace(/[^0-9,.+-]/g,""), 0);
			var actbadQty = cfIsNullString($("#popActbadQty").val().replace(/[^0-9,.+-]/g,""), 0);

			if( parseInt(poQty) != parseInt(actokQty) + parseInt(actbadQty) ) {
				cfAlert("양품+불량수량이 작업수량과 같아야 작업종료 가능합니다.");
				return false;
			}

			var workstDt = $("#popWorkstYmd").val().replace(/[^0-9]/gi, "") + $("#popWorkstTm").val() + $("#popWorkstMm").val() + new Date().getSeconds().toString().padStart(2, "0");
            var workedDt = $("#popWorkedYmd").val().replace(/[^0-9]/gi, "") + $("#popWorkedTm").val() + $("#popWorkedMm").val() + new Date().getSeconds().toString().padStart(2, "0");

            if( workstDt > workedDt ) {
            	cfAlert("종료일자는 시작일자 이후여야 합니다.");
            	return false;
            }

			$("#popWorkactEnd_ins_confirm").dialog("open");
		});

		//-------------------------------------------------------------
		// 생성 다이얼로그 팝업
		//-------------------------------------------------------------
		$("#popWorkactEnd_ins_confirm").dialog({
			autoOpen : false,
			width : 400,
			buttons : [ {
				text : "작업종료",
				click : function() {
					$(".input_number").each(function() {
						$(this).val(this.value.replace(/,/gi, ""));
					});

					document.popWorkactEndForm.crudType.value = "U";
					document.popWorkactEndForm.prodTypeCd.value = "END";
					document.popWorkactEndForm.workstDt.value = $("#popWorkstYmd").val().replace(/[^0-9]/gi, "") + $("#popWorkstTm").val() + $("#popWorkstMm").val() + new Date().getSeconds().toString().padStart(2, "0");
                    document.popWorkactEndForm.workedDt.value = $("#popWorkedYmd").val().replace(/[^0-9]/gi, "") + $("#popWorkedTm").val() + $("#popWorkedMm").val() + new Date().getSeconds().toString().padStart(2, "0");

                    cfAjaxCallAndGoLink("<c:url value='/productionActSaveAct.do'/>"
                            ,$('#popWorkactEndForm').serialize(),'작업종료 되었습니다.'
                            ,'popWorkactEndForm'
                            ,"<c:url value='/mobileProductionWorkactPage.do'/>");
				}
			}, {
				text : "취소",
				click : function() {
					$(this).dialog("close");
				}
			} ]
		});




	});

	// 팝업 호출
	function fn_popWorkactEnd(workactSeq, prodSeq, operCd) {
		// 팝업 호출시 화면 초기화
		$("#popWorkactEnd").css("display", "block");

		document.popWorkactEndForm.workactSeq.value = workactSeq;
		document.popWorkactEndForm.prodSeq.value = prodSeq;
		document.popWorkactEndForm.operCd.value = operCd;

		$.ajax({
			url : "<c:url value='/getProductionWorkactData.do'/>",
			type : 'POST',
			data : $('#popWorkactEndForm').serialize(),
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			context : this,
			dataType : 'json',
			beforeSend : function() {
				$("#popWorkactPerformanceListBody tr").remove();
				$("#popWorkactErrorListBody tr").remove();
				$("#layoutSidenav").loading();
			},
			success : function(data) {
				if (!cfCheckRtnObj(data.rtn))
					return;

				var rtnProductionActVo = data.productionActVo;
				$("input[name='workstDt']").val(rtnProductionActVo.workstDt);
				$("#popSabunId").val(rtnProductionActVo.sabunId);
				$("#popSabunNm").val(rtnProductionActVo.sabunNm);
				$("#popEquipNm").val(rtnProductionActVo.equipNm);
				$("#popPoQty").val(rtnProductionActVo.poQty);
				$("#popActokQty").val(rtnProductionActVo.actokQty);
				$("#popActbadQty").val(rtnProductionActVo.actbadQty);

				var workstDt = data.productionActVo.workstDt;
				workstDt = cfIsNullString(workstDt, "");
				workstDt = workstDt.replace(/[^0-9]/gi, "");

				$("#popWorkstYmd").val(workstDt.substring(0,8).replace(/(\d{4})(\d{2})(\d{2})/, '$1/$2/$3'));
		    	$("#popWorkstTm").val(workstDt.substring(8,10));
		    	$("#popWorkstMm").val(workstDt.substring(10,12));

				var workedDt = data.productionActVo.workedDt;
				workedDt = cfIsNullString(workedDt, "");
				workedDt = workedDt.replace(/[^0-9]/gi, "");

				if( cfIsNull(workedDt) ) {
					var today = new Date();
			    	var date = today.getFullYear() + "/" + (today.getMonth()+1).toString().padStart(2, "0") + "/" + today.getDate().toString().padStart(2, "0");

			    	$("#popWorkedYmd").val(date);
			    	$("#popWorkedTm").val(today.getHours().toString().padStart(2, "0"));
			    	$("#popWorkedMm").val(today.getMinutes().toString().padStart(2, "0"));
				} else {
					$("#popWorkedYmd").val(workedDt.substring(0,8).replace(/(\d{4})(\d{2})(\d{2})/, '$1/$2/$3'));
			    	$("#popWorkedTm").val(workedDt.substring(8,10));
			    	$("#popWorkedMm").val(workedDt.substring(10,12));
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
	}


</script>

<form:form commandName="popWorkactEndVo" id="popWorkactEndForm" name="popWorkactEndForm">
<input type="hidden" name="crudType" value="" />
<input type="hidden" name="searchItemCd" value=""/>
<input type="hidden" name="searchBomTypeCd" value=""/>
<input type="hidden" name="searchPoQty" value=""/>

<input type="hidden" name="workactMstSeq" value="${productionMstActVo.workactMstSeq}"/>
<input type="hidden" name="workactSeq" value=""/>
<input type="hidden" name="prodSeq" value=""/>
<input type="hidden"  id="searchProdSeq" name="searchProdSeq" value="${search.searchProdSeq}"/>
<input type="hidden" name="operCd" value=""/>
<input type="hidden" name="workstDt" value=""/>
<input type="hidden" name="workedDt" value=""/>
<input type="hidden" name="prodTypeCd" value=""/>


	<div id="popWorkactEnd" class="modal-container">
		<div class="modal-content">
			<div class="modal-header">
				<div class="txt20">작업종료 팝업</div>
				<span id="popWorkactEndClose" class="modal-close-button">×</span>
			</div>

			<div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
				<div class="card-header card-header-mobile">
					<sapn>작업종료</sapn>
				</div>

				<div class="card-body">
					<div class="form-row" style="display:none;">
	        			<div class="col-md-6">
			                <div class="form-group">
			                    <label class="small mb-1" for="popWorkstYmd">시작일자</label>
			                    <div class="form-row">
					                <input class="form-control2 col-10" id="popWorkstYmd" name="popWorkstYmd" type="text" style="margin-bottom:4px;"/>
			                    </div>
			                </div>
			            </div>
			        	<div class="col-md-3">
			                <div class="form-group">
			                    <label class="small mb-1" for="popWorkstTm">시간</label>
			                    <select class="form-control2" id="popWorkstTm" name="popWorkstTm">
				                    <c:forEach var="i" begin="0" end="23">
				                    	<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}" type="number"/>">${i}</option>
				                    </c:forEach>
			                    </select>
			                </div>
			            </div>
			        	<div class="col-md-3">
			                <div class="form-group">
			                    <label class="small mb-1" for="popWorkstMm">분</label>
			                    <select class="form-control2" id="popWorkstMm" name="popWorkstMm">
				                    <c:forEach var="i" begin="0" end="59">
				                    	<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}" type="number"/>">${i}</option>
				                    </c:forEach>
			                    </select>
			                </div>
			            </div>
			            <div class="col-md-3">
			            </div>
			        </div>
					<div class="form-row">
	        			<div class="col-md-6">
			                <div class="form-group">
			                    <label class="small mb-1" for="popWorkedYmd">종료일자</label>
			                    <div class="form-row">
					                <input class="form-control2 col-10" id="popWorkedYmd" name="workedYmd" type="text" style="margin-bottom:4px;"/>
			                    </div>
			                </div>
			            </div>
			        	<div class="col-md-3">
			                <div class="form-group">
			                    <label class="small mb-1" for="popWorkedTm">시간</label>
			                    <select class="form-control2" id="popWorkedTm" name="workedTm">
				                    <c:forEach var="i" begin="0" end="23">
				                    	<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}" type="number"/>">${i}</option>
				                    </c:forEach>
			                    </select>
			                </div>
			            </div>
			        	<div class="col-md-3">
			                <div class="form-group">
			                    <label class="small mb-1" for="popWorkedMm">분</label>
			                    <select class="form-control2" id="popWorkedMm" name="workedMm">
				                    <c:forEach var="i" begin="0" end="59">
				                    	<option value="<fmt:formatNumber minIntegerDigits="2" value="${i}" type="number"/>">${i}</option>
				                    </c:forEach>
			                    </select>
			                </div>
			            </div>
			        </div>
			        <div class="form-row">
			            <div class="col-md-6">
			                <div class="form-group">
			                    <label class="small mb-1" for="popEquipNm">작업 설비</label>
		                    	<input class="form-control2" id="popEquipNm" name="popEquipNm" type="text" readonly/>
			                </div>
			            </div>
			            <div class="col-md-6">
			                <div class="form-group">
			                    <label class="small mb-1" for="popSabunNm">작업자</label>
			                    <input id="popSabunId" name="sabunId" type="hidden"/>
			                    <input class="form-control2" id="popSabunNm" name="sabunNm" type="text" readonly/>
			                </div>
			            </div>
					</div>

					<div class="form-row">
			            <div class="col-md-4">
			                <div class="form-group">
			                    <label class="small mb-1" for="popPoQty">작업수량</label>
		                    	<input class="form-control2 input_number" id="popPoQty" name="poQty" type="text" readonly/>
			                </div>
			            </div>
			            <div class="col-md-4">
			                <div class="form-group">
			                    <label class="small mb-1" for="popActokQty">양품수량</label>
		                    	<input class="form-control2 input_number" id="popActokQty" name="actokQty" type="text"/>
			                </div>
			            </div>
			            <div class="col-md-4">
			                <div class="form-group">
			                    <label class="small mb-1" for="popActbadQty">불량수량</label>
		                    	<input class="form-control2 input_number" id="popActbadQty" name="actbadQty" type="text"/>
			                </div>
			            </div>
					</div>
				</div>
			</div>
			<div class="card" style="margin-left: 30px; margin-right: 30px;">
				<div class="card-body">
					<!-- 생성 버튼 -->
					<div id="viewCreate" class="col-md-12">
						<div class="form-row">
							<div class="col-md-6">
								<div id="btnPopWorkactEndCreate" class="btn btn-primary btn-block">작업종료</div>
							</div>
							<div class="col-md-6">
								<div id="btnPopWorkactEndCreateClose" class="btn btn-primary btn-block">닫기</div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
</form:form>

<div id="popWorkactEnd_ins_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p>작업종료 하시겠습니까 ?</p>
    </div>
</div>

<!-- 성능등록 -->
<div id="workact_performance_confirm" title="성능팝업" style="display:none;overflow:hidden;">
	<form:form commandName="popWorkactPerformanceVo" id="popWorkactPerformanceForm" name="popWorkactPerformanceForm">
		<input type="hidden" name="crudType"				value="C" />
		<input type="hidden" name="workactSeq"				value="" />
		<input type="hidden" name="workactPerformanceSeq"	value="" />

	    <div class="col-md-12" id="workactPerformanceBody">
	        <div class="form-row">
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceTypeCd1">성능1코드</label>
	                    <select class="form-control2" id="popPerformanceTypeCd1" name="performanceTypeCd1">
	                    	<option value="">성능코드 선택</option>
	                    	<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
	                    		<option value="${item.scode}">${item.codeNm}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceVal1">성능1값</label>
	                    <input class="form-control2 col-8 input_number" id="popPerformanceVal1" name="performanceVal1" type="text"/>
	                </div>
	            </div>
	        </div>
	        <div class="form-row">
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceTypeCd2">성능2코드</label>
	                    <select class="form-control2" id="popPerformanceTypeCd2" name="performanceTypeCd2">
	                    	<option value="">성능코드 선택</option>
	                    	<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
	                    		<option value="${item.scode}">${item.codeNm}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceVal2">성능2값</label>
	                    <input class="form-control2 col-8 input_number" id="popPerformanceVal2" name="performanceVal2" type="text"/>
	                </div>
	            </div>
	        </div>
	        <div class="form-row">
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceTypeCd3">성능3코드</label>
	                    <select class="form-control2" id="popPerformanceTypeCd3" name="performanceTypeCd3">
	                    	<option value="">성능코드 선택</option>
	                    	<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
	                    		<option value="${item.scode}">${item.codeNm}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceVal3">성능3값</label>
	                    <input class="form-control2 col-8 input_number" id="popPerformanceVal3" name="performanceVal3" type="text"/>
	                </div>
	            </div>
	        </div>
	        <div class="form-row">
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceTypeCd4">성능4코드</label>
	                    <select class="form-control2" id="popPerformanceTypeCd4" name="performanceTypeCd4">
	                    	<option value="">성능코드 선택</option>
	                    	<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
	                    		<option value="${item.scode}">${item.codeNm}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceVal4">성능4값</label>
	                    <input class="form-control2 col-8 input_number" id="popPerformanceVal4" name="performanceVal4" type="text"/>
	                </div>
	            </div>
	        </div>
	        <div class="form-row">
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceTypeCd5">성능5코드</label>
	                    <select class="form-control2" id="popPerformanceTypeCd5" name="performanceTypeCd5">
	                    	<option value="">성능코드 선택</option>
	                    	<c:forEach items="${performance_type_cd_list}" var="item" varStatus="status">
	                    		<option value="${item.scode}">${item.codeNm}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceVal5">성능5값</label>
	                    <input class="form-control2 col-8 input_number" id="popPerformanceVal5" name="performanceVal5" type="text"/>
	                </div>
	            </div>
	        </div>
	        <div class="form-row">
	            <div class="col-md-12">
	                <div class="form-group">
	                    <label class="small mb-1" for="popPerformanceActokQty">양품수량</label>
	                    <input class="form-control2 col-6 input_number" id="popPerformanceActokQty" name="actokQty" type="text"/>
	                </div>
	            </div>
	        </div>
	    </div>

	</form:form>
</div>



<!-- 불량등록 -->
<div id="workact_error_confirm" title="불량팝업" style="display:none;overflow:hidden;">
	<form:form commandName="popWorkactErrorVo" id="popWorkactErrorForm" name="popWorkactErrorForm">
		<input type="hidden" name="crudType"			value="C" />
		<input type="hidden" name="workactSeq"			value="" />
		<input type="hidden" name="workactBadSeq"		value="" />

	    <div class="col-md-12">
	        <div class="form-row">
	            <div class="col-md-4">
	                <div class="form-group">
	                    <label class="small mb-1" for="popBadCd">불량코드</label>
	                    <select class="form-control2" id="popBadCd" name="badCd">
	                    	<option value="">불량코드 선택</option>
	                    	<c:forEach items="${bad_cd_list}" var="item" varStatus="status">
	                    		<option value="${item.scode}">${item.codeNm}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="col-md-6">
	                <div class="form-group">
	                    <label class="small mb-1" for="popBadQty">불량수량</label>
	                    <input class="form-control2 col-8 input_number" id="popBadQty" name="badQty" type="text"/>
	                </div>
	            </div>
	        </div>
	    </div>

	</form:form>
</div>



<!-- 파일업로드 -->
<script type="text/javascript" src="<c:url value='/resource/js/ext/excel/xlsx.full.min.js'/>"></script>

<div id="workactError_excelUpload" title="엑셀 업로드 팝업" style="display: none;">
	<div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
		<p>Excel Upload</p>
	</div>
	<form:form commandName="workactErrorUpload" id="workactErrorUploadForm" name="workactErrorUploadForm" enctype="multipart/form-data">
		<div class="form-row">
			<div class="col-md-12">
				<div class="form-group">
					<label class="small mb-1" for="docNm">첨부파일</label>
					<div class="row ml-auto">
						<input type="file" id="excelFile" onchange="excelExport(event)" />
					</div>
				</div>
			</div>
		</div>
	</form:form>
</div>

<script>
function excelExport(event) {
	excelExportCommon(event, handleExcelDataAll);
}

function excelExportCommon(event, callback) {
	var input = event.target;
	var reader = new FileReader();
	reader.onload = function() {
		var fileData = reader.result;
		var wb = XLSX.read(fileData, {
			type : 'binary', cellDates: true, dateNF: 'YYYYMMDD'
		});
		var sheetNameList = wb.SheetNames; // 시트 이름 목록 가져오기
		var firstSheetName = sheetNameList[0]; // 첫번째 시트명
		var firstSheet = wb.Sheets[firstSheetName]; // 첫번째 시트
		callback(firstSheet);
	};
	reader.readAsBinaryString(input.files[0]);
}

function handleExcelDataAll(sheet) {
	handleExcelDataJson(sheet); // json 형태
}

var arrMpo012 = new Array();
function handleExcelDataJson(sheet) {
	var sheetData = XLSX.utils.sheet_to_json(sheet, {raw: false});

	for (var i = 0; i < sheetData.length; i++) {
		var sheetObj = sheetData[i];
		var idx = 0;

		var mpo012 = new Object();
		mpo012.workactSeq	= document.popWorkactEndForm.workactSeq.value;
		mpo012.poCalldt		= sheetObj[Object.keys(sheetObj)[idx++]];
		mpo012.itemNm		= sheetObj[Object.keys(sheetObj)[idx++]];
// 		mpo012.poQty		= sheetObj[Object.keys(sheetObj)[idx++]];
		mpo012.actokQty		= sheetObj[Object.keys(sheetObj)[idx++]];
		mpo012.badQty		= sheetObj[Object.keys(sheetObj)[idx++]];
		mpo012.badCd		= "BAD04";
// 		mpo012.badQty		= parseInt(mpo012.poQty) - parseInt(mpo012.actokQty);

		if( parseInt(mpo012.badQty) > 0 && i == sheetData.length - 1 ) {
			arrMpo012.push(mpo012);
		}
	}
}
</script>