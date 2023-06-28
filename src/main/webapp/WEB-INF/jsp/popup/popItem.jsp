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
    $('#btnPopItemSearch').click(function() {
        var frm = document.popItemForm;
        var idx = frm.parentIdx.value;
        
        fn_popItemList(frm.searchItemNm.value);
    });
    
  	//-------------------------------------------------------------
    // 컬럼 소트 이벤트
    //------------------------------------------------------------- 
    $('#popItemTable').find('th').not('.no-sort').click(function() {
        var frm = document.popItemForm;
        var sortCol = $(this).attr("id");
        frm.sortCol.value = sortCol;
        var sortColType = $(this).attr('class');
        if (sortColType == 'sorting_asc') {
            frm.sortType.value = 'desc'
        } else {
            frm.sortType.value = 'asc'
        }
        
        fn_popItemSubmit();
    });


     // 팝업 닫기
    $('#popItemClose').click(function() {
        $('#popItem').css("display", "none");
    });


    // 팝업 닫기
    $('.modal-close-button').click(function() {
        $('.modal-container').css("display", "none");
    });
});


//-----------------------------------------------------------------------
// 팝업의 리스트 클릭시
//-----------------------------------------------------------------------
function fn_clickPopItemList(itemCd,itemNm) {
    var param = {};
    param.itemCd = itemCd;
    param.itemNm = itemNm;

    fn_clickPopItem(param);
}


//-----------------------------------------------------------------------
// 팝업 호출
//-----------------------------------------------------------------------
function fn_popItemList(ItemNm) {
    var frm = document.popItemForm;
    frm.searchItemNm.value = ItemNm;

    //ajax submit
    fn_popItemSubmit();
}


//-----------------------------------------------------------------------
// ajax
//-----------------------------------------------------------------------
function fn_popItemSubmit() {
    $.ajax({
        url : "<c:url value='/getItemListData.do'/>",
        type: 'POST',
        data: $('#popItemForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        beforeSend:function(){
            $("#popItemListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
        	var html = "";
        	
        	if(data.rtn.obj == null || '' == data.rtn.obj) {
                var html = "";
                    html += "<tr>";
                    html += "<td colspan=\"7\" class=\"no-data\">- 표시할 내용이 없습니다. -</td>";
                    html += "</tr>";
                $("#popItemListBody").append(html);
            } else {
	            $.each(data.rtn.obj, function(key, val) {
	            	var itemObj = JSON.stringify(val).replace(/\"/gi, "\'");
	                
	                html = "";
	                html += "<tr role=\"row\" class=\"odd\">";
	                html += "<td class=\"text-ellipsis\" style=\"width: 10%;\"><span>"+val.itemCd+"</span></td>";
	                html += "<td class=\"text-ellipsis\" style=\"width: 15%;\"><span><a href=\"javascript:fn_clickPopItem(eval(" + itemObj + "))\">"+val.itemNm+"</a></span></td>";
	                html += "<td class=\"text-ellipsis\" style=\"width: 10%;\"><span>" + cfIsNullString(val.itemNo) + "</span></td>";
	                html += "<td class=\"text-ellipsis\" style=\"width: 10%;\"><span>" + cfIsNullString(val.stndVal, "-") + "</span></td>";
	                html += "<td class=\"text-ellipsis\" style=\"width: 10%;\"><span>" + cfIsNullString(val.tolrVal, "-") + "</span></td>";
	                html += "<td class=\"text-ellipsis\" style=\"width: 10%;\"><span>" + cfAddComma(cfIsNullString(val.lenVal, 0)) + " " + cfIsNullString(val.lenNm, "") + "</span></td>";
	                html += "<td class=\"text-ellipsis\" style=\"width: 10%;\"><span>" + cfAddComma(cfIsNullString(val.unitVal, 0)) + " " + cfIsNullString(val.unitNm, "") + "</span></td>";
	                html += "<td class=\"text-ellipsis\" style=\"width: 15%;\"><span>" + cfIsNullString(val.custNm) + "</span></td>";
	                html += "</tr>";
	                
	                $("#popItemListBody").append(html);
	            });
            }
        	
            $("#searchFromDate").val(data.search.searchFromDate);
            $("#searchToDate").val(data.search.searchToDate);
            $('#popItem').css("display", "block");
            
            document.popItemForm.sortType.value = data.search.sortType;
            document.popItemForm.sortCol.value = data.search.sortCol;
            
            if (data.search.sortType == 'asc') {
                $("#"+data.search.sortCol).attr('class','sorting_asc'); 
            } else {
                $("#"+data.search.sortCol).attr('class','sorting_desc');
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
}


//-----------------------------------------------------------------------
// 콜백
//-----------------------------------------------------------------------
function fn_clickPopItem(obj) {
     $('#popItem').css("display", "none");


     try{
         fn_popItem_callback(obj);
     } catch(e){
         alert("팝업 콜백함수(fn_popItem_callback)가 선언되어 있지 않습니다.");
     }
}
-->
</script>


<form:form commandName="search" id="popItemForm" name="popItemForm">
<input type="hidden" name="parentIdx" value=""/>
<input type="hidden" name="sortCol" value="item_cd"/>
<input type="hidden" name="sortType" value="asc"/>


    <div id="popItem" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">제품 선택</div>
                <span class="modal-close-button">×</span>
            </div> 
            <div class="card mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                <div class="card-header">
                       <div id="btnPopItemSearch" class="button-cr radius blue" style="float:right;margin:6px 5px 0 -44px;position:relative;">
                            <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                       </div>
                       <div style="float:right;margin:6px 5px;">
                           <input type="text" style="display:none;" />
                           <input type="text" class="form-control input-lg radius" size="35" placeholder="품명" id="searchItemNm" name="searchItemNm" value="" />
                      </div>
                </div>
                <div class="card mb-4" style="margin-top:0px; margin-left:30px; margin-right:30px;">
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="tb_wrap">
                                    <div class="tb_box">
                                        <table class="table table-borderless table-borderbottom dataTable table-hover" id="popItemTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width:100%;">
                                            <thead class="thead-dark">
                                                <tr role="row" class="odd fixed_top">
                                                    <th id="item_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">제품코드</th>
                                                    <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">제품명</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">품번</th> 
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">규격</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">공차</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">길이</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">무게</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">고객사</th>
                                                </tr>
                                            </thead>
                                            <tbody id="popItemListBody"/>
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