<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<script>
$(document).ready(function(){

	// 입고 LOT ID 선택 팝업
    $("#btnPopMaterialIn").click(function() {
    	fn_popMaterialInList();
    });

 	// 팝업 닫기
    $("#popMaterialInClose").click(function() {
        $('#popMaterialIn').css("display", "none");
    });

//     $("#searchToDate").datepicker({
//         showOn: "button",
//         buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
//         buttonImageOnly: true,
//         buttonText: "Select date",
//         dateFormat: "yy/mm/dd"
//       /*   onSelect: function(input, inst) {
// 			console.log("onSelect");
//         	$('#ui-datepicker-div > .ui-datepicker-header').addClass("ui-widget-header-pop");
//         } */
//     });

    $("#searchToDate").change(function(e) {
    	fn_popMaterialInList();
    });

    $("#searchMatNm").keyup(function(e) {
    	fn_popMaterialInList();
    });

});

function fn_popMaterialInList() {
    $.ajax({
        url : "<c:url value='/selectPopMaterialInList.do'/>",
        type: 'POST',
        data: $('#popMaterialInForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        async: false,
        beforeSend:function(){
        	$("#popMaterialInListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
        	var html = "";
        	$.each(data.rtn.obj, function(key, val){
        		var rtnObj = JSON.stringify(val).replace(/\"/gi, "\'");

        		html = "";
        		html += "<tr role=\"row\" class=\"odd\">";
        		html += "<td class=\"text-ellipsis\"><span>"+val.workshopNm+"</span></td>";
        		html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_clickMaterialIn(eval(" + rtnObj + "))\">"+val.matNm+"</a></span></td>";
        		html += "<td class=\"text-ellipsis\"><span>"+val.custNm+"</span></td>";
        		html += "<td class=\"text-ellipsis\"><span>"+val.inCnt + " KG</span></td>";
        		html += "<td class=\"text-ellipsis\"><span>"+val.stockQty +" KG</span></td>";
        		html += "<td class=\"text-ellipsis\"><span>"+val.lotid+"</span></td>";
        		html += "<td class=\"text-ellipsis\"><span>"+val.inDt+"</span></td>";
        		html += "</tr>";
        		$("#popMaterialInListBody").append(html);
        	});
        	$("#searchToDate").val(data.search.searchToDate);
        	$('#popMaterialIn').css("display", "block");
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

function fn_clickMaterialIn(obj) {

	$('#popMaterialIn').css("display", "none");

	 try{
		 fn_popMaterialIn_callback(obj);
	 } catch(e){
		 alert("lotid팝업 콜백함수(fn_popMaterialIn_callback)가 선언되어 있지 않습니다.");
	 }
}
</script>

<form:form commandName="search" id="popMaterialInForm" name="popMaterialInForm">

    <div id="popMaterialIn" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">입고 LOTID 조회</div>
                <span id="popMaterialInClose" class="modal-close-button">×</span>
            </div>
            <div class="card mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                <div class="card-header">
                    <sapn class="txt20">입고 LOTID 목록</sapn>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                            <div class="row">
                                <div class="col-sm-12 col-md-12" style="margin-bottom:5px;">
                                    <div id="dataTable_filter" class="dataTables_filter">
									    <div style="float: left; margin: 6px 5px;">
					                       <input class="form-control2" id="searchToDate" name="searchToDate" type="text" value="" readonly style="background-color:#e9ecef;"/>
					                       <input class="form-control2" id="searchMatNm" name="searchMatNm" type="text" value="" placeholder="자재명"/>
					                    </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="overflow-y:auto; height:300px;">
                                <div class="col-sm-12">
                                    <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                        <thead class="thead-dark">
                                            <tr role="row">
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">창고</th>
				                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">자재명</th>
				                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">자재처</th>
				                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">입고수량</th>
				                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">재고수량</th>
				                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">LOTID</th>
				                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">입고일자</th>
                                            </tr>
                                        </thead>
                                        <tbody id="popMaterialInListBody"/>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</form:form>