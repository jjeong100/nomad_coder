<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"          uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <title>공정권한 관리</title>

    <script type="text/javaScript" language="javascript" defer="defer"> 
        <!--
        //=====================================================================
        // jquery logic
        //=====================================================================
        (function($) {
            $(function(){
                //-------------------------------------------------------------
                // declare gloval 
                //-------------------------------------------------------------
                
                //-------------------------------------------------------------
                // jqery event 
                //-------------------------------------------------------------
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/operAuthListPage.do'/>";
                    frm.submit();
                });
                
                $(".input_number").on("keyup", function(event) {
                    $(this).val($(this).val().replace(/[^0-9.+-]/g,""));
                });
                
                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/operAuthListPage.do'/>";
                    frm.submit();
                });
                
                //-------------------------------------------------------------
                // 컬럼 소트 이벤트
                //------------------------------------------------------------- 
                $('#dataTable').find('th').not('.no-sort').click(function() {
                    var frm = document.searchForm;
                    var sortCol = $(this).attr("id");
                    frm.sortCol.value = sortCol;
                    var sortColType = $(this).attr('class');
                    if (sortColType == 'sorting_asc') {
                        frm.sortType.value = 'desc'
                    } else {
                        frm.sortType.value = 'asc'
                    }
                    frm.action = "<c:url value='/operAuthListPage.do'/>";
                    frm.submit();
                });
                
                //-------------------------------------------------------------
                // 엑셀 다운로드 이벤트
                //-------------------------------------------------------------
                $('#btnExcel').click(function() {
                    downloadExcelFromTable($('#dataTable'));
                });
                
                //-------------------------------------------------------------
                // 수정 이벤트
                //-------------------------------------------------------------
                $('span[name="btnOperAuthUpdate"]').click(function() {
                    document.operAuthForm.crudType.value = "U";
                    
                    $("#operAuthCd").val($('#'+$(this).data("key")+'_operAuthCd').html());
                    $("#operAuthNm").val($('#'+$(this).data("key")+'_operAuthNm').html());
                    $("#sortOrd").val($('#'+$(this).data("key")+'_sortOrd').html());
                    
                    $( "#oper_auth_confirm" ).dialog( "open" );
                });
                
                  //-------------------------------------------------------------
                // 생성 이벤트
                //-------------------------------------------------------------
                $('#btnCreate').click(function() {
                    document.operAuthForm.crudType.value = "C";
                    $( "#oper_auth_confirm" ).dialog( "open" );
                });
              
                  //-------------------------------------------------------------
                // 권한내역조회 이벤트
                //-------------------------------------------------------------
                $('span[name="btnOperAuthDtlView"]').click(function() {
                    drawOperAuthDtlList($(this).data("key"));
                });
                  
                drawOperAuthDtlList = function(operAuthCd) {
                    document.operAuthDtlForm.operAuthCd.value = operAuthCd;
                    
                    $.ajax({
                        url : "<c:url value='/getOperAuthDtlListData.do'/>",
                        type: 'POST',
                        data: $('#operAuthDtlForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            
                            $("#operAuthDtlListBody tr").remove();
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            if(!cfCheckRtnObj(data.rtn)) return;
                            var html = "";
                            $.each(data.rtn.obj, function(index, val){
                                html = "";
                                html += "<tr role=\"row\" class=\"odd\" style=\"display:table;width:100%;table-layout:fixed;\">";
                                html += "<td class=\"text-ellipsis\" style=\"width:23%\">";
                                html += "    <input type=\"hidden\" name=\"operAuthDtlList[" + index + "].operCd\" value=\"" + val.operCd + "\"/>";
                                html += "    <input type=\"checkbox\" class=\"input_check\" value=\"Y\" name=\"operAuthDtlList[" + index + "].operChkYn\" " + (cfIsNullString(val.operChkYn) == "Y" ? "checked":"") + " />";
                                html += "</td>";
                                html += "<td class=\"text-ellipsis text-center\" style=\"width:40%\"><span class=\"text-ellipsis\">"+val.operCd+"</span></td>";
                                html += "<td class=\"text-ellipsis text-center\" style=\"width:40%\"><span class=\"text-ellipsis\">"+val.operNm+"</span></td>";
                                html += "</tr>";
                                
                                $("#operAuthDtlListBody").append(html);
                            });
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                };
                
                  //-------------------------------------------------------------
                // 권한등록 이벤트
                //-------------------------------------------------------------
                $('#btnOperAuthSave').click(function() {
                    $.ajax({
                        url : "<c:url value='/operAuthDtlSaveAct.do'/>",
                        type: 'POST',
                        data: $('#operAuthDtlForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            if(!cfCheckRtnObj(data.rtn)) return;
                            cfAlert('변경 되었습니다.');
                            drawOperAuthDtlList(document.operAuthDtlForm.operAuthCd.value);
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                });
                
                //-------------------------------------------------------------
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                     if( ${not empty search.operAuthCd} ) {
                         drawOperAuthDtlList("${search.operAuthCd}");
                     } else {
                         if( $('span[name="btnOperAuthDtlView"]').length > 0 ) {
                             drawOperAuthDtlList($('span[name="btnOperAuthDtlView"]:eq(0)').data("key"));
                         }
                     }
                     
                 });
            });
        })(jQuery);
        
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/operAuthListPage.do'/>";
            frm.submit();
        }
        -->
    </script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp" ></jsp:include> 
    <div id="layoutSidenav">
        <!-- ==================================================================================================================================== -->
        <!-- menu                                                                                                                                 -->
        <!-- ==================================================================================================================================== -->
        <jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp" ></jsp:include>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <!-- ======================================================================================================================== -->
                    <!-- title                                                                                                                    -->
                    <!-- ======================================================================================================================== -->
                    <h1 class="mt-4">공정권한관리</h1>
                   
                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <sapn>공정권한 목록</sapn>
                           <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                           <div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">공정권한 추가</div>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                   <div class="row">
                                       <div class="col-sm-12 col-md-2" style="padding-top:5px;">
                                           <div class="dataTables_length" id="dataTable_length">
                                               <label>Show 
                                               <select id="pageSizeItem" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                                                   <option value="10">10</option>
                                                   <option value="25">25</option>
                                                   <option value="50">50</option>
                                                   <option value="100">100</option>
                                               </select> entries
                                               </label>
                                           </div>
                                       </div>
                                       
                                       <div class="col-sm-12 col-md-4" style="margin-bottom:5px;">
                                           <div id="dataTable_filter" class="dataTables_filter">
                                               <form:form commandName="search" id="searchForm" name="searchForm">
                                                   <input type="hidden" name="crudType" value="R"/>
                                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                                   <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                                                   <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                                                   <input type="hidden" name="sortType" value="${search.sortType}"/>
                                                   <input type="hidden" name="operAuthCd" value=""/>
                                                   <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
                                                   </div>
                                                   
                                                   <div style="float: right; margin: 6px 5px;">
                                                           <input type="text" class="form-control col-xs-2 input-lg radius" placeholder="공정권한명" id="searchOperAuthNm" name="searchOperAuthNm" value="${search.searchOperAuthNm}" />
                                                   </div>
                                                   
                                               </form:form>
                                           </div> 
                                       </div>
                                       
                                   </div>
                                   <div class="row">
                                       <div class="col-sm-6">
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                              <thead class="thead-dark">  
                                                  <tr role="row">
                                                      <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                      <th id="rnum"         class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">No</th>
                                                      <th id="oper_auth_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">공정권한코드</th>
                                                      <th id="oper_auth_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">공정권한명</th>
                                                      <th                   class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">권한조회</th>
                                                  </tr>
                                              </thead>
                                              <tbody>
                                                  <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">${item.rnum}</span></td>
                                                        <td class="text-ellipsis"><span class="oper_auth_cd">${item.operAuthCd}</span></td>
                                                        <td class="text-ellipsis"><span class="oper_auth_nm">${item.operAuthNm}</span></td>
                                                        <td class="text-ellipsis">
                                                            <div id="${item.operAuthCd}_operAuthCd" style="display:none;">${item.operAuthCd}</div>
                                                            <div id="${item.operAuthCd}_operAuthNm" style="display:none;">${item.operAuthNm}</div>
                                                            <div id="${item.operAuthCd}_sortOrd" style="display:none;">${item.sortOrd}</div>
                                                            <span name="btnOperAuthUpdate" class="btn btn-primary btn-sm" data-key="${item.operAuthCd}">수정</span>
                                                            <span name="btnOperAuthDtlView" class="btn btn-primary btn-sm" data-key="${item.operAuthCd}">조회</span>
                                                        </td>
                                                    </tr>
                                                  </c:forEach>
                                                  <c:if test="${fn:length(rtn.obj) le 0}">
                                                    <tr>
                                                        <td colspan="4" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                    </tr>
                                                  </c:if>
                                              </tbody>
                                              
                                           </table>
                                       </div>
                                       
                                       <div class="col-sm-6">
                                               <div class="card mb-1" style="padding: 0 5px; height:74%;">
                                                   <div class="card-body" style="padding:0px;">
                                                       <div class="tb_wrap">
                                                           <div class="tb_box">
                                                               <form:form commandName="search" id="operAuthDtlForm" name="operAuthDtlForm">
                                                                <input type="hidden" name="crudType" value="R"/>
                                                                <input type="hidden" name="operAuthCd" value=""/>
                                                                 <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                                                    <thead class="thead-dark" style="display:table;width:100%;table-layout:fixed;">
                                                                        <tr role="row">
                                                                            <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 23%;">선택</th>
                                                                            <th class="no-sort text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 40%;">공정코드</th>
                                                                            <th class="no-sort text-center" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 37%;">공정명</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="operAuthDtlListBody" style="display:block;max-height:260px;overflow:auto;table-layout:fixed;"/>
                                                                </table>
                                                            </form:form>
                                                        </div>
                                                    </div>
                                                  </div>
                                                </div>
                                        </div>
                                        
                                   </div>
                                   <!-- ======================================================================================================================== -->
                                   <!-- paging                                                                                                                   -->
                                   <!-- ======================================================================================================================== -->
                                   <div class="row">
                                       <div class="col-sm-12 col-md-3">
                                           <c:if test="${rtn.totCnt > 0}">
                                               <div class="dataTables_info" id="dataTable_info">Showing ${search.firstIndex+1} to ${search.lastIndex} of ${rtn.totCnt} entries</div>
                                           </c:if>
                                       </div>
                                       
                                       <div class="col-sm-12 col-md-3">
                                           <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                                               <ul class="pagination">
                                               
                                                   <c:set var="isLoof" value="true" />
                                                   <c:if test="${rtn.totCnt > 0}">
                                                       <c:if test="${search.pageIndex > 1}">
                                                           <li class="paginate_button page-item previous" id="dataTable_previous"><a href="javascript:fn_paging(${search.pageIndex-1})" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
                                                       </c:if>
                                                       <c:forEach begin="${search.startPage}" end="${search.endPage}" step="1" var="i">
                                                           <c:if test="${isLoof}">
                                                               <c:choose>
                                                                   <c:when test="${i == search.pageIndex}">
                                                                       <li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="${i}" tabindex="0" class="page-link">${i}</a></li>
                                                                   </c:when>
                                                                   <c:otherwise>
                                                                       <li class="paginate_button page-item "><a href="javascript:fn_paging(${i})" aria-controls="dataTable" data-dt-idx="${i}" tabindex="0" class="page-link">${i}</a></li>
                                                                   </c:otherwise>
                                                               </c:choose>
                                                               <c:if test="${rtn.totCnt <= (search.pageSize*i)}"><c:set var="isLoof" value="false" /></c:if>
                                                           </c:if>
                                                       </c:forEach>
                                                       <c:if test="${rtn.totCnt > (search.pageSize*search.pageIndex)}">
                                                           <li class="paginate_button page-item next" id="dataTable_next"><a href="javascript:fn_paging(${search.pageIndex+1})" aria-controls="dataTable" data-dt-idx="11" tabindex="0" class="page-link">Next</a></li>
                                                       </c:if>
                                                   </c:if> 
                                               </ul>
                                           </div>
                                       </div>
                                       
                                       <div class="col-sm-12 col-md-6">
                                           <div id="btnOperAuthSave" class="btn btn-primary btn-sm mr-2" style="float: right;">권한등록</div>
                                       </div>
                                       
                                   </div>
                                   <!-- page end -->
                               </div>
                           </div>
                       </div>
                   </div>
                   <!-- table card end -->
                </div>
            </main>
        </div>
        
    </div>
    


    <div id="oper_auth_confirm" title="공정권한" style="display:none;">
        <form:form commandName="operAuth" id="operAuthForm" name="operAuthForm">
            <input type="hidden" name="crudType" value=""/>
            
            <div class="col-md-12">
                <div class="form-row">
                    <div class="col-md-8">
                        <div class="form-group">
                            <label class="small mb-1" for="operAuthCd">권한코드</label>
                            <input class="form-control py-4" id="operAuthCd" name="operAuthCd" type="text" value="" placeholder="공정권한코드을 입력하세요"/>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label class="small mb-1" for="operAuthNm">권한명</label>
                            <input class="form-control py-4" id="operAuthNm" name="operAuthNm" type="text" value="" placeholder="공정권한명을 입력하세요"/>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label class="small mb-1" for="sortOrd">순번</label>
                            <input class="form-control py-4 input_number" id="sortOrd" name="sortOrd" type="text" value="" placeholder="순번을 입력하세요"/>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
    
    
