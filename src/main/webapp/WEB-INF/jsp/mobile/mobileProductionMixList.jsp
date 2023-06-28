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
    <title>PowerMES</title>
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
                $('#btnClose').click(function() {
                    var frm = document.searchForm;
                    frm.action = "<c:url value='/mobileMenuPage.do'/>";
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
                    frm.action = "<c:url value='/mobileProductionMixListPage.do'/>";
                    frm.submit();
                });
                
              	//-------------------------------------------------------------
                // 작업지시일자 변경 이벤트
                //------------------------------------------------------------- 
                $('#searchWorkDt').change(function() {
	                var frm = document.searchForm;
	                frm.workDt.value = $("#searchWorkDt").val();
	                frm.action = "<c:url value='/mobileProductionMixListPage.do'/>";
	                frm.submit();
                });
                
                //-------------------------------------------------------------
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                	 $('#shortId').val(SHORT_ID);
                	 if (document.searchForm.sortType.value == 'asc') {
                         $("#${search.sortCol}").attr('class','sorting_asc'); 
                     } else {
                         $("#${search.sortCol}").attr('class','sorting_desc');
                     }
                 });
                
                
                 $( "#start_work_confirm" ).dialog({
                     autoOpen: false,
                     width: 400,
                     buttons: [
                         {
                             text: "확인",
                             click: function() {
                                 $( this ).dialog( "close" );
                                 
                                 $.ajax({
                                     url : "<c:url value='/productionActUpdateAct.do'/>",
                                     type: 'POST',
                                     data: $('#productionActForm').serialize(),
                                     contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                                     context:this,
                                     dataType:'json',
                                     beforeSend:function(){
                                         $("#layoutSidenav").loading();
                                     },
                                     success: function(data) {
                                         if(!cfCheckRtnObj(data.rtn)) return;
                                         cfAlert('배합 완료 되었습니다.');
                                         var frm = document.searchForm;
                                         frm.action = "<c:url value='/mobileProductionMixListPage.do'/>";
                                         frm.submit();
                                     },
                                     error: function(request, status, error){
                                         console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                                         cfAlert('시스템 오류입니다.');
                                     },
                                     complete:function(){
                                         $("#layoutSidenav").loadingClose();
                                     }
                                 });
                             }
                         },
                         {
                             text: "취소",
                             click: function() {
                                 $( this ).dialog( "close" );
                             }
                         }
                     ]
                 });
                 
            });
        })(jQuery);
        
        //=====================================================================
        // button action funtion
        //===================================================================== 
        function fn_mix_start(workactSeq, operCd, poQty) {
        	document.productionActForm.workactSeq.value = workactSeq;
        	document.productionActForm.operCd.value = operCd;
            document.productionActForm.actokQty.value = poQty;
            document.productionActForm.prodTypeCd.value = 'ING';
            document.productionActForm.crudType.value = 'START';
        	$( "#start_work_confirm" ).dialog( "open" );
        }
        
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/mobileProductionMixListPage.do'/>";
            frm.submit();
        }
        
        
        -->
    </script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
    
    <div class="card">
        <div class="card-header">
            <sapn>배합 작업지시 </sapn>
            <div id="btnClose" class="btn-logout mr-2" style="float: right;"><i class="xi-close-circle-o"></i> 닫기</div>
        </div>
        <div class="card-body card-roundbox pr-sm-5 pl-sm-5">
             <h1 class="body-header">작업공정 : 배합 <div class="date-span">작업지시일자 &nbsp;&nbsp;<input class="card-roundbox" id="searchWorkDt" name="searchWorkDt" style="height: 40px; font-size:x-large; text-align: center;" value="" size="9"></div></h1>
          
            <div class="row" style="margin-bottom:5px;">
                <div class="table-responsive">
                    <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">  <!-- @@@ style="min-width:3000px;"  -->
                        <div class="row">
                            <div class="col-sm-12 col-md-2" style="padding-top:5px;">
                            </div>
                            <div class="col-sm-12 col-md-10" style="margin-bottom:5px;">
                                <div id="dataTable_filter" class="dataTables_filter">
                                    <form:form commandName="search" id="searchForm" name="searchForm">
                                        <input type="hidden" name="crudType" value="R"/>
                                        <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                        <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                                        <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                                        <input type="hidden" name="sortType" value="${search.sortType}"/>
                                        <input type="hidden" name="workDt" value="${search.workDt}"/>
                                    </form:form>
                                </div> 
                            </div>
                        </div>
                        <div class="row">
                            <!-- style="min-width:3000px;" -->
                            <div class="col-sm-12" style="min-width:1000px;">
                                <!-- table table-striped table-bordered table-hover -->
                                <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                   <thead class="thead-dark">
                                       <tr role="row">
                                           <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                           <th id="prod_po_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">작지번호</th>
                                           <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">제품</th>
                                           <th id="cust_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">납품업체</th>
                                           <th id="oper_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">공정</th>
                                           <th id="work_dt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업일자</th>
                                           <th id="prod_type_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업상태</th>
                                           <th id="workst_dt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">시작시간</th>
                                           <th id="po_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">계획수량</th>
                                       </tr>
                                   </thead>

                                   <tbody>
                                       <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                         <tr role="row" class="odd">
                                             <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                             <td class="text-ellipsis"><span class="prod_po_no">${item.prodPoNo}</span></td>
                                             <td class="text-ellipsis"><span class="item_nm">${item.itemNm}</span></td>
                                             <td class="text-ellipsis"><span class="cust_nm">${item.custNm}</span></td>
                                             <td class="text-ellipsis"><span class="oper_nm">${item.operNm}</span></td>
                                             <td class="text-ellipsis"><span class="work_dt">${item.workDt}</span></td>
                                             <c:choose>
                                                 <c:when test="${item.prodTypeCd == 'WAT'}">
                                                     <td class="text-ellipsis"><span class="prod_type_nm"><a href="javascript:fn_mix_start('${item.workactSeq}','${item.operCd}','${item.poQty}')">${item.prodTypeNm}</a></span></td>
                                                 </c:when>
                                                 <c:otherwise>
                                                     <td class="text-ellipsis"><span class="prod_type_nm">${item.prodTypeNm}</span></td>
                                                 </c:otherwise>
                                             </c:choose>
                                             <td class="text-ellipsis"><span class="workst_dt">${item.workstHour}</span></td>
                                             <td class="text-ellipsis"><span class="po_qty"><fmt:formatNumber value="${item.poQty}" pattern="###,###"/></span></td>
                                         </tr>
                                       </c:forEach>
                                       <c:if test="${fn:length(rtn.obj) le 0}">
                                         <tr>
                                             <td colspan="8" class="no-data">- 표시할 내용이 없습니다. -</td>
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
    </div>

<form:form commandName="productionAct" id="productionActForm" name="productionActForm">
    <input type="hidden" id="shortId" name="shortId" value=""/>
    <input type="hidden" name="workactSeq" value=""/>
    <input type="hidden" name="operCd" value=""/>
    <input type="hidden" name="prodTypeCd" value=""/>
    <input type="hidden" name="actokQty" value=""/>
    <input type="hidden" name="crudType" value=""/>
</form:form>
<div id="start_work_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p>배합 작업 처리  하시겠습니까 ?</p>
    </div>
</div> 
<script>
$( "#searchWorkDt" ).datepicker({ 
    showOn: "button",
    buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
    buttonImageOnly: true,
    buttonText: "Select date"
  });
$( "#searchWorkDt" ).datepicker("option", "dateFormat", "yy/mm/dd").datepicker("setDate", "${search.workDt}");
</script>
</body>
</html>