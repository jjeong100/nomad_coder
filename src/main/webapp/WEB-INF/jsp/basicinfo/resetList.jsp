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
    <title>개발</title>
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
                    frm.action = "<c:url value='/resetListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 삭제 이벤트
                //-------------------------------------------------------------

                $("#glv_del_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "확인",
                            click: function() {
                                $( this ).dialog( "close" );
                                document.objForm.crudType.value = 'D';
                                cfAjaxCallAndGoLink("<c:url value='/deleteCleanAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/resetListPage.do'/>");
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
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/resetListPage.do'/>";
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
                    frm.action = "<c:url value='/resetListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 엑셀 다운로드 이벤트
                //-------------------------------------------------------------
                $('#btnExcel').click(function() {
                    downloadExcelFromTable($('#dataTable'));
                });

                
                $("#glv_del_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "확인",
                            click: function() {
                                $( this ).dialog( "close" );
                                document.objForm.crudType.value = 'D';
                                cfAjaxCallAndGoLink("<c:url value='/deleteCleanAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/resetListPage.do'/>");
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
                 });
            });
        })(jQuery);

        //=====================================================================
        // paging
        //=====================================================================
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/resetListPage.do'/>";
            frm.submit();
        }

        function fn_click_event(deleteType) {
            var frm = document.objForm;
            frm.deleteType.value = deleteType;
            $( "#glv_del_confirm" ).dialog( "open" );
        }
        
        function fn_group_click_even() {
            var frm = document.objForm;
            
            if(confirm("삭제하시겠습니까?")) {
                $("#deleteListBody tr").each(function(idx,value){
                     var tr = $(this); // 현재 클릭된 row
                     var td = tr.children();
                    
                     if(td.eq(0).text().indexOf("✓") != -1) {
                         var spanId = td.eq(4).children().find("span").attr("id");
                         
                         $.ajax({
                             url : "<c:url value='/deleteCleanAct.do'/>",
                             type: 'POST',
                             data: {"deleteType":spanId},
                             contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                             context:this,
                             dataType:'json',
                             beforeSend:function(){
                                 $("#layoutSidenav").loading();
                             },
                             success: function(data) {
                                 if(!cfCheckRtnObj(data.rtn)) return;
                                 cfAlert("삭제되었습니다.");
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
                 });

            
//             frm.deleteType.value = deleteType;
           // $( "#glv_del_confirm" ).dialog( "open" );
            }
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
                    <h1 class="mt-4">데이터 관리</h1>

                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>초기화 목록</sapn>
                           <div id="btnDelete" class="btn btn-primary btn-sm mr-2" style="float: right;" onclick="javaScrip:fn_group_click_even();">체크일괄삭제</div>
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
                                        <div><font color="red" size="5">※삭제된 데이타는 복구되지 않습니다. 확인하시고 삭제하십시요.</font></div>

                                       <div class="col-sm-12 col-md-10" style="margin-bottom:5px;">
                                           <div id="dataTable_filter" class="dataTables_filter">
                                               <form:form commandName="search" id="searchForm" name="searchForm">
                                                   <input type="hidden" name="crudType"  value="R"/>
                                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                                   <input type="hidden" name="pageSize"  value="${search.pageSize}"/>
                                                   <input type="hidden" name="sortCol"   value="${search.sortCol}"/>
                                                   <input type="hidden" name="sortType"  value="${search.sortType}"/>
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
                                                      <th id="rnum"    class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:5%;">No</th>
                                                      <th id="subject" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:20%;">항목</th>
                                                      <th id="content" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">삭제테이블명</th>
                                                      <th id="content" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">삭제테이블</th>
                                                      <th id="botton"  class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:15%;">데이타삭제</th>

                                                  </tr>
                                              </thead>

                                              <tbody id="deleteListBody">
                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">1[✓]</span></td>
                                                        <td class="text-ellipsis"><span class="subject">자재 클린</span></td>
                                                        <td class="text-ellipsis"><span class="content">자재 입고,자재 출고,기초 재고,마감</span></td>
                                                        <td class="text-ellipsis"><span class="table">MMA022, MMA024, MMA025, MMA026 MWP001, MWP005</span></td>
                                                        <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteMaterial');"><span id="deleteMaterial" class="button-cr radius blue" style="display:inline-block;width:100%;">자재클린</span></a></span></td>
                                                    </tr>

                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">2[✓]</span></td>
                                                        <td class="text-ellipsis"><span class="subject">BOM 클린</span></td>
                                                        <td class="text-ellipsis"><span class="content">BOM version 채번,BOM ,BOM 검사항목,BOM history,BOM backup, 외주 Bom</span></td>
                                                        <td class="text-ellipsis"><span class="table">MCC013, MCC020, MCC050, MCC021, MCC022, MWP006, MCC015</span></td>
                                                        <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteBom');"><span id="deleteBom" class="button-cr radius blue" style="display:inline-block;width:100%;">BOM클린</span></a></span></td>
                                                    </tr>

                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">3[✓]</span></td>
                                                        <td class="text-ellipsis"><span class="subject">생산지시  클린</span></td>
<!--                                                         <td class="text-ellipsis"><span class="content">생산 지시,생산 실적,검사(자주/패트롤),자재 소요량</span></td> -->
                                                        <td class="text-ellipsis"><span class="content">생산 지시,생산 실적,검사결과(강동),자재 소요량,생산지시계획, 배정</span></td>
                                                        <td class="text-ellipsis"><span class="table">MPO009, MPO011, MPO012, MPO007, MPO010, MPO008</span></td>
                                                        <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteOrder');"><span id="deleteOrder" class="button-cr radius blue" style="display:inline-block;width:100%;">생산클린</span></a></span></td>
                                                    </tr>

                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">4[✓]</span></td>
                                                        <td class="text-ellipsis"><span class="subject">제품 입/출고 클린</span></td>
                                                        <td class="text-ellipsis"><span class="content">QM 검품,제품 입고,제품 입고 디테일 ,제품 출고,제품 출고 디테일</span></td>
                                                        <td class="text-ellipsis"><span class="table">MQC001, MWP012, MWP013, MWP015, MWP016, MWI001</span></td>
                                                        <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteInOut');"><span id="deleteInOut" class="button-cr radius blue" style="display:inline-block;width:100%;">입/출고클린</span></a></span></td>
                                                    </tr>

                                                     <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">5[✓]</span></td>
                                                        <td class="text-ellipsis"><span class="subject">제품 입/출고 클린(검품제외)</span></td>
                                                        <td class="text-ellipsis"><span class="content">제품 입고,제품 입고 디테일 ,제품 출고,제품 출고 디테일</span></td>
                                                        <td class="text-ellipsis"><span class="table">MWP012, MWP013, MWP015, MWP016, MWI001</span></td>
                                                        <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteInOutNotConf');"><span id="deleteInOutNotConf" class="button-cr radius blue" style="display:inline-block;width:100%;">입/출고클린(검품제외)</span></a></span></td>
                                                    </tr>
                                                    
                                                      <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">6[✓]</span></td>
                                                        <td class="text-ellipsis"><span class="subject">자재출고</span></td>
                                                        <td class="text-ellipsis"><span class="content">자재 출고,기초 재고, 그밖에..</span></td>
                                                        <td class="text-ellipsis"><span class="table">MMA024, MWP001, MMA025, MMA026</span></td>
                                                        <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteMaterialOut');"><span id="deleteMaterialOut" class="button-cr radius blue" style="display:inline-block;width:100%;">자재출고 클린</span></a></span></td>
                                                    </tr>

<!--                                                     <tr role="row" class="odd"> -->
<!--                                                         엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
<!--                                                         <td class="text-ellipsis"><span class="rnum">7[✓]</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="subject">외주 클린</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="content">외주 입고,외주 출고</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="table">MWP010, MWP017</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteOutsourcing');"><span id="deleteOutsourcing" class="button-cr radius blue" style="display:inline-block;width:100%;">외주 클린(Bom제외)</span></a></span></td> -->
<!--                                                     </tr> -->

<!--                                                       <tr role="row" class="odd"> -->
<!--                                                         엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
<!--                                                         <td class="text-ellipsis"><span class="rnum">8[✓]</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="subject">외주 입고</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="content">외주 입고</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="table">MWP010</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteOutsourcingIn');"><span id="deleteOutsourcingIn" class="button-cr radius blue" style="display:inline-block;width:100%;">외주입고 클린</span></a></span></td> -->
<!--                                                     </tr> -->

<!--                                                       <tr role="row" class="odd"> -->
<!--                                                         엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
<!--                                                         <td class="text-ellipsis"><span class="rnum">9[✓]</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="subject">불량 클린</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="content">불량 관리</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="table">MWP018,MBM001,MBM002</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteOutsourcingBad');"><span id="deleteOutsourcingBad" class="button-cr radius blue" style="display:inline-block;width:100%;">외주입고 클린</span></a></span></td> -->
<!--                                                     </tr> -->
                                                    
<!--                                                     <tr role="row" class="odd"> -->
<!--                                                         엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
<!--                                                         <td class="text-ellipsis"><span class="rnum">10[✓]</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="subject">재공품</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="content">재공품 삭제</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="table">MPO013, MPO014</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteWip');"><span id="deleteWip" class="button-cr radius blue" style="display:inline-block;width:100%;">재공품 클린</span></a></span></td> -->
<!--                                                     </tr> -->
                                                    
<!--                                                      <tr role="row" class="odd"> -->
<!--                                                         엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
<!--                                                         <td class="text-ellipsis"><span class="rnum">11</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="subject">테스트</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="content">[3],[6],[7]</span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="table"></span></td> -->
<!--                                                         <td class="text-ellipsis"><span class="botton"><a href="javascript:fn_click_event('deleteTest');"><span id="deleteTest" class="button-cr radius blue" style="display:inline-block;width:100%;">외주입고 클린</span></a></span></td> -->
<!--                                                     </tr> -->
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
<form name="objForm" id="objForm">
<input type="hidden" name="crudType" value="${search.crudType}"/>
<input type="hidden" name="deleteType" value="${search.deleteType}"/>
</form>

<div id="glv_del_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p>삭제 하시겠습니까 ?</p>
    </div>
</div>

</body>
</html>