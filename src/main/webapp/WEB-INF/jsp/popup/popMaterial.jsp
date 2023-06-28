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
	$("input[name=searchMatTypeCd]").val('<c:out value="${param.searchMatTypeCd}" />');
	
    $('#btnPopMaterialSearch').click(function() {
        var frm = document.popMaterialForm;
        var idx = frm.parentIdx.value;
        fn_popMaterialList(frm.searchMatNm.value);
    });

     // 팝업 닫기
    $('#popMaterialClose').click(function() {
        $('#popMaterial').css("display", "none");
    });


    // 팝업 닫기
    $('.modal-close-button').click(function() {
        $('.modal-container').css("display", "none");
    });
});

//-----------------------------------------------------------------------
// 팝업 호출
//-----------------------------------------------------------------------
function fn_popMaterialList(searchMatNm) {
    var frm = document.popMaterialForm;
    frm.searchMatNm.value = searchMatNm;

    //ajax submit
    fn_popMaterialSubmit();
}


//-----------------------------------------------------------------------
// ajax
//-----------------------------------------------------------------------
function fn_popMaterialSubmit() {
    $.ajax({
        url : "<c:url value='/getPopMaterialList.do'/>",
        type: 'POST',
        data: $('#popMaterialForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        beforeSend:function(){
            $("#popMaterialListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
            if(data.rtn.obj == null || '' == data.rtn.obj) {
            var html = "";
                html += "<tr>";
                html += "<td colspan=\"6\" class=\"no-data\">- 표시할 내용이 없습니다. -</td>";
                html += "</tr>";
               $("#popMaterialListBody").append(html);
            }else{
                $.each(data.rtn.obj, function(key, val){
                	var temp = {};
                	temp.matCd	 	= val.matCd;
                	temp.matNm	 	= val.matNm;
                	temp.matCustCd	= val.matCustCd;
                	temp.matCustNm	= val.matCustNm;
                	temp.stndVal 	= val.stndVal;
                	temp.tolrVal 	= val.tolrVal;
                	temp.lenVal	 	= val.lenVal;
                	temp.lenCd	 	= val.lenCd;
                	temp.lenNm	 	= val.lenNm;
                	temp.unitVal 	= val.unitVal;
                	temp.unitCd	 	= val.unitCd;
                	temp.unitNm	 	= val.unitNm;
                	var materialObj = JSON.stringify(temp).replace(/\"/gi, "\'");
                	
                	var html = "";
                    html += "<tr role=\"row\" class=\"odd\">";
                    html += "    <td class=\"text-ellipsis\" style=\"width:12%;\"><span>"+val.matCd+"</span></td>";
                    html += "    <td class=\"text-ellipsis\" style=\"width:20%;\"><span><a href=\"javascript:fn_clickPopMaterial(eval(" + materialObj + "));\">"+val.matNm+"</a></span></td>";
                    html += "    <td class=\"text-ellipsis\" style=\"width:14%;\"><span>"+val.stndVal+"</span></td>";
                    html += "    <td class=\"text-ellipsis\" style=\"width:20%;\"><span>"+val.matCustNm+"</span></td>";
                    html += "    <td class=\"text-ellipsis\" style=\"width:12%;\"><span>"+cfAddComma(val.lenVal)+"</span></td>";
                    html += "    <td class=\"text-ellipsis\" style=\"width:12%;\"><span>"+val.lenNm+"</span></td>";
                    html += "</tr>";
                    $("#popMaterialListBody").append(html);
                });
            }
            
            $("#popMaterial").css("display", "block");

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
function fn_clickPopMaterial(obj) {
     $("#popMaterial").css("display", "none");

     try{
         fn_popMaterial_callback(obj);
     } catch(e){
         alert("팝업 콜백함수(fn_popMaterial_callback)가 선언되어 있지 않습니다.");
     }
}
-->
</script>


<form:form commandName="search" id="popMaterialForm" name="popMaterialForm">
<input type="hidden" name="parentIdx" value=""/>
<input type="hidden" name="searchMatTypeCd" value=""/>


    <div id="popMaterial" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">자재 선택</div>
                <span class="modal-close-button">×</span>
            </div> 
            <div class="card mb-4">
                <div class="card-header">
                       <div id="btnPopMaterialSearch" class="button-cr radius blue" style="float:right;margin:6px 5px 0 -44px;position:relative;">
                            <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                       </div>
                      <div style="float:right;margin:6px 5px;">
                          <input type="text" style="display:none;" />
                           <input type="text" class="form-control input-lg radius" size="35" placeholder="자재명" id="searchMatNm" name="searchMatNm" value="" />
                      </div>
                </div>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="tb_wrap">
                                    <div class="tb_box">
                                        <table class="table table-borderless table-borderbottom dataTable table-hover" id="popMaterialTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width:100%;">
                                            <thead class="thead-dark">
                                                <tr role="row" class="odd fixed_top">
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:12%;">코드</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:20%;">자재명</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:14%;">규격</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:20%;">자재처</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:12%;">길이</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:12%;">단위</th>
                                                </tr>
                                            </thead>
                                            <tbody id="popMaterialListBody"/>
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