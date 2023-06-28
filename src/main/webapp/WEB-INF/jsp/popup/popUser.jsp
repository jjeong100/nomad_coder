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
    $('#btnPopUserSearch').click(function() {
        var frm = document.popUserForm;
        var idx = frm.parentIdx.value;
        fn_popUserList(frm.searchLoginName.value);
    });


     // 팝업 닫기
    $('#popUserClose').click(function() {
        $('#popUser').css("display", "none");
    });


    // 팝업 닫기
    $('.modal-close-button').click(function() {
        $('.modal-container').css("display", "none");
    });
});


//-----------------------------------------------------------------------
// 팝업의 리스트 클릭시
//-----------------------------------------------------------------------
function fn_clickPopUserList(shortId,loginName) {
    var param = {};
    param.shortId = shortId;
    param.loginName = loginName;


    fn_clickPopUser(param);
}


//-----------------------------------------------------------------------
// 팝업 호출
//-----------------------------------------------------------------------
function fn_popUserList(searchLoginName) {
    var frm = document.popUserForm;
    frm.searchLoginName.value = searchLoginName;


    //ajax submit
    fn_popUserSubmit();
}


//-----------------------------------------------------------------------
// ajax
//-----------------------------------------------------------------------
function fn_popUserSubmit() {
    $.ajax({
        url : "<c:url value='/getPopUserList.do'/>",
        type: 'POST',
        data: $('#popUserForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        beforeSend:function(){
            $("#popUserListBody tr").remove();
            $("#layoutSidenav").loading();
        },
        success: function(data) {
            if(data.rtn.obj == null || '' == data.rtn.obj) {
            var html = "";
                html += "<tr>";
                html += "<td colspan=\"6\" class=\"no-data\">- 표시할 내용이 없습니다. -</td>";
                html += "</tr>";
               $("#popUserListBody").append(html);
            }else{
                $.each(data.rtn.obj, function(key, val){
                var html = "";
                    html += "<tr role=\"row\" class=\"odd\">";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.rnum+"</span></td>";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.shortId+"</span></td>";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.loginId+"</span></td>";
                    html += "    <td class=\"text-ellipsis\"><span><a href=\"javascript:fn_clickPopUserList('"+val.shortId+"','"+val.loginName+"');\">"+val.loginName+"</a></span></td>";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.sabunId+"</span></td>";
                    html += "    <td class=\"text-ellipsis\"><span>"+val.mobileNo+"</span></td>";
                    html += "</tr>";
                    $("#popUserListBody").append(html);
                });
            }


            $("#searchFromDate").val(data.search.searchFromDate);
            $("#searchToDate").val(data.search.searchToDate);
            $('#popUser').css("display", "block");
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
function fn_clickPopUser(obj) {
     $('#popUser').css("display", "none");


     try{
         fn_popUser_callback(obj);
     } catch(e){
         alert("팝업 콜백함수(fn_popUser_callback)가 선언되어 있지 않습니다.");
     }
}
-->
</script>


<form:form commandName="search" id="popUserForm" name="popUserForm">
<input type="hidden" name="parentIdx" value=""/>


    <div id="popUser" class="modal-container" style="z-index:99999999999999">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">작업자 선택</div>
                <span class="modal-close-button">×</span>
            </div> 
            <div class="card mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                <div class="card-header">
                       <div id="btnPopUserSearch" class="button-cr radius blue" style="float:right;margin:6px 5px 0 -44px;position:relative;">
                            <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                       </div>
                      <div style="float:right;margin:6px 5px;">
                          <input type="text" style="display:none;" />
                           <input type="text" class="form-control input-lg radius" size="35" placeholder="작업자명" id="searchLoginName" name="searchLoginName" value="" />
                      </div>
                </div>
                <div class="card mb-4" style="margin-top:0px; margin-left:30px; margin-right:30px;">
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="tb_wrap">
                                    <div class="tb_box">
                                        <table class="table table-borderless table-borderbottom dataTable table-hover" id="popUserTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width:100%;table-layout:fixed;">
                                            <thead class="thead-dark">
                                                <tr role="row" class="odd fixed_top">
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:20%;">No</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:10%;">숏아이디</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:20%;">아이디</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:15%;">이름</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:20%;">사번</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width:15%;">전화번호</th>
                                                </tr>
                                            </thead>
                                            <tbody id="popUserListBody"/>
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