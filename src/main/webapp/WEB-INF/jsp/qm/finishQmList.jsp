<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <title>완제품QM관리</title>
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
                	showOn: "button",
                	buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
                	buttonImageOnly: true,
                	buttonText: "Select date",
                	dateFormat: "yy/mm/dd"
                });

                //-------------------------------------------------------------
                // jqery event
                //-------------------------------------------------------------
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/finishQmListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/finishQmListPage.do'/>";
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
                    frm.action = "<c:url value='/finishQmListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 엑셀 다운로드 이벤트
                //-------------------------------------------------------------
                $('#btnExcel').click(function() {
                	downloadExcelFromTable($('#dataTable'));
                });

                drawQmDtlList = function(prodSeq, workactSeq) {
                	if( cfIsNull(prodSeq) ) {
                		return false;
                	}

                	document.finishQmListForm.prodSeq.value = prodSeq;
                	document.finishQmListForm.workactSeq.value = workactSeq;

                	$.ajax({
                        url : "<c:url value='/getFinishQmListData.do'/>",
                        type: 'POST',
                        data: $('#finishQmListForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){

                            $("#finishQmBodyList tr").remove();
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            if(!cfCheckRtnObj(data.rtn)) return;
                            var html = "";
                            $.each(data.rtn.obj, function(key, val){
                           	 var valObj = JSON.stringify(val).replace(/\"/gi, "\'");

                                html = "";
                                html += "<tr role=\"row\" class=\"odd\" style=\"display:table;width:100%;table-layout:fixed;\">";
                                html += "	<td class=\"text-ellipsis\" style=\"text-align:center;width:25%;\"><span>" + cfAddComma(cfIsNullString(val.checkQty, "0")) + "개</span></td>";
                                html += "	<td class=\"text-ellipsis\" style=\"text-align:center;width:25%;\">";
                                html += "		<span><a href=\"javascript:fn_go_dtl_page(eval(" + valObj + "))\">" + val.qmCheckdt + "</a></span>";
                                html += "	</td>";
                                html += "	<td class=\"text-ellipsis\" style=\"text-align:center;width:25%;\"><span>" + val.qmStateNm + "</span></td>";
                                html += "	<td class=\"text-ellipsis\" style=\"text-align:center;width:26%;\"><span>" + cfAddComma(cfIsNullString(val.actokQty, "0")) + "개</span></td>";
                                html += "	<td class=\"text-ellipsis\" style=\"text-align:center;width:20%;\">";
                                html += "		<span><a href=\"javascript:drawQmBadList(eval(" + valObj + "))\">" + cfAddComma(cfIsNullString(val.actbadQty, "0")) + "개</a></span>";
                                html += "	</td>";
                                html += "</tr>";

                                $("#finishQmBodyList").append(html);
                            });
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                };

                drawQmBadList = function(obj) {
                	$.ajax({
                        url : "<c:url value='/getFinishQmBadListData.do'/>",
                        type: 'POST',
                        data: {mqcSeq: obj.mqcSeq},
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){

                            $("#finishQmBadList tr").remove();
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            if(!cfCheckRtnObj(data.rtn)) return;
                            var html = "";
                            $.each(data.rtn.obj, function(key, val){
                           	 var valObj = JSON.stringify(val).replace(/\"/gi, "\'");

                                html = "";
                                html += "<tr role=\"row\" class=\"odd\" style=\"display:table;width:100%;table-layout:fixed;\">";
                                html += "	<td class=\"text-ellipsis\" style=\"text-align:center;width:60%;\"><span>" + val.badNm + "</span></td>";
                                html += "	<td class=\"text-ellipsis\" style=\"text-align:center;width:40%;\"><span>" + cfAddComma(Number(cfIsNullString(val.badQty, "0"))) + "개</span></td>";
                                html += "</tr>";

                                $("#finishQmBadList").append(html);
                            });
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                };

                //-------------------------------------------------------------
                // onLoad
                //-------------------------------------------------------------
                 $(document).ready(function() {

//                 	 if( "${search.prodSeq}" != "" ) {
// 	                	 $("input[name='rowRadio'][data-prodseq='${search.prodSeq}']").prop("checked", true);
// 	                	 drawQmDtlList("${search.prodSeq}", "${search.workactSeq}");
//                 	 }

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
        // QM추가
        //=====================================================================
        function fn_createQM(prodSeq, workactSeq, mqcSeq, checkQty) {
            if ( parseInt(checkQty) <= 0) {
				alert("잔여량이 없습니다.");
				return false;
			}

            var frm = document.searchForm;
            frm.crudType.value		= "C";
            frm.prodSeq.value		= prodSeq;
            frm.workactSeq.value	= workactSeq;
            frm.mqcSeq.value		= mqcSeq;

            frm.action = "<c:url value='/finishQmDtlPage.do'/>";
            frm.submit();
        }

      	//=====================================================================
        // QM리스트 조회
        //=====================================================================
        function fn_drawQmDtl(prodSeq, workactSeq) {
        	drawQmDtlList(prodSeq, workactSeq);
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

        	frm.action = "<c:url value='/finishQmDtlPage.do'/>";
        	frm.submit();
        }

        //=====================================================================
        // paging
        //=====================================================================
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/finishQmListPage.do'/>";
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
                    <h1 class="mt-4">완제품QM관리</h1>

                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>생산/검품 목록</sapn>
                           <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                           <!-- <div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">완제품QM 추가</div> -->
                           <!-- <div id="btnUpdate" class="btn btn-primary btn-sm mr-2" style="float: right;">완제품QM 변경</div> -->
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
                                                   <input type="hidden" name="prodSeq" value=""/>
                                                   <input type="hidden" name="workactSeq" value=""/>
                                                   <input type="hidden" name="mqcSeq" value=""/>

                                                   <div id="btnSearch" class="button-cr radius blue float-right" style="margin: 6px 5px 0 -44px; position: relative;">
                                                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                                                   </div>
                                                   <div style="float: right; margin: 6px 5px;">
                                                       <input class="form-control" id="searchProdPoNo" name="searchProdPoNo" type="text" value="${search.searchProdPoNo}" placeholder="작업지시번호"/>
                                                   </div>

                                                   <div style="float: right; margin: 6px 5px;">
								                       <input class="form-control" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="입고조회 종료일자"/>
								                   </div>

								                   <div style="float: right; margin: 6px 5px;">
								                       <input class="form-control" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="입고조회 시작일자"/>
								                   </div>
                                               </form:form>
                                           </div>
                                       </div>

                                   </div>
                                   <div class="row">
                                       <!-- style="min-width:3000px;" -->
                                       <div class="col-sm-6">
                                           <!-- table table-striped table-bordered table-hover -->
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="1000%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                              <thead class="thead-dark">
                                                  <tr role="row">
                                                      <!-- <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%; text-align: center;">선택</th> -->
                                                      <th id="worked_dt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%; text-align: center;">생산일자</th>
                                                      <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 11%; text-align: center;">제품</th>
                                                      <th id="prod_wa_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%; text-align: center;">생산실적LOT</th>
                                                      <th id="po_qty" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%; text-align: center;">양품수량</th>
                                                      <th id="work_actqty" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">검품수량</th>
                                                      <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">추가</th>
                                                  </tr>
                                              </thead>

                                              <tbody>
                                                  <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                    <tr role="row" class="odd">
                                                        <%-- <td class="text-ellipsis" style="text-align: center;">
                                                            <input type="radio" name="rowRadio" value="${status.count}" data-prodseq="${item.prodSeq}" data-workactseq="${item.workactSeq}" data-mqcseq="${item.mqcSeq}" data-checkqty="${item.actokQty - item.useCheckQty}"/>
                                                        </td> --%>
                                                        <td class="text-ellipsis text-center">
                                                        <span class="worked_dt">
                                                        <fmt:parseDate value="${item.workedDt}" var="workedDt" pattern="yyyyMMdd"/>
                                                        <fmt:formatDate pattern="yyyy/MM/dd" value="${workedDt}"/></span>
                                                        </td>
                                                        <td class="text-ellipsis text-center"><span class="item_nm">${item.itemNm}</span></td>
                                                        <td class="text-ellipsis text-center"><span class="prod_wa_no">${item.prodWaNo}</span></td>
                                                        <td class="text-ellipsis text-center"><span class="actok_qty"><fmt:formatNumber value="${item.actokQty}" pattern="###,###"/>개</span></td>
                                                        <td class="text-ellipsis text-center"><span class="use_check_qty"><a href="javascript:fn_drawQmDtl('${item.prodSeq}', '${item.workactSeq}');"><fmt:formatNumber value="${item.useCheckQty}" pattern="###,###"/>개</a></span></td>
                                                        <td class="text-ellipsis text-center"><span><a href="javascript:fn_createQM('${item.prodSeq}', '${item.workactSeq}', '${item.mqcSeq}', ${item.actokQty - item.useCheckQty});">검품추가</a></span></td>
                                                    </tr>
                                                  </c:forEach>
                                                  <c:if test="${fn:length(rtn.obj) le 0}">
                                                    <tr>
                                                        <td colspan="6" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                    </tr>
                                                  </c:if>
                                              </tbody>

                                           </table>
                                       </div>

                                       <div class="col-sm-4" style="text-align: center;">
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="Table" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                <thead class="thead-dark" style="display:table;width:100%;table-layout:fixed;">
                                                   <tr role="row">
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;text-align: center;">검품수량</th>
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;text-align: center;">검품일자</th>
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;text-align: center;">분류</th>
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 26%;text-align: center;">양품수량</th>
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;text-align: center;">불량수량</th>
                                                   </tr>
                                               </thead>
                                               <tbody id="finishQmBodyList" style="display:block;max-height:500px;overflow:auto;table-layout:fixed;"/>
                                           </table>
                                       </div>

                                       <div class="col-sm-2" style="text-align: center;">
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="Table" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                <thead class="thead-dark" style="display:table;width:100%;table-layout:fixed;">
                                                   <tr role="row">
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 60%;text-align: center;">불량코드</th>
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 40%;text-align: center;">불량수량</th>
                                                   </tr>
                                               </thead>
                                               <tbody id="finishQmBadList" style="display:block;max-height:500px;overflow:auto;table-layout:fixed;"/>
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

    <form:form commandName="search" id="finishQmListForm" name="finishQmListForm">
    	<input type="hidden" name="prodSeq" value=""/>
    	<input type="hidden" name="workactSeq" value=""/>
	</form:form>
</body>
</html>