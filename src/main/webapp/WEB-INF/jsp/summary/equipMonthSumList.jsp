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
    <title>설비 월별 실적</title>
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
                
                //-------------------------------------------------------------
                // jqery event 
                //-------------------------------------------------------------
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/equipMonthSumListPage.do'/>";
                    frm.submit();
                });
                
                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/equipMonthSumListPage.do'/>";
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
                    frm.action = "<c:url value='/equipMonthSumListPage.do'/>";
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
            frm.action = "<c:url value='/equipMonthSumListPage.do'/>";
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
                    <h1 class="mt-4">설비 월별 실적</h1>
                   
                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>설비별 실적 목록</sapn>
                           <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">  <!-- @@@ style="min-width:3000px;"  -->
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
                                           <div id="dataTable_filter" class="dataTables_filter">
                                               <form:form commandName="search" id="searchForm" name="searchForm">
                                                   <input type="hidden" name="crudType" value="R"/>
                                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                                   <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                                                   <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                                                   <input type="hidden" name="sortType" value="${search.sortType}"/>
                                                   <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                                                   </div>
                                                   
                                                   <div style="float: right; margin: 6px 5px;">
                                                       <input class="form-control" id="searchEquipNm" name="searchEquipNm" type="text" value="${search.searchEquipNm}" placeholder="장비명"/>
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
                                                      <th id="equip_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">설비코드</th>
                                                      <th id="equip_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">설비명</th>
                                                      <th id="month01" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">1월</th>
                                                      <th id="month02" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">2월</th>
                                                      <th id="month03" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">3월</th>
                                                      <th id="month04" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">4월</th>
                                                      <th id="month05" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">5월</th>
                                                      <th id="month06" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">6월</th>
                                                      <th id="month07" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">7월</th>
                                                      <th id="month08" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">8월</th>
                                                      <th id="month09" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">9월</th>
                                                      <th id="month10" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">10월</th>
                                                      <th id="month11" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">11월</th>
                                                      <th id="month12" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">12월</th>
                                                  </tr>
                                              </thead>
                                              <tbody>
                                                  <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="equip_cd">${item.equipCd}</span></td>
                                                        <td class="text-ellipsis"><span class="equip_nm">${item.equipNm}</span></td>
                                                        <td class="text-ellipsis"><span class="month01"><fmt:formatNumber value="${item.month01}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month02"><fmt:formatNumber value="${item.month02}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month03"><fmt:formatNumber value="${item.month03}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month04"><fmt:formatNumber value="${item.month04}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month05"><fmt:formatNumber value="${item.month05}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month06"><fmt:formatNumber value="${item.month06}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month07"><fmt:formatNumber value="${item.month07}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month08"><fmt:formatNumber value="${item.month08}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month09"><fmt:formatNumber value="${item.month09}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month10"><fmt:formatNumber value="${item.month10}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month11"><fmt:formatNumber value="${item.month11}" pattern="#,###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="month12"><fmt:formatNumber value="${item.month12}" pattern="#,###,###"/></span></td>
                                                    </tr>
                                                  </c:forEach>
                                                  
                                                  <c:if test="${fn:length(rtn.obj) le 0}">
                                                    <tr>
                                                        <td colspan="14" class="no-data">- 표시할 내용이 없습니다. -</td>
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