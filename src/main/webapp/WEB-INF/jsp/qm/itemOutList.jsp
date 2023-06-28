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
<title>출하관리</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
    //=====================================================================
    // jquery logic
    //=====================================================================
    (function($) {
        $(function() {
            //-------------------------------------------------------------
            // declare gloval
            //-------------------------------------------------------------
            $("#searchFromDate, #searchToDate").datepicker({
                showOn : "both",
                buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                buttonImageOnly : true,
                buttonText : "Select date",
                dateFormat : "yy/mm/dd"
            });

            //-------------------------------------------------------------
            // jqery event
            //-------------------------------------------------------------
            // 검색 이벤트
            //-------------------------------------------------------------
            $('#btnSearch').click(function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.action = "<c:url value='/itemOutListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 페이징 사이즈 변경 이벤트
            //-------------------------------------------------------------
            $('#pageSizeItem').on('change', function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.pageSize.value = $("#pageSizeItem").val();
                frm.action = "<c:url value='/itemOutListPage.do'/>";
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
                frm.action = "<c:url value='/itemOutListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 엑셀 다운로드 이벤트
            //-------------------------------------------------------------
            $('#btnExcel').click(function() {
                downloadExcelFromTable($('#dataTable'));
            });

            //-------------------------------------------------------------
            // 바코드 출력
            //-------------------------------------------------------------
            $("#btnBarCodePrint").click(function() {
//                 if( $("#barcodePrinter").val() == "" ) {
//                     cfAlert("프린터를 선택하세요.");
//                     return false;
//                 }

                // 버튼이벤트 중복 발생을 막기 위해 로딩바를 먼저 호출.
                $("#previewBarCode").loading();

                var barcodeDivObj = $("div[name=previewBarCodeChild]");
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
                            IpAdress: '<spring:eval expression="@property['Globals.print.ip']"/>',
//                             Port: $("#barcodePrinter").val(),
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
            $("#btnPrintBarCode").click(function() {
                var barCodeCnt = $("input:checkbox[name='rowCheckBox']:checked").length;

                if (barCodeCnt == 0) {
                    cfAlert("바코드 데이타를 선택하세요.");
                    return false;
                }

                if (barCodeCnt > 10) {
                    cfAlert("바코드출력은 10개까지만 가능합니다.");
                    return false;
                }

                $("#previewBarCode div").remove();

                var html = "";
                $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
                    html = createHtmlBarCode($(this).val());
                    $("#previewBarCode").append(html);
                    $("#" + $(this).val()).barcode($(this).val(), "code128", {barWidth : 3, barHeight : 60, showHRI : false, bgColor : "white", output : "css"});
                });
                $("#barcodePrintModal").css("display", "block");
            });

            //-------------------------------------------------------------
            // 바코드 팝업 닫기
            //-------------------------------------------------------------
            $('.modal-close-button').click(function() {
                $('.modal-container').css("display", "none");
            });

            // 바코드 스캔 이벤트
            $(document).scannerDetection({
                timeBeforeScanTest: 200, // wait for the next character for upto 200ms
                avgTimeByChar: 100, // it's not a barcode if a character takes longer than 100ms
                onComplete: function(barcode, qty){
                    if( barcode.length < 15 ) {
                        cfAlert("바코드스캔은 영문변환 후 사용 가능합니다.");
                        return false;
                    }
                    fn_drawItemOutList(barcode);
                } // main callback function
            });

            //-------------------------------------------------------------
            // 출하 디테일 목록
            //-------------------------------------------------------------
            drawItemOutList = function(lotid) {
                document.itemOutForm.searchLotid.value = lotid;

                $.ajax({
                    url : "<c:url value='/getItemOutListData.do'/>",
                    type : "POST",
                    data : $("#itemOutForm").serialize(),
                    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
                    context : this,
                    dataType : "json",
                    beforeSend : function() {
                        $("#itemOutListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        if (!cfCheckRtnObj(data.rtn))
                            return;

                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            var valObj = JSON.stringify(val).replace(/\"/gi, "\'");

                            html = "";
                            html += "<tr role=\"row\" class=\"odd\" style=\"display:table;width:100%;table-layout:fixed;\">";
                            html += "    <td class=\"text-ellipsis\" style=\"width:8%;\">";
                            html += "        <input type=\"checkbox\" name=\"rowCheckBox\" value=\"" + val.lotOutId + "\"/>";
                            html += "        <div id=\"" + val.lotOutId + "_itemNm\" style=\"display:none;\">" + val.itemNm + "</div>";
                            html += "        <div id=\"" + val.lotOutId + "_custNm\" style=\"display:none;\">" + val.custNm + "</div>";
                            html += "        <div id=\"" + val.lotOutId + "_outQty\" style=\"display:none;\">" + cfAddComma(cfIsNullString(val.outQty,"0")) + "</div>";
                            html += "        <div id=\"" + val.lotOutId + "_itemoutDt\" style=\"display:none;\">" + val.itemoutDt + "</div>";
                            html += "    </td>";
                            html += "    <td class=\"text-ellipsis\" style=\"width:20%;\"><span><a href=\"javascript:fn_go_dtl_page(eval(" + valObj + "))\">" + val.itemoutDt + "</a></span></td>";
                            html += "    <td class=\"text-ellipsis\" style=\"width:15%;\"><span>" + cfAddComma(cfIsNullString(val.outQty,"0")) + " 개</span></td>";
                            html += "    <td class=\"text-ellipsis\" style=\"width:20%;\"><span>" + val.itemOutTypeNm + "</span></td>";
                            html += "    <td class=\"text-ellipsis\" style=\"width:15%;\"><span>" + cfIsNullString(val.custNm) + "</span></td>";
                            html += "    <td class=\"text-ellipsis\" style=\"width:20%;\"><span>" + val.lotOutId + "</span></td>";
                            html += "</tr>";

                            $("#itemOutListBody").append(html);
                        });
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert("시스템 오류입니다.");
                    },
                    complete : function() {
                        $("#layoutSidenav").loadingClose();
                    }
                });
            };

            //-------------------------------------------------------------
            // onLoad
            //-------------------------------------------------------------
            $(document).ready(function() {
                $("#tabs").tabs();
                $("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
                if (document.searchForm.sortType.value == 'asc') {
                    $("#${search.sortCol}").attr('class', 'sorting_asc');
                } else {
                    $("#${search.sortCol}").attr('class', 'sorting_desc');
                }
            });
        });
    })(jQuery);

    //-------------------------------------------------------------
    // 바코드 출력 html
    //-------------------------------------------------------------
    function createHtmlBarCode(lotOutId) {
        html = "";
        html += "<div name=\"previewBarCodeChild\" style=\"padding:10px 5px 10px 10px;\">"; // 용지 좌우 여백 조절
        html += "<div class=\"row\" style=\"margin-top:20px\">";
        html += "<div class=\"col-md-12\" style=\"min-width:410px;\">";
        html += "<table class=\"barcode-table\" style=\"width:600px;\">";
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
        html += "<div id=\""+lotOutId+"\"/>";
        html += "</div>";
        // barcode text
        html += "<div style=\"font-weight: bold; font-size: 1.6em; width:100%; float:left;\">"+lotOutId+"</div>";
        html += "</td>";
        html += "</tr>";
        //---------------------------------------------------------------------------------------------
        // 제품명, 수 량, 입고일자
        //---------------------------------------------------------------------------------------------
        html += "<tr>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">제품명</td>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.8em;\">"+$('#'+lotOutId+'_itemNm').html()+"</td>";
        html += "</tr>";

        html += "<tr>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">납품처</td>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.8em;\">"+cfIsNullString($('#'+lotOutId+'_custNm').html())+"</td>";
        html += "</tr>";

        html += "<tr>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">수 량</td>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+$('#'+lotOutId+'_outQty').html()+" EA</td>";
        html += "</tr>";

        html += "<tr>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">출고일자</td>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+$('#'+lotOutId+'_itemoutDt').html()+"</td>";
        html += "</tr>";

        html += "</tbody>";
        html += "</table>";
        html += "</div>";
        html += "</div>";
        html += "</div>";

        return html;
    }

    //=====================================================================
    // 출고 리스트 조회
    //=====================================================================
    function fn_drawItemOutList(lotid) {
        drawItemOutList(lotid);
      }

      //=====================================================================
    // 출고추가
    //=====================================================================
    function fn_createItemOut(prodSeq, lotid, iteminStockQty) {
        if ( parseInt(iteminStockQty) <= 0) {
            alert("잔여량이 없습니다.");
            return false;
        }

        var frm = document.searchForm;
        frm.crudType.value    = "C";
        frm.prodSeq.value    = prodSeq;
        frm.lotid.value        = lotid;

        frm.action = "<c:url value='/itemOutDtlPage.do'/>";
        frm.submit();
    }

    //=====================================================================
    // button action funtion
    //=====================================================================
    function fn_go_dtl_page(obj) {
        var frm = document.searchForm;
        frm.crudType.value = "R";
        frm.itemoutSeq.value = obj.itemoutSeq;
        frm.prodSeq.value = obj.prodSeq;
        frm.lotid.value = obj.lotid;
        frm.action = "<c:url value='/itemOutDtlPage.do'/>";
        frm.submit();
    }

    //=====================================================================
    // paging
    //=====================================================================
    function fn_paging(pageIndex) {
        var frm = document.searchForm;
        frm.pageIndex.value = pageIndex;
        frm.action = "<c:url value='/itemOutListPage.do'/>";
        frm.submit();
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
                <h1 class="mt-4">출하 관리</h1>
                <!-- ========================================================================================================================= -->
                <!-- taable list                                                                                                              -->
                <!-- ======================================================================================================================== -->
                <div class="card mb-4">
                    <div class="card-header">
                        <sapn>출하 목록</sapn>
                        <div id="btnPrintBarCode" class="btn btn-primary btn-sm mr-2" style="float: right;">바코드출력</div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4 vh-100">
                                <!-- @@@ style="min-width:3000px;"  -->
                                <div class="row">
                                    <div class="col-sm-12 col-md-2" style="padding-top: 5px;">
                                        <div class="dataTables_length" id="dataTable_length">
                                            <label>Show <select id="pageSizeItem" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                                                    <option value="10">10</option>
                                                    <option value="25">25</option>
                                                    <option value="50">50</option>
                                                    <option value="100">100</option>
                                                </select> entries
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-10" style="margin-bottom: 5px;">
                                        <div id="dataTable_filter" class="dataTables_filter">
                                            <form:form commandName="search" id="searchForm" name="searchForm">
                                                <input type="hidden" name="crudType" value="R" />
                                                <input type="hidden" name="pageIndex" value="${search.pageIndex}" />
                                                <input type="hidden" name="pageSize" value="${search.pageSize}" />
                                                <input type="hidden" name="sortCol" value="${search.sortCol}" />
                                                <input type="hidden" name="sortType" value="${search.sortType}" />
                                                <input type="hidden" name="prodSeq" value="${search.prodSeq}" />
                                                <input type="hidden" name="lotid" value="${search.lotid}" />
                                                <input type="hidden" name="itemoutSeq" value="${search.itemoutSeq}" />

                                                <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                    <img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
                                                </div>
                                                <div style="float: right; margin: 6px 5px;">
                                                    <input class="form-control2" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="종료일자" />
                                                </div>
                                                <div style="float: right; margin: 6px 5px;">
                                                    <input class="form-control2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="시작일자" />
                                                </div>
                                                <div style="float: right; margin: 6px 5px; width: 120px;">

                                                    <select class="form-control2" id="searchType" name="searchType">
                                                    <option value="">출고 구분</option>
                                                        <c:forEach items="${item_out_type_cd_list}" var="item" varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${item.scode == search.searchType}">
                                                                    <option value="${item.scode}" selected>${item.codeNm}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${item.scode}">${item.codeNm}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="row" style="margin-left: 0">
                                            <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; font-size:0.8rem; table-layout: fixed;">
                                                <thead class="thead-dark">
                                                    <tr role="row">
                                                        <th id="itemin_dt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">입고일자</th>
                                                        <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">제품명</th>
                                                        <th id="prod_po_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">지시LOT</th>
                                                        <th id="lotid" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">입고LOT</th>
                                                        <th id="inok_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">입고 수량</th>
                                                        <th id="itemin_stock_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">출고 수량</th>
                                                        <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">추가</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${rtn.obj}" var="item" varStatus="status">
                                                        <tr role="row" class="odd">
                                                            <td class="text-ellipsis"><span class="itemin_dt">${item.iteminDt}</span></td>
                                                            <td class="text-ellipsis"><span class="item_nm">${item.itemNm}</span></td>
                                                            <td class="text-ellipsis"><span class="prod_po_no">${item.prodPoNo}</span></td>
                                                            <td class="text-ellipsis"><span class="lotid">${item.lotid}</span></td>
                                                            <td class="text-ellipsis"><span class="inok_qty"><fmt:formatNumber value="${item.inokQty}" pattern="###,###"/>개</span></td>
                                                            <td class="text-ellipsis text-center"><span class="itemin_stock_qty"><a href="javascript:fn_drawItemOutList('${item.lotid}');"><fmt:formatNumber value="${item.totOutQty}" pattern="###,###"/>개</a></span></td>
                                                            <td class="text-ellipsis text-center"><span><a href="javascript:fn_createItemOut('${item.prodSeq}', '${item.lotid}', ${item.iteminStockQty});">출하추가</a></span></td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(rtn.obj) le 0}">
                                                        <tr>
                                                            <td colspan="7" class="no-data">- 표시할 내용이 없습니다. -</td>
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

                                    <div class="col-sm-6">
                                        <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; font-size:0.8rem;table-layout: fixed;">
                                            <thead class="thead-dark" style="display: table; width: 100%; table-layout: fixed;">
                                                <tr role="row">
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">선택</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">출고일자</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">출고수량</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">출고구분</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">납품처</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">출고LOT</th>
                                                </tr>
                                            </thead>
                                            <tbody id="itemOutListBody" style="display: block; max-height: 500px; overflow: auto; table-layout: fixed;" />
                                        </table>
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
    </div>

    <div id="barcodePrintModal" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">바코드 출력 정보</div>
                <span class="modal-close-button">×</span>
            </div>
            <div class="card mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                <div class="card-header">
                    <sapn class="txt20">출력 바코드 목록</sapn>
                    <div class="form-inline float-right">
<!--                         <select class="form-control mt-n1 mb-n1 mr-2" id="barcodePrinter" name="barcodePrinter"> -->
<!--                             <option value="">프린터 선택</option> -->
<%--                             <c:forEach items="${barcode_print_list}" var="item" varStatus="status"> --%>
<%--                                 <option value="${item.scode}">${item.codeNm}</option> --%>
<%--                             </c:forEach> --%>
<!--                         </select> -->
                        <div id="btnBarCodePrint" class="btn btn-primary btn-sm mr-2">바코드출력</div>
                    </div>
                </div>
                <div id="previewBarCode" class="card-body" style="margin: auto;">
                </div>
            </div>
        </div>
    </div>

    <form:form commandName="search" id="itemOutForm" name="itemOutForm">
        <input type="hidden" name="searchLotid" value="" />
    </form:form>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
</body>
</html>