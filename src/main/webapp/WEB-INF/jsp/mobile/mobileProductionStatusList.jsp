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
    <title>PowerMES</title>
    <style>
        dl dt {
            background:#5f9be3;
            color:#fff;
            float:left; 
            font-weight:bold; 
            /* margin-right:10px; */
            margin:3.5px 0;
            padding:5px 0;
            width:100px; 
        }
         
        dl dd {
            background:#b5d1f3;
            margin:3.5px -20px 2px 7px; 
            padding:5px 0;
        }
        
        .tb_wrap {
          position:relative;
          width:100%;
        /*    margin:20px auto; */
            padding-top:43px;
        }
        .tb_box {
          max-height:275px;
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
                $('#btnClose, #btnOut').click(function() {
                    var frm = document.searchForm;
                    frm.action = "<c:url value='/mobileProductionListPage.do'/>";
                    frm.submit();
                });
                
                $('#btnEnd').click(function() {
                     $( "#end_confirm" ).dialog( "open" );
                });
                
                $( "#end_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "작업종료",
                            click: function() {
                                var frm = document.searchForm;
                                frm.prodTypeCd.value = "END";
                                frm.searchProdSeq.value = frm.prodSeq.value;
                                
                                $.ajax({
                                    url : "<c:url value='/productionActUpdateAct.do'/>",
                                    type: 'POST',
                                    data: $('#searchForm').serialize(),
                                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                                    context:this,
                                    dataType:'json',
                                    beforeSend:function(){
                                        $("#layoutSidenav").loading();
                                    },
                                    success: function(data) {
                                        if(!cfCheckRtnObj(data.rtn)) return;
                                        //cfAlert('작업이 종료 되었습니다.');
                                        
                                        frm.searchProdSeq.value = "";
                                        $( "#glvForm" ).html("searchForm");
                                        $( "#glvLink" ).html("<c:url value='/mobileProductionListPage.do'/>");
                                        cfAlertAnGo('작업이 종료 되었습니다.');
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
                        },
                        {
                            text: "취소",
                            click: function() {
                                $( this ).dialog( "close" );
                            }
                        }
                    ]
                });
                
                $('#btnSave').click(function() {
                    var frm = document.productionActForm;
                    
                    frm.actbadViewQty.value = $("#actbadViewQty").val();
                    
                    $.ajax({
                        url : "<c:url value='/updateActbadQtyAct.do'/>",
                        type: 'POST',
                        data: $('#productionActForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            if(!cfCheckRtnObj(data.rtn)) return;
                            cfAlert('변경 되었습니다.');
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
                
                $(".input_number").on("keyup", function(event) {
                    $(this).val($(this).val().replace(/[^0-9]/g,""));
                })
                
                //-------------------------------------------------------------
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                     drawProductionStatusList();
                     setInterval(drawProductionStatusList, 30000);
                 });
                 
                 //-------------------------------------------------------------
                 // 재고 목록 Draw
                 //-------------------------------------------------------------
                 drawProductionStatusList = function() {
                    $.ajax({
                        url : "<c:url value='/mobileProductionStatusListData2.do'/>",
                        type: 'POST',
                        data: $('#searchForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#productionStatusListBody tr").remove();
                            $("#dataTable_wrapper").loading();
                        },
                        success: function(data) {
                            if(!cfCheckRtnObj(data.rtn)) return;
                            var html = "";
                            $.each(data.rtn.obj, function(index, val) {
                                html = "";
                                html += "<tr id=\"tableRow"+val.rnum+"\" role=\"row\" class=\"odd\">";
                                html += "<td class=\"text-ellipsis\" style=\"width:13%\"><span>"+val.rnum+"</span></td>";
                                html += "<td class=\"text-ellipsis\" style=\"width:18%\"><span>"+val.nowWorkCnt+"</span></td>";
                                //html += "<td class=\"text-ellipsis\" style=\"width:18%\"><span>"+val.nowErrCnt+"</span></td>";
                                html += "<td class=\"text-ellipsis\" style=\"width:18%\"><span>0</span></td>";
                                html += "<td class=\"text-ellipsis\" style=\"width:33%\"><span>"+val.writeDate+"</span></td>";
                                html += "</tr>";
                                
                                $("#productionStatusListBody").append(html);
                                if( index == 0 ) {
                                    $("#dlProductionStatus > dd:nth-child(8)").text(val.workCnt);
                                    //$("#dlProductionStatus > dd:nth-child(10)").text(val.errCnt);
                                    $("#dlProductionStatus > dd:nth-child(10)").text(0);
                                }
                                
                                //if( index > 5 ) return false;
                            });
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(result) {
                            $("#dataTable_wrapper").loadingClose();
                        }
                    });
                      
                    
                 }
            });
        })(jQuery);
        
        //=====================================================================
        // button action funtion
        //===================================================================== 
        
        -->
    </script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
<div id="layoutSidenav"></div>
    <div class="card">
        <div class="card-body">
            
<!--             <div class="row"> -->
<!--                 <div class="col-md-12"> -->
<!--                     <div class="card-header"> -->
<!--                         <sapn>공정실적 </sapn> -->
<!--                         <div id="btnClose" class="btn-logout mr-2" style="float: right;"><i class="xi-close-circle-o"></i> 닫기</div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
            
            <div class="row">
                <div class="col-md-7">
                    <div id="card-list" class="card card-roundbox" style="padding: 0 5px; overflow-y:auto;">
                        <div class="card-body" style="padding: 0px;">
                            <div class="card mb-1" style="padding: 0 5px;">
                                <div class="card-body" style="padding: 12px;">
                                    <div class="row" style="margin-bottom:5px;">
                                        <div class="col-md-12" style="padding:0 5px;">
                                            <div class="btn btn-warning btn-block">
                                                <div style="height: 20px; font-size:x-large; padding:0px;font-size: 1.0em;">${productionActVo.itemNm}</div>
                                                <div style="height: 40px; font-size:x-large; padding:0px;font-weight: bold; font-size: 2.0em;">${productionActVo.prodPoNo}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
        
                            <div class="card mb-1" style="padding: 0 5px; height:74%;">
                                <div class="card-body" style="padding: 6px;height:330px;">
                                    <div class="table-responsive">
                                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                            <div class="tb_wrap">
                                                <div class="tb_box">
                                                    <table class="table table-borderless table-borderbottom dataTable table-hover tb" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
                                                        <thead class="thead-dark">
                                                            <tr role="row" class="odd fixed_top">
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 13%;">NO</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 18%;">양품</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 18%;">불량</th>
                                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 33%;">일시</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="productionStatusListBody"/>
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
                
                <div class="col-md-5">
                    <div id="card-form" class="card card-roundbox" style="padding: 0 5px;">
                        <div class="card-body" style="padding: 0px;">
                            <div class="card mb-1" style="padding: 0 5px;">
                                <div class="card-body" style="padding: 12px;">
                                    <div class="row" style="margin-bottom:5px;">
                                        <div class="col-md-12" style="padding:0 5px;">
                                            <div class="btn btn-blue btn-block">
                                                <div id="btnStop" style="height: 60px; font-size:x-large; padding:12px;">공정실적</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-md-12 pl-4">
                                    
                                    <dl id="dlProductionStatus" class="row text-center col-md-12">
                                        <dt class="col-sm-6">제품명</dt>
                                        <dd class="col-sm-6">${productionActVo.itemNm}</dd>
                                        <dt class="col-sm-6">작업일자</dt>
                                        <dd class="col-sm-6">
                                            <fmt:parseDate value="${productionActVo.workDt}" var="convWorkDt" pattern="yyyyMMdd"/>
                                            <fmt:formatDate pattern="yyyy/MM/dd" value="${convWorkDt}" />
                                        </dd>
                                        <dt class="col-sm-6">계획수량</dt>
                                        <dd class="col-sm-6">${productionActVo.poQty}</dd>
                                        <dt class="col-sm-6">양품수량</dt>
                                        <dd class="col-sm-6"></dd>
                                        <dt class="col-sm-6">불량수량</dt>
                                        <dd class="col-sm-6"></dd>
                                        <%-- <dt class="col-sm-6">육안검사불량</dt>
                                        <dd class="col-sm-6">
                                            <div style="float: right;">
                                                <div class="btn btn-sm btn-blue btn-block">
                                                    <div id="btnSave">저장</div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6" style="float: right;">
                                                <input type="text" id="actbadViewQty" name="actbadViewQty" class="input_number form-control form-control-sm" maxlength="4" style="width:100%; text-align:center;" value="${productionActVo.actbadViewQty}"/>
                                            </div>
                                        </dd> --%>
                                    </dl>
                                </div>
                            </div>
                            
                            <div class="row mb-2 pl-3 pr-3">
                                <div class="col-md-6">
                                    <div class="btn btn-blue btn-block">
                                        <div id="btnEnd" style="font-size:x-large;">작업종료</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="btn btn-blue btn-block">
                                        <div id="btnOut" style="font-size:x-large;">화면나가기</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            <!-- row -->
        </div>
        <!-- card-body -->
    </div>
    <!-- card -->
        
    
<form:form commandName="search" id="searchForm" name="searchForm">
    <input type="hidden" name="searchProdSeq" value=""/>
    <input type="hidden" name="workactSeq" value="${productionActVo.workactSeq}"/>
    <input type="hidden" name="prodSeq" value="${productionActVo.prodSeq}"/>
    <input type="hidden" name="workDt" value="${productionActVo.workDt}"/>
    <input type="hidden" name="operCd" value="${productionActVo.operCd}"/>
    <input type="hidden" name="prodTypeCd" value="${productionActVo.prodTypeCd}"/>
    <input type="hidden" name="equipCd" value="${productionActVo.equipCd}"/>
</form:form>

<form:form commandName="productionAct" id="productionActForm" name="productionActForm">
    <input type="hidden" name="workactSeq" value="${productionActVo.workactSeq}"/>
    <input type="hidden" name="prodSeq" value="${productionActVo.prodSeq}"/>
    <input type="hidden" name="prodTypeCd" value="${productionActVo.prodTypeCd}"/>
    <input type="hidden" name="operCd" value="${productionActVo.operCd}"/>
    <input type="hidden" name="actbadViewQty" value="${productionActVo.actbadViewQty}"/>
    <input type="hidden" name="equipCd" value="${productionActVo.equipCd}"/>
</form:form>


<div id="end_confirm" title="확인" style="display:none;">
    <div style="font-size:1.3em; text-align:center; margin-top:20px;">
        <p>작업종료 하시겠습니까 ?</p>
    </div> 
</div>

<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>
<script>

</script>
</body>
</html>