<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <title>Lot Tracking</title>
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


                // 바코드 스캔 이벤트
                $(document).scannerDetection({
                    timeBeforeScanTest: 200, // wait for the next character for upto 200ms
                    avgTimeByChar: 100, // it's not a barcode if a character takes longer than 100ms
                    onComplete: function(barcode, qty){
                        //$('#lotid').val(barcode);
                        if( barcode.length < 15 ) {
                        	cfAlert("바코드스캔은 영문변환 후 사용 가능합니다.");
                        	return false;
                        }

                        $("#searchLotId").val(barcode)
                        var frm = document.searchForm;
                         frm.pageIndex.value = 1;
                         frm.action = "<c:url value='/lotTrackingListPage.do'/>";
                          frm.submit();
                    } // main callback function
                });



                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/lotTrackingListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/lotTrackingListPage.do'/>";
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
                    frm.action = "<c:url value='/lotTrackingListPage.do'/>";
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
            frm.action = "<c:url value='/lotTrackingListPage.do'/>";
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
                    <h1 class="mt-4">Lot Tracking</h1>

                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>조회하고자하는 바코드를 입력/스캔하세요</sapn>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                   <div class="row">

                                       <div class="col-sm-12 col-md-12" style="margin-bottom:5px;">
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
                                                       <input class="form-control" size="35" id="searchLotId" name="searchLotId" type="text" value="${search.searchLotId}" placeholder="LOTID를 입력하세요"/>
                                                   </div>
                                               </form:form>
                                           </div>
                                       </div>

                                   </div>

                                   <!-- div row [s] -->
                                   <div class="row">
                                           <div class="card mb-4">
                                            <div class="card-header">
                                                <sapn class="txt20">제품정보</sapn>
                                            </div>

                                            <div class="card-body">
                                               <div class="col-sm-12" style="min-width:1100px;">
                                                   <!-- table table-striped table-bordered table-hover -->
                                                   <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                      <thead class="thead-dark">
                                                          <tr role="row">
                                                              <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                              <th id="item_cd" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">제품코드</th>
                                                              <th id="item_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">품명</th>
                                                              <!-- <th id="cust_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">고객사</th> -->
                                                              <th id="po_qty" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">지시수량</th>
                                                              <th id="actok_qty" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">실적수량</th>
                                                              <th id="worked_dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">생산일자</th>
                                                          </tr>
                                                      </thead>
                                                      <tbody>
                                                          <c:forEach items ="${item_list}" var="item" varStatus="status">
                                                            <tr role="row" class="odd">
                                                                <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                                <td class="text-ellipsis"><span class="item_cd">${item.itemCd}</span></td>
                                                                <td class="text-ellipsis"><span class="item_nm">${item.itemNm}</span></td>
                                                                <%-- <td class="text-ellipsis"><span class="cust_nm">${item.custNm}</span></td> --%>
                                                                <td class="text-ellipsis"><span class="po_qty">${item.poQty}</span></td>
                                                                <td class="text-ellipsis"><span class="actok_qty">${item.actokQty}</span></td>
                                                                <td class="text-ellipsis"><span class="worked_dt">${item.workedDt}</span></td>
                                                            </tr>
                                                          </c:forEach>

                                                          <c:if test="${fn:length(item_list) le 0}">
                                                            <tr>
                                                                <td colspan="5" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                            </tr>
                                                          </c:if>

                                                      </tbody>
                                                   </table>
                                               </div>
                                            </div>
                                        </div>
                                   </div>
                                   <!-- div row [e] -->

                                   <!-- div row [s] -->
                                   <div class="row">
                                           <div class="card mb-4">
                                            <div class="card-header">
                                                <sapn class="txt20">자재정보</sapn>
                                            </div>

                                            <div class="card-body">
                                                   <div class="col-sm-12" style="min-width:1100px;">
                                                   <!-- table table-striped table-bordered table-hover -->
                                                   <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                      <thead class="thead-dark">
                                                          <tr role="row">
                                                              <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                              <th id="gubun" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">구분</th>
                                                              <th id="dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">일자</th>
                                                              <th id="qty" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">수량</th>
                                                              <th id="lotid" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">LOTNo.</th>
                                                              <th id="prod_po_no" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">생산지시번호</th>
                                                              <th id="mat_cust_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재처</th>
                                                              <th id="mat_cd" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재코드</th>
                                                              <th id="mat_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재명</th>
                                                          </tr>
                                                      </thead>
                                                      <tbody>
                                                          <c:forEach items ="${mat_list}" var="item" varStatus="status">
                                                            <tr role="row" class="odd">
                                                                <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                                <td class="text-ellipsis"><span class="gubun">${item.gubun}</span></td>
                                                                <td class="text-ellipsis"><span class="dt">${item.dt}</span></td>
                                                                <td class="text-ellipsis"><span class="qty">${item.qty}</span></td>
                                                                <td class="text-ellipsis"><span class="lotid">${item.lotid}</span></td>
                                                                <td class="text-ellipsis"><span class="prod_po_no">${item.prodPoNo}</span></td>
                                                                <td class="text-ellipsis"><span class="mat_cust_nm">${item.matCustNm}</span></td>
                                                                <td class="text-ellipsis"><span class="mat_cd">${item.matCd}</span></td>
                                                                <td class="text-ellipsis"><span class="mat_nm">${item.matNm}</span></td>
                                                            </tr>
                                                          </c:forEach>

                                                          <c:if test="${fn:length(mat_list) le 0}">
                                                            <tr>
                                                                <td colspan="8" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                            </tr>
                                                          </c:if>

                                                      </tbody>
                                                   </table>
                                               </div>
                                            </div>
                                        </div>
                                   </div>
                                   <!-- div row [e] -->

                                   <!-- div row [s] -->
                                   <div class="row">
                                           <div class="card mb-4">
                                            <div class="card-header">
                                                <sapn class="txt20">공정실적</sapn>
                                            </div>

                                            <div class="card-body">
                                                   <div class="col-sm-12" style="min-width:1100px;">
                                                   <!-- table table-striped table-bordered table-hover -->
                                                   <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                      <thead class="thead-dark">
                                                          <tr role="row">
                                                              <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                              <th id="work_dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업일자</th>
                                                              <th id="oper_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업공정</th>
                                                              <th id="sabun_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업자</th>
                                                              <th id="workst_dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">시작일시</th>
                                                              <th id="worked_dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">종료일시</th>
                                                              <th id="actok_qty" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업수량</th>
                                                              <th id="actbad_qty" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">불량수량</th>
                                                          </tr>
                                                      </thead>
                                                      <tbody>
                                                          <c:forEach items ="${workSum_list}" var="item" varStatus="status">
                                                            <tr role="row" class="odd">
                                                                <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                                <td class="text-ellipsis"><span class="work_dt">${item.workDt}</span></td>
                                                                <td class="text-ellipsis"><span class="oper_nm">${item.operNm}</span></td>
                                                                <td class="text-ellipsis"><span class="sabun_nm">${item.sabunNm}</span></td>
                                                                <td class="text-ellipsis"><span class="workst_dt">${item.workstDt}</span></td>
                                                                <td class="text-ellipsis"><span class="worked_dt">${item.workedDt}</span></td>
                                                                <td class="text-ellipsis"><span class="actok_qty">${item.actokQty}</span></td>
                                                                <td class="text-ellipsis"><span class="actbad_qty">${item.actbadQty}</span></td>
                                                            </tr>
                                                          </c:forEach>

                                                          <c:if test="${fn:length(workSum_list) le 0}">
                                                            <tr>
                                                                <td colspan="7" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                            </tr>
                                                          </c:if>

                                                      </tbody>
                                                   </table>
                                                </div>
                                            </div>
                                           </div>
                                   </div>
                                   <!-- div row [e] -->

                                   <!-- div row [s] -->
                                   <div class="row">
                                       <div class="card mb-4">
                                            <div class="card-header">
                                                <sapn class="txt20">출하정보</sapn>
                                            </div>

                                            <div class="card-body">
                                                   <div class="col-sm-12" style="min-width:1100px;">
                                                   <!-- table table-striped table-bordered table-hover -->
                                                   <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                      <thead class="thead-dark">
                                                          <tr role="row">
                                                              <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                              <th id="work_dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">출하일자</th>
                                                              <th id="oper_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">고객사</th>
                                                              <th id="sabun_nm" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">출하수량</th>
                                                              <th id="workst_dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">박스수량</th>
                                                              <th id="worked_dt" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">출하자</th>
                                                          </tr>
                                                      </thead>
                                                      <tbody>
                                                          <c:forEach items ="${itemOut_list}" var="item" varStatus="status">
                                                            <tr role="row" class="odd">
                                                                <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                                <td class="text-ellipsis"><span class="work_dt">${item.itemoutDt}</span></td>
                                                                <td class="text-ellipsis"><span class="oper_nm">${item.custNm}</span></td>
                                                                <td class="text-ellipsis"><span class="sabun_nm">${item.outQty}</span></td>
                                                                <td class="text-ellipsis"><span class="worked_dt">${item.boxCnt}</span></td>
                                                                <td class="text-ellipsis"><span class="sabunNm">${item.sabunNm}</span></td>
                                                            </tr>
                                                          </c:forEach>

                                                          <c:if test="${fn:length(itemOut_list) le 0}">
                                                            <tr>
                                                                <td colspan="5" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                            </tr>
                                                          </c:if>

                                                      </tbody>
                                                   </table>
                                               </div>
                                           </div>
                                       </div>
                                   </div>
                                   <!-- div row [e] -->

                               </div>
                           </div>
                       </div>
                   </div>
                   <!-- table card end -->
                </div>
            </main>
        </div>
    </div>
<script>
$( "#searchFromDate" ).datepicker({
    showOn: "button",
    buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
    buttonImageOnly: true,
    buttonText: "Select date"
  });
$( "#searchFromDate" ).datepicker("option", "dateFormat", "yy/mm/dd");

$( "#searchToDate" ).datepicker({
    showOn: "button",
    buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
    buttonImageOnly: true,
    buttonText: "Select date"
  });
$( "#searchToDate" ).datepicker("option", "dateFormat", "yy/mm/dd");
</script>
</body>
</html>