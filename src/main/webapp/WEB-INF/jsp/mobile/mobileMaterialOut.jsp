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
<title>PowerMES</title>
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
			var G_flag = false;

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			$('#btnColse').click(function() {
				var frm = document.closeSearchForm;
				frm.pageIndex.value = 1;
				frm.action = "<c:url value='/mobileProductionListPage.do'/>";
				frm.submit();
			});

			var preMatOutcnt;
			$("#matOutcnt").on("focus", function() {
				preMatOutcnt = this.value;
			}).on("input", function() {
				if (event.type != "input") {
					return false;
				}

				if (document.searchForm.searchLotid.value == '') {
					alert('출고 대상을 선택 해 주세요');
					$('#matOutcnt').val(preMatOutcnt);
					return false;
				}

				var stockCnt = Number($('#materialIndataTable tr').eq(1).children().eq(2).html().replaceAll(',', ''));
				$('#matOutcnt').val($('#matOutcnt').val() + $(this).html());
				if (Number($('#matOutcnt').val()) > stockCnt) {
					alert('재고량을 초과 하였습니다.');
					$('#matOutcnt').val(preMatOutcnt);
					return false;
				}
				$('#materialIndataTable tr').eq(1).children().eq(3).html(cfAddComma(Number(cfIsNullString($('#matOutcnt').val(), "0"))));
				$('#materialIndataTable tr').eq(1).children().eq(4).html(cfAddComma(stockCnt - Number(cfIsNullString($('#matOutcnt').val(), "0"))));
			});

			$('#btn1,#btn2,#btn3,#btn4,#btn5,#btn6,#btn7,#btn8,#btn9,#btn0').click(function() {
				if (document.searchForm.searchLotid.value == '') {
					alert('출고 대상을 선택 해 주세요');
					return false;
				}
				var tmp = $('#matOutcnt').val().replaceAll(',', '');
				var stockCnt = Number($('#materialIndataTable tr').eq(1).children().eq(2).html().replaceAll(',', ''));
				$('#matOutcnt').val($('#matOutcnt').val() + $(this).html());
				if (Number($('#matOutcnt').val()) > stockCnt) {
					alert('재고량을 초과 하였습니다.');
					$('#matOutcnt').val(tmp);
					return false;
				}
				$('#materialIndataTable tr').eq(1).children().eq(3).html(cfAddComma(Number(cfIsNullString($('#matOutcnt').val(), "0"))));
				$('#materialIndataTable tr').eq(1).children().eq(4).html(cfAddComma(stockCnt - Number(cfIsNullString($('#matOutcnt').val(), "0"))));
			});

			$('#btnAdd').click(function() {
				if (document.searchForm.searchLotid.value == '') {
					alert('출고 대상을 선택 해 주세요');
					return false;
				}

				if ($('#matOutcnt').val() == '') {
					alert('출고 수량을 입력 해 주세요');
					return false;
				}

				if (!cfCheckDigit($("#matOutcnt").val().replaceAll(',', ''))) {
					alert(MSG_COM_ERR_008.replace("[@]", " : 출고 수량"));
					$("#matOutcnt").focus();
					return false;
				}

				if (!G_flag) {
					alert("출고 대상을 선택 해 주세요");
					return false;
				}
				if ($("#materialInListBody tr").length <= 0) {
					alert("출고 대상을 선택 해 주세요");
					return false;
				}
				
				if(Number($('#matOutcnt').val())+Number($('#requireMatListBody tr').find("td:eq(5)").text()) > Number($('#requireMatListBody tr').find("td:eq(4)").text())){
					alert("소요량을 초과해서 출고할 수 없습니다.")
					return false;
				}

				var stockCnt = Number($('#materialIndataTable tr').eq(1).children().eq(2).html().replaceAll(',', ''));
				if (Number($('#matOutcnt').val()) > stockCnt) {
					alert('재고량을 초과 하였습니다.');
					$('#matOutcnt').val("");
					return false;
				}

				document.objForm.outCnt.value = $('#matOutcnt').val().replaceAll(',', '');
				document.objForm.matCd.value = document.searchForm.searchMatCd.value;
				document.objForm.lotid.value = document.searchForm.searchLotid.value;
				$("#outDt").val($("#outDt").val().replaceAll('/', ''));
				document.objForm.prodSeq.value = document.searchRequireMatForm.searchProdSeq.value;
				document.objForm.workshopCd.value = $("#searchWorkshopCd").val();
				document.objForm.matTypeCd.value = $("#materialIndataTable tr").find("td > span[name='stockMatTypeCd']").text();

				$.ajax({
					url : "<c:url value='/materialOutSaveAct.do'/>",
					type : 'POST',
					data : $('#objForm').serialize(),
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					context : this,
					dataType : 'json',
					beforeSend : function() {
						$("#layoutSidenav").loading();
					},
					success : function(data) {
						$("#layoutSidenav").loadingClose();
						if (!cfCheckRtnObj(data.rtn))
							return;
						cfAlert('출고 되었습니다.');
						$('#btnClear').click();
						//$("#matOutcnt").val("");
						//drawRequireMatList();
						//drawMaterialInList();
					},
					error : function(request, status, error) {
						console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
						cfAlert('시스템 오류입니다.');
					},
					complete : function() {
						$("#layoutSidenav").loadingClose();
					}
				});
			});

			$('#btnBack').click(function() {
				if (document.searchForm.searchLotid.value == '') {
					alert('출고 대상을 선택 해 주세요');
					return false;
				}
				if ($('#matOutcnt').val().length > 0) {
					$('#matOutcnt').val($('#matOutcnt').val().substr(0, $('#matOutcnt').val().length - 1));
					var stockCnt = Number($('#materialIndataTable tr').eq(1).children().eq(2).html().replaceAll(',', ''));
					$('#materialIndataTable tr').eq(1).children().eq(3).html(cfAddComma(Number(cfIsNullString($('#matOutcnt').val(), "0"))));
					$('#materialIndataTable tr').eq(1).children().eq(4).html(cfAddComma(stockCnt - Number(cfIsNullString($('#matOutcnt').val(), "0"))));
				}
			});

			$('#btnClear').click(function() {
				G_flag = false;
				$('#matOutcnt').val('');
				$('#barCodeMsg').show();
				$('#barCode').html('');
				$('#barCodeText').html('');
				$('#barCode').hide();
				$('#barCodeText').hide();
				document.searchRequireMatForm.searchMatCd.value = '';
				$('#barCodeMsg').html('소요자재를 선택 하세요');
				document.searchForm.searchLotid.value = '';
				drawRequireMatList();
				$('#cardRequireMat').css('height', '320px');
				$('#cardRequireMat').css('overflow-y', 'auto');
				$('#cardMaterialIn').hide();
			});

			$(document).scannerDetection({
				timeBeforeScanTest : 200, // wait for the next character for upto 200ms
				avgTimeByChar : 100, // it's not a barcode if a character takes longer than 100ms
				onComplete : function(barcode, qty, x) {
					if (this.activeElement.nodeName == "INPUT") {
						return false;
					}
					barcode = barcode.toUpperCase();
					drawBarCode(barcode);
				} // main callback function
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
				$("#outDt").val('${rtn.obj.outDt}');
				drawRequireMatList();
			});

			$(document).on('click', '#requireMatListBody tr', function() {
				var tr = $(this);
				var td = tr.children();
				$('#cardRequireMat').css('height', '100px');
				$('#cardRequireMat').css('overflow-y', '');
				$('#cardMaterialIn').show();

				var matCd = $(this).find("td > span[name='requireMatCd']").html();
				var matTypeCd = $(this).find("td > span[name='requireMatTypeCd']").html();

				document.searchRequireMatForm.searchMatCd.value = matCd;
				$('#barCodeMsg').html('자재 LOT NO를 스캔하세요');
				drawRequireMatList();
				G_flag = true;
				document.searchForm.searchMatCd.value = matCd;
				document.searchForm.searchMatTypeCd.value = matTypeCd;
				document.searchForm.searchLotid.value = "";
				drawMaterialInList();
			});

			$(document).on('click', '#materialInListBody tr', function() {
				var tr = $(this);
				var td = tr.children();
				drawBarCode($(this).find("td > span[name='stockLotid']").html());
			});

			drawBarCode = function(barcode) {
				if (document.searchRequireMatForm.searchProdSeq.value == '') {
					return false;
				}
				$('#barCodeMsg').hide();
				$('#barCode').barcode(barcode, "code128", {
					barWidth : 3,
					barHeight : 40,
					showHRI : false,
					bgColor : "white",
					output : 'css'
				});
				$('#barCodeText').html(barcode);
				$('#barCode').show();
				$('#barCodeText').show();
				document.searchForm.searchLotid.value = barcode;
				drawMaterialInList();
				$('#matOutcnt').val('');
			};

			//-------------------------------------------------------------
			// 소요자재 목록 Draw
			//-------------------------------------------------------------
			drawRequireMatList = function() {
				$.ajax({
					url : "<c:url value='/searchRequireMatListByProdSeqData.do'/>",
					type : 'POST',
					data : $('#searchRequireMatForm').serialize(),
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					context : this,
					dataType : 'json',
					beforeSend : function() {
						$("#requireMatListBody tr").remove();
						$("#dataTable_wrapper").loading();
					},
					success : function(data) {
						if (!cfCheckRtnObj(data.rtn))
							return;
						var html = "";
						$.each(data.rtn.obj, function(key, val) {
							html = "";
							html += "<tr role=\"row\" class=\"odd\">";
							html += "<td style=\"display:none;\">";
							html += "	<span name=\"requireMatCd\">" + val.matCd + "</span>";
							html += "	<span name=\"requireMatTypeCd\">" + val.matTypeCd + "</span>";
							html += "</td>";
							html += "<td class=\"text-ellipsis\"><span>" + val.itemNm + "</span></td>";
							html += "<td class=\"text-ellipsis\"><span>" + val.poCalldt + "</span></td>";
							html += "<td class=\"text-ellipsis\"><span>" + val.matNm + "</span></td>";
							html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.demandQty, "0"))) + "</span></td>";
							html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.matOutQty, "0"))) + "</span></td>";
							html += "<td class=\"text-ellipsis\"><span>" + cfIsNullString(val.lotid, "") + "</span></td>";
							html += "</tr>";
							$("#requireMatListBody").append(html);
						});
					},
					error : function(request, status, error) {
						console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
						cfAlert('시스템 오류입니다.');
					},
					complete : function() {
						$("#dataTable_wrapper").loadingClose();
					}
				});
			};
			//-------------------------------------------------------------
			// 재고 목록 Draw
			//-------------------------------------------------------------
			drawMaterialInList = function() {

				$.ajax({
					url : "<c:url value='/mobileMerterialInData.do'/>",
					type : 'POST',
					data : $('#searchForm').serialize(),
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					context : this,
					dataType : 'json',
					beforeSend : function() {
						$("#materialInListBody tr").remove();
						$("#dataTable_wrapper").loading();
					},
					success : function(data) {
						if (!cfCheckRtnObj(data.rtn))
							return;
						if (data.msg != undefined) {
							alert(data.msg);
						}
						var html = "";
						$.each(data.rtn.obj, function(key, val) {
							html = "";
							html += "<tr role=\"row\" class=\"odd\">";
							html += "<td style=\"display:none;\">";
							html += "	<span name=\"stockLotid\">" + val.lotid + "</span>";
							html += "	<span name=\"stockMatTypeCd\">" + val.matTypeCd + "</span>";
							html += "</td>";
							html += "<td class=\"text-ellipsis\"><span>" + val.matNm + "</span></td>";
							html += "<td class=\"text-ellipsis\">" + cfAddComma(Number(cfIsNullString(val.stockQty, "0"))) + "</td>";
							html += "<td class=\"text-ellipsis\">0</td>";
							html += "<td class=\"text-ellipsis\">" + cfAddComma(Number(cfIsNullString(val.stockQty, "0"))) + "</td>";
							html += "<td class=\"text-ellipsis\"><span>" + val.inDt + "</span></td>";
							html += "<td class=\"text-ellipsis\"><span>" + val.lotid + "</span></td>";
							html += "<td style=\"display:none;\">" + val.matCd + "</td>";
							html += "</tr>";

							$("#materialInListBody").append(html);
						});
					},
					error : function(request, status, error) {
						console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
						cfAlert('시스템 오류입니다.');
					},
					complete : function() {
						$("#dataTable_wrapper").loadingClose();

						// 첫번째 로우 자동 클릭
						if( $("#materialInListBody > tr").length == 1 ) {
							var barcode = $("#materialIndataTable tr > td:nth-child(1) > span[name='stockLotid']").html();

							document.searchForm.searchLotid.value = barcode;
							$('#barCodeMsg').hide();
							$('#barCode').barcode(barcode, "code128", {
								barWidth : 3,
								barHeight : 40,
								showHRI : false,
								bgColor : "white",
								output : 'css'
							});
							$('#barCodeText').html(barcode);
							$('#barCode').show();
							$('#barCodeText').show();

							var requireCnt = Number($('#requireMatTable tr').eq(1).children().eq(4).text().replaceAll(',', ''));
							var outCnt = Number($('#requireMatTable tr').eq(1).children().eq(5).text().replaceAll(',', ''));
							var stockCnt = Number($('#materialIndataTable tr').eq(1).children().eq(2).text().replaceAll(',', ''));
							var matOutcnt =(requireCnt-outCnt).toFixed(2);
							if(stockCnt<=matOutcnt){
								$('#matOutcnt').val(stockCnt);
							}else{
								$('#matOutcnt').val(matOutcnt);
							}
						}
					}
				});
			};
		});
	})(jQuery);

	//=====================================================================
	// button action funtion
	//=====================================================================

	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<div class="card">
		<div class="card-body">
			<div class="row">
				<div class="col-md-8">
					<form:form commandName="search" id="searchRequireMatForm" name="searchRequireMatForm">
						<input type="hidden" name="searchProdSeq" value="${search.searchProdSeq}" />
						<input type="hidden" name="searchMatCd" value="" />
						<div class="card-header">
							<sapn>자재출고</sapn>
							<div id="btnClear" class="btn-logout" style="float: right; margin-left: 5px;">
								<i class="xi-renew"></i> 초기화
							</div>
							<div style="float: right; width: 150px;display: none;">
								<select class="form-control2" id="searchWorkshopCd" name="searchWorkshopCd">
									<c:forEach items="${store_house_list}" var="item" varStatus="status">
										<option value="${item.workshopCd}">${item.workshopNm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</form:form>
					<div id="cardRequireMat" class="card card-roundbox" style="padding: 0 5px; height: 320px; overflow-y: auto;">
						<div class="card-body" style="padding: 12px;">
							<div class="table-responsive">
								<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
									<table class="table table-borderless table-borderbottom dataTable table-hover" id="requireMatTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
										<thead class="thead-dark">
											<tr role="row">
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 18%;">제품명</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">작지일자</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 18%;">자재명</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">소요량 (KG)</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">출고량 (KG)</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">LOT No</th>
											</tr>
										</thead>
										<tbody id="requireMatListBody" />
									</table>
								</div>
							</div>
						</div>
					</div>
					<div id="cardMaterialIn" class="card card-roundbox" style="margin-top: 10px; padding: 0 5px; height: 200px; display: none; overflow-y: auto;">
						<div class="card-body" style="padding: 12px;">
							<div class="table-responsive">
								<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
									<table class="table table-borderless table-borderbottom dataTable table-hover" id="materialIndataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
										<thead class="thead-dark">
											<tr role="row">
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">자재명</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">재고 (KG)</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">출고량 (KG)</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">잔여량 (KG)</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">입고일자</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">LOT No</th>
											</tr>
										</thead>
										<tbody id="materialInListBody" />
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="card-body card-roundbox mt-3">
						<div class="btn btn-block">
							<div id="barCodeView" style="height: 70px; padding: 6px;">
								<div id="barCodeMsg" style="height: 70px; padding: 6px; color: grey; font-weight: bold; font-size: 1.6em; margin-top: 5px; text-align: center;">소요자재를 선택 하세요</div>
								<div id="barCode" style="display: none; width: 100%; float: left; padding: 10px 20px 10px 20px;"></div>
								<div id="barCodeText" style="display: none; color: grey; font-weight: bold; font-size: 1.2em; width: 100%; float: left; text-align: center;"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card-header">
						<sapn>KEYPAD</sapn>
						<div id="btnColse" class="btn-logout" style="float: right;">
							<i class="xi-close-circle-o"></i> 닫기
						</div>
					</div>
					<div class="card card-roundbox" style="clear: both">
						<!--<h1 class="body-header">자재출고량</h1>-->
						<div class="row calc-lcd" style="margin-top: 10px;">
							<input class="form-inline" id="matOutcnt" name="matOutcnt" type="text" value="" placeholder="출고량" />
							<span class="unit-span">KG</span>
						</div>
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn1">1</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn2">2</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn3">3</div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn4">4</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn5">5</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn6">6</div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn7">7</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn8">8</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn9">9</div>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 5px;">
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btnBack">←</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btn0">0</div>
								</div>
							</div>
							<div class="col-md-4" style="padding: 0 5px;">
								<div class="btn calc-btn btn-block">
									<div id="btnAdd">등록</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" name="searchLotid" value="" />
		<input type="hidden" name="searchMatCd" value="" />
		<input type="hidden" name="searchMatTypeCd" value="" />
	</form:form>
	<form:form commandName="obj" id="objForm" name="objForm">
		<input type="hidden" name="crudType" value="C" />
		<input type="hidden" name="workshopCd" value="" />
		<input type="hidden" name="matOutTypeCd" value="GOUT" />
		<input type="hidden" name="matTypeCd" value="" />
		<input type="hidden" id="outDt" name="outDt" value="${rtn.obj.outDt}" />
		<input type="hidden" name="outCnt" value="" />
		<input type="hidden" name="matCd" value="" />
		<input type="hidden" name="lotid" value="" />
		<input type="hidden" name="prodSeq" value="${search.searchUpProdSeq}" />
	</form:form>
	<form:form commandName="search" id="closeSearchForm" name="closeSearchForm">
		<input type="hidden" name="pageIndex" value="1" />
		<input type="hidden" name="searchProdSeq" value="${search.searchProdSeq}" />
		<input type="hidden" name="searchPoCalldt" value="${search.searchPoCalldt}" />
	</form:form>
</body>
</html>