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
    <title>달력 관리</title>
    <style type="text/css">
.cal_top{
    text-align: center;
    font-size: 30px;
}
.cal{
    text-align: center; 
}
table.calendar{
    border: 1px solid black;
    display: inline-table;
    text-align: left;
    width: 100%;
}
table.calendar td{
    vertical-align: top;
    border: 1px solid skyblue;
    width: 100px;
}
</style>
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
               //-------------------------------------------------------------
                // declare gloval
                //-------------------------------------------------------------
                $("#searchToDate").datepicker({
                    showOn : "button",
                    buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                    buttonImageOnly : true,
                    buttonText : "Select date",
                    dateFormat : "yy/mm/dd"
                });

                 //-------------------------------------------------------------
                 // click  
                 //-------------------------------------------------------------
                 $(document).on("click", ".calendar td", function(event) { 
                     if ( $(this).css('background-color') == 'rgb(255, 196, 196)' ) {
                         $(this).children('.checkLabel').val(null);
                         $(this).children('.checkLabel').val("Y");
                        // $(this).css("background-color","rgb(50 218 69 / 29%)");
                     }else{
                         $(this).children('.checkLabel').val(null);
                         $(this).children('.checkLabel').val("N");
                    //   $(this).css("background-color","rgb(255, 196, 196)");
                     }
                 });
                
                 //-------------------------------------------------------------
                 // btnSave  
                 //-------------------------------------------------------------
                 $('#btnSave').click(function() {
                    $( "#add_content" ).dialog( "open" );
                 });
                 
                 //-------------------------------------------------------------
                 // 저장팝업
                 //-------------------------------------------------------------
                 $( "#add_content" ).dialog({
                     open: function(event, ui) {
                         $("#searchToDate").val(new Date().format("yyyy/MM/dd"));
                         $("#content").val("");
                         $("#workYn").val("N");
                         $('input:radio[name="workYn"]').filter("[value='N']").prop("checked", true);
                     },
                   autoOpen: false,
                   width: 400,
                   modal:true,
                 
                   buttons: [
                       {
                           text: "확인",
                           click: function() {
                               $( this ).dialog( "close" );
                               $.ajax({
                                   url : "<c:url value='/calanderSaveAct.do'/>",
                                   type: 'POST',
                                   data: $('#searchForm').serialize(),
                                   contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                                   context:this,
                                   dataType:'json',
                                   beforeSend:function(){
                                       $("#layoutSidenav").loading();
                                   },
                                   success: function(data) {
                                       if(!cfCheckRtnObj(data.rtn)) return;
                                       cfAlert('처리 되었습니다.');
                                       getNewInfo();
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
               
               
               
                //-------------------------------------------------------------
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                     drawCalendar();
                     initDate();
                     drawDays();
                   //  drawSche();
                     $("#movePrevMonth").on("click", function(){movePrevMonth();});
                     $("#moveNextMonth").on("click", function(){moveNextMonth();});
                     getNewInfo();
                 });
                 
            });
        })(jQuery);
        
        //=====================================================================
        // button action funtion
        //=====================================================================
        function fn_go_dtl_page(id) {
            var frm = document.searchForm;
            frm.crudType.value = 'R';
            frm.boxCd.value = id;
            frm.action = "<c:url value='/calanderDtlPage.do'/>";
            frm.submit();
        }
            
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/calanderListPage.do'/>";
            frm.submit();
        }

        //=====================================================================
        // 데이타 조회
        //===================================================================== 
        function drawCalendar(){
//             
            var setTableHTML = "";
//             $("#cal_tab").html(setTableHTML);            
            setTableHTML+="<table class=\"table table-borderless table-borderbottom dataTable table-hover\" id=\"dataTable\" cellspacing=\"0\" role=\"grid\" aria-describedby=\"dataTable_info\" style=\"width:100%;table-layout:fixed;\">";

//             setTableHTML+='<tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>';
            setTableHTML += "<thead class=\"thead-dark\">";
            setTableHTML += "<tr role=\"row\">";
            
            setTableHTML += "<th id=\"rnum\" class=\"no-sort\" tabindex=\"0\" aria-controls=\"dataTable\" rowspan=\"1\" colspan=\"1\" style=\"width:14%;\">일</th>";
            setTableHTML += "<th id=\"rnum\" class=\"no-sort\" tabindex=\"0\" aria-controls=\"dataTable\" rowspan=\"1\" colspan=\"1\" style=\"width:14%;\">월</th>";
            setTableHTML += "<th id=\"rnum\" class=\"no-sort\" tabindex=\"0\" aria-controls=\"dataTable\" rowspan=\"1\" colspan=\"1\" style=\"width:14%;\">화</th>";
            setTableHTML += "<th id=\"rnum\" class=\"no-sort\" tabindex=\"0\" aria-controls=\"dataTable\" rowspan=\"1\" colspan=\"1\" style=\"width:14%;\">수</th>";
            setTableHTML += "<th id=\"rnum\" class=\"no-sort\" tabindex=\"0\" aria-controls=\"dataTable\" rowspan=\"1\" colspan=\"1\" style=\"width:14%;\">목</th>";
            setTableHTML += "<th id=\"rnum\" class=\"no-sort\" tabindex=\"0\" aria-controls=\"dataTable\" rowspan=\"1\" colspan=\"1\" style=\"width:14%;\">금</th>";
            setTableHTML += "<th id=\"rnum\" class=\"no-sort\" tabindex=\"0\" aria-controls=\"dataTable\" rowspan=\"1\" colspan=\"1\" style=\"width:14%;\">토</th>";
            
            setTableHTML += "</tr>";
            setTableHTML += "</thead>";
            
            for(var i=0;i<6;i++){
                setTableHTML+='<tr height="100">';
                for(var j=0;j<7;j++){
                    setTableHTML+='<td class="calendar" style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap" >';
                    setTableHTML+='    <input type="hidden" class="checkLabel" value=""/>';
                    setTableHTML+='    <div class="cal-day"></div>';
                    setTableHTML+='    <div class="cal-schedule"></div>';
                    setTableHTML+='</td>';
                }
                setTableHTML+='</tr>';
            }
            setTableHTML+='</table>';
            $("#cal_tab").html(setTableHTML);
        }
        
        //날짜 초기화
        function initDate(){
            $tdDay = $("td div.cal-day")
            console.log($tdDay);
            $tdSche = $("td div.cal-schedule")
            dayCount = 0;
            today = new Date();
            year = today.getFullYear();
            month = today.getMonth()+1;
            if(month < 10){month = "0"+month;}
            firstDay = new Date(year,month-1,1);
            lastDay = new Date(year,month,0);
        }
        
        //calendar 날짜표시
        function drawDays(){
            $("#cal_top_year").text(year);
            $("#cal_top_month").text(month);
            
            for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
                $tdDay.eq(i).text(++dayCount);
            }
           /*  for(var i=0;i<42;i+=7){
                $tdDay.eq(i).css("color","red");
            }
            for(var i=6;i<42;i+=7){
                $tdDay.eq(i).css("color","blue");
            } */
        }
        
        //calendar 월 이동
        function movePrevMonth(){
            month--;
            if(month<=0){
                month=12;
                year--;
            }
            if(month<10){
                month=String("0"+month);
            }
            getNewInfo();
        }
        
        function moveNextMonth(){
            month++;
            if(month>12){
                month=1;
                year++;
            }
            if(month<10){
                month=String("0"+month);
            }
            getNewInfo();
        }
        
        //정보갱신
        function getNewInfo(){
            for(var i=0;i<42;i++){
                $tdDay.eq(i).text("");
                $tdSche.eq(i).text("");
            }
            dayCount=0;
            firstDay = new Date(year,month-1,1);
            lastDay = new Date(year,month,0);
            drawDays();
            //drawSche();
            
            var selectCalendar=  $("#cal_top_year").text() + $("#cal_top_month").text();
            
            $.ajax({
                url : "<c:url value='/getCalendarListData.do'/>",
                type: 'POST',
                data: {"searchFromDate":selectCalendar},
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                context:this,
                dataType:'json',

                success: function(data) {
                    $('.calendar td').css("background-color", "rgb(255, 255, 255)"); 
                    
//                     for(var i=0;i<42;i++){
                    for(var i=0;i<35;i++){
//                            if( $tdDay.eq(i).text() !=''){
                                 $tdDay.eq(i).parent().css("background-color", "rgb(50 218 69 / 29%)");
//                            }
                    }
                      for(var i=0;i<42;i+=7){
                       if( $tdDay.eq(i).text() !=''){
                             $tdDay.eq(i).parent().css("background-color", "rgb(255, 196, 196)");
                       }
                     
                         $tdDay.eq(i).css("color","red");
                     }
                     for(var i=6;i<42;i+=7){ 
                        if( $tdDay.eq(i).text() !=''){
                            $tdDay.eq(i).parent().css("background-color", "rgb(255, 196, 196)");
                        }
                         $tdDay.eq(i).css("color","blue");
                     }
                     
                   $.each(data.rtn.obj, function(key, val){ 
                       for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
                           
                           if( $tdDay.eq(i).text() == val.day){
                               $tdDay.eq(i).click(function() {
                                   $("#add_content" ).dialog( "open" ); 
                                   $("#searchToDate").val(val.yyymmdd);
                                   $("#content").val(val.bigo);
                                   $("#workYn").val(val.workYn);
                                   $('input:radio[name="workYn"]').filter("[value='"+val.workYn+"']").prop("checked", true);
                               });
                               
                               $tdDay.eq(i).html($tdDay.eq(i).text()+"<br>"+val.bigo);
                               if(val.workYn == "Y"){
                                   $tdDay.eq(i).parent().css("background-color", "rgb(255, 196, 196)");
                               }else{
                                   $tdDay.eq(i).parent().css("background-color", "rgb(50 218 69 / 29%)");
                               }
                           }
                       }
                   });
                   
                },
                error: function(){
                    cfAlert('시스템 오류입니다.');
                },
                complete:function(){
                }
            });
        }
        
        //2019-08-27 추가본
        //데이터 등록
        function setData(){
            jsonData = 
            {
                "2021":{
                    "07":{
                        "17":"제헌절"
                    }
                    ,"08":{
                        "7":"칠석"
                        ,"15":"광복절"
                        ,"23":"처서"
                    }
                    ,"09":{
                        "13":"추석"
                        ,"23":"추분"
                    }
                }
            }
        }
        
    /*     //스케줄 그리기
        function drawSche(){   
           setData();
            var dateMatch = null;
            for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
                var txt = "";
               
                txt = jsonData[year][month][i];
                dateMatch = firstDay.getDay() + i -1; 
                $tdSche.eq(dateMatch).text(txt);
                $tdSche.eq(dateMatch).css("background-color", "rgb(255, 196, 196)");
            }
        }
         */
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
                    <h1 class="mt-4">달력</h1>
                   
                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
