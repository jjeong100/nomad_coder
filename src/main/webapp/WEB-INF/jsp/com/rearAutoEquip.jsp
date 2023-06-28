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
                        url : "<c:url value='/getRearAutoEquipChartData.do'/>",
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
                                            easing: 'linear' 
                                         },
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
                                
                                console.log(userData);
                           
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
                        url : "<c:url value='/getRearAutoEquipSummaryData.do'/>",
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
                // Left 리스트 클릭
                //-------------------------------------------------------------
                $(document).on('click','#mainLeftListBody tr',function(e){
                     var radioBox = $(this).children().find("input[name=rowRadio]");
                     radioBox.prop('checked', true);
                     
                     var prodSeq = radioBox.val();
                     
                     var frm = document.searchForm;
                     frm.prodSeq.value = prodSeq;
                     
                     fn_search_list(prodSeq);
                     
                     /** chart **/
                     drawDashBoard();
                     drawProductionChart();
                });
                
                //-------------------------------------------------------------
                // 날짜 변경 이벤트
                //-------------------------------------------------------------
                $('#searchToDate').on('change', function() {
                    var frm = document.searchForm;
                    frm.searchToDate.value = $(this).val().replace(/[^0-9]/g,'');
//                     alert($(this).val());
                    frm.action = "<c:url value='/rearAutoEquipPage.do'/>";
                    frm.submit();
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
                     $("#searchToDate").val("${search.searchToDate}");
                     
                     
                     /** 리스트의 첫 번째 클릭  drawDashBoard에서 prodSeq를 
                                                 사용하기 때문에 drawDashBoard 항상 먼저 위치 한다.**/
                                                 
                     fn_select_position("mainLeftListBody",0);
                     
                     drawDashBoard();
                     google.charts.load('current',{packages:['corechart']});
                     google.charts.setOnLoadCallback(drawProductionChart);

                     fn_timer_start();
                
                 });
            });
        })(jQuery);
        
        //=====================================================================
        // 리스트 조회
        //=====================================================================
        function fn_search_list(prodSeq) {
             $.ajax({
                 url : "<c:url value='/getItemImageData.do'/>",
                 type: 'POST',
                 data: {"prodSeq":prodSeq},
                 contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                 context:this,
                 dataType:'json',
                 beforeSend:function(){
                     $('div#imgArea > img').remove();
                     $("#layoutSidenav").loading();
                 },
                 success: function(data) {
                     if(!cfCheckRtnObj(data.rtn)) return;
                   var vimg;
                   if(data.rtn.obj != null) {
                     vimg = $("<img>",{
                               "src"       : data.rtn.obj.itemImageData
                             , "width"     :"100%"
                             , "height"    :"100%"
                             , "max-width" : "350px"
                             , "max-height": "300px"
                     });
                   }else{
                       vimg = $("<img>",{
                           "src"       : "/PowerMES/resource/images/no_image.png"
                         , "width"     :"100%"
                         , "height"    :"100%"
                         , "max-width" : "350px"
                         , "max-height": "300px"    
                       });
                   }
                   $(vimg).appendTo("#imgArea");
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
        
         //=====================================================================
        // 위치 클릭 
        //=====================================================================
        function fn_select_position(body,index){
            var col01 = $("#"+body+" tr:eq("+index+")>td:eq(0)").children();
            var td = $("#"+body+" tr").eq(index).children();

            var radioBox = td.children().find("input[name=rowRadio]");
            radioBox.prop('checked', true);
            
            var prodSeq = radioBox.val();
            fn_search_list(prodSeq);
            
            var frm = document.searchForm;
            frm.prodSeq.value = prodSeq;

//             drawDashBoard();
//             drawProductionChart();
        }
      
        //=====================================================================
        // 타이머 시작
        //=====================================================================
        function fn_timer_start() {
            refreshTimer = setInterval(function(){
                drawDashBoard();
                drawProductionChart();
            },10000);
        }
        
        //=====================================================================
        // 타이머 종료
        //=====================================================================
        function fn_timer_stop() {
            clearInterval(refreshTimer);
        }
        
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/rearAutoEquipPage.do'/>";
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
<!--                     <h1 class="mt-4">Dashboard</h1> -->
<div class="row" style="padding:10px;">
                   <div class="col-sm-5">
                        <!-- ========================================================================================================================= -->
                        <!-- taable list                                                                                                              -->
                        <!-- ======================================================================================================================== -->
                       <div class="card mb-4">
                        <div id="dataTable_filter" class="dataTables_wrapper">
                               <form:form commandName="search" id="searchForm" name="searchForm">
                                   <input type="hidden" name="crudType"  value="R"/>
                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                   <input type="hidden" name="pageSize"  value="${search.pageSize}"/>
                                   <input type="hidden" name="sortCol"   value="${search.sortCol}"/>
                                   <input type="hidden" name="sortType"  value="${search.sortType}"/>
                                   
                                   <input type="hidden" name="prodSeq"   value="${search.prodSeq}"/>
                                   <input type="hidden" name="searchIdx" value="${search.searchIdx}"/>
                                   <div style="float:left;"><h1 class="mt-4 mb-1">리어자동화</h1></div>
                                   <div class="float-right margin-dt">
                                       <input class="form-control3 dt-w55 col-xs-2" style="width:400px;" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="조회 일자"/>
                                   </div>
                               </form:form>
                           </div>
                                
                           <div class="card-body">
                               <div class="table-responsive">
                                   <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                         <div class="row">
                                                <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width:100%;table-layout:fixed;">
                                                  <thead class="thead-dark">  
                                                      <tr role="row">
                                                            <th id="ridio_box"    class="no_sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:10%;">선택</th>
                                                            <th id="work_dt"      class="no_sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">작업일</th>
                                                            <th id="prod_po_no"   class="no_sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">작업지시</th>
                                                            <th id="prod_type_nm" class="no_sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:30%;">상태</th>
                                                       </tr>
                                                   </thead>
                                                   <tbody id="mainLeftListBody">
                                                       <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                         <tr role="row" class="odd">
                                                             <td class="text-ellipsis"><span class="work_dt"><input type="radio" name="rowRadio" value="${item.prodSeq}"/></span></td>
                                                             <td class="text-ellipsis"><span class="work_dt">${item.workDt}</span></td>
                                                             <td class="text-ellipsis"><span class="prod_po_no">${item.prodPoNo}</span></td>
                                                             <td class="text-ellipsis"><span class="prod_type_nm">${item.prodTypeNm}</span></td>
                                                         </tr>
                                                       </c:forEach>
                                                       <c:if test="${fn:length(rtn.obj) le 0}">
                                                         <tr>
                                                             <td colspan="4" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                         </tr>
                                                       </c:if>
                                                   </tbody>
                                                </table>
                                                
                                                <!-- ======================================================================================================================== -->
                                                <!-- paging                                                                                                                   -->
                                                <!-- ======================================================================================================================== -->
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
                                            <!-- page end -->
                                           <div class="col-sm-12 col-md-12" style="padding:40px;">
                                               <div class="form-group">
                                               <div id="imgArea"></div>
                                                </div>
                                           </div>
                                    
                                       </div>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <!-- table card end -->
                   </div>
                   <div class="col-sm-7">
                   <div class="row">
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-success text-white mb-4">
                               <div class="card-body" style="font-size:150%;">계획</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="totPoQtyView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>

                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-warning text-white mb-4">
                               <div class="card-body" style="font-size:150%;">실적</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="totActokQtyView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>
                       
                       <div class="col-xl-2 col-md-2">
                           <div class="card bg-danger text-white mb-4">
                               <div class="card-body" style="font-size:150%;">불량</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="totActbadQtyView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>

                       <div class="col-xl-3 col-md-2">
                           <div class="card bg-success text-white mb-4">
                               <div class="card-body" style="font-size:150%;">달성률</div>
                               <div class="card-footer d-flex align-item-center justify-content-between">
                                   <div id="actokRateView" class="small text-white stretched-link" style="font-size:120%;">0</div>
                               </div>
                           </div>
                       </div>
                       
                       <div class="col-xl-3 col-md-2">
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
                   </div>
</div>
                   <!-- card end -->
                </div>
            </main>
        </div>
    </div>
<script>
$( "#searchToDate" ).datepicker({
    beforeShow: function() {
        setTimeout(function(){
            $('.ui-datepicker').css('z-index', 9999);
        }, 0);
    },
    showOn: "button",
    buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
    buttonImageOnly: true,
    buttonText: "Select date"
  });
$( "#searchToDate" ).datepicker("option", "dateFormat", "yy/mm/dd");
</script>
</body>
</html>