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
			$("#searchFromQmCheckdt, #searchToQmCheckdt, #searchFromPoCalldt, #searchToPoCalldt").datepicker({
				showOn : "button",
				buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
				buttonImageOnly : true,
				buttonText : "Select date",
				dateFormat : "yy/mm/dd"
			}).css("z-index", 3);
			var cardBoxData = [{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}
            ,{'prodSeq':'','mqcSeq':'','qmStockQty':0,'selected':false}];


			var itemCardBoxList = [{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}
            ,{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}
            ,{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}
            ,{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}
            ,{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}
            ,{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}
            ,{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}
            ,{'lotId':'','itemNm':'','inokQty':0,'iteminDt':'','selected':false}];

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			$('#cardBox1,#cardBox2,#cardBox3,#cardBox4,#cardBox5,#cardBox6,#cardBox7,#cardBox8').click(function() {
				var pos = parseInt($(this).attr('id').replace('cardBox', '')) - 1;
				cardBoxData[pos].prodSeq = $(this).data("prodseq");
				cardBoxData[pos].mqcSeq = $(this).data("mqcseq");
				cardBoxData[pos].qmStockQty = $(this).data("qmstockqty");
				var cnt = 0;
				while (cnt < 8) {
					itemCardBoxList[cnt].selected = false;
					cnt++;
				}

				if (cardBoxData[pos].selected) {
					cardBoxData[pos].selected = false;
					$(this).attr('class', 'card bg-primary text-white mb-4');
				} else {
					cardBoxData[pos].selected = true;
					$(this).attr('class', 'card bg-warning text-white mb-4');
					var i = 0;
					while (i < 8) {
						if (i != pos) {
							cardBoxData[i].selected = false;
							$("#cardBox" + (i + 1)).attr('class', 'card bg-primary text-white mb-4');
						}
						i++;
					}
				}
				fn_drawItemInList($(this).data("mqcseq"), '1');
			});

			$(document).on("click",'#itemCardBox1,#itemCardBox2,#itemCardBox3,#itemCardBox4,#itemCardBox5,#itemCardBox6,#itemCardBox7,#itemCardBox8',function(){
				var pos = parseInt($(this).attr('id').replace('itemCardBox', '')) - 1;
				itemCardBoxList[pos].lotId = $(this).find('.lotid').text();
				itemCardBoxList[pos].itemNm = $(this).find('.itemNm').text();
				itemCardBoxList[pos].inokQty = $(this).find('.inokQty').text().replace("입고수량", "").replace("EA", "");
				itemCardBoxList[pos].iteminDt = $(this).find('.iteminDt').text().replace("입고일자:", "");
				if (itemCardBoxList[pos].selected) {
					itemCardBoxList[pos].selected = false;
					$(this).attr('class', 'card bg-primary text-white mb-4');
				} else {
					itemCardBoxList[pos].selected = true;
					$(this).attr('class', 'card bg-warning text-white mb-4');
				}
			});

			$("#searchFromQmCheckdt, #searchToQmCheckdt, #searchFromPoCalldt, #searchToPoCalldt").change(function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.action = "<c:url value='/mobileItemInListPage.do'/>";
				frm.submit();
			});
			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//-------------------------------------------------------------
			$('#btnColse').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileMenuPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 페이징 사이즈 변경 이벤트
			//-------------------------------------------------------------
			$("#pageSizeItem").on("change", function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.pageSize.value = $("#pageSizeItem").val();
				frm.action = "<c:url value='/mobileItemInListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 컬럼 소트 이벤트
			//-------------------------------------------------------------
			$("#dataTable").find("th").not(".no-sort").click(function() {
				var frm = document.searchForm;
				var sortCol = $(this).attr("id");
				var sortColType = $(this).attr("class");
				frm.sortCol.value = sortCol;

				if (sortColType == "sorting_asc") {
					frm.sortType.value = "desc";
				} else {
					frm.sortType.value = "asc";
				}

				frm.action = "<c:url value='/mobileItemInListPage.do'/>";
				frm.submit();
			});

			$("#searchTypeInView").click(function() {
				var frm = document.searchForm;
				frm.sortCol.value = "ITEMIN_DT"
				frm.sortType.value = "DESC"
			})

			//-------------------------------------------------------------
			// 엑셀 다운로드 이벤트
			//-------------------------------------------------------------
			$("#btnExcel").click(function() {
				downloadExcelFromTable($("#dataTable"));
			});

			//-------------------------------------------------------------
			// 생성 이벤트
			//-------------------------------------------------------------
			$("#btnCreate").click(function() {
				if( cardBoxData.find(element => element["selected"] == true) == undefined ) {
					cfAlert("검품 데이타를 선택하세요.");
					return false;
				}

				$.each(cardBoxData, function(index, card) {
					if (card.selected) {
						fn_createItemIn(card.prodSeq, card.mqcSeq, card.qmStockQty);
					}
				});
			});

			//-------------------------------------------------------------
			// 출하 목록
			//-------------------------------------------------------------
			drawItemInList = function(mqcSeq, pageIndex) {
				document.itemInForm.searchMqcSeq.value = mqcSeq;
				document.itemInForm.pageIndex.value = pageIndex;
				$.ajax({
					url : "<c:url value='/getMobileItemInListData.do'/>",
					type : "POST",
					data : $("#itemInForm").serialize(),
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					context : this,
					dataType : "json",
					beforeSend : function() {
						$("#itemInListBody").children('div').remove();
						$('#detailPageDiv').empty();
						$("#layoutSidenav").loading();
					},
					success : function(data) {
						if (!cfCheckRtnObj(data.rtn))
							return;
						var html = "";
						var i = 1;
						// html += "<div style=\"max-height:250px; overflow-y:scroll; overflow-x: clip;\">";
						$.each(data.rtn.obj, function(key, val) {
							var valObj = JSON.stringify(val).replace(/\"/gi, "\'");

							html = "";
							html += "<div class=\"row\">";
							html += "<div class=\"col-xl-12 col-md-12\">";
							html += "<div id=\"itemCardBox" + (i++) + "\" class=\"card bg-primary text-white mb-4\" style=\"height:120px;\">";
							html += "<div id=" + val.lotid + "_itemNm style=\"display:none;\">" + val.itemNm + "</div>";
							html += "<div id=" + val.lotid + "_inokQty style=\"display:none;\">" + cfAddComma(cfIsNullString(val.inokQty, "0")) + "</div>";
							html += "<div id=" + val.lotid + "_iteminDt style=\"display:none;\">" + val.iteminDt + "</div>";
							html += "<div class=\"lotid card-body\" style=\"font-size:85%; text-align:center;\"><span><a href=\"javascript:fn_go_dtl_page(eval(" + valObj + "))\">" + val.lotid + "</a></span></div>";
							html += "<div class=\"itemNm card-body\" style=\"font-size:85%; text-align:center;\">" + val.itemNm + "</div>";
							html += "<div class=\"inokQty card-body\" style=\"font-size:85%;  text-align:center;\">입고수량" + cfAddComma(cfIsNullString(val.inokQty, "0")) + " EA</div>";
							html += "<div class=\"iteminDt card-body\" style=\"font-size:85%;  text-align:center;\">입고일자:" + val.iteminDt + "</div>";
							html += "</div>";
							html += "</div>";
							html += "</div>";

							$("#itemInListBody").append(html);
						});
						//html += "</div>";
						//=====================================================================
						// paging처리
						//=====================================================================
						var cnt = data.rtn.totCnt;
						var search = data.search;
						var isLoof = true;
						var appendPoint = '#detailPageDiv';
						paging_base(cnt, search, isLoof, appendPoint); //function
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
			// 바코드 출력
			//-------------------------------------------------------------
			$("#btnBarCodePrint").click(function() {
				if( $("#barcodePrinter").val() == "" ) {
					cfAlert("프린터를 선택하세요.");
					return false;
				}

				// 버튼이벤트 중복 발생을 막기 위해 로딩바를 먼저 호출.
				$("#previewBarCode").loading();

				var barcodeDivObj = $("div[name=previewBarCodeChild]");
				var arrImageData = [];
				var deferred = $.Deferred();

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
							IpAdress: '<spring:eval expression="@property['Globals.print.ip']"/>',
                            Port: $("#barcodePrinter").val(),
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
			// 바코드 출력 팝업
			//-------------------------------------------------------------
			$("#btnPrintBarCode").click(function() {
				if( itemCardBoxList.find(element => element["selected"] == true) == undefined ) {
					cfAlert("바코드 데이타를 선택하세요.");
					return false;
				}

				$("#previewBarCode div").remove();

				var html = "";
				$.each(itemCardBoxList, function(index, card) {
					if (card.selected) {
						html = createHtmlBarCode(card.lotId);
						$("#previewBarCode").append(html);
						$("#"+card.lotId).barcode(card.lotId, "code128",{barWidth:3, barHeight:60,showHRI:false,bgColor:"white", output:'css'});
					};
				});

				$("#barcodePrintModal").css("display", "block");
			});

			//-------------------------------------------------------------
			// 바코드 팝업 닫기
			//-------------------------------------------------------------
			$('.modal-close-button').click(function() {
				$(".modal-container").css("display", "none");
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
				$("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);

				if (document.searchForm.sortType.value == "asc") {
					$("#${search.sortCol}").attr("class", "sorting_asc");
				} else {
					$("#${search.sortCol}").attr("class", "sorting_desc");
				}

				$("#searchFromQmCheckdt").val("${search.searchFromQmCheckdt}");
				$("#searchToQmCheckdt").val("${search.searchToQmCheckdt}");
				$("#searchFromPoCalldt").val("${search.searchFromPoCalldt}");
				$("#searchToPoCalldt").val("${search.searchToPoCalldt}");
				$("#searchType").val("${search.searchType}");

				if ("${search.mqcSeq}" != "") {
					drawItemInList('${search.mqcSeq}', '1');
				}
			});
		});
	})(jQuery);

	//-------------------------------------------------------------
	// 바코드 출력 html
	//-------------------------------------------------------------
	function createHtmlBarCode(lotid) {
		html = "";
		html += "<div name=\"previewBarCodeChild\" style=\"padding:10px 5px 10px 10px;\">"; // 용지 좌우 여백 조절
		html += "<div class=\"row\" style=\"margin-top:20px\">";
		html += "<div class=\"col-md-12\" style=\"min-width:410px;\">";
		html += "<table class=\"barcode-table\" style=\"width:600px;\">";
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
		html += "<div style=\"width:100%; float:left; padding:0px 20px 0px 20px;\">";
		html += "<div id=\""+lotid+"\"/>";
		html += "</div>";
		// barcode text
		html += "<div style=\"font-weight: bold; font-size: 1.6em; width:100%; float:left;\">" + lotid + "</div>";
		html += "</td>";
		html += "</tr>";
		//---------------------------------------------------------------------------------------------
		// 제품명, 수 량, 입고일자
		//---------------------------------------------------------------------------------------------
		html += "<tr style=\"height:130px;\">";
		html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">제품명</td>";
		html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.8em;\">" + $('#' + lotid + '_itemNm').html() + "</td>";
		html += "</tr>";

		html += "<tr>";
		html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">수 량</td>";
		html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">" + $('#' + lotid + '_inokQty').html() + " EA</td>";
		html += "</tr>";

		html += "<tr>";
		html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">입고일자</td>";
		html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">" + $('#' + lotid + '_iteminDt').html() + "</td>";
		html += "</tr>";

		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";
		html += "</div>";

		return html;
	}

	//=====================================================================
	// 입고 리스트 조회
	//=====================================================================
	function fn_drawItemInList(mqcSeq, pageIndex) {
		drawItemInList(mqcSeq, pageIndex);
	}

	//=====================================================================
	// QM추가
	//=====================================================================
	function fn_createItemIn(prodSeq, mqcSeq, qmStockQty) {
		if (parseInt(qmStockQty) <= 0) {
			alert("잔여량이 없습니다.");
			return false;
		}

		var frm = document.searchForm;
		frm.crudType.value = "C";
		frm.prodSeq.value = prodSeq;
		frm.mqcSeq.value = mqcSeq;

		frm.action = "<c:url value='/mobileItemInDtlPage.do'/>";
		frm.submit();
	}

	//=====================================================================
	// button action funtion
	//=====================================================================
	function fn_go_dtl_page(obj) {
		var frm = document.searchForm;
		frm.crudType.value = "R";
		frm.iteminSeq.value = obj.iteminSeq;
		frm.prodSeq.value = obj.prodSeq;
		frm.mqcSeq.value = obj.mqcSeq;
		frm.action = "<c:url value='/mobileItemInDtlPage.do'/>";
		frm.submit();
	}

	//=====================================================================
	// paging
	//=====================================================================
	function fn_paging(pageIndex) {
		var frm = document.searchForm;
		frm.pageIndex.value = pageIndex;
		frm.action = "<c:url value='/mobileItemInListPage.do'/>";
		frm.submit();
	}

	//=====================================================================
	// 제품 입고 paging
	//=====================================================================
	function paging_base(cnt, search, isLoof, appendPoint) {
		var html = '';
		html += '<div class="col-sm-12 col-md-5">';
		if (cnt > 0) {
			html += '<div class="dataTables_info" id="dataTable_info">Showing ' + (search.firstIndex * 1 + 1) + ' to ' + search.lastIndex + ' of ' + cnt + ' entries</div>';
		}
		html += '</div>';

		html += '<div class="col-sm-12 col-md-7">';
		html += '<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">';
		html += '<ul class="pagination">';
		if (cnt > 0) {
			if (search.pageIndex > 1) {
				html += '<li class="paginate_button page-item previous" id="dataTable_previous"><a href="javascript:drawItemInList(\'' + search.searchMqcSeq + '\',' + (search.pageIndex - 1)
						+ ')" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>';
			}
			for (var i = search.startPage; i < search.endPage; i++) {
				if (isLoof) {
					if (i == search.pageIndex) {
						html += '<li class="paginate_button page-item active saleChoicePage" id="'+search.pageIndex+'"><a href="#" aria-controls="dataTable" data-dt-idx="'+i+'" tabindex="0" class="page-link">' + i + '</a></li>';
					} else {
						html += '<li class="paginate_button page-item"><a href="javascript:drawItemInList(\'' + search.searchMqcSeq + '\',' + i + ') "aria-controls="dataTable" data-dt-idx="' + i + '" tabindex="0" class="page-link">' + i
								+ '</a> </li>';
					}
					if (cnt <= (search.pageSize * i)) {
						isLoof = false;
					}
				}
			}
			if (cnt > (search.pageSize * search.pageIndex)) {
				html += '<li class="paginate_button page-item next" id="dataTable_next"><a href="javascript:drawItemInList(\'' + search.searchMqcSeq + '\',' + (search.pageIndex + 1)
						+ ')" aria-controls="dataTable" data-dt-idx="11" tabindex="0" class="page-link">Next</a></li>'
			}
		}
		html += '</div>'
		html += '</div>'
		html += '</div>'
		$('' + appendPoint + '').append(html);
	}
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<div class="card" style="padding:15px 30px;">
		<div class="card-header">
		    <sapn>제품입고</sapn>
		    <div id="btnColse" class="btn-logout mr-2" style="float: right;"><i class="xi-close-circle-o"></i> 닫기</div>
		</div>

		<div class="card-body card-roundbox pr-sm-5 pl-sm-5">
			<div class="row" style="padding-top: 5px; margin-bottom: 5px;">
				<div class="container-fluid">
					<div class="row">
						<div class="col-sm-6">
							<div class="card bg-primary text-white mb-2">
								<div class="card-body" style="font-size: 135%; height: 35px; text-align: center;">검품</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="card bg-primary text-white mb-2">
								<div class="card-body" style="font-size: 135%; height: 35px; text-align: center;">제품 입고</div>
							</div>
						</div>
					</div>
					<div class="card mb-4" style="padding-top: 0px;">
						<div class="row">
							<div class="col-sm-6">
								<div class="card-header" style="padding-top: 5px; border-bottom: 1px solid rgba(151, 151, 151, 0.9); margin-bottom: 20px; font-size: 1.4em; font-weight: 600;">
									<form:form commandName="search" id="searchForm" name="searchForm">
										<input type="hidden" name="crudType" value="R" />
										<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
										<input type="hidden" name="pageSize" value="${search.pageSize}" />
										<input type="hidden" name="sortCol" value="${search.sortCol}" />
										<input type="hidden" name="sortType" value="${search.sortType}" />
										<input type="hidden" name="mqcSeq" value="" />
										<input type="hidden" name="prodSeq" value="" />
										<input type="hidden" name="iteminSeq" value="" />
										<div id="searchTypeNinView">
											<div style="float: right; margin: 6px 5px;">
												<input class="form-control3 align-top" size="8" id="searchToQmCheckdt" name="searchToQmCheckdt" type="text" value="${search.searchToQmCheckdt}" />
											</div>
											<div style="float: right; margin: 6px 5px;">
												<input class="form-control3 align-top" size="8" id="searchFromQmCheckdt" name="searchFromQmCheckdt" type="text" value="${search.searchFromQmCheckdt}" />
											</div>
										</div>
									</form:form>
									<sapn>검품 목록</sapn>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="card-header" style="padding-top: 5px; border-bottom: 1px solid rgba(151, 151, 151, 0.9); margin-bottom: 20px; font-size: 1.4em; font-weight: 600;">
									<span>제품 입고 목록</span>
									<div id="btnPrintBarCode" class="btn btn-primary btn-sm mr-2" style="float: right;">바코드발행</div>
									<div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">입고추가</div>
								</div>
							</div>
						</div>
						<div class="card-body">
							<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<div class="col-sm-6">
										<table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
											<div class="container-fluid">
												<div style="max-height: 250px; overflow-y: auto; overflow-x: clip;">
													<c:forEach items="${rtn.obj}" var="item" varStatus="status">
														<div class="row">
															<div class="col-xl-12 col-md-12">
																<div id="cardBox${status.count}" data-mqcSeq="${item.mqcSeq}" data-prodSeq="${item.prodSeq}" data-qmStockQty="${item.qmStockQty}" class="card bg-primary text-white mb-4" style="height: 120px;">
																	<div class="prodQmNo card-body" style="font-size: 85%; text-align: center;">${item.prodQmNo}</div>
																	<div class="itemNm card-body" style="font-size: 85%; text-align: center;">${item.itemNm}</div>
																	<div class="checkQty card-body" style="font-size: 85%; text-align: center;">검품수량/입고수량 ${item.actokQty}/${item.useCheckQty}EA</div>
																	<div class="qmCheckdt card-body" style="font-size: 85%; text-align: center;">검품일자 ${item.qmCheckdt}</div>
																</div>
															</div>
														</div>
													</c:forEach>
												</div>
											</div>
										</table>
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
									<div class="col-sm-6">
										<div id="itemInListBody" style="max-height: 250px; overflow-y: scroll; overflow-x: clip;"></div>
										<div class="row" id="detailPageDiv"></div>
									</div>
								</div>
							</div>
						</div>
						<!-- card body -->
					</div>
				</div>
			</div>
		</div>
	</div>

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

	<form:form commandName="search" id="itemInForm" name="itemInForm">
		<input type="hidden" name="searchMqcSeq" value="" />
		<input type="hidden" id="pageIndex" name="pageIndex" value="${search.pageIndex }" />
	</form:form>
</body>
</html>