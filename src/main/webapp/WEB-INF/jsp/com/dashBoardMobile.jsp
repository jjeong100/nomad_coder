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
    <title>박스 정보 관리</title>
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
                var refreshTimer ;
                
                //-------------------------------------------------------------
                // jqery event 
                //-------------------------------------------------------------
                //
                //-------------------------------------------------------------
                drawProductionChart = function(pageIndex) {
//                 	alert(pageIndex);
// var frm = document.searchForm;
// frm.pageIndex.value = pageIndex;
                    $.ajax({
                        url : "<c:url value='/dashboardProductionChartData.do'/>",
                        type: 'POST',
                        data: $('#searchForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            $("#layoutSidenav").loadingClose();
                            if (data.rtn.rc == 0) {
                                var userData = new google.visualization.DataTable();
                                userData.addColumn('string','호기');
                                userData.addColumn('number','생산수량');
                                userData.addColumn('number','불량');
                                
                                $.each(data.rtn.obj, function(key, val){
                                    userData.addRow([val.equipNm
                                                    ,val.actokQty
                                                    ,val.actbadQty
                                                    ]);
                                });
                                
                                var options = {
                                    'width': '100%',
                                    'height': 420,
                                    'chartArea': {left:50, right:150, 'width': '100%', 'height': '80%'}
                                };
                                
                           
                                var chart = new google.visualization.ColumnChart(document.getElementById('chart_production_div'));
                                chart.draw(userData, options);
                                window.addEventListener('resize',drawProductionChart,false);
                            }
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
                // 
                //-------------------------------------------------------------
                drawDashBoard = function() {
                    $.ajax({
                        url : "<c:url value='/getDashboardEquipData.do'/>",
                        type: 'POST',
                        data: $('#searchForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            if( $("div[class='spinner']").length == 0 ) {
                                $("#layoutSidenav").loading();
                                $("#equipRow1").empty();
                                $("#equipRow2").empty();
                            }
                        },
                        success: function(data) {
                            if(!cfCheckRtnObj(data.rtn)) return;
                            
                            
                            $('#nowDayView').html(data.rtn.obj.nowDay);
                            $('#nowTimeView').html(data.rtn.obj.nowTime);
                            $('#totPoQtyView').html(cfAddComma(data.rtn.obj.totPoQty));
                            $('#totActokQtyView').html(cfAddComma(data.rtn.obj.totActokQty));
                            $('#totActbadQtyView').html(cfAddComma(data.rtn.obj.totActbadQty));
                            $('#actokRateView').html(data.rtn.obj.actokRate+' %');
                            $('#actbadRateView').html(data.rtn.obj.actbadRate+' %');
                            
                            // 에러 얼럿창이 떠있는경우 삭제
                            $("#glv-dialog-alert-dynamic").remove();
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
                 $(document).ready(function(){
                     drawDashBoard();
                     google.charts.load('current',{packages:['corechart']});
                     google.charts.setOnLoadCallback(drawProductionChart);
                     
                     fn_timer_start();
                 });
            });
        })(jQuery);
        
        function fn_timer_start() {
        	var pageIndex = 1;
            refreshTimer = setInterval(function(){
                drawDashBoard();
                drawProductionChart(pageIndex);
            },5000);
        }
        
        function fn_timer_stop() {
            clearInterval(refreshTimer);
        }
        
        //=====================================================================
        // button action funtion
        //=====================================================================
        
            
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/dashBoardPage.do'/>";
            frm.submit();
        }
        -->
    </script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
<%--     <jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp" ></jsp:include>  --%>
    <div id="layoutSidenav">
        <!-- ==================================================================================================================================== -->
        <!-- menu                                                                                                                                 -->
        <!-- ==================================================================================================================================== -->
<%--         <jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp" ></jsp:include> --%>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <!-- ======================================================================================================================== -->
                    <!-- title                                                                                                                    -->
                    <!-- ======================================================================================================================== -->
                    <h1 class="mt-4"><a href="./loginAct.do">Dashboard</a></h1>
                   
                   <div class="row">
                   
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-primary text-white mb-4">
                               <div class="card-body" style="font-size:130%;" id="nowDayView">TODAY</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="nowTimeView" class="small text-white stretched-link" style="font-size:120%;"></div>
                               </div>
                           </div>
                       </div>
                       
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-success text-white mb-4">
                               <div class="card-body" style="font-size:150%;">계획 수량</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="totPoQtyView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>
                       
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-warning text-white mb-4">
                               <div class="card-body" style="font-size:150%;">실적 수량</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="totActokQtyView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>
                       
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-danger text-white mb-4">
                               <div class="card-body" style="font-size:150%;">불량 수량</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="totActbadQtyView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>
                       
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-success text-white mb-4">
                               <div class="card-body" style="font-size:150%;">달성률</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="actokRateView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>
                       
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-warning text-white mb-4">
                               <div class="card-body" style="font-size:150%;">불량률</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="actbadRateView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>
                   </div>
                   
                   <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                   <form:form commandName="search" id="searchForm" name="searchForm">
                   <input type="hidden" name="crudType"  value="R"/>
                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                   <input type="hidden" name="pageSize"  value="${search.pageSize}"/>
                   <input type="hidden" name="sortCol"   value="${search.sortCol}"/>
                   <input type="hidden" name="sortType"  value="${search.sortType}"/>

                   <div class="row">
                       <div class="col-xl-12 col-md-12">
                           <div class="card mb-4">
                               <div class="card-header">
                                   <sapn>생산현황</sapn>
                               </div>
                               <div class="card-body">
                                   <div id="chart_production_div"></div>
                               </div>
                           </div>
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
                             <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate" style="align:right;">
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
                   </form:form>
                   <!-- card end -->
                   </div>
                </div>
            </main>
        </div>
    </div>
<script>

</script>
</body>
</html>