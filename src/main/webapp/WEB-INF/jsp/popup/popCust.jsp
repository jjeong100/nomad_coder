<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"       uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.tb_wrap {
  position:relative;
  width:100%;
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
</style>


<script type="text/javascript">
<!--
$(document).ready(function(){
	$("input[name=custTypeCd]").val('<c:out value="${param.custTypeCd}" />');
	
	if($("input[name=custTypeCd]").val() == 'COD'){
		$(".txt20").html("납품처 선택");
	}else{
		$(".txt20").html("자재처 선택");
	}
	
    $('#btnPopCustSearch').click(function() {
        var frm = document.popCustForm;
        var idx = frm.parentIdx.value;
        fn_popCustList(frm.custNm.value);
    });


     // 팝업 닫기
    $('#popCustClose').click(function() {
        $('#popCust').css("display", "none");
    });


    // 팝업 닫기
    $('.modal-close-button').click(function() {
        $('.modal-container').css("display", "none");
    });
});


//-----------------------------------------------------------------------
// 팝업의 리스트 클릭시
//-----------------------------------------------------------------------
function fn_clickPopCustList(custCd,custNm) {
    var param = {};
    param.custCd = custCd;
    param.custNm = custNm;


    fn_clickPopCust(param);
}


//-----------------------------------------------------------------------
// 팝업 호출
//-----------------------------------------------------------------------
function fn_popCustList(custNm) {
    var frm = document.popCustForm;
    frm.custNm.value = custNm;


    //ajax submit
    fn_popCustSubmit();
}


//-----------------------------------------------------------------------
// ajax
//-----------------------------------------------------------------------
function fn_popCustSubmit() {
    $.ajax({
        url : "<c:url value='/getPopCustList.do'/>",
        type: 'POST',
        data: $('#popCustForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        beforeSend:function(){
            $("#popCustListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
            if(data.rtn.obj == null || '' == data.rtn.obj) {
            var html = "";
                html += "<tr>";
                html += "<td colspan=\"4\" class=\"no-data\">- 표시할 내용이 없습니다. -</td>";
                html += "</tr>";
               $("#popItemListBody").append(html);
            }else{
                $.each(data.rtn.obj, function(key, val){
                var html = "";
                    html += "<tr role=\"row\" class=\"odd\">";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.custCd+"</span></td>";
                    html += "    <td class=\"text-ellipsis\"><span><a href=\"javascript:fn_clickPopCustList('"+val.custCd+"','"+val.custNm+"');\">"+val.custNm+"</a></span></td>";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.custTypeNm+"</span></td>";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.matTypeNm+"</span></td>";
                    html += "</tr>";
                    $("#popCustListBody").append(html);
                });
            }

            $("#searchFromDate").val(data.search.searchFromDate);
            $("#searchToDate").val(data.search.searchToDate);
            $("#popCust").css("display", "block");
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


//-----------------------------------------------------------------------
// 콜백
//-----------------------------------------------------------------------
function fn_clickPopCust(obj) {
     $("#popCust").css("display", "none");

     try{
         fn_popCust_callback(obj);
     } catch(e){
         alert("팝업 콜백함수(fn_popCust_callback)가 선언되어 있지 않습니다.");
     }
}
-->
</script>


<form:form commandName="search" id="popCustForm" name="popCustForm">
<input type="hidden" name="parentIdx"  value=""/>
<input type="hidden" name="custTypeCd" value=""/><!--  납품처 -->


    <div id="popCust" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">납품처 선택</div>
                <span class="modal-close-button">×</span>
            </div> 
            <div class="card mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                <div class="card-header">
                       <div id="btnPopCustSearch" class="button-cr radius blue" style="float:right;margin:6px 5px 0 -44px;position:relative;">
                            <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                       </div>
                      <div style="float:right;margin:6px 5px;">
                          <input type="text" style="display:none;" />
                          <input type="text" class="form-control input-lg radius" size="35" placeholder="거래처명" id="custNm" name="custNm" value="" />
                      </div>
                </div>
                <div class="card mb-4" style="margin-top:0px; margin-left:30px; margin-right:30px;">
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="tb_wrap">
                                    <div class="tb_box">
                                        <table class="table table-borderless table-borderbottom dataTable table-hover" id="popCustTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width:100%;table-layout:fixed;">
                                            <thead class="thead-dark">
                                                <tr role="row" class="odd fixed_top">
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:10%;">코드</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:10%;">거래처명</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:10%;">업체구분</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:10%;">자재구분</th>
                                                </tr>
                                            </thead>
                                            <tbody id="popCustListBody"/>
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


</form:form>