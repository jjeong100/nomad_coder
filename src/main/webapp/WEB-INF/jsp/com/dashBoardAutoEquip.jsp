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
                drawProductionChart = function() { 
                    $.ajax({
                        url : "<c:url value='/dashboardAutoEquipChartData.do'/>",
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
                                userData.addColumn({type:'number', role:'annotation'});
                                userData.addColumn('number','불량');
                                userData.addColumn({type:'number', role:'annotation'});
                                
                                $.each(data.rtn.obj, function(key, val){
                                    userData.addRow([val.equipNm
                                                    ,val.actokQty
                                                    ,val.actokQty
                                                    ,val.actbadQty
                                                    ,val.actbadQty
                                                    ]);
                                });
                                
                                var options = {
                                        'width': '100%',
                                        'height': 550,
                                        tooltip:{textStyle : {fontSize:12}, showColorCode : true},
                                        'chartArea': {left:50, right:150, 'width': '100%', 'height': '90%'},
                                        animation: {
                                            startup: false,
                                            duration: 1000,
                                            easing: 'linear' },
                                          annotations: {
                                              textStyle: {
                                                fontSize: 50, 
                                                bold: true,
                                                italic: true,
                                                color: '#871b47',
                                                auraColor: '#d799ae',
                                                opacity: 0.8
                                              }
                                         }
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
                        url : "<c:url value='/getDashboardAutoEquipData.do'/>",
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
            refreshTimer = setInterval(function(){
                drawDashBoard();
                drawProductionChart();
            },10000);
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
                    <h1 class="mt-4">Dashboard</h1>
                   
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
                   
                   <!-- card end -->
                </div>
            </main>
        </div>
    </div>
<form:form commandName="search" id="searchForm" name="searchForm">
    <input type="hidden" name="dummy" value=""/>
</form:form>    
<script>

</script>
</body>
</html>