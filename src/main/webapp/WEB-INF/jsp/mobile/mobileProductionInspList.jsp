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
<title>검사 정보 관리</title>
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
			$('#btnClose').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileProductionWorkactPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// jqery event
			//-------------------------------------------------------------
			// 검색 이벤트
			//-------------------------------------------------------------
			$('#btnSearch').click(function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.action = "<c:url value='/mobileProductionInspListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 페이징 사이즈 변경 이벤트
			//-------------------------------------------------------------
			$('#pageSizeItem').on('change', function() {
				var frm = document.searchForm;
				frm.pageIndex.value = 1;
				frm.pageSize.value = $("#pageSizeItem").val();
				frm.action = "<c:url value='/mobileProductionInspListPage.do'/>";
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
				frm.action = "<c:url value='/mobileProductionInspListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 생성 이벤트
			//-------------------------------------------------------------
			$('#btnCreate').click(function() {
				var frm = document.searchForm;
				frm.crudType.value = 'C';
				frm.action = "<c:url value='/mobileProductionInspDtlPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// onLoad
			//-------------------------------------------------------------
			$(document).ready(function() {
				$("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
				if (document.searchForm.sortType.value == 'asc') {
					$("th[id='${search.sortCol}']").attr('class', 'sorting_asc');
				} else {
					$("th[id='${search.sortCol}']").attr('class', 'sorting_desc');
				}
			});
		});
	})(jQuery);

	//=====================================================================
	// button action funtion
	//=====================================================================
	function fn_go_dtl_page(inspSeq, inspDaySeq, inspSmeCd) {
		var frm = document.searchForm;
		frm.crudType.value = 'R';
		frm.inspSeq.value = inspSeq;
		frm.inspDaySeq.value = inspDaySeq;
		frm.inspSmeCd.value = inspSmeCd;
		frm.action = "<c:url value='/mobileProductionInspDtlPage.do'/>";
		frm.submit();
	}

	//=====================================================================
	// paging
	//=====================================================================
	function fn_paging(pageIndex) {
		var frm = document.searchForm;
		frm.pageIndex.value = pageIndex;
		frm.action = "<c:url value='/mobileProductionInspListPage.do'/>";
		frm.submit();
	}
	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
				<!-- ========================================================================================================================= -->
				<!-- table list                                                                                                              -->
				<!-- ======================================================================================================================== -->
				<div class="card" style="padding: 15px 30px;">
					<div class="card-header">
						<sapn>${searchInsp.searchInspTypeCd == 'JJ' ? '자주':'패트롤'} 검사 목록</sapn>
						<div id="btnClose" class="btn-logout mr-2" style="float: right;"><i class="xi-close-circle-o"></i> 닫기</div>
						<div id="btnCreate" class="btn-logout mr-2" style="float: right;">검사 추가</div>
					</div>
					<div class="card-body card-roundbox pr-sm-5 pl-sm-5">
						<div class="table-responsive">
							<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<div class="col-sm-12 col-md-2" style="padding-top: 5px;">
										<div class="dataTables_length" id="dataTable_length">
											<label>Show <select id="pageSizeItem" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm">
													<option value="10">10</option>
													<option value="25">25</option>
													<option value="50">50</option>
													<option value="100">100</option>
												</select> entries
											</label>
										</div>
									</div>
									<div class=" col-sm-12 col-md-10" style="margin-bottom: 5px;">
										<div id="dataTable_filter" class="dataTables_wrapper">
											<form:form commandName="search" id="searchForm" name="searchForm">
												<input type="hidden" name="crudType" value="R" />
												<input type="hidden" name="pageIndex" value="1" />
												<input type="hidden" name="pageSize" value="${search.pageSize}" />
												<input type="hidden" name="sortCol" value="${search.sortCol}" />
												<input type="hidden" name="sortType" value="${search.sortType}" />

												<input type="hidden" name="workactMstSeq" value="${search.workactMstSeq}" />
												<input type="hidden" name="searchProdSeq" value="${search.searchProdSeq}" />
												<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
												<input type="hidden" name="itemCd" value="${search.itemCd}" />
												<input type="hidden" name="operCd" value="${search.operCd}" />
												<input type="hidden" name="searchWorkactSeq" value="${search.searchWorkactSeq}" />
												<input type="hidden" name="searchInspTypeCd" value="${search.searchInspTypeCd}" />

												<input type="hidden" name="inspSeq" value="" />
												<input type="hidden" name="inspDaySeq" value="0" />
												<input type="hidden" name="inspSmeCd" value="" />

												<div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
													<img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
												</div>
												<div style="float: right; margin: 6px 5px; width: 300px;">
													<select class="form-control2" id="searchInspSmeCd" name="searchInspSmeCd">
														<option value="">검사구분 선택</option>
														<c:forEach items="${insp_sme_cd_list}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${item.scode == search.searchInspSmeCd}">
																	<option value="${item.scode}" selected>${item.codeNm}</option>
																</c:when>
																<c:otherwise>
																	<option value="${item.scode}">${item.codeNm}</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
												</div>
											</form:form>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<!-- table table-striped table-bordered table-hover -->
										<table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
											<thead class="thead-dark">
												<tr role="row">
													<!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
													<th id="insp_sme_cd" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">검사구분</th>
													<th id="insp_day_seq" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">회차</th>
													<th id="insp_dt" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">검사일시</th>
													<th id="insp_rlt_cd" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">전체판정</th>
													<th id="insp_view" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">보기</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${rtn.obj}" var="item" varStatus="status">
													<tr role="row" class="odd">
														<!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
														<td class="text-ellipsis"><span class="insp_sme_cd">${item.inspSmeNm}</span></td>
														<td class="text-ellipsis"><span class="insp_day_seq">${item.inspDaySeq}</span></td>
														<td class="text-ellipsis"><span class="insp_dt">${item.inspDt}</span></td>
														<td class="text-ellipsis"><span class="insp_rlt_cd">${item.inspRltCd}</span></td>
														<td class="text-ellipsis"><span class="insp_view"><a href="javascript:fn_go_dtl_page('${item.inspSeq}', '${item.inspDaySeq}', '${item.inspSmeCd}')">보기</a></span></td>
													</tr>
												</c:forEach>
												<c:if test="${fn:length(rtn.obj) le 0}">
													<tr>
														<td colspan="5" class="no-data">- 표시할 내용이 없습니다. -</td>
													</tr>
												</c:if>
											</tbody>
										</table>
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
				<!-- table card end -->

		</div>
		<!-- layoutSidenav_content end -->
	</div>
	<!-- layoutSidenav -->
</body>
</html>