<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<style>

.pop-dialog-titlebar {
    background: #deedf7 url('../images/jquery/ui-bg_highlight-soft_100_deedf7_1x100.png') 50% 50% repeat-x !important;
    background-color: #343a40 !important;
}

.pop-dialog-close-button {
    float: right;
    margin: 0px 10px 0px 20px;
    font-size: 20px;
    font-weight: bold;
    color: white !important;
    border: #343a40 !important;
    background-color: #343a40 !important;
    display: block !important;
}
</style>
<script>
$(document).ready(function(){
	
    // 입고 LOT 팝업
    $("#btnPopItemIn").click(function() {
    	$("#popItemIn").dialog("open");
    });
    
 	// 팝업 닫기
    $('#popItemInClose').click(function() {
        $('#popItemIn').css("display", "none");
    });
 	
    $( "#searchFromIteminDt, #searchToIteminDt" ).datepicker({ 
        showOn: "button",
        buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
        buttonImageOnly: true,
        buttonText: "Select date",
        dateFormat: "yy/mm/dd"
       /*  onSelect: function(input, inst) {
        	$('#ui-datepicker-div > .ui-datepicker-header').addClass("ui-widget-header-pop");
        } */
    });
    
    $("#searchFromIteminDt, #searchToIteminDt").change(function(e) {
    	fn_popItemInList();
    });
   
    $("#searchItemNm").keyup(function(e) {
    	fn_popItemInList();
    });
    
    $("#popItemIn").dialog({
        autoOpen: false,
        draggable:false, //창 드래그 못하게
        modal:true,
        resizable:false,
        position:{
            my:"center",
            at:"center",
            of:"#layoutSidenav_content"
            },
        width: 950,
        open: function( event, ui ) {
        	//$(".ui-dialog-titlebar").hide();
        	$(".ui-dialog-titlebar").addClass("pop-dialog-titlebar");
        	
        	fn_popItemInList();
        },
        buttons: [
            /* {
                text: "선택",
                click: function() {
                	if (cfIsNull($("input:radio[name=popItemInRadioBox]:checked").val())) {
                		alert("LOTID를 선택해 주세요"); 
                        return false;
                	}
                	
                	var idx = $("input:radio[name=popItemInRadioBox]:checked").val();
                	var param = {};
                	param.lotid		= $('#lotid_'+ idx).html();
                	param.prodSeq	= $('#prodSeq_'+ idx).html();
                	param.prodPoNo	= $('#prodPoNo_'+ idx).html();
                	param.itemCd	= $('#itemCd_'+ idx).html();
                	param.itemNm	= $('#itemNm_'+ idx).html();
                	param.poQty		= $('#poQty_'+ idx).html();
                	param.custCd	= $('#custCd_'+ idx).html();
                	param.iteminSeq	= $('#iteminSeq_'+ idx).html();
                	param.mqcSeq	= $('#mqcSeq_'+ idx).html();
                	
                	fn_clickItemIn(param);
                	$( this ).dialog( "close" );
                }
            }, */
            {
                text: "닫기",
                click: function() {
                    $( this ).dialog( "close" );
                }
            }
        ]
    });
    
});

