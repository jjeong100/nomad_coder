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
<title>생산지시관리</title>
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
			
			$("div[id^='divMonth_']").click(function() {
				var frm = document.searchForm;
				var name = $(this).attr("name");
				var fdt = frm.searchFromDate.value;
				var tdt = frm.searchToDate.value;
				
				if( name == "plus" ) {
					fdt = cfGetNextMonthNum(fdt, 1);
					frm.searchFromDate.value = fdt; 
					frm.searchToDate.value = fdt.substring(0, 6) + cfLastDateNum(fdt);
				} else if( name == "minus" ) {
					fdt = cfGetPrevMonthNum(fdt, 1);
					frm.searchFromDate.value = fdt; 
					frm.searchToDate.value = fdt.substring(0, 6) + cfLastDateNum(fdt);
				}
				
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
				frm.action = "<c:url value='/productionOrderListPage.do'/>";
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
				frm.action = "<c:url value='/productionOrderListPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 생성 이벤트
			//-------------------------------------------------------------
			$('#btnCreate').click(function() {
				var frm = document.searchForm;
				frm.crudType.value = 'C';
				frm.action = "<c:url value='/productionOrderDtlPage.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// onLoad  
			//-------------------------------------------------------------
			$(document).ready(function() {
				$("#tabs").tabs();
				$("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
				if (document.searchForm.sortType.value == 'asc') {
					$("#${search.sortCol}").attr('class', 'sorting_asc');
				} else {
					$("#${search.sortCol}").attr('class', 'sorting_desc');
				}

				$("#searchFromDate").val("${search.searchFromDate}");
				$("#searchToDate").val("${search.searchToDate}");
				
				var lastDay = ${search.lastDay};
				for(var i=31; i>lastDay; i--) {
					$("#dataTable tr > *:nth-child(" + (4 + i) + ")").hide();
				}
			});
		});
	})(jQuery);

	//=====================================================================
	// button action funtion
	//=====================================================================
	function fn_go_dtl_page(id) {
		var frm = document.searchForm;
		frm.crudType.value = 'R';
		frm.prodSeq.value = id;
		frm.action = "<c:url value='/productionOrderDtlPage.do'/>";
		frm.submit();
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
				<h1 class="mt-4">생산지시관리</h1>
				<!-- ========================================================================================================================= -->
				<!-- taable list                                                                                                              -->
				<!-- ======================================================================================================================== -->
				<div class="card mb-4">
					<div class="card-header">
						<div class="form-inline">
							<div class="col-sm-3 form-inline">
								<div id="divMonth_minus" name="minus" class="mr-2"><span class="btn btn-sm btn-dark" style=""> < </span></div>
								<sapn id="spaMonthText">${fn:substring(search.searchFromDate,4,6)}월 생산지시</sapn>
								<div id="divMonth_plus" name="plus" class="ml-2"><span class="btn btn-sm btn-dark" style=""> > </span></div>
							</div>						
							<div class="col-sm-9">
								<div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">생산지시추가</div>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<!-- <div class="col-sm-12 col-md-2" style="padding-top: 5px;">
										<div class="dataTables_length" id="dataTable_length">
											<label>Show <select id="pageSizeItem" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
													<option value="10">10</option>
													<option value="25">25</option>
													<option value="50">50</option>
													<option value="100">100</option>
												</select> entries
											</label>
										</div>
									</div> -->
									<div class=" col-sm-12 col-md-10" style="margin-bottom: 5px;display:none;">
										<div id="dataTable_filter" class="dataTables_wrapper">
											<form:form commandName="search" id="searchForm" name="searchForm">
												<input type="hidden" name="crudType" value="R" />
												<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
												<input type="hidden" name="pageSize" value="${search.pageSize}" />
												<input type="hidden" name="sortCol" value="${search.sortCol}" />
												<input type="hidden" name="sortType" value="${search.sortType}" />
												<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
												<div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
													<img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
												</div>
												<div class="float-right margin-dt">
													<input class="form-control3 dt-w55 col-xs-2" style="width: 200px;" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="입고조회 종료일자" />
												</div>
												<div class="float-right margin-dt">
													<input class="form-control3 dt-w55 col-xs-2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="입고조회 시작일자" />
												</div>
											</form:form>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="">
										<div class="row" style="margin-left: 0">
											<!-- table table-striped table-bordered table-hover -->
											<table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 1700px !important;">
												<thead class="thead-dark">
													<tr role="row">
														<!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
														<th id="prod_po_no" class="no-sort text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 140px;">LOT</th>
														<th id="item_nm" class="no-sort text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 200px;">제품명</th>
														<th id="po_qty" class="no-sort text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 80px;">계획</th>
														<th id="actok_qty" class="no-sort text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 80px;">완료</th>
														<th name="day1"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">1</th>
														<th name="day2"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">2</th>
														<th name="day3"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">3</th>
														<th name="day4"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">4</th>
														<th name="day5"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">5</th>
														<th name="day6"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">6</th>
														<th name="day7"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">7</th>
														<th name="day8"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">8</th>
														<th name="day9"  class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">9</th>
														<th name="day10" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">10</th>
														<th name="day11" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">11</th>
														<th name="day12" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">12</th>
														<th name="day13" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">13</th>
														<th name="day14" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">14</th>
														<th name="day15" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">15</th>
														<th name="day16" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">16</th>
														<th name="day17" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">17</th>
														<th name="day18" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">18</th>
														<th name="day19" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">19</th>
														<th name="day20" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">20</th>
														<th name="day21" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">21</th>
														<th name="day22" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">22</th>
														<th name="day23" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">23</th>
														<th name="day24" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">24</th>
														<th name="day25" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">25</th>
														<th name="day26" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">26</th>
														<th name="day27" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">27</th>
														<th name="day28" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">28</th>
														<th name="day29" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">29</th>
														<th name="day30" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">30</th>
														<th name="day31" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:25px;">31</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${rtn.obj}" var="item" varStatus="status">
														<tr role="row" class="odd">
															<!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
															<td class="text-ellipsis text-center" style="width: 140px;"><span class="prod_po_no"><a href="javascript:fn_go_dtl_page('${item.prodSeq}')">${item.prodPoNo}</a></span></td>
															<td class="text-ellipsis text-center" style="width: 200px;"><span class="item_nm">${item.itemNm}</span></td>
															<td class="text-ellipsis text-center" style="width: 80px;"><span class="po_qty"><fmt:formatNumber value="${item.poQty}" pattern="##,###" />개</span></td>
															<td class="text-ellipsis text-center" style="width: 80px;"><span class="actok_qty"><fmt:formatNumber value="${item.actokQty}" pattern="##,###" />개</span></td>
															<td class="text-ellipsis text-center ${ item.day1  == 'END' ? 'th-bgcolor-act-end': (item.day1  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day2  == 'END' ? 'th-bgcolor-act-end': (item.day2  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day3  == 'END' ? 'th-bgcolor-act-end': (item.day3  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day4  == 'END' ? 'th-bgcolor-act-end': (item.day4  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day5  == 'END' ? 'th-bgcolor-act-end': (item.day5  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day6  == 'END' ? 'th-bgcolor-act-end': (item.day6  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day7  == 'END' ? 'th-bgcolor-act-end': (item.day7  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day8  == 'END' ? 'th-bgcolor-act-end': (item.day8  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day9  == 'END' ? 'th-bgcolor-act-end': (item.day9  == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day10 == 'END' ? 'th-bgcolor-act-end': (item.day10 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day11 == 'END' ? 'th-bgcolor-act-end': (item.day11 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day12 == 'END' ? 'th-bgcolor-act-end': (item.day12 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day13 == 'END' ? 'th-bgcolor-act-end': (item.day13 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day14 == 'END' ? 'th-bgcolor-act-end': (item.day14 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day15 == 'END' ? 'th-bgcolor-act-end': (item.day15 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day16 == 'END' ? 'th-bgcolor-act-end': (item.day16 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day17 == 'END' ? 'th-bgcolor-act-end': (item.day17 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day18 == 'END' ? 'th-bgcolor-act-end': (item.day18 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day19 == 'END' ? 'th-bgcolor-act-end': (item.day19 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day20 == 'END' ? 'th-bgcolor-act-end': (item.day20 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day21 == 'END' ? 'th-bgcolor-act-end': (item.day21 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day22 == 'END' ? 'th-bgcolor-act-end': (item.day22 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day23 == 'END' ? 'th-bgcolor-act-end': (item.day23 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day24 == 'END' ? 'th-bgcolor-act-end': (item.day24 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day25 == 'END' ? 'th-bgcolor-act-end': (item.day25 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day26 == 'END' ? 'th-bgcolor-act-end': (item.day26 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day27 == 'END' ? 'th-bgcolor-act-end': (item.day27 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day28 == 'END' ? 'th-bgcolor-act-end': (item.day28 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day29 == 'END' ? 'th-bgcolor-act-end': (item.day29 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day30 == 'END' ? 'th-bgcolor-act-end': (item.day30 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
															<td class="text-ellipsis text-center ${ item.day31 == 'END' ? 'th-bgcolor-act-end': (item.day31 == 'Y' ? 'th-bgcolor-act':'') }" style=""><span class=""></span></td>
														</tr>
													</c:forEach>
													<c:if test="${fn:length(rtn.obj) le 0}">
														<tr>
															<td colspan="${4+search.lastDay}" class="no-data">- 표시할 내용이 없습니다. -</td>
														</tr>
													</c:if>
												</tbody>
											</table>
										</div>
										
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- table card end -->
			</div>
			</main>
		</div>
		
	</div>
	
	
	<form:form commandName="search" id="marRequireListForm" name="marRequireListForm">
		<input type="hidden" name="searchProdSeq" value="" />
	</form:form>
</body>
</html>