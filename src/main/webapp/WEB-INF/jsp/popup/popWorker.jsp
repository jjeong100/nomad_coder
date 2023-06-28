<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<style>

.tb_wrap {
  position:relative;
  width:100%;
/*    margin:20px auto; */
    padding-top:43px;
}
.tb_box {
  max-height:400px;
  overflow-y:scroll;
  border-bottom:1px solid #dedede;
}
.tb {
  border-collapse:collapse;
  border-spacing:0;
  width:100%;
}

.fixed_top {
  display:inline-table;
  position:absolute;
  top:0;
  width:calc(100% - 17px);
  background:#eef7ff;
}
.fixed_top th {
  border-top:1px solid #dedede;
  border-bottom:1px solid #dedede;
}
.tb tr.end {
  color:#999;
}

.ui-widget-header {
	border-bottom: 1px solid rgba(0, 62, 255, 0.125);
	border: 1px solid #aed0ea;
	background: #deedf7 url("../images/jquery/ui-bg_highlight-soft_100_deedf7_1x100.png") 50% 50% repeat-x;
	background-color:#343a40;
	font-weight: bold;
}

.ui-dialog .ui-dialog-titlebar-close {
	position: absolute;
	right: .3em;
	top: 50%;
	width: 20px;
	margin: -10px 0 0 0;
	padding: 1px;
	height: 20px;
	display: block;
}

.ui-widget-content a {
	color: #007bff;
}
</style>

<script>
$(document).ready(function(){
	 
 	// 팝업 닫기
    $('.modal-close-button').click(function() {
        $('.modal-container').css("display", "none");
    });
 	
  	//-------------------------------------------------------------
    // 성적서등록 팝업
    //-------------------------------------------------------------
    $( "#popWorker" ).dialog({
        autoOpen: false,
        draggable:false, //창 드래그 못하게
        modal:true,
        resizable:false,
        position:{
            my:"center",
            at:"top",
            of:window
            },
        width: 600,
        open: function( event, ui ) {
        	$.ajax({
                url : "<c:url value='/popWorkerList.do'/>",
                type: 'POST',
                data: $('#popWorkerForm').serialize(),
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                context:this,
                dataType:'json',
                beforeSend:function(){
                    $("#popWorkerListBody tr").remove();
                    $("#table_wrapper_popWorker").loading();
                },
                success: function(data) {
                    if(!cfCheckRtnObj(data.rtn)) return;
                    var html = "";
                    $.each(data.rtn.obj, function(key, val){
                    	var temp = {};
                    	temp = val;
                    	temp.kindId = $("#popWorker").data("kindId");
                    	var worker = JSON.stringify(temp).replace(/\"/gi, "\'");
                    	
                        html = "";
                        html += "<tr role=\"row\" class=\"odd\">";
	                    html += "    <td class=\"text-ellipsis\"><span class=\"rnum\">" + val.rnum + "</span></td>";
	                    html += "    <td class=\"text-ellipsis\"><span class=\"login_id\">" + val.loginId + "</span></td>";
	                    html += "    <td class=\"text-ellipsis\"><span class=\"login_name\"><a href=\"javascript:fn_clickWorker(eval(" + worker + "));\">" + val.loginName + "</a></span></td>";
	                    html += "    <td class=\"text-ellipsis\"><span class=\"sabun_id\">" + val.sabunId + "</span></td>";
	                    html += "</tr>";
                        $("#popWorkerListBody").append(html);
                    });
                },
                error: function(request, status, error){
                    console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                    cfAlert('시스템 오류입니다.');
                },
                complete:function(){
                    $("#table_wrapper_popWorker").loadingClose();
                }
            });
        },
        buttons: [
            /* {
                text: "선택",
                click: function() {
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

function fn_clickWorker(worker) {
	 $( "#popWorker" ).dialog( "close" );
	 try{
		 fn_popWorker_callback(worker);
	 } catch(e){
		 alert("사원팝업 콜백함수(fn_popWorker_callback)가 선언되어 있지 않습니다.");
	 }
}
</script>

<form:form commandName="searchPopWorker" id="popWorkerForm" name="popWorkerForm">
	<input type="hidden" name="crudType" value="R"/>
	<input type="hidden" name="pageIndex" value="1"/>
	<input type="hidden" name="pageSize" value="10"/>
</form:form>

<div id="popWorker" title="사원팝업">
	<div id="table_wrapper_popWorker" class="dataTables_wrapper dt-bootstrap4">
		<div class="tb_wrap">
			<div class="tb_box">
				<table class="table table-borderless table-borderbottom dataTable table-hover tb" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info">
<!-- 				<table class="table table-borderless tb" > -->
					<thead class="thead-dark">
						<tr role="row" class="odd fixed_top">
							<th id="rnum">No</th>
							<th id="login_id">아이디</th>
							<th id="login_name">이름</th>
							<th id="sabun_id">사번</th>
					    </tr>
					</thead>
					<tbody id="popWorkerListBody"/>
				</table>
			</div>
		</div>
	</div>
</div>