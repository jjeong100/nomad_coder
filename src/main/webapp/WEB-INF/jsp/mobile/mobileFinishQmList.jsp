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
			$("#searchFromDate, #searchToDate").datepicker({
				showOn : "button",
				buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
				buttonImageOnly : true,
				buttonText : "Select date",
				dateFormat : "yy/mm/dd"
			}).css("z-index", 3);

			var cardBoxData = [{'prodSeq':'','workactSeq':'','qmStockQty':0,'selected':false}
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
				cardBoxData[pos].prodSeq = $(this).data("prodseq");
				cardBoxData[pos].workactSeq = $(this).data("workactseq");
				cardBoxData[pos].qmStockQty = $(this).data("qmstockqty");

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
				fn_drawQmDtl($(this).data("prodseq"), $(this).data("workactseq"), '1');
			});

			$("#searchFromDate, #searchToDate").change(function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.action = "<c:url value='/mobileFinishQmListPage.do'/>";
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
				frm.action = "<c:url value='/mobileFinishQmListPage.do'/>";
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

				frm.action = "<c:url value='/mobileFinishQmListPage.do'/>";
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
					cfAlert("검품하실 생산품을 선택하세요.");
					return false;
				}

				$.each(cardBoxData, function(index, card) {
					if (card.selected) {
						fn_createQM(card.prodSeq, card.workactSeq, card.qmStockQty);
					}
				});
			});

			//-------------------------------------------------------------
			// 출하 목록
			//-------------------------------------------------------------
			drawQmDtlList = function(prodSeq, workactSeq, pageIndex) {
				if (cfIsNull(prodSeq)) {
					return false;
				}
				document.finishQmListForm.prodSeq.value = prodSeq;
				document.finishQmListForm.workactSeq.value = workactSeq;

				$.ajax({
					url : "<c:url value='/getMobileFinishQmListData.do'/>",
					type : "POST",
					data : $("#finishQmListForm").serialize(),
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					context : this,
					dataType : "json",
					beforeSend : function() {
						$("#finishQmBodyList").children('div').remove();
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
							html += "<div class=\"lotid card-body\" style=\"font-size:85%; text-align:center;\">";
							html += "	<span><a href=\"javascript:fn_go_dtl_page(eval(" + valObj + "))\" style=\"color: #ffffff;text-decoration: underline;\">" + val.prodQmNo + "</a></span>";
							html += "</div>";
							html += "<div class=\"itemNm card-body\" style=\"font-size:85%; text-align:center;\">" + val.itemNm + "</div>";
							html += "<div class=\"inokQty card-body\" style=\"font-size:85%;  text-align:center;\">검품수량" + cfAddComma(cfIsNullString(val.checkQty, "0")) + " EA</div>";
							html += "<div class=\"iteminDt card-body\" style=\"font-size:85%;  text-align:center;\">검품일자:" + val.qmCheckdt + "</div>";
							html += "</div>";
							html += "</div>";
							html += "</div>";

							$("#finishQmBodyList").append(html);
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
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
// 				if ("${search.prodSeq}" != "") {
// 					$("input[name='rowRadio'][data-prodseq='${search.prodSeq}']").prop("checked", true);
// 					drawQmDtlList("${search.prodSeq}", "${search.workactSeq}");
// 				}

				$("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);

				if (document.searchForm.sortType.value == 'asc') {
					$("#${search.sortCol}").attr('class', 'sorting_asc');
				} else {
					$("#${search.sortCol}").attr('class', 'sorting_desc');
				}
			});
		});
	})(jQuery);

	//=====================================================================
	// 입고 리스트 조회
	//=====================================================================
	function fn_drawQmDtl(prodSeq, workactSeq, pageIndex) {
		drawQmDtlList(prodSeq, workactSeq, pageIndex);
	}

	//=====================================================================
	// QM추가
	//=====================================================================
	function fn_createQM(prodSeq, workactSeq, checkQty) {
		if (parseInt(checkQty) <= 0) {
			alert("잔여량이 없습니다.");
			return false;
		}
		var frm = document.searchForm;
		frm.crudType.value = "C";
		frm.prodSeq.value = prodSeq;
		frm.workactSeq.value = workactSeq;

		frm.action = "<c:url value='/mobileFinishQmDtlPage.do'/>";
		frm.submit()
	}

	//=====================================================================
    // button action funtion
    //=====================================================================
    function fn_go_dtl_page(paramObj) {
    	var frm = document.searchForm;
    	frm.crudType.value		= 'R';
    	frm.mqcSeq.value		= paramObj.mqcSeq;
    	frm.prodSeq.value		= paramObj.prodSeq;
    	frm.workactSeq.value	= paramObj.workactSeq;

    	frm.action = "<c:url value='/mobileFinishQmDtlPage.do'/>";
    	frm.submit();
    }

	//=====================================================================
	// paging
	//=====================================================================
	function fn_paging(pageIndex) {
		var frm = document.searchForm;
		frm.pageIndex.value = pageIndex;
		frm.action = "<c:url value='/mobileFinishQmListPage.do'/>";
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
				html += '<li class="paginate_button page-item previous" id="dataTable_previous"><a href="javascript:drawQmDtlList(\'' + search.searchworkactSeq + '\',' + (search.pageIndex - 1)
						+ ')" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>';
			}
			for (var i = search.startPage; i < search.endPage; i++) {
				if (isLoof) {
					if (i == search.pageIndex) {
						html += '<li class="paginate_button page-item active saleChoicePage" id="'+search.pageIndex+'"><a href="#" aria-controls="dataTable" data-dt-idx="'+i+'" tabindex="0" class="page-link">' + i + '</a></li>';
					} else {
						html += '<li class="paginate_button page-item"><a href="javascript:drawQmDtlList(\'' + search.searchworkactSeq + '\',' + i + ') "aria-controls="dataTable" data-dt-idx="' + i + '" tabindex="0" class="page-link">' + i
								+ '</a> </li>';
					}
					if (cnt <= (search.pageSize * i)) {
						isLoof = false;
					}
				}
			}
			if (cnt > (search.pageSize * search.pageIndex)) {
				html += '<li class="paginate_button page-item next" id="dataTable_next"><a href="javascript:drawQmDtlList(\'' + search.searchworkactSeq + '\',' + (search.pageIndex + 1)
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
	<div class="card" style="padding: 15px 30px;">
		<div class="card-header">
			<sapn>검품</sapn>
			<div id="btnColse" class="btn-logout mr-2" style="float: right;"><i class="xi-close-circle-o"></i> 닫기</div>
		</div>

		<div class="card-body card-roundbox pr-sm-5 pl-sm-5">
			<div class="row" style="padding-top: 5px; margin-bottom: 5px;">
				<div class="container-fluid">
					<div class="row">
						<div class="col-sm-6">
							<div class="card bg-primary text-white mb-2">
								<div class="card-body" style="font-size: 135%; height: 35px; text-align: center;">생산</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="card bg-primary text-white mb-2">
								<div class="card-body" style="font-size: 135%; height: 35px; text-align: center;">검품</div>
							</div>
						</div>
					</div>
					<div class="card" style="padding-top: 0px;">
						<div class="row">
							<div class="col-sm-6">
								<div class="card-header" style="border-bottom: 1px solid rgba(151, 151, 151, 0.9); margin-bottom: 20px; font-size: 1.4em; font-weight: 600;">
									<form:form commandName="search" id="searchForm" name="searchForm">
										<input type="hidden" name="crudType" value="R" />
										<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
										<input type="hidden" name="pageSize" value="${search.pageSize}" />
										<input type="hidden" name="sortCol" value="${search.sortCol}" />
										<input type="hidden" name="sortType" value="${search.sortType}" />
										<input type="hidden" name="mqcSeq" value="" />
										<input type="hidden" name="prodSeq" value="" />
										<input type="hidden" name="workactSeq" value="" />
										<div style="float: right; margin: 6px 5px;">
											<input class="form-control3 align-top" size="8" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="종료일자" />
										</div>
										<div style="float: right; margin: 6px 5px;">
											<input class="form-control3 align-top" size="8" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="시작일자" />
										</div>
									</form:form>
									<sapn>제품 생산 목록</sapn>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="card-header" style="padding-top: 5px; border-bottom: 1px solid rgba(151, 151, 151, 0.9); margin-bottom: 20px; font-size: 1.4em; font-weight: 600;">
									<span>제품 검품 목록</span>
									<div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">검품추가</div>
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
																<div id="cardBox${status.count}" data-workactSeq="${item.workactSeq}" data-prodSeq="${item.prodSeq}" data-qmStockQty="${item.qmStockQty}" class="card bg-primary text-white mb-4" style="height: 120px;">
																	<div class="prodWaNo card-body" style="font-size: 85%; text-align: center;">${item.prodWaNo}</div>
																	<div class="itemNm card-body" style="font-size: 85%; text-align: center;">${item.itemNm}</div>
																	<div class="actokQty card-body" style="font-size: 85%; text-align: center;">생산수량/ 검품수량 ${item.actokQty}/${item.useCheckQty}EA</div>
																	<div class="workedDt card-body" style="font-size: 85%; text-align: center;">생산일자
																	<fmt:parseDate value="${item.workedDt}" var="workedDt" pattern="yyyyMMdd"/>
                                                                    <fmt:formatDate pattern="yyyy/MM/dd" value="${workedDt}"/></span></div>
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
										<div id="finishQmBodyList" style="max-height: 250px; overflow-y: auto; overflow-x: clip;"></div>
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
	<form:form commandName="search" id="finishQmListForm" name="finishQmListForm">
		<input type="hidden" id="pageIndex" name="pageIndex" value="${search.pageIndex }" />
		<input type="hidden" name="prodSeq" value="" />
		<input type="hidden" name="workactSeq" value="" />
	</form:form>
</body>
</html>