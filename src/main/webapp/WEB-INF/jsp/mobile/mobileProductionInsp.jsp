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
<title>PowerMES</title>
<style>
@media print {
	body {
		-webkit-print-color-adjust: exact !important;
		margin-top: 0mm;
		margin-bottom: 0mm;
		margin-left: 0mm;
		margin-right: 0mm;
		background-color: transparent;
	}
	
	@page {
	  size: A4 portrait;
	  /* margin: 10mm; */
	}
	
    .page-break {
    	margin-top: 10mm !important;
    	page-break-before: auto !important;
    	page-break-inside: avoid !important;
    }
}
</style>

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
			$("#inspDt").datepicker({dateFormat: "yy/mm/dd"});
			$("#inspDt").css("color", "#212529");
			
			//-------------------------------------------------------------
			// jqery event 
			//-------------------------------------------------------------
			$("#btnClose").click(function() {
				var frm = document.objForm;
				frm.action = "<c:url value='/mobileProductionListPage.do'/>";
				frm.submit();
			});
			
			//-------------------------------------------------------------
            // 시료추가
            //-------------------------------------------------------------
			$("#btnAdd").click(function() {
				if( $("tr[id^='inspSmpNo_']").length < 14) {
					drawInspSmpNo();
				} else {
					cfAlert("시료추가는 14번까지만 추가 가능합니다.");
					return false;
				}
			});
			
			//-------------------------------------------------------------
            // 사원 팝업
            //-------------------------------------------------------------
            $(".sign").click(function() {
            	var kindId = $(this).attr("id");
            	$("#popWorker").data("kindId", kindId).dialog("open");
            });
			
			//-------------------------------------------------------------
			// 등록
			//-------------------------------------------------------------
			$('#btnSave').click(function() {
				// 등록 가능 상태 확인.
				$.ajax({
	                url : "<c:url value='/chkInspWrite.do'/>",
	                type: 'POST',
	                data: $('#objForm').serialize(),
	                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	                context:this,
	                dataType:'json',
	                beforeSend:function(){
	                    $("#layoutSidenav").loading();
	                },
	                success: function(data) {
	                	if(!cfCheckRtnObj(data.rtn)) {
	                		return;
	                	} else {
	                		$("#glv_ins_confirm").dialog("open");
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
				
				//$("#glv_ins_confirm").dialog("open");
			});
			
			//-------------------------------------------------------------
			// 출력
			//-------------------------------------------------------------
			$("#btnPrint").click(function() {
				fn_print();
			});

			//-------------------------------------------------------------
			//
			//-------------------------------------------------------------
			$("#glv_ins_confirm").dialog({
				autoOpen : false,
				width : 400,
				buttons : [ {
					text : "생성",
					click : function() {
						$(this).dialog("close");
						cfAjaxCallAndGoLink("<c:url value='/productionInspSaveAct.do'/>"
											, $("#objForm").serialize(), "생성 되었습니다."
											, "objForm", "<c:url value='/mobileProductionInspPage.do'/>");
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
				
				// 검사자
				if( cfIsNull($("#inspId").val()) ) {
					$("#inspId").val("${sessionData.userId}");
					$("#inspNm").text("${sessionData.userName}");
				}
				
				// 검사일
				if( cfIsNull($("#inspDt").val()) ) {
					$("#inspDt").datepicker("setDate", new Date());
				}
				
				// 측정값 설정
				<c:forEach items="${inspRltDtlList}" var="item" varStatus="status">
					$("input[data-no='${item.inspSmpNo}'][data-num='${item.inspSmpNum}'][data-nm='inspDtlSeq']").val("${item.inspDtlSeq}");
					
					$("input[data-no='${item.inspSmpNo}'][data-num='${item.inspSmpNum}'][data-nm='measureVal1']").val("${item.measureVal1}");
					$("input[data-no='${item.inspSmpNo}'][data-num='${item.inspSmpNum}'][data-nm='measureVal2']").val("${item.measureVal2}");
					$("input[data-no='${item.inspSmpNo}'][data-num='${item.inspSmpNum}'][data-nm='measureVal3']").val("${item.measureVal3}");
					$("input[data-no='${item.inspSmpNo}'][data-num='${item.inspSmpNum}'][data-nm='measureVal4']").val("${item.measureVal4}");
					$("input[data-no='${item.inspSmpNo}'][data-num='${item.inspSmpNum}'][data-nm='measureVal5']").val("${item.measureVal5}");
					
					fn_check_insp($("input[data-no='${item.inspSmpNo}'][data-num='${item.inspSmpNum}'][data-nm='measureVal1']"));
				</c:forEach>
			});

		});
	})(jQuery);

	//=====================================================================
	// button action funtion
	//=====================================================================
	function drawInspSmpNo(inspSmpNo) {
		var html = "";
		var row = cfIsNull(inspSmpNo) ? $("tr[id^='inspSmpNo_']").length:inspSmpNo;
		row++;
		
		html += "<tr class=\"page-break\">";
		html += "	<td>";
		html += "		<table border=\"2\" width=\"100%\" class=\"table-report table-report-bordered tr-table\">";
		html += "			<tr id=\"inspSmpNo_" + (row-1) + "\">";
		html += "				<td colspan=\"1\" rowspan=\"4\" width=\"8%\" class=\"title11b align-middle\">" + row + "</td>";
		html += "				<td colspan=\"1\" rowspan=\"1\" width=\"8%\" class=\"title11b align-middle\">공차</td>";
		html += "				<td colspan=\"5\" rowspan=\"1\" width=\"75%\" class=\"title11b align-middle\">${inspList[0].inspItemNm}(" + Number("${inspList[0].lowVal}").toFixed(3) + "Φ ~ " + Number("${inspList[0].highVal}").toFixed(3) + "Φ)</td>";
		html += "				<td colspan=\"1\" rowspan=\"4\" width=\"9%\" class=\"title11b align-middle\"><span id=\"inspRltCd_" + row + "\"></span></td>";
		html += "			</tr>";
		
		<c:forEach var="inspSmpNum" begin="0" end="2" step="1">
			var numInx = (row*3-3) + parseInt("${inspSmpNum}");
			html += "		<tr id=\"inspSmpNum_" + (row-1) + "_${inspSmpNum}\">";
			html += "			<td colspan=\"1\" rowspan=\"1\" width=\"8%\" class=\"title11b\">";
			html += "				${inspSmpNum+1}";
			html += "				<input type=\"hidden\" name=\"objList[" + numInx + "].inspDtlSeq\">";
			html += "				<input type=\"hidden\" name=\"objList[" + numInx + "].inspSmpNo\" value=\"" + row + "\">";
			html += "				<input type=\"hidden\" name=\"objList[" + numInx + "].inspSmpNum\" value=\"${inspSmpNum+1}\">";
			html += "				<input type=\"hidden\" name=\"objList[" + numInx + "].inspItemCd\" value=\"${inspList[0].inspItemCd}\">";
			html += "				<input type=\"hidden\" data-no=\"" + row + "\" data-num=\"${inspSmpNum+1}\" data-nm=\"inspRltCd\" name=\"objList[" + numInx + "].inspRltCd\" value=\"\">";
			html += "			</td>";
			
			<c:forEach var="mIndex" begin="1" end="${fn:length(bomInspSecVo)}" step="1">
				html += "		<td colspan=\"1\" rowspan=\"1\" width=\"${75/fn:length(bomInspSecVo)}%\" class=\"row_content text-center\">";
				<c:if test="${fn:length(bomInspSecVo) > mIndex-1}">
					html += "		<input type=\"text\" class=\"col-md-8 m-auto input_number\" data-no=\"" + row + "\" data-num=\"${inspSmpNum+1}\" data-nm=\"measureVal${mIndex}\" name=\"objList[" + numInx + "].measureVal${mIndex}\" value=\"\" onkeyup=\"javascript:fn_chkek_number(this);\"/>";
				</c:if>
				html += "		</td>";
			</c:forEach>
		
			html += "		</tr>";
		</c:forEach>
		
		html += "		</table>";
		html += "	</td>";
		html += "</tr>";
		
		//$("#inspBody").append(html);
		
		var inspBodyObj = $("#inspBody > tr");
		inspBodyObj.eq( inspBodyObj.size() - 3 ).after(html);
	}
	
	//-----------------------------------------------------------------------
    // 숫자만 입력 가능
    //-----------------------------------------------------------------------
    function fn_chkek_number(obj) {
		// 소수점 한개만
		var val = obj.value.replace(",", ".").replace(/[^\d\.]/g, "").replace(/\./, "x").replace(/\./g, "").replace(/x/, ".");
		// 소수점 3자리만 허용
		val = val.replace(/(\d{1}\.\d{3})(\d*)$/, "$1");
        obj.value = val.replace(/[^0-9|.]/g,"");
        
        // 판정
        fn_check_insp(obj);
    }
	
  	//-----------------------------------------------------------------------
    // 판정
    //-----------------------------------------------------------------------
	function fn_check_insp(obj) {
		var no = $(obj).data("no");
		var highVal = Number($("#highVal").val());
		var lowVal = Number($("#lowVal").val());
		
		var numRow = $("input[data-no='" + no + "']").closest("tr").length;
		
		for(var i=0; i<numRow; i++) {
			var chkData = true;
			var chkLowCnt = 0;
			var num = i + 1;
			
			$("input[data-no='" + no + "'][data-num='" + num + "'][data-nm^='measureVal']").each(function(index, targetObj) {
				var val = Number($(targetObj).val());
				
			    if( cfIsNull($(targetObj).val()) ) {
			        chkData = false;
			        return false;
			    } else {
			        if( val > highVal || val < lowVal ) {
			        	chkLowCnt++;
			        }
			    }
			});
	
			if( !chkData ) {
			    //console.log("데이타 미등록");
			    return false;
			} else {
				if( chkLowCnt > 0 ) {
					$("input[data-no='" + no + "'][data-num='" + num + "'][data-nm='inspRltCd']").val("NG");
				    $("#inspRltCd_"+no).text("NG");
				} else {
					$("input[data-no='" + no + "'][data-num='" + num + "'][data-nm='inspRltCd']").val("OK");
					$("#inspRltCd_"+no).text("OK");
				}
			}
		}
		
		// 종합판정
		/*
		$("input[data-nm='inspRltCd']").each(function(index, obj) {
		    if( !cfIsNull($(obj).val()) ) {
		        $("#inspRltCd").val($(obj).val());
		        $("#inspRltNm").text($(obj).val());

		        if( $(obj).val() == "NG" ) {
		            return false;
		        }
		    }
		})
		*/
	}
	
	//-----------------------------------------------------------------------
    // popWorker.jsp 콜백함수
    //-----------------------------------------------------------------------
	function fn_popWorker_callback(worker) {
		switch(worker.kindId) {
			case "inspSign":	// 검사확인자
				$("#inspConfId").val(worker.loginId);
				$("#inspConfNm").text(worker.loginName);
				break;
			case "apprSign":	// 승인확인자
				$("#apprConfId").val(worker.loginId);
				$("#apprConfNm").text(worker.loginName);
				break;
			default:
				break;
		}
	}
	
	function fn_print() {
		window.onbeforeprint = beforePrint;
        window.onafterprint = afterPrint;
		window.print();
	}
	
	function beforePrint() {
		var inspBodyObj = $("#inspBody > tr");
		
		if( inspBodyObj.length < 9 ) {
			return false;
		}
		
		var pageDivHtml = "";
		pageDivHtml += "<tr name=\"trPage\" class=\"page-break\" style=\"height: 40px;border-left-style: hidden;border-right-style: hidden;\">";
		pageDivHtml += "	<td colspan=\"12\"></td>";
		pageDivHtml += "</tr>";
		
		inspBodyObj.eq( 7 ).after(pageDivHtml);
	}
	
	function afterPrint() {
		if( $("tr[name='trPage']").length > 0 ) {
			$("tr[name='trPage']").remove();
		}
	}
	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<form name="objForm" id="objForm" method="post">
	    <input type="hidden" name="prodSeq" value="${search.prodSeq}"/>
	    <input type="hidden" name="operCd" value="${search.operCd}"/>
		<input type="hidden" name="workactSeq" value="${search.workactSeq}"/>
	    <input type="hidden" name="inspTypeCd" value="${searchInsp.inspTypeCd}"/>
	    <input type="hidden" name="inspSeq" value="${inspRltMstVo.inspSeq}"/>
	    
	    <input type="hidden" id="highVal" value="${inspList[0].highVal}"/>
	    <input type="hidden" id="lowVal" value="${inspList[0].lowVal}"/>
    	
    	<!-- container [S] -->
    	<div id="container" class="pop-body">
    	
	    	<!-- card [S] -->
			<div class="card mr-1 ml-1 mb-n4 card-deck">
			
				<!-- card-body [S] -->
				<div class="card-body card-roundbox embed-responsive">
				
					<!-- navbar [S] -->
					<div class="navbar" style="margin-left: auto;">
						<!--  table-responsive [S] -->
						<div class="table-responsive">
							<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<div class="col-sm-12 col-md-6">
										<div id="btnAdd" class="btn btn-primary btn-sm mr-2">시료추가</div>
									</div>
									<div class="col-sm-6">
										<div class="float-right">
											<div id="btnClose" class="btn btn-primary btn-sm mr-2">나가기</div>
											<div id="btnPrint" class="btn btn-primary btn-sm mr-2">출력</div>
											<div id="btnSave" class="btn btn-primary btn-sm mr-2">저장</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--  table-responsive [E] -->
					</div>
					<!-- navbar [E] -->
						
					<!-- printBody [S] -->
					<div id="printBody" width="100%" style="margin-top:10px;">
						
						<div class="card-header card-header-tabs">
				    		<h1 class="font-weight-bold my-1 mb-4 text-center">검 사 성 적 서</h1>
				    	</div>
			    	
						<!--  table-responsive [S] -->
						<div class="table-responsive">
							
							<!-- 성적서 마스터 정보 [S] -->
							<table border="2" width="100%" class="table-report table-report-bordered mb-4">
								<tbody>
									<tr>
										<td width="16%" class="title10b align-middle">성적서 No.</td>
										<td width="32%" class="title10b align-middle" style="padding:0px;">
											<input type="hidden" id="inspRptNo" name="inspRptNo" class="form-control form-control-sm title10b input_borderless font-weight-bold" value="${inspRltMstVo.inspRptNo}"/>
											<span>${inspRltMstVo.inspRptNo}</span>
										</td>
										<td width="18%" class="title10b align-middle">고객사</td>
										<td width="34%" colspan="2" class="title11b align-middle" style="padding:0px;">${inspRltMstVo.custNm}</td>
									</tr>
									<tr>
										<td width="16%" class="title10b align-middle">검사일</td>
										<td width="32%" class="title10b align-middle" style="padding:0px;">
											<input type="text" id="inspDt" name="inspDt" class="form-control form-control-sm title10b input_borderless font-weight-bold" value="${inspRltMstVo.inspDt}"/>
										</td>
										<td width="18%" class="title10b align-middle">원소재 품명 / 규격</td>
										<td width="17%" class="title10b align-middle" style="padding:0px;">${inspRltMstVo.itemNm}</td>
										<td width="17%" class="title10b align-middle" style="padding:0px;"><fmt:formatNumber value="${inspRltMstVo.matStndVal}" pattern="#.###"/> ${inspRltMstVo.matLenNm}</td>
									</tr>
									<tr>
										<td width="16%" class="title10b align-middle">검사자</td>
										<td width="32%" class="title10b align-middle" style="padding:0px;">
											<input type="hidden" id="inspId" name="inspId" value="${inspRltMstVo.inspId}"/>
											<span id="inspNm">${inspRltMstVo.inspNm}</span>
										</td>
										<td width="18%" class="title10b align-middle">작업사이즈 / 공차</td>
										<td width="17%" class="title10b align-middle" style="padding:0px;"><fmt:formatNumber value="${inspRltMstVo.stndVal}" pattern="#.000"/> ${inspRltMstVo.itemLenNm}</td>
										<td width="17%" class="title10b align-middle" style="padding:0px;">${inspList[0].inspItemNm}</td>
									</tr>
									<tr>
										<td width="16%" class="title10b align-middle">검사방식</td>
										<td width="32%" class="title10b align-middle" style="padding:0px;">외경측정, 마이크로미터</td>
										<td width="18%" class="title10b align-middle">Lot No / 수량</td>
										<td width="17%" class="title10b align-middle" style="padding:0px;">${inspRltMstVo.prodPoNo}</td>
										<td width="17%" class="title10b align-middle" style="padding:0px;"><fmt:formatNumber value="${inspRltMstVo.poQty}" pattern="###,###"/>${inspRltMstVo.unitNm}</td>
									</tr>
								</tbody>
							</table>
							<!-- 성적서 마스터 정보 [E] -->
							
							<!-- 성적서 디테일 [S] -->
							<table border="2" width="100%" class="table-report table-report-bordered overflow-hidden">
								<tbody id="inspBody">
									<tr class="page-break">
										<td>
		                            		<table border="2" width="100%" class="table-report table-report-bordered tr-table">
				          						<td colspan="1" rowspan="1" width="8%" class="title11b align-middle" style="">시료<br/>No</td>
				                                <td colspan="1" rowspan="1" width="8%" class="title11b align-middle" style="">측정<br/>횟수</td>
				                                <td colspan="1" rowspan="1" width="75%" class="title11b align-middle" style="">
				                                	<span>측정구간 및 측정값</span>
				                                	<hr class="col-sm-11 mt-2" style="border: 5px solid #000;"></hr>
				                                	<div class="col-sm-11" style="position: relative;margin: 0 0 3rem 1rem;">
					                                	<c:forEach items ="${bomInspSecVo}" var="item" varStatus="status">
					                                		<div class="form-group" style="display:inline;position: absolute;left: ${item.secVal}%;">
					                                			<span style="transform:rotate(-90deg);display:inline-block;margin-top:-20px;">➔</span><br/><span>${item.secNm}</span>
					                                		</div>
											        	</c:forEach>
										        	</div>
				                                </td>
				                                <td colspan="1" rowspan="1" width="9%" class="title11b align-middle" style="">판정</td>
		                            		</table>
		                            	</td>
		                            </tr>
		                            
		                            <c:forEach var="inspSmpNo" begin="0" end="${inspRow < 5 ? 4:(inspRow-1)}" step="1">
			                            <tr class="page-break">
			                            	<td>
			                            		<table border="2" width="100%" class="table-report table-report-bordered tr-table">
					                            		<tr id="inspSmpNo_${inspSmpNo+1}">
					                            			<td colspan="1" rowspan="4" width="8%" class="title11b align-middle">${inspSmpNo+1}</td>
					                            			<td colspan="1" rowspan="1" width="8%" class="title11b align-middle">공차</td>
					                            			<td colspan="5" rowspan="1" width="75%" class="title11b align-middle">${inspList[0].inspItemNm}(<fmt:formatNumber pattern="#.000" value="${inspList[0].lowVal}" />Φ ~ <fmt:formatNumber pattern="#.000" value="${inspList[0].highVal}" />Φ)</td>
					                            			<td colspan="1" rowspan="4" width="9%" class="title11b align-middle"><span id="inspRltCd_${inspSmpNo+1}"></span></td>
					                            		</tr>
					                            		
					                            		<c:forEach var="inspSmpNum" begin="0" end="2" step="1">
					                            			<tr id="inspSmpNum_${inspSmpNo+1}_${inspSmpNum+1}">
						                            			<td colspan="1" rowspan="1" width="8%" class="title11b">
						                            				${inspSmpNum+1}
						                            				<input type="hidden" data-no="${inspSmpNo+1}" data-num="${inspSmpNum+1}" data-nm="inspDtlSeq" name="objList[${(inspSmpNo*3)+inspSmpNum}].inspDtlSeq">
						                            				<input type="hidden" data-no="${inspSmpNo+1}" data-num="${inspSmpNum+1}" data-nm="inspSmpNo" name="objList[${(inspSmpNo*3)+inspSmpNum}].inspSmpNo" value="${inspSmpNo+1}">
						                            				<input type="hidden" data-no="${inspSmpNo+1}" data-num="${inspSmpNum+1}" data-nm="inspSmpNum" name="objList[${(inspSmpNo*3)+inspSmpNum}].inspSmpNum" value="${inspSmpNum+1}">
						                            				<input type="hidden" data-no="${inspSmpNo+1}" data-num="${inspSmpNum+1}" data-nm="inspItemCd" name="objList[${(inspSmpNo*3)+inspSmpNum}].inspItemCd" value="${inspList[0].inspItemCd}">
						                            				<input type="hidden" data-no="${inspSmpNo+1}" data-num="${inspSmpNum+1}" data-nm="inspRltCd" name="objList[${(inspSmpNo*3)+inspSmpNum}].inspRltCd" value="">
						                            			</td>
						                            			
						                            			<c:forEach var="mIndex" begin="1" end="${fn:length(bomInspSecVo)}" step="1">
						                            				<td colspan="1" rowspan="1" width="${75/fn:length(bomInspSecVo)}%" class="row_content text-center">
						                            					<c:if test="${fn:length(bomInspSecVo) > mIndex-1}">
						                            						<input type="text" class="col-md-8 m-auto input_number" data-no="${inspSmpNo+1}" data-num="${inspSmpNum+1}" data-nm="measureVal${mIndex}" name="objList[${(inspSmpNo*3)+inspSmpNum}].measureVal${mIndex}" value="" onkeyup="javascript:fn_chkek_number(this);"/>
						                            					</c:if>
						                            				</td>
						                            			</c:forEach>
						                            		</tr>
					                            		</c:forEach>
					                            </table>
			                            	</td>
			                            </tr>
				                    </c:forEach>
		                            
		                            <tr class="page-break">
		                            	<td>
		                            		<table border="2" width="100%" class="table-report table-report-bordered tr-table">
				                            	<tr style="height:135px;">
				                            		<td colspan="1" rowspan="1" width="16%" class="title11b align-middle">불합격시<br/>조치사항</td>
				                            		<td colspan="1" rowspan="1" width="66%" class="title11b align-middle">
				                            			<textarea id="ngCmmt" name="ngCmmt" class="form-control" rows="4" style="resize:none;border:none;">${inspRltMstVo.ngCmmt}</textarea>
				                            		</td>
				                            		<td colspan="1" rowspan="1" width="5%" class="title11b align-middle"><span class="text-vertical" style="height:95px;">종합판정</span></td>
				                            		<td colspan="1" rowspan="1" width="13%" class="title11b align-middle">
				                            			<input type="hidden" id="inspRltCd" name="inspRltCd" value=""/>
				                            			<span id="inspRltNm"></span>
				                            		</td>
				                            	</tr>
		                            		</table>
		                            	</td>
		                            </tr>
		                            
	                            	<tr class="page-break">
	                            		<td>
	                            			<table border="2" width="100%" class="table-report table-report-bordered tr-table">
	                            				<tr>
				                            		<td colspan="1" rowspan="2" width="16%" class="title11b align-middle">비고및<br/>특이사항</td>
				                            		<td colspan="1" rowspan="2" width="57%" class="title11b align-middle">
				                            			<textarea id="inspBigo" name="inspBigo" class="form-control" rows="5" style="resize:none;border:none;">${inspRltMstVo.inspBigo}</textarea>
				                            		</td>
				                            		<td colspan="1" rowspan="2" width="5%" class="title11b align-middle" style="height:95px;"><span class="text-vertical">확   인</span></td>
				                            		<td colspan="1" rowspan="1" width="11%" class="title11b align-middle" style="height:35px;">검사</td>
				                            		<td colspan="1" rowspan="1" width="11%" class="title11b align-middle" style="height:35px;">승인</td>
				                            	</tr>
				                            	<tr>
				                            		<td colspan="1" rowspan="1" class="title11b align-middle sign" id="inspSign" style="height:107px;">
				                            			<input type="hidden" id="inspConfId" name="inspConfId" value="${inspRltMstVo.inspConfId}"/>
				                            			<span id="inspConfNm">${inspRltMstVo.inspConfNm}</span>
				                            		</td>
				                            		<td colspan="1" rowspan="1" class="title11b align-middle sign" id="apprSign" style="height:107px;">
				                            			<input type="hidden" id="apprConfId" name="apprConfId" value="${inspRltMstVo.apprConfId}"/>
				                            			<span id="apprConfNm">${inspRltMstVo.apprConfNm}</span>
				                            		</td>
				                            	</tr>
	                            			</table>
	                            		</td>
	                            	</tr>
								</tbody>
							</table>
							<!-- 성적서 디테일 [E] -->
							
						</div>
						<!--  table-responsive [E] -->
						
					</div>
					<!-- printBody [E] -->
					
				</div>
				<!-- card-body [E] -->
				
			</div>
			<!-- card [E] -->
		
		</div>
		<!-- container [E] -->
		
	</form>
	
	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
	<jsp:include flush="false" page="/WEB-INF/jsp/popup/popWorker.jsp" ></jsp:include>
</body>

</html>