function fn_popItemInList() {
    $.ajax({
        url : "<c:url value='/selectPopItemInList.do'/>",
        type: 'POST',
        data: $('#popItemInForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        beforeSend:function(){
        	$("#popItemInListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
        	var html = "";
        	$.each(data.rtn.obj, function(key, val){
        		var itemObj = JSON.stringify(val).replace(/\"/gi, "\'");
        		
        		html = "";
        		html += "<tr role=\"row\" class=\"odd\">";
	        	/* html += "	<td class=\"text-ellipsis\">";
		        html += "		<input type=\"radio\" name=\"popItemInRadioBox\" value=\"" + key + "\"/>";
		        html += "		<div id=\"lotid_" + key + "\" style=\"display:none;\">" + val.lotid + "</div>";
		        html += "		<div id=\"prodSeq_" + key + "\" style=\"display:none;\">" + val.prodSeq + "</div>";
		        html += "		<div id=\"prodPoNo_" + key + "\" style=\"display:none;\">" + val.prodPoNo + "</div>";
		        html += "		<div id=\"itemCd_" + key + "\" style=\"display:none;\">" + val.itemCd + "</div>";
		        html += "		<div id=\"itemNm_" + key + "\" style=\"display:none;\">" + val.itemNm + "</div>";
		        html += "		<div id=\"poQty_" + key + "\" style=\"display:none;\">" + val.poQty + "</div>";
		        html += "		<div id=\"custCd_" + key + "\" style=\"display:none;\">" + val.custCd + "</div>";
		        html += "		<div id=\"iteminSeq_" + key + "\" style=\"display:none;\">" + val.iteminSeq + "</div>";
		        html += "		<div id=\"mqcSeq_" + key + "\" style=\"display:none;\">" + val.mqcSeq + "</div>";
		        html += "		<div id=\"qmCheckdt_" + key + "\" style=\"display:none;\">" + val.qmCheckdt + "</div>";
		        html += "	</td>"; */
		        html += "	<td class=\"text-ellipsis\">" + val.prodPoNo + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + cfIsNullString(val.custNm) + "</td>";
		        html += "	<td class=\"text-ellipsis\"><span class=\"login_name\"><a href=\"javascript:fn_clickItemIn(eval(" + itemObj + "));\" style=\"color: #007bff;\">" + val.itemNm + "</a></span></td>";
		        html += "	<td class=\"text-ellipsis\">" + val.actokQty + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + val.iteminDt + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + val.inokQty + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + val.workshopNm + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + val.lotid + "</td>";
        		html += "</tr>";
        		$("#popItemInListBody").append(html);
        	});
        	
        	$("#searchFromIteminDt").val(data.search.searchFromIteminDt);
        	$("#searchToIteminDt").val(data.search.searchToIteminDt);
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

function fn_clickItemIn(obj) {
	$('#popItemIn').dialog( "close" );
	
	 try{
		 fn_popItemIn_callback(obj);
	 } catch(e){
		 alert("입고LOT번호팝업 콜백함수(fn_popItemIn_callback)가 선언되어 있지 않습니다.");
	 }
}
</script>


<div id="popItemIn" title="입고 LOT NO 팝업">
	<div class="card" style="padding:0;">
		<div class="card-body" style="padding:0;">
	        <div class="table-responsive">
	            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				    <div class="row">
				    	<div class="col-sm-12 col-md-12" style="margin-bottom:5px;">
				        	<div id="dataTable_filter" class="dataTables_filter">
								<form:form commandName="search" id="popItemInForm" name="popItemInForm">
									<input type="hidden" name="searchType" value="IN">
									<input class="form-control2" id="searchFromIteminDt" name="searchFromIteminDt" type="text" value=""/>
									<input class="form-control2" id="searchToIteminDt" name="searchToIteminDt" type="text" value=""/>
									<input class="form-control2" id="searchItemNm" name="searchItemNm" type="text" value="" placeholder="제품명"/>
								</form:form>
							</div>
						</div>
					</div>
           
				    <div class="row" style="overflow-y:auto; height:300px;">
						<div id="table_wrapper_popWorker" class="dataTables_wrapper dt-bootstrap4">
							<div class="tb_wrap">
								<div class="tb_box">
									<table class="table table-borderless table-borderbottom dataTable table-hover tb" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info">
										<thead class="thead-dark">
											<tr role="row" class="odd fixed_top">
												<!-- <th>No</th> -->
												<th>작지번호</th>
												<th>고객사</th>
												<th>품명</th>
												<th>작지수량</th>
												<th>입고일자</th>
												<th>입고수량</th>
												<th>입고창고</th>
												<th>바코드번호</th>
										    </tr>
										</thead>
										<tbody id="popItemInListBody"/>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

