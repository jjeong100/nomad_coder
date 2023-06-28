<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"       uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <title>재고 현황</title>
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        //=====================================================================
        // jquery logic
        //=====================================================================
        (function($) {
            $(function(){
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

                //-------------------------------------------------------------
                // jqery event
                //-------------------------------------------------------------
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/itemStockListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/itemStockListPage.do'/>";
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
                    frm.action = "<c:url value='/itemStockListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 엑셀 다운로드 이벤트
                //-------------------------------------------------------------
                $('#btnExcel').click(function() {
                    downloadExcelFromTable($('#dataTable'));
                });

                //-------------------------------------------------------------
                // onLoad
                //-------------------------------------------------------------
                 $(document).ready(function(){
                     $("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
                     if (document.searchForm.sortType.value == 'asc') {
                         $("#${search.sortCol}").attr('class','sorting_asc');
                     } else {
                         $("#${search.sortCol}").attr('class','sorting_desc');
                     }
                     $("#searchFromDate").val("${search.searchFromDate}");
                     $("#searchToDate").val("${search.searchToDate}");

                     /** ajax조회 **/
                     $("#searchItemCd").select2();
                     
                     /** 최상위 올리기 **/
                     $("#btnSearch").css("z-index",9999);
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
            frm.action = "<c:url value='/itemStockListPage.do'/>";
            frm.submit();
        }
        -->
    </script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp" ></jsp:include>
    <div id="layoutSidenav">
        <!-- ==================================================================================================================================== -->
        <!-- menu                                                                                                                                 -->
        <!-- ==================================================================================================================================== -->
        <jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp" ></jsp:include>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <!-- ======================================================================================================================== -->
                    <!-- title                                                                                                                    -->
                    <!-- ======================================================================================================================== -->
                    <h1 class="mt-4">재고 관리</h1>

                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>재고 관리 목록</sapn>
                           <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4 vh-100">  <!-- @@@ style="min-width:3000px;"  -->
                                   <div class="row">
                                       <div class="col-sm-12 col-md-2" style="padding-top:5px;">
                                           <div class="dataTables_length" id="dataTable_length">
                                               <label>Show
                                               <select id="pageSizeItem" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                                                   <option value="10">10</option>
                                                   <option value="25">25</option>
                                                   <option value="50">50</option>
                                                   <option value="100">100</option>
                                               </select> entries
                                               </label>
                                           </div>
                                       </div>

                                       <div class="col-sm-12 col-md-10" style="margin-bottom:5px;">
                                           <div id="dataTable_filter" class="dataTables_wrapper">
                                               <form:form commandName="search" id="searchForm" name="searchForm">
                                                   <input type="hidden" name="crudType" value="R"/>
                                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                                   <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                                                   <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                                                   <input type="hidden" name="sortType" value="${search.sortType}"/>
                                                   <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                                                   </div>

                                                   <div style="float: right; margin: 6px 5px; width:200px">
                                                       <select class="form-control2" id="searchWorkshopCd" name="searchWorkshopCd">
                                                           <option value="">창고 선택</option>
                                                           <c:forEach items="${store_house_list}" var="item" varStatus="status">
                                                           <c:choose>
                                                               <c:when test="${item.workshopCd == search.searchWorkshopCd}">
                                                                   <option value="${item.workshopCd}" selected>${item.workshopNm}</option>
                                                               </c:when>
                                                               <c:otherwise>
                                                                   <option value="${item.workshopCd}">${item.workshopNm}</option>
                                                               </c:otherwise>
                                                           </c:choose>
                                                           </c:forEach>
                                                       </select>
                                                   </div>

                                                   <div style="float:right; margin:6px 5px;width:250px">
                                                       <select class="form-control2" id="searchItemCd" name="searchItemCd">
                                                               <option value="">제품 선택</option>
                                                               <c:forEach items="${product_list}" var="item" varStatus="status">
                                                                    <c:choose>
                                                                        <c:when test="${item.itemCd == search.searchItemCd}">
                                                                            <option value="${item.itemCd}" selected>${item.itemNm}</option>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <option value="${item.itemCd}">${item.itemNm}</option>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                       </select>
                                                   </div>

                                                   <div class="float-right margin-dt">
                                                        <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="수불조회 종료일자" />
                                                    </div>
                                                    <div class="float-right margin-dt">
                                                        <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="수불조회 시작일자" />
                                                    </div>
                                               </form:form>
                                           </div>
                                       </div>

                                   </div>
                                   <div class="row">
                                       <!-- style="min-width:3000px;" -->
                                       <div class="col-sm-12" style="min-width:1200px;">
                                           <!-- table table-striped table-bordered table-hover -->
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                              <thead class="thead-dark">
                                                  <tr role="row">
                                                      <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                      <th id="sb_dt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">일자</th>
                                                      <th id="workshop_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">창고명</th>
                                                      <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">제품명</th>
                                                      <th id="base_qty" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">기초재고</th>
                                                      <th id="item_in_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">(+)입고</th>
                                                      <th id="item_out_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">(-)출고</th>
                                                      <th id="item_out_wait_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">(-)출고대기</th>
<!--                                                       <th id="item_out_can_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">(+)출고취소</th> -->
                                                      <th id="item_disuse_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">(-)폐기</th>
                                                      <th id="item_modify_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">(+)조정수량</th>
                                                      <th id="stock_qty" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">(=)최종재고</th>
                                                  </tr>
                                              </thead>
                                              <tbody>
                                                  <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="sb_dt">
                                                        <fmt:parseDate value="${item.sbDt}" var="sbDt" pattern="yyyyMMdd"/>
                                                        <fmt:formatDate pattern="yyyy/MM/dd" value="${sbDt}"/></span>
                                                        </td>
                                                        <td class="text-ellipsis"><span class="workshop_cd">${item.workshopNm}</span></td>
                                                        <td class="text-ellipsis"><span class="item_nm">${item.itemNm}</span></td>
                                                        <td class="text-ellipsis"><span class="base_qty">${item.baseQty}</span></td>
                                                        <td class="text-ellipsis"><span class="item_out_qty">${item.itemInQty}</span></td>
                                                        <td class="text-ellipsis"><span class="item_out_qty">${item.itemOutQty}</span></td>
                                                        <td class="text-ellipsis"><span class="item_out_wait_qty">${item.itemOutWaitQty}</span></td>
<%--                                                         <td class="text-ellipsis"><span class="item_out_can_qty">${item.itemOutCanQty}</span></td> --%>
                                                        <td class="text-ellipsis"><span class="item_disuse_qty">${item.itemDisuseQty}</span></td>
                                                        <td class="text-ellipsis"><span class="item_modify_qty">${item.itemModifyQty}</span></td>
                                                        <td class="text-ellipsis"><span class="stock_qty">${item.stockQty}</span></td>
                                                    </tr>
                                                  </c:forEach>

                                                  <c:if test="${fn:length(rtn.obj) le 0}">
                                                    <tr>
                                                        <td colspan="10" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                    </tr>
                                                  </c:if>

                                                  <c:if test="${!empty matSumQty}">
                                                      <tr>
                                                        <td colspan="6" style="border:0;"/>
                                                        <td style="text-align:center; font-weight:bold; background-color:#e9ecef;"><span>최종재고</span></td>
                                                        <td colspan="3" style="text-align:center; font-weight:bold;"><span>${matSumQty}</span></td>
                                                      </tr>
                                                  </c:if>
                                              </tbody>
                                           </table>
                                       </div>
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
                                                               <c:if test="${rtn.totCnt <= (search.pageSize*i)}"><c:set var="isLoof" value="false" /></c:if>
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
                   <!-- table card end -->
                </div>
            </main>
        </div>
    </div>

</body>
</html>