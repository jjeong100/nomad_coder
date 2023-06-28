<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<script>
$(document).ready(function(){

	// 입고 LOT ID 선택 팝업
    $("#btnPopMatRequire").click(function() {
    	fn_popMatRequireList();
    });

 	// 팝업 닫기
    $("#popMatRequireClose").click(function() {
        $('#popMatRequire').css("display", "none");
    });

    $("#searchPoCalldt").datepicker({
        showOn: "button",
        buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
        buttonImageOnly: true,
        buttonText: "Select date",
        dateFormat: "yy/mm/dd"
      /*   onSelect: function(input, inst) {
			console.log("onSelect");
        	$('#ui-datepicker-div > .ui-datepicker-header').addClass("ui-widget-header-pop");
        } */
    });

    $("#searchPoCalldt").change(function(e) {
    	fn_popMatRequireList();
    });

});

function fn_popMatRequireList() {
	$.ajax({
        url : "<c:url value='/searchRequireMatListData.do'/>",
        type: 'POST',
        data: $('#popMatRequireForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        async : false,
        dataType:'json',
        beforeSend:function(){
            $("#popMatRequireListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
            var html = "";
            $.each(data.rtn.obj, function(key, val){
            	var rtnObj = JSON.stringify(val).replace(/\"/gi, "\'");

                html = "";
                html += "<tr role=\"row\" class=\"odd\">";
                html += "<td class=\"text-ellipsis\"><span>"+val.itemNm+"</span></td>";
                html += "<td class=\"text-ellipsis\"><span>"+val.poCalldt+"</span></td>";
                html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_clickMatRequire(eval(" + rtnObj + "))\">"+val.matNm+"</a></span></td>";
                html += "<td class=\"text-ellipsis\"><span>"+cfAddComma(val.matEa)+"개</span></td>";
                html += "<td class=\"text-ellipsis\"><span>"+cfAddComma(Number(cfIsNullString(val.matOutCnt, "0")))+"개</span></td>";
                html += "<td class=\"text-ellipsis\"><span>"+cfIsNullString(val.lotid)+"</span></td>";
                html += "</tr>";
                $("#popMatRequireListBody").append(html);
            });
            $('#popMatRequire').css("display", "block");
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

function fn_clickMatRequire(obj) {

	$('#popMatRequire').css("display", "none");

	 try {
		 fn_popMatRequire_callback(obj);
	 } catch(e){
		 alert("popMatRequire팝업 콜백함수(fn_popMatRequire_callback)가 선언되어 있지 않습니다.");
	 }
}

</script>

<form:form commandName="search" id="popMatRequireForm" name="popMatRequireForm">
<input type="hidden" id="popMatRequire_targetObj" name="popMatRequire_targetObj" value=""/>

    <div id="popMatRequire" class="modal-container">
		<div class="modal-content">
			<div class="modal-header">
				<div class="txt20">작업지시 소요 자재</div>
				<span id="popMatRequireClose" class="modal-close-button">×</span>
			</div>
			<div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
				<div class="card-header">
					<sapn class="txt20">자재 소요 목록</sapn>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
							<div class="row">
								<div class="col-sm-12 col-md-12" style="margin-bottom: 5px;">
									<div id="dataTable_filter" class="dataTables_filter">
										<div style="float: left; margin: 6px 5px;">
											<input class="form-control2" id="searchPoCalldt" name="searchPoCalldt" type="text" value="${rtn.obj.searchFromDate}" />
										</div>
									</div>
								</div>
							</div>
							<div class="row" style="overflow-y: auto; height: 200px;">
								<div class="col-sm-12">
									<table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
										<thead class="thead-dark">
											<tr role="row">
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">제품명</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">작지일자</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">자재명</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">소요수량</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">출고수량</th>
												<th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">자재출고LOT</th>
											</tr>
										</thead>
										<tbody id="popMatRequireListBody" />
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