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
    <title>작업지시 정보 관리</title>
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
                    frm.action = "<c:url value='/workEquipmentListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/workEquipmentListPage.do'/>";
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
                    frm.action = "<c:url value='/workEquipmentListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 엑셀 다운로드 이벤트
                //-------------------------------------------------------------
                $('#btnExcel').click(function() {
                    downloadExcelFromTable($('#dataTable'));
                });

                //-------------------------------------------------------------
                // row클릭이벤트
                //-------------------------------------------------------------
                drawMatRequireList = function(prodSeq) {
                    document.equipmentForm.prodSeq.value = prodSeq;
                    
                    $.ajax({
                        url : "<c:url value='/getEquipListData.do'/>",
                        type: 'POST',
                        data: $('#equipmentForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#workEquipListBody tr").remove();
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            var frm = document.equipmentForm;
                            if(!cfCheckRtnObj(data.rtn)) return;
                            var html = "";
                                $.each(data.rtn.obj, function(key, val){
                                    html = "";
                                    html += "<tr role=\"row\" class=\"odd\">";
                                    html += "<td class=\"text-ellipsis\" style=\"width: 30%;\"><span>"+val.equipNm+"</span></td>";
                                    html += "<td class=\"text-ellipsis\" style=\"width: 30%;\"><span>"+val.workQty+"</span></td>";
                                    html += "</tr>";

                                    $("#workEquipListBody").append(html);
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
                 $("span[name='btnCreate']").click(function() {
                    document.objForm.prodSeq.value = $(this).data('prodseq');
                    $("#start_work_confirm").dialog( "open" );
                });
            //-------------------------------------------------------------
            // 생산 시작 팝업
            //-------------------------------------------------------------
            $( "#start_work_confirm" ).dialog({
                autoOpen: false,
                modal: true,
                width: 500,
                buttons: [
                    {
                        text: "등록",
                        click: function() {
                            document.objForm.equipCd.value = $("#equipCd").val();
                            document.objForm.workQty.value = $("#workQty").val();
                            if($("#equipCd").val().trim() == ''){
                                    alert(MSG_COM_ERR_001.replace("[@]", " : 장비명"));
                                    $("#equipCd").focus();
                                    return false;
                            }
                            if($("#workQty").val().trim() == ''){
                                    alert(MSG_COM_ERR_001.replace("[@]", " : 배정수량"));
                                    $("#workQty").focus();
                                    return false;
                            }
                               cfAjaxCallAndGoLink("<c:url value='/workEquipmentUpdateAct.do'/>"
                                    ,$('#objForm').serialize(),'등록 되었습니다.'
                                    ,'objForm'
                                    ,"<c:url value='/workEquipmentListPage.do'/>");
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
                     
                     /** 리스트의 첫 번째 클릭 **/
                     fn_select_position("mainLeftListBody",0);
                 });
            });
        })(jQuery);

        //=====================================================================
        // paging
        //=====================================================================
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/workEquipmentListPage.do'/>";
            frm.submit();
        }
        
        //=====================================================================
        // 위치 클릭 
        //=====================================================================
        function fn_select_position(body,index){
//         	var index = parseInt(idx);
            var col01 = $("#"+body+" tr:eq("+index+")>td:eq(0)").children();
            var td    = $("#"+body+" tr").eq(index).children();
            var col02 = td.eq(0).find("input[type=hidden]").val();
            
            if(fn_undefined(col01) != "" && fn_undefined(col02) != "") {
                drawMatRequireList(col02);
            }
        }
        
        //=====================================================================
        // 데이타 null,0 처리
        //=====================================================================
        function fn_undefined(values) {
            var result = "";
            if(values != null && values != 'undefined') result = values;
            
            //0숫자 처리
            if(values == 0) result = "";
            return result;
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
                    <h1 class="mt-4">작업배정</h1>

                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>작업배정 목록</sapn>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
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

                                       <div class=" col-sm-12 col-md-10" style="margin-bottom:5px;">
                                           <div id="dataTable_filter" class="dataTables_wrapper">
                                               <form:form commandName="search" id="searchForm" name="searchForm">
                                                   <input type="hidden" name="crudType"  value="R"/>
                                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                                   <input type="hidden" name="pageSize"  value="${search.pageSize}"/>
                                                   <input type="hidden" name="sortCol"   value="${search.sortCol}"/>
                                                   <input type="hidden" name="sortType"  value="${search.sortType}"/>
                                                   <input type="hidden" name="prodSeq"   value="${search.prodSeq}"/>
                                                   <input type="hidden" name="searchIdx" value="${search.searchIdx}"/>

                                                   <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                                                   </div>
                                                   <div style="float: right; margin: 6px 5px; ">
                                                       <input type="text" class="form-control col-xs-2 input-lg radius" size="35" placeholder="지시LOT" id="searchProdPoNo" name="searchProdPoNo" value="${search.searchProdPoNo}" />
                                                   </div>

                                                   <div class="float-right margin-dt">
                                                       <input class="form-control3 dt-w55 col-xs-2" style="width:200px;" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="입고조회 종료일자"/>
                                                   </div>

                                                   <div class="float-right margin-dt">
                                                       <input class="form-control3 dt-w55 col-xs-2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="입고조회 시작일자"/>
                                                   </div>

                                                   <div style="float: right; margin: 6px 5px;">
                                                       <select class="form-control2" id="searchItemCd" name="searchItemCd" data-size="7" data-live-search="true">
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
                                               </form:form>
                                           </div>
                                       </div>
                                   </div>

                                     <div class="row">
                                       <div class="col-sm-9">
                                            <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width:100%;table-layout:fixed;">
                                              <thead class="thead-dark">  
                                                  <tr role="row">
                                                        <th id="prod_po_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">지시LOT</th>
                                                        <th id="cust_nm"    class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">제품명</th>
                                                        <th id="po_qty"     class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:13%;">완료일자</th>
                                                        <th id="order_qty"  class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:13%;">지시수량</th>
                                                        <th id="po_calldt"  class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:14%;">설비추가</th>
                                                   </tr>
                                               </thead>
                                               <tbody id="mainLeftListBody">
                                                   <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                     <tr role="row" class="odd">
<%--                                                          <td class="text-ellipsis"><span class="prod_po_no"><a href="javascript:drawMatRequireList('${item.prodSeq}')">${item.prodPoNo}</a></span></td> --%>
                                                         <td class="text-ellipsis">
                                                            <input type="hidden" name="prodSeq" value="${item.prodSeq}"/>
                                                            <span class="prod_po_no"><a href="javascript:drawMatRequireList('${item.prodSeq}')">${item.prodPoNo}</a></span>
                                                         </td>
                                                         <td class="text-ellipsis"><span class="item_nm" >${item.itemNm}</span></td>
                                                         <td class="text-ellipsis"><span class="po_targetdt">${item.poTargetdt}</span></td>
                                                         <td class="text-ellipsis"><span class="po_qty"><fmt:formatNumber value="${item.poQty}" pattern="###,###"/>개</span></td>
                                                         <td class="text-ellipsis"><span name="btnCreate" data-prodseq="${item.prodSeq}" class="btn btn-primary btn-sm" style="padding:0.1rem 0.5rem;font-size:0.74rem;">추가</span></td>
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

                                       <div class="col-sm-3">
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                               <thead class="thead-dark">
                                                   <tr role="row">
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">설비명</th>
                                                       <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:23%;">작업배정수량</th>
                                                   </tr>
                                               </thead>
                                                <tbody id="workEquipListBody"/>
                                           </table>
                                       </div>
                                   </div>

                                   <!-- ======================================================================================================================== -->
                                   <!-- paging 20201124 jeonghwan 페이징 위치 왼쪽이동                                                                                                                                                                   -->
                                   <!-- ======================================================================================================================== -->
                                   <div class="row">
                                       <div class="col-sm-12 col-md-9">
                                           <c:if test="${rtn.totCnt > 0}">
                                               <div class="dataTables_info" id="dataTable_info">Showing ${search.firstIndex+1} to ${search.lastIndex} of ${rtn.totCnt} entries</div>
                                           </c:if>

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
        <!-- layoutSidenav_content end -->
    </div>
<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>
<form:form commandName="obj" id="objForm" name="objForm">
   <input type="hidden" name="equipCd" value="" />
   <input type="hidden" name="workQty"     value="" />
   <input type="hidden" name="prodSeq"     value="" />
</form:form>
 <div id="start_work_confirm" title="설비지정" style="display:none;overflow:hidden;">
        <div class="col-md-12">
            <div class="form-row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="small mb-1" for="equip_cd">장비명</label>
                        <div class="form-row">
                            <select class="form-control2 col-11" id="equipCd" >
                                <option value="">장비 선택</option>
                                <c:forEach items="${equip_list}" var="item" varStatus="status">
                                    <option value="${item.equipCd}">${item.equipNm}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="small mb-1" for="work_qty">배정수량</label>
                        <div class="form-row">
                            <input class="form-control2 col-12 worker" id="workQty" name="workQty" type="text" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 

<form:form commandName="equipment" id="equipmentForm" name="equipmentForm">
    <input type="hidden" name="prodSeq" value=""/>
</form:form>
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