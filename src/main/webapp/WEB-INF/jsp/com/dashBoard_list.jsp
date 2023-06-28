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
<title>Dashboard 관리</title>
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
			var refreshTimer;

			//-------------------------------------------------------------
			// jqery event 
			//-------------------------------------------------------------
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
				
				fn_paging();
			});

			//-------------------------------------------------------------
			// onLoad  
			//-------------------------------------------------------------
			$(document).ready(function() {
				fn_paging();
				fn_timer_start();
			});
		});
	})(jQuery);

	function fn_timer_start() {
		refreshTimer = setInterval(function() {
			fn_paging();
		}, 10000);
	}
	
	function fn_paging() {
         $.ajax({
			url : "<c:url value='/getDashboardProductionMonthListData.do'/>",
			type : 'POST',
			data : $('#searchForm').serialize(),
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			context : this,
			dataType : 'json',
			beforeSend : function() {
				$("#dashboardProductionMonthList tr").remove();
			},
			success : function(data) {
				if(!cfCheckRtnObj(data.rtn)) return;
				var monthListHtml = "";
				
				$.each(data.productionMonthList, function(key, val) {
					monthListHtml += "<tr role=\"row\" class=\"odd\">";
					monthListHtml += "	<td class=\"text-ellipsis text-center\" style=\"width: 140px;\"><span class=\"prod_po_no\">" + val.prodPoNo + "</span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center\" style=\"width: 200px;\"><span class=\"item_nm\">" + val.itemNm + "</span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center\" style=\"width: 80px;\"><span class=\"po_qty\">" + val.poQty + "개</span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center\" style=\"width: 80px;\"><span class=\"actok_qty\">" + val.actokQty + "개</span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day1  == "END" ? "th-bgcolor-act-end":(val.day1   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day2  == "END" ? "th-bgcolor-act-end":(val.day2   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day3  == "END" ? "th-bgcolor-act-end":(val.day3   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day4  == "END" ? "th-bgcolor-act-end":(val.day4   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day5  == "END" ? "th-bgcolor-act-end":(val.day5   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day6  == "END" ? "th-bgcolor-act-end":(val.day6   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day7  == "END" ? "th-bgcolor-act-end":(val.day7   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day8  == "END" ? "th-bgcolor-act-end":(val.day8   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day9  == "END" ? "th-bgcolor-act-end":(val.day9   == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day10 == "END" ? "th-bgcolor-act-end":(val.day10  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day11 == "END" ? "th-bgcolor-act-end":(val.day11  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day12 == "END" ? "th-bgcolor-act-end":(val.day12  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day13 == "END" ? "th-bgcolor-act-end":(val.day13  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day14 == "END" ? "th-bgcolor-act-end":(val.day14  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day15 == "END" ? "th-bgcolor-act-end":(val.day15  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day16 == "END" ? "th-bgcolor-act-end":(val.day16  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day17 == "END" ? "th-bgcolor-act-end":(val.day17  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day18 == "END" ? "th-bgcolor-act-end":(val.day18  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day19 == "END" ? "th-bgcolor-act-end":(val.day19  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day20 == "END" ? "th-bgcolor-act-end":(val.day20  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day21 == "END" ? "th-bgcolor-act-end":(val.day21  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day22 == "END" ? "th-bgcolor-act-end":(val.day22  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day23 == "END" ? "th-bgcolor-act-end":(val.day23  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day24 == "END" ? "th-bgcolor-act-end":(val.day24  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day25 == "END" ? "th-bgcolor-act-end":(val.day25  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day26 == "END" ? "th-bgcolor-act-end":(val.day26  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day27 == "END" ? "th-bgcolor-act-end":(val.day27  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day28 == "END" ? "th-bgcolor-act-end":(val.day28  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day29 == "END" ? "th-bgcolor-act-end":(val.day29  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day30 == "END" ? "th-bgcolor-act-end":(val.day30  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	             	monthListHtml += "	<td class=\"text-ellipsis text-center " + (val.day31 == "END" ? "th-bgcolor-act-end":(val.day31  == "Y" ? "th-bgcolor-act":""))+ "\" style=\"\"><span class=\"\"></span></td>";
	            	monthListHtml += "</tr>";
	            });
	            
				
				if( monthListHtml == "" ) {
					monthListHtml += "<tr>";
					monthListHtml += "	<td colspan=\"" + (4 + data.search.lastDay) + "\" class=\"no-data\">- 표시할 내용이 없습니다. -</td>";
					monthListHtml += "</tr>";
				}
			
	            $("#dashboardProductionMonthList").append(monthListHtml);
	              
	            var lastDay = data.search.lastDay;
	            for(var i=31; i>lastDay; i--) {
	            	$("#dataTable tr > *:nth-child(" + (4 + i) + ")").hide();
	            }
	            
              	$("#spaMonthText").text(data.search.searchFromDate.substring(4, 6) + "월 생산지시현황");
				
				// 에러 얼럿창이 떠있는경우 삭제
				$("#glv-dialog-alert-dynamic").remove();
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

	function fn_timer_stop() {
		clearInterval(refreshTimer);
	}

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
				<h1 class="mt-4">Dashboard</h1>
				<div id="divProductionChart" class="row">
					<div class="col-xl-12 col-md-12">
						<div class="card mb-4">
							<div class="card-header">
								<div class="col-sm-12 form-inline">
									<div id="divMonth_minus" name="minus" class="mr-2"><span class="btn btn-sm btn-dark" style=""> < </span></div>
									<sapn id="spaMonthText">${fn:substring(search.searchFromDate,4,6)}월 생산지시현황</sapn>
									<div id="divMonth_plus" name="plus" class="ml-2"><span class="btn btn-sm btn-dark" style=""> > </span></div>
								</div>
							</div>
							<div class="card-body">
								<div id="chart_production_div"></div>
							</div>
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
								<div class=" col-sm-12 col-md-10" style="margin-bottom: 5px; display: none;">
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
													<th name="day1" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">1</th>
													<th name="day2" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">2</th>
													<th name="day3" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">3</th>
													<th name="day4" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">4</th>
													<th name="day5" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">5</th>
													<th name="day6" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">6</th>
													<th name="day7" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">7</th>
													<th name="day8" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">8</th>
													<th name="day9" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">9</th>
													<th name="day10" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">10</th>
													<th name="day11" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">11</th>
													<th name="day12" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">12</th>
													<th name="day13" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">13</th>
													<th name="day14" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">14</th>
													<th name="day15" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">15</th>
													<th name="day16" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">16</th>
													<th name="day17" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">17</th>
													<th name="day18" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">18</th>
													<th name="day19" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">19</th>
													<th name="day20" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">20</th>
													<th name="day21" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">21</th>
													<th name="day22" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">22</th>
													<th name="day23" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">23</th>
													<th name="day24" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">24</th>
													<th name="day25" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">25</th>
													<th name="day26" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">26</th>
													<th name="day27" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">27</th>
													<th name="day28" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">28</th>
													<th name="day29" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">29</th>
													<th name="day30" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">30</th>
													<th name="day31" class="text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25px;">31</th>
												</tr>
											</thead>
											<tbody id="dashboardProductionMonthList">
												<%-- <c:forEach items="${rtn.obj}" var="item" varStatus="status">
													<tr role="row" class="odd">
														<td class="text-ellipsis text-center" style="width: 140px;"><span class="prod_po_no">${item.prodPoNo}</span></td>
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
												</c:if> --%>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- card end -->
			</div>
			</main>
		</div>
	</div>
	<script>
		
	</script>
</body>
</html>