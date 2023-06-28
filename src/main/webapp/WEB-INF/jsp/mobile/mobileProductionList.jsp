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
			$("#searchPoCalldt").datepicker({
				showOn : "button",
				buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
				buttonImageOnly : true,
				buttonText : "Select date",
				dateFormat : "yy/mm/dd"
			}).css("z-index", 3);

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			$('#btnClear').click(function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.searchProdSeq.value = '';
				frm.searchPoCalldt.value = '';
				frm.action = "<c:url value='/mobileProductionListPage.do'/>";
				frm.submit();
			});

			$('#cardBox1,#cardBox2,#cardBox3,#cardBox4,#cardBox5,#cardBox6,#cardBox7,#cardBox8').click(function() {
				fn_go_search_page($(this).data("prodseq"));
			});

			//-------------------------------------------------------------
			// 닫기 버튼 클릭
			//-------------------------------------------------------------
			$('#btnColse').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileMenuPage.do'/>";
				frm.submit();
			});

			$('#searchPoCalldt').change(function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.searchProdSeq.value = '';
				frm.action = "<c:url value='/mobileProductionListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 페이징 사이즈 변경 이벤트
			//-------------------------------------------------------------
			$('#pageSizeItem').on('change', function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.pageSize.value = $("#pageSizeItem").val();
				frm.action = "<c:url value='/mobileProductionListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 컬럼 소트 이벤트
			//-------------------------------------------------------------
			$('#dataTable').find('th').not('.no-sort').click(function() {
				var frm = document.searchForm;
				var sortCol = $(this).attr("id");
				frm.sortCol.value = sortCol;
				var sortColType = $(this).attr('class');
				if (sortColType == 'sorting_asc') {
					frm.sortType.value = 'desc'
				} else {
					frm.sortType.value = 'asc'
				}
				frm.action = "<c:url value='/mobileProductionListPage.do'/>";
				frm.submit();
			});

			drawProductionOperList = function(prodSeq) {
				document.operListForm.searchProdSeq.value = prodSeq;
				$.ajax({
					url : "<c:url value='/getProductionOperListData.do'/>",
					type : 'POST',
					data : $('#operListForm').serialize(),
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					context : this,
					dataType : 'json',
					beforeSend : function() {

						$("#prodOrderBodyList tr").remove();
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
							html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_go_oper(eval(" + rtnObj + "))\">" + val.operNm + "</a></span></td>";

							if (val.statusCd == 'END') {
								html += "<td class=\"text-ellipsis\"><span>완료</span></td>";
							} else if (val.statusCd == 'ING') {
								html += "<td class=\"text-ellipsis\"><span>작업중</span></td>";
							} else {
								html += "<td class=\"text-ellipsis\"><span>대기</span></td>";
							}

							if (val.operCd == 'MAT_OUT') {
								html += "<td class=\"text-ellipsis\"><span>-</span></td>";
								html += "<td class=\"text-ellipsis\"><span>-</span></td>";
								html += "<td class=\"text-ellipsis\"><span>-</span></td>";
								html += "<td class=\"text-ellipsis\"><span>-</span></td>";
							} else {
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.assignQty, "0"))) + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.workQty, "0"))) + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.actokQty, "0"))) + "</span></td>";
								html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.actbadQty, "0"))) + "</span></td>";
							}

							html += "</tr>";
							$("#prodOrderBodyList").append(html);
						});
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
				$("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
				if (document.searchForm.sortType.value == 'asc') {
					$("#${search.sortCol}").attr('class', 'sorting_asc');
				} else {
					$("#${search.sortCol}").attr('class', 'sorting_desc');
				}
				if ($("#searchProdSeq").val() != '') {
					drawProductionOperList($("#searchProdSeq").val());
				}

				$("#searchPoCalldt").val('${search.searchPoCalldt}');

			});
		});
	})(jQuery);

	//=====================================================================
	// button action funtion
	//=====================================================================
	function fn_go_search_page(id) {
		var frm = document.searchForm;
		frm.pageIndex.value = 1;
		frm.searchProdSeq.value = id;
		frm.action = "<c:url value='/mobileProductionListPage.do'/>";
		frm.submit();
	}

	//=====================================================================
	// paging
	//=====================================================================
	function fn_paging(pageIndex) {
		var frm = document.searchForm;
		frm.pageIndex.value = pageIndex;
		frm.action = "<c:url value='/mobileProductionListPage.do'/>";
		frm.submit();
	}

	//=====================================================================
	//
	//=====================================================================
	function fn_go_oper(param) {
		var frm = document.searchForm;
		frm.workactMstSeq.value = param.workactMstSeq;
		frm.workactSeq.value = param.workactSeq;
		frm.prodSeq.value = param.prodSeq;
		frm.operCd.value = param.operCd;
		frm.searchProdSeq.value = param.prodSeq;

		switch (param.operCd) {
		case "MAT_OUT": // 자재출고
			frm.action = "<c:url value='/mobileMaterialOutPage.do'/>";
			break;
		default:
			frm.action = "<c:url value='/mobileProductionWorkactPage.do'/>";
			break;
		}

		frm.submit();
	}
	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<div class="card" style="padding:15px 30px;">
		<div class="card-header">
		    <sapn>생산작업</sapn>
		    <div id="btnColse" class="btn-logout mr-2" style="float: right;"><i class="xi-close-circle-o"></i> 닫기</div>
		</div>

		<div class="card-body card-roundbox pr-sm-5 pl-sm-5">
			<div class="row" style="padding-top: 5px; margin-bottom: 5px;">
				<div class="container-fluid">
					<div class="row">
						<div class="col-sm-6">
							<div class="card bg-primary text-white mb-2">
								<div class="card-body" style="font-size: 135%; height: 35px; text-align: center;">작업 지시</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="card bg-primary text-white mb-2">
								<div class="card-body" style="font-size: 135%; height: 35px; text-align: center;">공정</div>
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
										<input type="hidden" name="workactMstSeq" value="" />
										<input type="hidden" name="workactSeq" value="" />
										<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
										<input type="hidden" name="operCd" value="${search.operCd}" />
										<input type="hidden" id="searchProdSeq" name="searchProdSeq" value="${search.searchProdSeq}" />
										<div id="btnClear" class="btn btn-dark float-right">
											<i class="xi-renew"></i>초기화
										</div>
										<div class="float-right">
											<input class="form-control3 align-top" size="8" id="searchPoCalldt" name="searchPoCalldt" type="text" value="${search.searchPoCalldt}" placeholder="실적조회 종료일자" />
										</div>
									</form:form>
									<sapn>작업지시 목록</sapn>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="card-header" style="padding-top: 5px; border-bottom: 1px solid rgba(151, 151, 151, 0.9); margin-bottom: 20px; font-size: 1.4em; font-weight: 600;">
									<span>공정 목록</span>
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
															<div class="col-xl-12">
																<div id="cardBox${status.count}" data-prodSeq="${item.prodSeq}" class="card bg-primary text-white mb-4" style="height: 120px;">
																	<div class="prodPoNo card-body" style="font-size: 85%; text-align: center;">${item.prodPoNo}</div>
																	<div class="itemNm card-body" style="font-size: 85%; text-align: center;">${item.itemNm}</div>
																	<div class="poQty card-body" style="font-size: 85%; text-align: center;">지시수량 ${item.poQty}EA</div>
																	<div class="poCalldt card-body" style="font-size: 85%; text-align: center;">지시일자 ${item.poCalldt}</div>
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
										<table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
											<thead class="thead-dark">
												<tr role="row" style="font-size: 13px;">
													<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 30%;">공정명</th>
													<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">상태</th>
													<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">배정</th>
													<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">작업</th>
													<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">양품</th>
													<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">불량</th>
												</tr>
											</thead>
											<tbody id="prodOrderBodyList" />
										</table>
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

	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
	<form:form commandName="search" id="operListForm" name="operListForm">
		<input type="hidden" name="searchProdSeq" value="" />
	</form:form>
</body>
</html>