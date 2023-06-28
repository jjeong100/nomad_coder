<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>Dashboard</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>

<link type="text/css" rel="stylesheet" href="<c:url value='/resource/css/bootstrap.css'/>" />
<link type="text/css" rel="stylesheet" href="<c:url value='/resource/css/dashboard.css'/>" />
<link type="text/css" rel="stylesheet" href="<c:url value='/resource/css/fontawesome-all.css'/>" />
<link type="text/css" rel="stylesheet" href="<c:url value='/resource/css/menustyle.css'/>" />
<link type="text/css" rel="stylesheet" href="<c:url value='/resource/css/style.css'/>" />


<script type="text/javascript">
    function popclick() {
        document.location.href = "notice.html?view_id=menu_11";
    }

    $(function() {

        function realTimeCheck() {
            var date = new Date(Date.now());
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var today = date.getDate();
            var hour = date.getHours();
            var minute = date.getMinutes();
            var second = date.getSeconds();
            if (month < 10) {
                month = '0' + month;
            }
            if (today < 10) {
                today = '0' + today;
            }
            if (hour < 10) {
                hour = '0' + hour;
            }
            if (minute < 10) {
                minute = '0' + minute;
            }
            if (second < 10) {
                second = '0' + second;
            }
            var weekdays = [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ];
            var weekday = weekdays[date.getDay()];

            $('.today').html(
                    year + '년 ' + month + '월 ' + today + '일 ' + hour + '시 ' + minute + '분 ' + second + '초 ' + weekday);
        }

        function init() {
            realTimeCheck();
            setInterval(realTimeCheck, 1000);
        }

        init();
    });

    $(document).ready( function() { dashdata(); setInterval(dashdata, 30000); });
    
    function dashdata() {
        
        $.ajax({
            url : "<c:url value='/dashboardEquipInfoListData.do'/>",
            type: 'POST',
            data: {},
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            context:this,
            dataType:'json',
            beforeSend:function(){
               $("#equipment").empty();
            },
            success: function(data) {
                var html = "";
                $.each(data.rtn.obj, function(key, val){
                     html = "";
                     var mesViewStatus     = 'G';//mapper.mesViewStatus == '02inOperation' ? 'G': 'R';
                     var workstationStatus = val.statusCd;//mapper.workstationStatus == '02inOperation' ? 'G': 'R';
                     var subassemblyStatus = val.statusCd;//mapper.subassemblyStatus == '02inOperation'  ? 'G': 'R';
                     
                     html += "<span class=\"col-xs-2\" style=\"padding:0px;\">";
                     html += "<div class=\"hor_line_" + mesViewStatus + "\"></div>";
                     html += "<div class=\"ver_line1_" + subassemblyStatus + "\"></div>";
//                      html += "<div class=\"IGS_" + subassemblyStatus + "_D\">"+fn_undefined(val.itemNm) + "</div>";
//                      html += "<div class=\"ver_line2_" + subassemblyStatus + "\"></div>";
                     html += "<div class=\"infobox_"+ workstationStatus +"\">";
                     html += "<div class=\"equ_name_"+ workstationStatus +"_D\">"+fn_undefined(val.equipNm)+"</div>";
                     
                     html += "<table border=\"1px;\" id=\"dashboardTable_D\">";
                     html += "<tr>";
                     html += "<td>품명</td>";
                     html += "<td style=\"color: #66CCFF;\" colspan=\"2\">"+fn_undefined(val.itemNm)+"</td>";
                     html += "</tr>";
                     html += "<tr>";
                     html += "<td>* 계획수량</td>";
                     html += "<td style=\"color: #66CCFF;\">"+fn_undefined(val.poQty)+"</td>";
                     html += "<td>EA</td>";
                     html += "</tr>";
                     html += "<tr>";
                     html += "<td>* 생 산 량</td>";
                     html += "<td style=\"color: #FF9966;\">"+fn_undefined(val.actokQty)+"</td>";
                     html += "<td>EA</td>";
                     html += "</tr>";
                     html += "</table>";
                     html += "</div>";   
                     html += "</span>";
                    $("#equipment").append(html);
                });
            },
            error: function(request, status, error){
                console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                cfAlert('시스템 오류입니다.');
            },
            complete:function(){
            }
        });
    }

    //화면 클릭시 전체화면(ON/OFF)
    $(document).ready(function(i) {
        var e = document.getElementById("fullscreen");
        e.onclick = function() {
            toggleFullScreen();
        }
    });

    function toggleFullScreen() {
        var doc = window.document;
        var docEl = doc.documentElement;

        var requestFullScreen = docEl.requestFullscreen || docEl.mozRequestFullScreen || docEl.webkitRequestFullScreen
                || docEl.msRequestFullscreen;
        var cancelFullScreen = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen
                || doc.msExitFullscreen;

        if (!doc.fullscreenElement && !doc.mozFullScreenElement && !doc.webkitFullscreenElement
                && !doc.msFullscreenElement) {
            requestFullScreen.call(docEl);
        } else {
            cancelFullScreen.call(doc);
        }
    }
    
    //=====================================================================
    // paging
    //===================================================================== 
    function fn_paging(pageIndex) {
        var frm = document.searchForm;
        frm.pageIndex.value = pageIndex;
        frm.action = "<c:url value='/materialInListPage.do'/>";
        frm.submit();
    }
    
    //-----------------------------------------------------------------------
    // null문자나 undefined 또는 null일때 공백 처리
    //-----------------------------------------------------------------------
    function fn_undefined(values) {
        var result = "";
        if(values != null && values != 'undefined') result = values;
        if(values == "null" || values == "0") result = "";
        return result;
    }
</script>
</head>
 
<body class="bg-Dark" style="padding: 5px; border: 5px solid white;">
    <form:form commandName="search" id="searchForm" name="searchForm">
        <input type="hidden" name="crudType" value="R"/>
        <input type="hidden" name="pageIndex" value="1"/>
     </form:form>
    <section id="fullscreen" class="body-container">
<!--         <div class="dashboard-total-container bg-Dark"> -->
            <!-- Body -->
            <div class="dashboard-body-container bg-Dark">
                <div class="content-container width100per height100per bg-Dark">
                    <div class="content bg-Dark">
                        <!-- content start -->
<!--                         <div class="row"> -->
<!--                             <span class="col-xs-1"> -->
<!--                                 <div class="navbar-header dropdown" style="background: #202930; width: 100%; height: 54px; text-align: center; cursor: pointer;" onclick="popclick()"></div> -->
<!--                             </span> <span class="col-xs-10 pagename"></span> <span class="col-xs-1"></span> -->
<!--                         </div> -->
                        <div class="row" style="margin-top: 10px;">
                            <span class="col-xs-1"></span>
                            <span class="col-xs-2" style="border-left: 6px solid green; padding: 0px; text-align: center;">
                                <div class="col-xs-6 mesGreenLine">&nbsp;</div>
                                <div class="col-xs-6"></div><img alt="" src="<c:url value='/resource/images/mes_G.png'/>" style="height: 60%; width: 60%; border: 6px solid green;" onclick="javascript:fn_paging('1');">
<!--                                 <div class="col-xs-12">&nbsp;</div> -->
                            </span>
                            <span class="col-xs-6" style="padding: 0px; text-align: center;">
                                <h1>
                                    <div class="today"></div>
                                </h1>
                            </span><span class="col-xs-1"></span>
                        </div>
                        
                        <div id="equipment" class="row"></div>
                        
                    </div>
                </div>
            </div>
<!--         </div> -->
        <div style="clear: both;"></div>
    </section>
</body>

</html>