<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
<title>작업지시 관리</title>
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
                $("#searchFromDate, #searchToDate").datepicker({
                    showOn : "button",
                    buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                    buttonImageOnly : true,
                    buttonText : "Select date",
                    dateFormat : "yy/mm/dd"
                });
                $("#searchFromDate, #searchToDate").change(function(){
                    if($("#searchFromDate").val() > $("#searchToDate").val()){
                    	alert("날짜 FROM은 날짜 TO보다 적어야 합니다");
                    	$("#searchFromDate").val('${search.searchFromDate}');
                    	$("#searchToDate").val('${search.searchToDate}');
                    }
                })

                //-------------------------------------------------------------
                // jqery event
                //-------------------------------------------------------------
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/productionOrderListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                    var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/productionOrderListPage.do'/>";
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
                    frm.action = "<c:url value='/productionOrderListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 엑셀 다운로드 이벤트
                //-------------------------------------------------------------
                $('#btnExcel').click(function() {
                    downloadExcelFromTable($('#dataTable'));
                });

                //-------------------------------------------------------------
                // 생성 이벤트
                //-------------------------------------------------------------
                $('#btnCreate').click(function() {
                    var frm = document.searchForm;
                    frm.crudType.value = 'C';
                    frm.action = "<c:url value='/productionOrderDtlPage.do'/>";
                    frm.submit();
                });


                  //-------------------------------------------------------------
                // 팝업 닫기
                //-------------------------------------------------------------
                $('.modal-close-button').click(function() {
                    $('.modal-container').css("display", "none");
                });

                  //-------------------------------------------------------------
                // 바코드 출력
                //-------------------------------------------------------------
                $('#btnBarCodePrint').click(function() {
                    var selectedTab = $("#tabs").tabs('option', 'active');

                    //0일때 바코드
                    //1일때 QR코드
                    var childName = "previewBarCode";
                    if(selectedTab != "0") childName = "previewQrCode";

                    if( $("#barcodePrinter").val() == "" ) {
                        cfAlert("프린터를 선택하세요.");
                        return false;
                    }

                    var barcodeDivObj = $("div[name="+childName+"Child]");
                    var arrImageData = [];
                    var deferred = $.Deferred();

                    barcodeDivObj.each(function(idx, obj) {
                        html2canvas($(obj), {
                            height: $(obj).outerHeight(),
                            background: "white",
                            onrendered: function(canvas) {
                                arrImageData.push(canvas.toDataURL("image/png"));

                                 // 전체 이미지 추출 후 프린트
                                if( idx == barcodeDivObj.length-1 ) {
                                    deferred.resolve("end," + arrImageData.length);
                                }
                            }
                        });
                    });

                    deferred.done(function(message) {
                        console.log("resolve:" + message);

                        $.ajax({
                            url : "<c:url value='/labelMultiImageConvertPrint.do'/>",
                            type: "POST",
                            data: {
                                imageData: arrImageData,
                                IpAdress: $("#barcodePrinter").val(),
                                Port: '<spring:eval expression="@property['Globals.print.port']"/>',
                                Count: 1
                            },
                            contentType: "application/x-www-form-urlencoded; charset=UTF-16",
                            context:this,
                            dataType:"json",
                            beforeSend:function(){
                                $("#previewBarCode").loading();
                            },
                            success: function(data) {
                                var resultMessage = data.resultMessage;
                                cDialog("확인",resultMessage,null);
                            },
                            error: function(request, status, error){
                                cDialog("확인","시스템 오류입니다.\n관리자에게 문의해주세요",null);
                            },
                            complete:function(){
                                $("#previewBarCode").loadingClose();
                            }
                        });
                    }).fail(function(error) {
                        console.log(error);
                    }).always(function() {
                        console.log('완료!');
                    });
                });

                //-------------------------------------------------------------
                // 바코드 출력 팝업
                //-------------------------------------------------------------
                $('#btnPrintBarCode').click(function() {
                    var barCodeCnt = $("input:checkbox[name=rowCheckBox]:checked").length;

                    if( barCodeCnt == 0 ) {
                        cfAlert("선택된 목록이 없습니다.");
                        return false;
                    }

                    if( barCodeCnt > 10 ) {
                        cfAlert("바코드출력은 10개까지만 가능합니다.");
                        return false;
                    }

                    // width:640, height:424 사이즈로 나와야 용지 사이즈에 맞음.
                    $("#previewBarCode div").remove();
                    $("#previewQrCode div").remove();

                    var html = "";
                    $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
                        ///////////// BAR CODE
                        html = createHtmlBarCode($(this).val());
                        $("#previewBarCode").append(html);
                        $('#'+$(this).val()).barcode($(this).val(), "code128",{barWidth:3, barHeight:60,showHRI:false,bgColor:"white", output:'css'});


                        ///////////// QR CODE
                        /* html = createHtmlQrCode($(this).val());
                        $("#previewQrCode").append(html);

                        var qrcode = new QRCode(document.getElementById($(this).val()+"_qr"), {
                            text: $(this).val(),
                            width: 200,
                            height: 200,
                            colorDark : "#000000",
                            colorLight : "#ffffff",
                            correctLevel : QRCode.CorrectLevel.H
                        }); */

                       $("#"+$(this).val()+"_qr > img").css({"margin":"auto"});
                    });
                    $('#barcodePrintModal').css("display", "block");
                });

                //-------------------------------------------------------------
                // onLoad
                //-------------------------------------------------------------
                 $(document).ready(function(){
                     $( "#tabs" ).tabs();
                     $("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
                     if (document.searchForm.sortType.value == 'asc') {
                         $("#${search.sortCol}").attr('class','sorting_asc');
                     } else {
                         $("#${search.sortCol}").attr('class','sorting_desc');
                     }

                     $("#searchFromDate").val("${search.searchFromDate}");
                     $("#searchToDate").val("${search.searchToDate}");

                     /** ajax조회 **/
                     $("#searchItemCd").select2();
                     
                     /** 최상위 올리기 **/
                     $("#btnSearch").css("z-index",9999);
                 });
            });
        })(jQuery);

        //=====================================================================
        // button action funtion
        //=====================================================================
        function fn_go_dtl_page(id) {
            var frm = document.searchForm;
            frm.crudType.value = 'R';
            frm.prodSeq.value = id;
            frm.action = "<c:url value='/productionOrderDtlPage.do'/>";
            frm.submit();
        }

        //=====================================================================
        // paging
        //=====================================================================
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/productionOrderListPage.do'/>";
            frm.submit();
        }

          //-------------------------------------------------------------
        // 바코드 출력 html
        //-------------------------------------------------------------
        function createHtmlBarCode(code) {
            html = "";
            html += "<div name=\"previewBarCodeChild\" style=\"padding:5px 5px 15px 5px;\">";
            html += "<div class=\"row\" style=\"margin-top:30px;\">";
            html += "<div class=\"col-md-12\" style=\"min-width:435px;\">";
            html += "<table class=\"barcode-table\" style=\"width:615px;\">";
            html += "<colgroup>";
            html += "<col width=\"30%\"/>";
            html += "<col width=\"70%\"/>";
            html += "</colgroup>";
            html += "<tbody>";
            //---------------------------------------------------------------------------------------------
            // bar code
            //---------------------------------------------------------------------------------------------
            html += "<tr>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" colspan=\"2\">";
            // barcode
            html += "<div style=\"width:100%; float:left; padding:0px 20px 0px 20px;\">";
            html += "<div id=\""+code+"\"/>";
            html += "</div>";
//             // barcode text
//             html += "<div style=\"font-weight: bold; font-size: 1.6em; width:100%; float:left;\">"+code+"</div>";
            html += "</td>";
            html += "</tr>";
            //---------------------------------------------------------------------------------------------
            // 기종, 품명, 품번
            //---------------------------------------------------------------------------------------------
            html += "<tr>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\"  colspan=\"2\">";
            html += "<div style=\"width:100%; text-align:center; margin-top:36px; margin-bottom:36px; \">";
            if (cfIsNull($('#'+code+'_itemNm').html())) {
                html += "<div style=\"font-weight: bold;font-size: 2.7em;\">N/A</div>";
            } else {
//                 html += "<div style=\"font-weight: bold;font-size: 2.7em;\">"+$('#'+code+'_itemNm').html()+' '+$('#'+code+'_lenVal').html()+' '+$('#'+code+'_lenNm').html()+"</div>";
                html += "<div style=\"font-weight: bold;font-size: 2.7em;\">"+$('#'+code+'_itemNm').html()+"</div>";
            }
            html += "</div>";
            html += "</td>";
            html += "</tr>";
            //---------------------------------------------------------------------------------------------
            // 수량, 작지일자
            //---------------------------------------------------------------------------------------------
            html += "<tr>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">Lot No.</td>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+code+"</td>";
            html += "</tr>";
            html += "<tr>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">작지수량</td>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+$('#'+code+'_poQty').html()+" EA</td>";
            html += "</tr>";
            html += "<tr>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">작지일자</td>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+$('#'+code+'_poCalldt').html()+"</td>";
            html += "</tr>";
            html += "<tr>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">기타</td>";
            html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\"></td>";
            html += "</tr>";

            html += "</tbody>";
            html += "</table>";
            html += "</div>";
            html += "</div>";
            html += "</div>";

            return html;
        }

        //-------------------------------------------------------------
        // QR코드 출력 html
        //-------------------------------------------------------------
        function createHtmlQrCode(code) {
             html = "";
             html += "<div name=\"previewQrCodeChild\" style=\"padding:10px 5px 10px 15px;\">";
             html += "<div class=\"row\" style=\"margin-top:20px\">";
             html += "<div class=\"col-md-12\" style=\"min-width:435px;\">";
             html += "<table class=\"barcode-table\" style=\"width:613px;\">";
             html += "<colgroup>";
             html += "<col width=\"30%\"/>";
             html += "<col width=\"20%\"/>";
             html += "<col width=\"50%\"/>";
             html += "</colgroup>";
             html += "<tbody>";
             //---------------------------------------------------------------------------------------------
             // bar code
             //---------------------------------------------------------------------------------------------
             html += "<tr>";
             html += "<td class=\"barcode-table-td bt-td-pl5 bt-td-pr5\" rowspan=\"7\">";
             // barcode
             html += "<div style=\"width:100%; float:left; padding:0px 20px 0px 20px;\">";
             html += "<div id=\""+code+"_qr\"/>";
             html += "</div>";

             // barcode text
             html += "<div style=\"font-weight: bold; font-size: 0.8em; width:100%; float:left;\">"+code+"</div>";
             html += "</td>";
             html += "</tr>";

              html += "<tr>";
              html += "<td class=\"barcode-table-td\" style=\"font-weight: bold; font-size: 1em;\">품명</td>";

              if (cfIsNull($('#'+code+'_itemNm').html())) {
                  html += "<td class=\"barcode-table-td\" style=\"font-weight: bold; font-size: 2.2em;\">N/A</td>";
              } else {
                  html += "<td class=\"barcode-table-td\" style=\"font-weight: bold; font-size: 2.2em;\">"+cfIsNullString($('#'+code+'_itemNm').html())+"</td>";
              }

              html += "</tr>";

              html += "<tr>";
              html += "<td class=\"barcode-table-td\" style=\"font-weight: bold; font-size: 1em;\">수량</td>";
              html += "<td class=\"barcode-table-td\" style=\"font-weight: bold; font-size: 1.5em;\">"+cfIsNullString($('#'+code+'_poQty').html())+"</td>";
              html += "</tr>";

              html += "<tr>";
              html += "<td class=\"barcode-table-td\" style=\"font-weight: bold; font-size: 1em;\">작지일자</td>";
              html += "<td class=\"barcode-table-td\" style=\"font-weight: bold; font-size: 1.5em;\">"+cfIsNullString($('#'+code+'_poCalldt').html())+"</td>";
              html += "</tr>";


             html += "</tbody>";
             html += "</table>";
             html += "</div>";
             html += "</div>";
             html += "</div>";

             return html;
        }
        -->
    </script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
    <div id="layoutSidenav">
        <!-- ==================================================================================================================================== -->
        <!-- menu                                                                                                                                 -->
        <!-- ==================================================================================================================================== -->
        <jsp:include flush="false" page="/WEB-INF/jsp/include/menu.jsp"></jsp:include>
        <div id="layoutSidenav_content">
            <main>
            <div class="container-fluid">
                <!-- ======================================================================================================================== -->
                <!-- title                                                                                                                    -->
                <!-- ======================================================================================================================== -->
                <h1 class="mt-4">작업지시</h1>
                <!-- ========================================================================================================================= -->
                <!-- taable list                                                                                                              -->
                <!-- ======================================================================================================================== -->
                <div class="card mb-4">
                    <div class="card-header">
                        <sapn>작업지시 목록</sapn>
                        <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                        <div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">생산지시 추가</div>
                        <div id="btnPrintBarCode" class="btn btn-primary btn-sm mr-2" style="float: right;">바코드발행</div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4 vh-100">
                                <div class="row">
                                    <div class="col-sm-12 col-md-2" style="padding-top: 5px;">
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
                                    <div class=" col-sm-12 col-md-10" style="margin-bottom: 5px;">
                                        <div id="dataTable_filter" class="dataTables_wrapper">
                                            <form:form commandName="search" id="searchForm" name="searchForm">
                                                <input type="hidden" name="crudType" value="R" />
                                                <input type="hidden" name="pageIndex" value="${search.pageIndex}" />
                                                <input type="hidden" name="pageSize" value="${search.pageSize}" />
                                                <input type="hidden" name="sortCol" value="${search.sortCol}" />
                                                <input type="hidden" name="sortType" value="${search.sortType}" />
                                                <input type="hidden" name="prodSeq" value="${search.prodSeq}" />
                                                <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                    <img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
                                                </div>
                                                <div style="float: right; margin: 6px 5px;">
                                                    <input type="text" class="form-control col-xs-2 input-lg radius" placeholder="작업지시번호" id="searchProdPoNo" name="searchProdPoNo" value="${search.searchProdPoNo}" />
                                                </div>
                                                <div style="float: right; margin: 6px 5px;">
                                                    <select class="form-control2" id="searchItemCd" name="searchItemCd">
                                                        <option value="">제품 선택</option>
                                                        <c:forEach items="${product_list}" var="item" varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${item.itemCd == search.searchItemCd}">
                                                                    <option value="${item.itemCd}" selected>${item.itemNm}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${item.itemCd}">${item.itemNm}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="float-right margin-dt">
                                                    <input class="form-control3 dt-w55 col-xs-2" style="width: 200px;" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="입고조회 종료일자" />
                                                </div>
                                                <div class="float-right margin-dt">
                                                    <input class="form-control3 dt-w55 col-xs-2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="입고조회 시작일자" />
                                                </div>

                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row" style="margin-left: 0 ;margin-right: 0;">
                                            <!-- table table-striped table-bordered table-hover -->
                                            <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                                <thead class="thead-dark">
                                                    <tr role="row">
                                                        <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                        <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">선택</th>
                                                        <th id="po_calldt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">지시일자</th>
                                                        <th id="md_delidt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">납기일자</th>
                                                        <th id="prod_po_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">작업지시 LOT</th>
                                                        <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">품명</th>
                                                        <th id="po_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">지시수량</th>
                                                        <th id="actok_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">양품수량</th>
                                                        <th id="actbad_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">불량수량</th>
                                                        <th id="prod_type_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">상태</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${rtn.obj}" var="item" varStatus="status">
                                                        <tr role="row" class="odd">
                                                            <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                            <td class="text-ellipsis"><input type="checkbox" name="rowCheckBox" value="${item.prodPoNo}" />
                                                                <div id="${item.prodPoNo}_itemNm" style="display: none;">${item.itemNm}</div>
                                                                <div id="${item.prodPoNo}_poQty" style="display: none;"><fmt:formatNumber value="${item.poQty}" pattern="##,###" /></div>
                                                                <div id="${item.prodPoNo}_poCalldt" style="display: none;">${item.poCalldt}</div>
                                                            </td>
                                                            <td class="text-ellipsis"><span class="po_calldt">${item.poCalldt}</span></td>
                                                            <td class="text-ellipsis"><span class="md_delidt">${item.mdDelidt}</span></td>
                                                            <td class="text-ellipsis"><span class="prod_po_no"><a href="javascript:fn_go_dtl_page('${item.prodSeq}')">${item.prodPoNo}</span></td>
                                                            <td class="text-ellipsis"><span class="item_nm">${item.itemNm}</span></td>
                                                            <td class="text-ellipsis"><span class="po_qty"><fmt:formatNumber value="${item.poQty}" pattern="##,###" />개</span></td>
                                                            <td class="text-ellipsis"><span class="actok_qty"><fmt:formatNumber value="${item.actokQty}" pattern="##,###" />개</span></td>
                                                            <td class="text-ellipsis"><span class="actbad_qty"><fmt:formatNumber value="${item.actbadQty}" pattern="##,###" />개</span></td>
                                                            <td class="text-ellipsis"><span class="prod_type_nm">${item.prodTypeNm}</span></td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(rtn.obj) le 0}">
                                                        <tr>
                                                            <td colspan="9" class="no-data">- 표시할 내용이 없습니다. -</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- ======================================================================================================================== -->
                                        <!-- paging                                                                                                                   -->
                                        <!-- ======================================================================================================================== -->
                                        <div class="row">
                                            <div class="col-sm-12 col-md-5">
                                                <c:if test="${rtn.totCnt > 0}">
                                                    <div class="dataTables_info" id="dataTable_info">Showing ${search.firstIndex+1} to ${search.lastIndex} of ${rtn.totCnt} entries</div>
                                                </c:if>
                                            </div>
                                            <div class="col-sm-12 col-md-7">
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
                                                                    <c:if test="${rtn.totCnt <= (search.pageSize*i)}">
                                                                        <c:set var="isLoof" value="false" />
                                                                    </c:if>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${rtn.totCnt > (search.pageSize*search.pageIndex)}">
                                                                <li class="paginate_button page-item next" id="dataTable_next"><a href="javascript:fn_paging(${search.pageIndex+1})" aria-controls="dataTable" data-dt-idx="11" tabindex="0" class="page-link">Next</a></li>
                                                            </c:if>
                                                        </c:if>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- page end -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- table card end -->
            </div>
            </main>
        </div>
        <!-- layoutSidenav_content end -->
        <div id="opmatModal" class="modal-container">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="txt20">소요량 정보</div>
                    <span class="modal-close-button">×</span>
                </div>
                <div id="previewOpmatList" class="card-body" style="margin: auto;" />
            </div>
        </div>
    </div>
    <div id="barcodePrintModal" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">바코드 출력 정보</div>
                <span class="modal-close-button">×</span>
            </div>
            <div id="tabs">
                <div class="card mb-4" style="margin-top: 30px; margin-left: 30px; margin-right: 30px;">
                    <ul>
                        <li><a href="#tabs-1">바코드</a></li>
                        <!-- <li><a href="#tabs-2">QR코드</a></li> -->
                        <div class="ml-2" style="float: right;">
                            <div id="btnBarCodePrint" class="btn btn-primary btn-sm mr-2" style="float: right;">바코드출력</div>
                        </div>
                        <div class="" style="float: right;">
                            <select class="form-control" id="barcodePrinter" name="barcodePrinter">
                                <option value="">프린터 선택</option>
                                <c:forEach items="${barcode_print_list}" var="item" varStatus="status">
                                    <option value="${item.scode}">${item.codeNm}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </ul>
                    <div id="tabs-1">
                        <div id="previewBarCode" class="card-body" style="margin: auto;"></div>
                    </div>
                    <!-- <div id="tabs-2">
                     <div id="previewQrCode" class="card-body" style="margin: auto;"></div>
                    </div> -->
                </div>
            </div>
        </div>
    </div>
    <form:form commandName="search" id="marRequireListForm" name="marRequireListForm">
        <input type="hidden" name="searchProdSeq" value="" />
    </form:form>
</body>
</html>