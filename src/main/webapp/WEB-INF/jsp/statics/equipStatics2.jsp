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
    <title>Power MES</title>
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
                //-------------------------------------------------------------
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                    drawChart();
                    drawTot();
                });
                
                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/equipStaticsPage.do'/>";
                    frm.submit();
                });
                
                drawChart = function() {
                    $.ajax({
                        url : "<c:url value='/searchEquipStaticsListData.do'/>",
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
                                userData.addColumn('string','장비');
                                userData.addColumn('number','기준');
                                userData.addColumn('number','대상');
                                
                                $.each(data.rtn.obj, function(key, val){
                                    userData.addRow([val.equipCd,val.baseYearRate,val.compYearRate]);
                                });

                                var options = {
                                    'width': '100%',
                                    'height': 550,
                                    'chartArea': {left:50, right:120, 'width': '1000%', 'height': '90%'},
                                    'vAxis': {
                                        viewWindow: {
                                            max:100,
                                            min:0
                                        }
                                    }
                                };
                           
                                var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                                chart.draw(userData, options);
                                window.addEventListener('resize',drawChart,false);
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
                
                drawTot = function() {
                    $.ajax({
                        url : "<c:url value='/selectEquipTotStaticsData.do'/>",
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
                                $("#titleMsg").html('설비 가동률(%) 기준년도:'+data.rtn.obj.baseYearTotRate+'% 대상년도:'+data.rtn.obj.compYearTotRate+'%');
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
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                     google.charts.load('current',{packages:['corechart']});
                     google.charts.setOnLoadCallback(drawChart);
                     var month = new Date().getMonth();
                     month = month > 9 ? month : "0"+month;
                     $("#searchMonth").val(month);
                     drawTot();
                     
                     appendYear();
                     
                     $("#searchCompYear").val("${search.searchCompYear}");
                     $("#searchBaseYear").val("${search.searchBaseYear}");
                     $("#searchMonth").val("${search.searchMonth}");
                 });
            });
        })(jQuery);
        
        //=====================================================================
        // 10년 콤보박스
        //=====================================================================
        function appendYear(){
            var date = new Date();
            var year = date.getFullYear();
            for(var index = year-10; index<=year; index++){
                $("#searchBaseYear").prepend("<option value='"+index+"'>"+index+"</option>");
                $("#searchCompYear").prepend("<option value='"+index+"'>"+index+"</option>");
            }
            $("#searchBaseYear").find("option:eq(1)").prop("selected", true);
            $("#searchCompYear").find("option:eq(0)").prop("selected", true);
        }
        
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/equipStaticsPage.do'/>";
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
                    <h1 class="mt-4">생산지표</h1>
                     <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">  <!-- @@@ style="min-width:3000px;"  -->
                    <div class="row">
                        <div class="col-sm-12 col-md-12" style="padding-top:5px;">
                            <form:form commandName="search" id="searchForm" name="searchForm">
                                 <input type="hidden" name="crudType" value="R"/>
                                 <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                 <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                                 <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                                 <input type="hidden" name="sortType" value="${search.sortType}"/>
                                                   
<!--                                 <input type="hidden" name="pageIndex" value="1"/> -->
                                <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                     <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                                </div>
                                <div style="float: right; margin: 6px 5px; width: 200px;">
                                    <select class="form-control2" id="searchMonth" name="searchMonth">
                                        <option value="01">1월</option>
                                        <option value="02">2월</option>
                                        <option value="03">3월</option>
                                        <option value="04">4월</option>
                                        <option value="05">5월</option>
                                        <option value="06">6월</option>
                                        <option value="07">7월</option>
                                        <option value="08">8월</option>
                                        <option value="09">9월</option>
                                        <option value="10">10월</option>
                                        <option value="11">11월</option>
                                        <option value="12">12월</option>
                                    </select>
                                </div>
                                <span style="float: right; margin: 10px; ">월 선택</span> 
                                <div style="float: right; margin: 6px 5px; width: 200px;">
                                     <select class="form-control2" id="searchCompYear" name="searchCompYear">
<!--                                          <option value="2020">2020</option> -->
<!--                                          <option value="2019">2019</option> -->
<!--                                          <option value="2018">2018</option> -->
                                     </select>
                                 </div>
                                <span style="float: right; margin: 10px; ">대상년도</span>
                                <div style="float: right; margin: 6px 5px; width: 200px;">
                                     <select class="form-control2" id="searchBaseYear" name="searchBaseYear">
<!--                                          <option value="2019">2019</option> -->
<!--                                          <option value="2018">2018</option> -->
                                     </select>
                                 </div>
                                 <span style="float: right; margin: 10px; ">기준년도</span> 
                            </form:form>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xl-12">
                            <div class="card mb-4">
                               <div class="card-header">
                                   <div style="float:left;padding:5px;"><svg class="svg-inline--fa fa-chart-bar fa-w-16 mr-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chart-bar" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M332.8 320h38.4c6.4 0 12.8-6.4 12.8-12.8V172.8c0-6.4-6.4-12.8-12.8-12.8h-38.4c-6.4 0-12.8 6.4-12.8 12.8v134.4c0 6.4 6.4 12.8 12.8 12.8zm96 0h38.4c6.4 0 12.8-6.4 12.8-12.8V76.8c0-6.4-6.4-12.8-12.8-12.8h-38.4c-6.4 0-12.8 6.4-12.8 12.8v230.4c0 6.4 6.4 12.8 12.8 12.8zm-288 0h38.4c6.4 0 12.8-6.4 12.8-12.8v-70.4c0-6.4-6.4-12.8-12.8-12.8h-38.4c-6.4 0-12.8 6.4-12.8 12.8v70.4c0 6.4 6.4 12.8 12.8 12.8zm96 0h38.4c6.4 0 12.8-6.4 12.8-12.8V108.8c0-6.4-6.4-12.8-12.8-12.8h-38.4c-6.4 0-12.8 6.4-12.8 12.8v198.4c0 6.4 6.4 12.8 12.8 12.8zM496 384H64V80c0-8.84-7.16-16-16-16H16C7.16 64 0 71.16 0 80v336c0 17.67 14.33 32 32 32h464c8.84 0 16-7.16 16-16v-32c0-8.84-7.16-16-16-16z"></path></svg>
                                   </div>
                                   <div id="titleMsg">설비 가동률 (%)</div> 
                               </div>
                               <div class="card-body">
                                   <div id="chart_div"></div>
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
            </main>
        </div>
    </div>
</body>
</html>