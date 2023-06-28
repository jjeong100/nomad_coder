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
<title>자재입고</title>
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
                showOn : "button",
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
                frm.action = "<c:url value='/materialInListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 페이징 사이즈 변경 이벤트
            //-------------------------------------------------------------
            $('#pageSizeItem').on('change', function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.pageSize.value = $("#pageSizeItem").val();
                frm.action = "<c:url value='/materialInListPage.do'/>";
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
                frm.action = "<c:url value='/materialInListPage.do'/>";
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
                frm.action = "<c:url value='/materialInDtlPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 바코드 출력 팝업
            //-------------------------------------------------------------
            $('#btnPrintBarCode').click(function() {
                var barCodeCnt = $("input:checkbox[name=rowCheckBox]:checked").length;

                if (barCodeCnt == 0) {
                    cfAlert("바코드 데이타를 선택하세요.");
                    return false;
                }

                if( barCodeCnt > 10 ) {
                    cfAlert("바코드출력은 10개까지만 가능합니다.");
                    return false;
                }

                // width:640, height:424 사이즈로 나와야 용지 사이즈에 맞음.
                $("#previewBarCode div").remove();

                $("input[name=rowCheckBox]:checked").each(function(idx, obj) {
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
                    html += "<tr style=\"height:120px\">";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" colspan=\"2\">";
                    // barcode
                    html += "<div style=\"width:100%; float:left; padding:0px 20px 0px 20px;\">";
                    html += "<div id=\""+$(this).val()+"\"/>";
                    html += "</div>";
                    // barcode text
                    html += "<div style=\"font-weight: bold; font-size: 1.6em; width:100%; float:left;\">"+$(this).val()+"</div>";
                    html += "</td>";
                    html += "</tr>";

                    //---------------------------------------------------------------------------------------------
                    // 원재료, 입고일자, 중 량
                    //---------------------------------------------------------------------------------------------
                    html += "<tr style=\"height:65px\">";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">자재명</td>";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.8em;\">"+$('#'+$(this).val()+'_matNm').html()+"</td>";
                    html += "</tr>";
                    html += "<tr style=\"height:65px\">";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">자재처</td>";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.8em;\">"+$('#'+$(this).val()+'_custNm').html()+"</td>";
                    html += "</tr>";
                    html += "<tr style=\"height:65px\">";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">입고일자</td>";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+$('#'+$(this).val()+'_inDt').html()+"</td>";
                    html += "</tr>";
                    html += "<tr style=\"height:65px\">";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">수 량</td>";
                    html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+fn_add_comma($('#'+$(this).val()+'_inCnt').html())+" EA</td>";
                    html += "</tr>";

                    html += "</tbody>";
                    html += "</table>";
                    html += "</div>";
                    html += "</div>";
                    html += "</div>";
                    $("#previewBarCode").append(html);
                    $('#'+$(this).val()).barcode($(this).val(), "code128",{barWidth:3, barHeight:60,showHRI:false,bgColor:"white", output:'css'});
                });

                $('#barcodePrintModal').css("display", "block");
            });

              //-------------------------------------------------------------
            // 바코드 팝업 닫기
            //-------------------------------------------------------------
            $('.modal-close-button').click(function() {
                $('.modal-container').css("display", "none");
            });

            //-------------------------------------------------------------
            // 바코드 출력
            //-------------------------------------------------------------
            $('#btnBarCodePrint').click(function() {
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
            // onLoad
            //-------------------------------------------------------------
            $(document).ready(function() {
                $("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
                if (document.searchForm.sortType.value == 'asc') {
                    $("#${search.sortCol}").attr('class', 'sorting_asc');
                } else {
                    $("#${search.sortCol}").attr('class', 'sorting_desc');
                }

                $("#searchFromDate").val("${search.searchFromDate}");
                $("#searchToDate").val("${search.searchToDate}");
                
                /** ajax조회 **/
                $("#searchCustCd").select2();
                
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
        frm.matinSeq.value = id;
        frm.action = "<c:url value='/materialInDtlPage.do'/>";
        frm.submit();
    }

    //=====================================================================
    // paging
    //=====================================================================
    function fn_paging(pageIndex) {
        var frm = document.searchForm;
        frm.pageIndex.value = pageIndex;
        frm.action = "<c:url value='/materialInListPage.do'/>";
        frm.submit();
    }
    
    //-------------------------------------------------------------
    // 천단위 콤마 처리
    //-------------------------------------------------------------
    function fn_add_comma(values){
        var result = String(values);
        if(result == null || "0" == result) result = "";
        result = String(result).replace(/[^0-9]/g,"").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return result;
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
                <h1 class="mt-4">자재입고</h1>
                <!-- ========================================================================================================================= -->
                <!-- taable list                                                                                                              -->
                <!-- ======================================================================================================================== -->
                <div class="card mb-4">
                    <div class="card-header">
                        <sapn>자재입고 목록</sapn>
                        <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                        <div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">자재입고</div>
                        <div id="btnPrintBarCode" class="btn btn-primary btn-sm mr-2" style="float: right;">바코드발행</div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <!-- @@@ style="min-width:3000px;"  -->
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
                                    <div class="col-sm-12 col-md-10" style="margin-bottom: 5px;">
                                        <div id="dataTable_filter" class="dataTables_wrapper">
                                            <form:form commandName="search" id="searchForm" name="searchForm">
                                                <input type="hidden" name="crudType" value="R" />
                                                <input type="hidden" name="pageIndex" value="${search.pageIndex}" />
                                                <input type="hidden" name="pageSize" value="${search.pageSize}" />
                                                <input type="hidden" name="sortCol" value="${search.sortCol}" />
                                                <input type="hidden" name="sortType" value="${search.sortType}" />
                                                <input type="hidden" name="matinSeq" value="${search.matinSeq}" />
                                                <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                    <img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
                                                </div>
                                                <div style="float: right; margin: 6px 5px; width: 200px;">
                                                       <input type="text" class="form-control input-lg radius" size="18" placeholder="자재명" id="searchMatNm" name="searchMatNm" value="${search.searchMatNm}" />
                                                   </div>
                                                <div style="float:right;margin:6px 5px;width:250px">
                                                    <select class="form-control2" id="searchCustCd" name="searchCustCd">
                                                        <option value="">자재처 선택</option>
                                                        <c:forEach items="${mat_cust_list}" var="item" varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${item.custCd == search.searchCustCd}">
                                                                    <option value="${item.custCd}" selected>${item.custNm}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${item.custCd}">${item.custNm}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div style="float:right;margin:6px 5px;width:200px">
                                                    <select class="form-control2" id="searchWorkshopCd" name="searchWorkshopCd">
                                                        <option value="">창고 선택</option>
                                                        <c:forEach items="${store_house_list}" var="item" varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${item.workshopCd == search.searchWorkshopCd}">
                                                                    <option value="${item.workshopCd}" selected>${item.workshopNm}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${item.workshopCd}">${item.workshopNm}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="float-right margin-dt">
                                                    <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="수불조회 종료일자" />
                                                </div>
                                                <div class="float-right margin-dt">
                                                    <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="수불조회 시작일자" />
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <!-- style="min-width:3000px;" -->
                                    <div class="col-sm-12" style="min-width: 1000px;">
                                        <!-- table table-striped table-bordered table-hover -->
                                        <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                            <thead class="thead-dark">
                                                <tr role="row">
                                                    <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                    <th id="rnum"         class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">선택</th>
                                                    <th id="in_dt"        class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">입고일자</th>
                                                    <th id="workshop_cd"  class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">창고</th>
                                                    <th id="mat_cd"       class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 13%;">자재명</th>
                                                    <th id="cust_cd"      class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">자재처</th>
                                                    <th id="in_cnt"       class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">수량</th>
                                                    <th id="lotid"        class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">LOT</th>
                                                    <th id="write_nm"     class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">등록자</th>
                                                    <th id="write_dt_str" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">등록일</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${rtn.obj}" var="item" varStatus="status">
                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis">
                                                            <input type="checkbox" name="rowCheckBox" value="${item.lotid}" />
                                                            <div id="${item.lotid}_matNm" style="display: none;">${item.matNm}</div>
                                                            <div id="${item.lotid}_custNm" style="display: none;">${item.custNm}</div>
                                                            <div id="${item.lotid}_inCnt" style="display: none;">${item.inCnt}</div>
                                                            <div id="${item.lotid}_inDt" style="display: none;">${item.inDt}</div></td>
                                                        <td class="text-ellipsis"><span class="in_dt"><a href="javascript:fn_go_dtl_page('${item.matinSeq}')">${item.inDt}</a></span></td>
                                                        <td class="text-ellipsis"><span class="workshop_cd">${item.workshopNm}</span></td>
                                                        <td class="text-ellipsis"><span class="mat_cd">${item.matNm}</span></td>
                                                        <td class="text-ellipsis"><span class="cust_cd">${item.custNm}</span></td>
                                                        <td class="text-ellipsis"><span class="in_cnt"><fmt:formatNumber value="${item.inCnt}" pattern="###,###"/></span></td>
                                                        <td class="text-ellipsis"><span class="lotid">${item.lotid}</span></td>
                                                        <td class="text-ellipsis"><span class="write_nm">${item.writeNm}</span></td>
                                                        <td class="text-ellipsis"><span class="write_dt_str">${item.writeDtStr}</span></td>
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

</body>
</html>