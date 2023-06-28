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
<title>자재 입고 관리</title>
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
			$("#searchFromDate, #searchToDate").datepicker({
				showOn : "button",
				buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
				buttonImageOnly : true,
				buttonText : "Select date",
				dateFormat : "yy/mm/dd"
			});
			var cardBoxList = [{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}];

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			$('#cardBox1,#cardBox2,#cardBox3,#cardBox4,#cardBox5,#cardBox6,#cardBox7,#cardBox8').click(function() {
				var pos = parseInt($(this).attr('id').replace('cardBox', '')) - 1;
				cardBoxList[pos].lotId = $(this).find('.lotId').text();
				cardBoxList[pos].matNm = $(this).find('.matNm').text();
				cardBoxList[pos].inCnt = $(this).find('.inCnt').text().replace("입고수량", "").replace("EA", "");
				cardBoxList[pos].inDt = $(this).find('.inDt').text().replace("입고일", "");
				if (cardBoxList[pos].selected) {
					cardBoxList[pos].selected = false;
					$(this).attr('class', 'card bg-primary text-white mb-4');
				} else {
					cardBoxList[pos].selected = true;
					$(this).attr('class', 'card bg-warning text-white mb-4');
				}
			});

			$('#btnColse').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileMenuPage.do'/>";
				frm.submit();
			});

			//초기화
			$('#btnClear').click(function() {
				var i = 0;
				while (i < 8) {
					cardBoxList[i].selected = false;
					$("#cardBox" + (i + 1)).attr('class', 'card bg-primary text-white mb-4');
					i++;
				}
			});

			$('#searchFromDate,#searchToDate').change(function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.action = "<c:url value='/mobileMaterialInListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 생성 이벤트
			//-------------------------------------------------------------
			$('#btnCreate').click(function() {
				var frm = document.searchForm;
				frm.crudType.value = 'C';
				frm.action = "<c:url value='/mobileMaterialInDtlPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 바코드 출력 팝업
			//-------------------------------------------------------------
			$('#btnPrintBarCode').click(function() {
				if( cardBoxList.find(element => element["selected"] == true) == undefined ) {
					cfAlert("바코드 데이타를 선택하세요.");
					return false;
				}

				// width:640, height:424 사이즈로 나와야 용지 사이즈에 맞음.
				$("#previewBarCode div").remove();

				var html = "";
				$.each(cardBoxList, function(index, card) {
					if (card.selected) {
						html = "";
						html += "<div id=\"previewBarCodeChild\" name=\"previewBarCodeChild\">"; // 용지 좌우 여백 조절
						html += "<div class=\"row\" style=\"margin-top:20px\">";
						html += "<div class=\"col-md-12\" style=\"min-width:410px;\">";
						http: //localhost:8080/originalMaterialDtlPage.do#
						html += "<table class=\"barcode-table\" style=\"width:400px;\">";
						html += "<colgroup>";
						html += "<col width=\"30%\"/>";
						html += "<col width=\"70%\"/>";
						html += "</colgroup>";
						html += "<tbody>";
						//---------------------------------------------------------------------------------------------
						// bar code
						//---------------------------------------------------------------------------------------------
						html += "<tr>";
						html += "<td class=\"barcode-table-td barcode-table-td-p5\" colspan=\"2\">";
						// barcode
						html += "<div style=\"width:100%; float:left; padding:0px 20px 0px 20px;\"></div>";
						html += "<div id=\""+card.lotId+"\"/></div>";
						// barcode text
						html += "<div style=\"font-weight: bold; font-size: 1.6em; width:100%; float:left;\">" + card.lotId + "</div>";
						html += "</td>";
						html += "</tr>";
						//---------------------------------------------------------------------------------------------
						// 자재처, 입고일자, 수 량
						//---------------------------------------------------------------------------------------------
						html += "<tr style=\"height:130px;\">";
						html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">자재명</td>";
						html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.8em;\">" + card.matNm + "</td>";
						html += "</tr>";

						html += "<tr>";
						html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">입고수량</td>";
						html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">" + card.inCnt + " EA</td>";
						html += "</tr>";

						html += "<tr>";
						html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">입고일자</td>";
						html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">" + card.inDt + "</td>";
						html += "</tr>";

						html += "</tbody>";
						html += "</table>";
						html += "</div>";
						html += "</div>";
						html += "</div>";
						$("#previewBarCode").append(html);
						$("#"+card.lotId).barcode(card.lotId, "code128",{barWidth:3, barHeight:60,showHRI:false,bgColor:"white", output:'css'});
					}
				});
				$('#barcodePrintModal').css("display", "block");
			});

			//-------------------------------------------------------------
			// 바코드 팝업 닫기
			//-------------------------------------------------------------
			$('.modal-close-button').click(function() {
				$('.modal-container').css("display", "none");
			});

			//-------------------------------------------------------------
			// 바코드 출력
			//-------------------------------------------------------------
			$('#btnBarCodePrint').click(function() {
				if( $("#barcodePrinter").val() == "" ) {
					cfAlert("프린터를 선택하세요.");
					return false;
				}

				var barcodeDivObj = $("div[name=previewBarCodeChild]");
				var arrImageData = [];
				barcodeDivObj.each(function(idx, obj) {
					html2canvas($(obj), {
						height : $(obj).outerHeight(),
						background : "white",
						onrendered : function(canvas) {
							arrImageData.push(canvas.toDataURL("image/png"));

							// 전체 이미지 추출 후 프린트
							if (idx == barcodeDivObj.length - 1) {
								deferred.resolve("end," + arrImageData.length);
							}
						}
					});
				});

				deferred.done(function(message) {
					console.log("resolve:" + message);

					$.ajax({
						url : "<c:url value='/labelMultiImageConvertPrint.do'/>",
						type : "POST",
						data : {
							imageData : arrImageData,
							IpAdress : '<spring:eval expression="@property['Globals.print.ip']"/>',
							Port : $("#barcodePrinter").val(),
							Count : 1
						},
						contentType : "application/x-www-form-urlencoded; charset=UTF-16",
						context : this,
						dataType : "json",
						beforeSend : function() {
							$("#previewBarCode").loading();
						},
						success : function(data) {
							var resultMessage = data.resultMessage;
							cDialog("확인", resultMessage, null);
						},
						error : function(request, status, error) {
							cDialog("확인", "시스템 오류입니다.\n관리자에게 문의해주세요", null);
						},
						complete : function() {
							$("#previewBarCode").loadingClose();
						}
					});
				}).fail(function(error) {
					console.log(error);
				}).always(function() {
					console.log('완료!');
				});
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
				if (document.searchForm.sortType.value == 'asc') {
					$("#${search.sortCol}").attr('class', 'sorting_asc');
				} else {
					$("#${search.sortCol}").attr('class', 'sorting_desc');
				}

				$("#searchFromDate").val("${search.searchFromDate}");
				$("#searchToDate").val("${search.searchToDate}");

				// selectbox search
				$(".selectpicker").selectpicker();
				$(".selectpicker").parent().addClass("col-sm-12");
				$(".selectpicker").next("button").addClass("form-control2");
				$(".selectpicker").parent().wrap("<div class='row'></div>");
			});
		});
	})(jQuery);

	//=====================================================================
	// button action funtion
	//=====================================================================

	//=====================================================================
	// paging
	//=====================================================================
	function fn_paging(pageIndex) {
		var frm = document.searchForm;
		frm.pageIndex.value = pageIndex;
		frm.action = "<c:url value='/mobileMaterialInListPage.do'/>";
		frm.submit();
	}
	function fn_go_dtl_page(id) {
		var frm = document.searchForm;
		frm.crudType.value = 'R';
		frm.matinSeq.value = id;
		frm.action = "<c:url value='/mobileMaterialInDtlPage.do'/>";
		frm.submit();
	}
	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<div class="card" style="padding: 15px 30px;">
		<div class="card-header">
			<sapn>자재입고</sapn>
			<div id="btnColse" class="btn-logout mr-2" style="float: right;"><i class="xi-close-circle-o"></i> 닫기</div>
			<div id="btnClear" class="btn-logout mr-2" style="float: right;"><i class="xi-renew"></i>초기화</div>
			<div id="btnPrintBarCode" class="btn-logout mr-2" style="float: right;">바코드출력</div>
			<div id="btnCreate" class="btn-logout mr-2" style="float: right;">자재입고</div>
		</div>
		<div class="card-body card-roundbox pr-sm-5 pl-sm-5">
			<div class="row" style="padding-top: 5px; margin-bottom: 5px;">
				<div class="table-responsive">
					<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
						<!-- @@@ style="min-width:3000px;"  -->
						<div class="row">
							<div class="col-sm-12 col-md-2" style="padding-top: 5px;"></div>
							<div class="col-sm-12 col-md-10" style="margin-bottom: 5px; padding-right: 19px;">
								<div id="dataTable_filter" class="dataTables_filter">
									<form:form commandName="search" id="searchForm" name="searchForm">
										<input type="hidden" name="crudType" value="R" />
										<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
										<input type="hidden" name="pageSize" value="${search.pageSize}" />
										<input type="hidden" name="sortCol" value="${search.sortCol}" />
										<input type="hidden" name="sortType" value="${search.sortType}" />
										<input type="hidden" name="matinSeq" value="${search.matinSeq}" />
										<div style="float: right; margin: 6px 5px;">
											<input class="form-control3 align-top" size="8" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="입고조회 종료일자" />
										</div>
										<div style="float: right; margin: 6px 5px;">
											<input class="form-control3 align-top" size="8" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="입고조회 시작일자" />
										</div>
									</form:form>
								</div>
							</div>
						</div>
						<div class="container-fluid">
							<c:forEach items="${rtn.obj}" var="item" varStatus="status">
								<c:if test="${status.count%4 == 1}">
									<div class="row">
								</c:if>
								<div class="col-xl-3 col-md-3">
									<div id="cardBox${status.count}" class="card bg-primary text-white mb-4" style="height: 92%;">
										<div class="lotId card-body" style="font-size: 85%; height: 20px; text-align: center;"><a href="javascript:fn_go_dtl_page('${item.matinSeq}')">${item.lotid}</a></div>
										<div class="matNm card-body" style="font-size: 95%; height: 40px; text-align: center;">${item.matNm}</div>
										<div class="inCnt card-body" style="font-size: 110%; height: 25px; text-align: center;">입고수량 ${item.inCnt} KG</div>
										<div class="inDt card-body" style="font-size: 90%; height: 25px; text-align: center">입고일 ${item.inDt}</div>

									</div>
								</div>
								<c:if test="${status.count%4 == 0}">
									</div>
								</c:if>
							</c:forEach>
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
													<c:if test="${rtn.totCnt <= (search.pageSize*i)}">
														<c:set var="isLoof" value="false" />
													</c:if>
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
	</div>

	<form:form commandName="search" id="matDtlListForm" name="matDtlListForm">
		<input type="hidden" id="searchMstLotid" name="searchMstLotid" value="" />
	</form:form>

	<div id="barcodePrintModal" class="modal-container">
		<div class="modal-content">
			<div class="modal-header">
				<div class="txt20">바코드 출력 정보</div>
				<span class="modal-close-button">×</span>
			</div>
			<div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
				<div class="card-header">
					<sapn class="txt20">출력 바코드 목록</sapn>
                    <div class="form-inline float-right">
	                    <select class="form-control mt-n1 mb-n1 mr-2" id="barcodePrinter" name="barcodePrinter">
							<option value="">프린터 선택</option>
							<c:forEach items="${barcode_print_list}" var="item" varStatus="status">
								<option value="${item.scode}">${item.codeNm}</option>
							</c:forEach>
						</select>
	                    <div id="btnBarCodePrint" class="btn btn-primary btn-sm mr-2">바코드출력</div>
                    </div>
				</div>
				<div id="previewBarCode" class="card-body" style="margin: auto;"></div>
			</div>
		</div>
	</div>

	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
</body>
</html>