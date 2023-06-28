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
    
    //-------------------------------------------------------------
    // 팝업 등록 시 제품 입고 정보에 조회
    //-------------------------------------------------------------
    $("#btnCreateIn").on('click',function(){
    	$('input[name=popItemOutCheckBox]').each(function(index){  
            //$(this).is(":checked");  //true 또는 false
            if($(this).is(":checked")){
	            var size = $("input[name='ItemInCheckBox']").length;
                for(i=0;i<size;i++){
	                if($(this).val() == $("input[name='ItemInCheckBox']").eq(i).attr("value")){
	            	alert("이미 등록된 제품이 있습니다.");
	            	return false;
	                }
                }
	            if(Number($("#"+$(this).val()+"_storkQty").text()) == 0 ){
	                alert("잔여량이 0개인 제품은 선택할 수 없습니다.");
	                return false;
	            }
            	var html = "";
            	html += "   <tr role=\"row\" class=\"odd\">";
            	html += "	<td class=\"text-ellipsis\">";
            	html += "   <span><input type=\"checkbox\" name=\"ItemInCheckBox\" value="+$(this).val()+">"
            	html += "   <div id="+$(this).val()+"_lotid2 style=\"display:none;\">"+$("#"+$(this).val()+"_lotid").text()+"</div>";
            	html += "   <div id="+$(this).val()+"_workshopCd2 style=\"display:none;\">"+$("#"+$(this).val()+"_workshopCd").text()+"</div>";
            	html += "   <div id="+$(this).val()+"_prodSeq2 style=\"display:none;\">"+$("#"+$(this).val()+"_prodSeq").text()+"</div>";
            	html += "   <div id="+$(this).val()+"_prodPoNo2 style=\"display:none;\">"+$("#"+$(this).val()+"_prodPoNo").text()+"</div>";
            	html += "   <div id="+$(this).val()+"_itemCd2 style=\"display:none;\">"+$("#"+$(this).val()+"_itemCd").text()+"</div></span></td>";
            	html += "	<td class=\"text-ellipsis\">"+$("#"+$(this).val()+"_itemNm").text()+"</td>";
            	html += "	<td class=\"text-ellipsis\">"+$("#"+$(this).val()+"_lotIdtlId").text()+"</td>";
            	html += "	<td class=\"text-ellipsis\">"+$("#"+$(this).val()+"_storkQty").text()+"</td>";
            	html += "	<td class=\"text-ellipsis\">"
            	html += "   <input type=\"text\" id="+$(this).val()+"_itemOutText name=\"itemOutText\" style=\"text-align: left;\" value="+$("#"+$(this).val()+"_storkQty").text()+"></td>";
            	html += "   </tr>";
            	$("#itemInBodyList").append(html)   
            	$("#popItemOut").dialog( "close" );       
            }
            
        });
    });
    
    
    $("#searchItemNm").keyup(function(e) {
    	fn_popItemOutList();
    });
    $("#searchLotIdtlId").keyup(function(e) {
    	fn_popItemOutList();
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
    $("#searchFromIteminDt, #searchToIteminDt").change(function() {
    	fn_popItemOutList();
    });
    
    $("#popItemOut").dialog({
        autoOpen: false,
        draggable:false, //창 드래그 못하게
        modal:true,
        resizable:false,
        position:{
            my:"center",
            at:"center",
            of:".card"
            },
        width: 950,
        open: function( event, ui ) {
        	//$(".ui-dialog-titlebar").hide();
        	$(".ui-dialog-titlebar").addClass("pop-dialog-titlebar");
        	
        	 fn_popItemOutList();
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
function fn_popItemList() {
	$("#popItemOut").dialog("open");
    //ajax submit
}
function fn_popItemOutList() {
    $.ajax({
        url : "<c:url value='/getItemInDtlListData.do'/>",
        type: 'POST',
        data: $('#popItemOutForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        beforeSend:function(){
        	$("#popItemOutListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
        	var html = "";
        	$.each(data.rtn.obj, function(key, val){
        		
        		html = "";
        		html += "<tr role=\"row\" class=\"odd\">";
		        html += "	<td class=\"text-ellipsis\">";
		        html += "   <span><input type=\"checkbox\" name=\"popItemOutCheckBox\" value="+val.itemindSeq+">"
		        html += "   <div id="+val.itemindSeq+"_itemNm style=\"display:none;\">"+val.itemNm+"</div>"
		        html += "   <div id="+val.itemindSeq+"_lotIdtlId style=\"display:none;\">"+val.lotIdtlId+"</div>"
		        html += "   <div id="+val.itemindSeq+"_storkQty style=\"display:none;\">"+val.storkQty+"</div>";
		        html += "   <div id="+val.itemindSeq+"_outQty style=\"display:none;\">"+val.outQty+"</div>";
		        html += "   <div id="+val.itemindSeq+"_workshopCd style=\"display:none;\">"+val.workshopCd+"</div>";
		        html += "   <div id="+val.itemindSeq+"_prodSeq style=\"display:none;\">"+val.prodSeq+"</div>";
		        html += "   <div id="+val.itemindSeq+"_prodPoNo style=\"display:none;\">"+val.prodPoNo+"</div>";
		        html += "   <div id="+val.itemindSeq+"_lotid style=\"display:none;\">"+val.lotid+"</div>";
		        html += "   <div id="+val.itemindSeq+"_itemCd style=\"display:none;\">"+val.itemCd+"</div></span></td>";
		        html += "	<td class=\"text-ellipsis\">" + val.itemNm + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + val.lotIdtlId + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + val.storkQty + "</td>";
		        html += "	<td class=\"text-ellipsis\">" + val.iteminOutDt + "</td>";
        		html += "</tr>";
        		$("#popItemOutListBody").append(html);
        	});
        	$('#popItemOut').css("display", "block");
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
	$('#popItemOut').dialog( "close" );
	
	 try{
		 fn_popItemOut_callback(obj);
	 } catch(e){
		 alert("입고LOT번호팝업 콜백함수(fn_popItemOut_callback)가 선언되어 있지 않습니다.");
	 }
}
</script>


<div id="popItemOut" title="입고 LOT 팝업">
	<div class="card" style="padding:0;">
		<div class="card-body" style="padding:0;">
	        <div class="table-responsive">
	        <div class="card-header">
                    <sapn class="txt20">입고 LOTID 목록</sapn>
                    <div id="btnCreateIn" class="btn btn-primary btn-sm mr-2" style="float: right;">등록</div>
            </div>
	            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				    <div class="row">
				    	<div class="col-sm-12 col-md-12">
				        	<div id="dataTable_filter" class="dataTables_filter">
								<form:form commandName="search" id="popItemOutForm" name="popItemOutForm">
									<input class="form-control2 pt-2" size="10" id="searchFromIteminDt" name="searchFromIteminDt" type="text" value=""/>
									<input class="form-control2 pt-2" size="10" id="searchToIteminDt" name="searchToIteminDt" type="text" value=""/>
									<input class="form-control2 pt-2" id="searchLotIdtlId" name="searchLotIdtlId" type="text" value="" placeholder="입고LOT" style="margin: 5px;"/>
									<input class="form-control2 pt-2" id="searchItemNm" name="searchItemNm" type="text" value="" placeholder="제품명" style="margin: 5px;"/>
								</form:form>
							</div>
						</div>
					</div>
           
				    <div class="row" style="overflow-y:auto; height:300px; display: block;">
						<div id="table_wrapper_popWorker" class="dataTables_wrapper dt-bootstrap4">
							<div class="tb_wrap">
								<div class="tb_box">
									<table class="table table-borderless table-borderbottom dataTable table-hover tb" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info">
										<thead class="thead-dark">
											<tr role="row" class="odd fixed_top">
												<!-- <th>No</th> -->
												<th>선택</th>
												<th>제품명</th>
												<th>입고BoxLOT</th>
												<th>잔여량</th>
												<th>입고일자</th>
										    </tr>
										</thead>
										<tbody id="popItemOutListBody"/>
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