<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include> 
<script>
//-------------------------------------------------------------
// 공정권한등록 팝업
//-------------------------------------------------------------
$( "#oper_auth_confirm" ).dialog({
    autoOpen: false,
    width: 400,
    open: function( event, ui ) {
        var crudType = document.operAuthForm.crudType.value;
        if( crudType == "C" ) {
            $(".ui-dialog-buttonset > button > span:contains('삭제')").hide();
        } else if( crudType == "U" ) {
            $(".ui-dialog-buttonset > button > span:contains('등록')").html("수정");
            $("#operAuthCd").attr("readOnly",true);
        }
    },
    buttons: [
        {
            text: "등록",
            click: function() {
                if (!fn_oper_auth_validation()) {
                    return false;
                }
                
                document.searchForm.operAuthCd.value = document.operAuthForm.operAuthCd.value;
                $( this ).dialog( "close" );
                
                cfAjaxCallAndGoLink("<c:url value='/operAuthSaveAct.do'/>"
                        ,$('#operAuthForm').serialize(),'등록 되었습니다.'
                        ,'searchForm'
                        ,"<c:url value='/operAuthListPage.do'/>");
            }
        },
        {
            text: "삭제",
            click: function() {
                if (!fn_oper_auth_validation()) {
                    return false;
                }
                
                document.operAuthForm.crudType.value = "D";
                document.searchForm.operAuthCd.value = document.operAuthForm.operAuthCd.value;
                $( this ).dialog( "close" );
                
                cfAjaxCallAndGoLink("<c:url value='/operAuthSaveAct.do'/>"
                        ,$('#operAuthForm').serialize(),'삭제 되었습니다.'
                        ,'searchForm'
                        ,"<c:url value='/operAuthListPage.do'/>");
            }
        },
        {
            text: "닫기",
            click: function() {
                $( this ).dialog( "close" );
            }
        }
    ]
});


function fn_oper_auth_validation() {
    if($("#operAuthCd").val().trim() == ''){
        alert(MSG_COM_ERR_001.replace("[@]", " : 공정권한코드"));
        $("#operAuthCd").focus();
        return false;
    }
    
    if($("#operAuthNm").val().trim() == ''){
        alert(MSG_COM_ERR_001.replace("[@]", " : 공정권한명"));
        $("#operAuthNm").focus();
        return false;
    }
    
    if($("#sortOrd").val().trim() == ""){
        $("#sortOrd").val("0");
    }
    return true;
}

function fn_operAuthSave() {
    $.ajax({
        url : "<c:url value='/operAuthSaveAct.do'/>",
        type: 'POST',
        data: $('#operAuthForm').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        context:this,
        dataType:'json',
        beforeSend:function(){
            $("#layoutSidenav").loading();
        },
        success: function(data) {
            if(!cfCheckRtnObj(data.rtn)) return;
            cfAlert('변경 되었습니다.');
            fn_paging(1);
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
</script>
</body>
</html>