<!--                            <sapn>달력</sapn> -->
                           <div id="btnSave" class="btn btn-primary btn-sm mr-2" style="float: right;">저장</div>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">  <!-- @@@ style="min-width:3000px;"  -->
                                    <div class="cal_top">
                                        <a href="#" id="movePrevMonth"><span id="prevMonth" class="cal_tit">&lt;</span></a>
                                        <span id="cal_top_year"></span>
                                        <span id="cal_top_month"></span>
                                        <a href="#" id="moveNextMonth"><span id="nextMonth" class="cal_tit">&gt;</span></a>
                                    </div>
                                    <div id="cal_tab" class="cal">
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
    
<div id="add_content" title="확인" style="display:none;overflow:hidden;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p>일정을 등록하세요!.</p>
    </div>
      <form:form commandName="search" id="searchForm" name="searchForm">
      <input type="hidden" name="crudType" value="R"/>
      <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
      <input type="hidden" name="pageSize" value="${search.pageSize}"/>
      <input type="hidden" name="sortCol" value="${search.sortCol}"/>
      <input type="hidden" name="sortType" value="${search.sortType}"/>
      <input type="hidden" name="yyyymmdd"/>
                                    
     <div id="dataTable_filter" class="dataTables_wrapper">
       <div class="float-center margin-dt">
           <input type="radio" name="workYn" value="N" checked/>&nbsp;작업일&nbsp;<input type="radio" name="workYn" value="Y"/>&nbsp;휴일&nbsp;
           <input class="form-control3 col-xs-2" style="width:150px;" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="선택 일자" />
       </div>
    </div>
    <div class="card-body">
        <div class="form-row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="small mb-1" for="popAddWorkerSabunId">내용 :</label>
                        <div class="input-group">
                         <textarea class="form-control py-4" id="content" name="content" rows="7"></textarea>
                        </div>
                </div>
            </div>
        </div>
    </div>
    </form:form>
</div>
<script>

</script>
</body>
</html>