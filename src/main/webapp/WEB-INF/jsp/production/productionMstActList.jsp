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
<title>작업실적</title>
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
            $("#searchPoCalldt").datepicker({
                showOn : "button",
                buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                buttonImageOnly : true,
                buttonText : "Select date",
                dateFormat : "yy/mm/dd"
            }).css("z-index", 3);

            //-------------------------------------------------------------
            // jqery event
            //-------------------------------------------------------------
            $('#btnClear').click(function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.searchProdSeq.value = '';
                frm.searchPoCalldt.value = '';
                frm.action = "<c:url value='/productionMstActListPage.do'/>";
                frm.submit();
            });

            $('#searchPoCalldt').change(function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.searchProdSeq.value = '';
                frm.action = "<c:url value='/productionMstActListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 페이징 사이즈 변경 이벤트
            //-------------------------------------------------------------
            $('#pageSizeItem').on('change', function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.pageSize.value = $("#pageSizeItem").val();
                frm.action = "<c:url value='/productionMstActListPage.do'/>";
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
                frm.action = "<c:url value='/productionMstActListPage.do'/>";
                frm.submit();
            });

            drawProductionOperList = function(prodSeq) {
                document.operListForm.searchProdSeq.value = prodSeq;
                $.ajax({
                    url : "<c:url value='/getProductionOperListData.do'/>",
                    type : 'POST',
                    data : $('#operListForm').serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : 'json',
                    beforeSend : function() {

                        $("#prodOrderBodyList tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        if (!cfCheckRtnObj(data.rtn))
                            return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            var rtnObj = JSON.stringify(val).replace(/\"/gi, "\'");

                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-ellipsis\"><span><a href=\"javascript:fn_go_oper(eval(" + rtnObj + "))\">" + val.operNm + "</a></span></td>";

                            if (val.statusCd == 'END') {
                                html += "<td class=\"text-ellipsis\"><span>완료</span></td>";
                            } else if (val.statusCd == 'ING') {
                                html += "<td class=\"text-ellipsis\"><span>작업중</span></td>";
                            } else {
                                html += "<td class=\"text-ellipsis\"><span>대기</span></td>";
                            }

                            if (val.operCd == 'MAT_OUT') {
                                html += "<td class=\"text-ellipsis\"><span>-</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>-</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>-</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>-</span></td>";
                            } else {
                                html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.assignQty, "0"))) + "</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.workQty, "0"))) + "</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.actokQty, "0"))) + "</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>" + cfAddComma(Number(cfIsNullString(val.actbadQty, "0"))) + "</span></td>";
                            }

                            html += "</tr>";
                            $("#prodOrderBodyList").append(html);
                        });
                    },
                    error : function(request, status, error) {
                        console.log("code = " + request.status + " message = " + request.responseText + " error = " + error);
                        cfAlert('시스템 오류입니다.');
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
                $("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);
                if (document.searchForm.sortType.value == 'asc') {
                    $("#${search.sortCol}").attr('class', 'sorting_asc');
                } else {
                    $("#${search.sortCol}").attr('class', 'sorting_desc');
                }

                if ($("#searchProdSeq").val() != '') {
                    drawProductionOperList($("#searchProdSeq").val());
                }

                $("#searchPoCalldt").val('${search.searchPoCalldt}');

            });
        });
    })(jQuery);

    //=====================================================================
    // button action funtion
    //=====================================================================
    function fn_go_search_page(id) {
        var frm = document.searchForm;
        frm.pageIndex.value = 1;
        frm.searchProdSeq.value = id;
        frm.action = "<c:url value='/productionMstActListPage.do'/>";
        frm.submit();
    }

    //=====================================================================
    // paging
    //=====================================================================
    function fn_paging(pageIndex) {
        var frm = document.searchForm;
        frm.pageIndex.value = pageIndex;
        frm.action = "<c:url value='/productionMstActListPage.do'/>";
        frm.submit();
    }

    //=====================================================================
    //
    //=====================================================================
    function fn_go_oper(param) {
        var frm = document.searchForm;
        frm.workactMstSeq.value        = param.workactMstSeq;
        frm.workactSeq.value         = param.workactSeq;
        frm.prodSeq.value             = param.prodSeq;
        frm.operCd.value            = param.operCd;
        frm.searchProdSeq.value        = param.prodSeq;

        switch (param.operCd) {
            case "MAT_OUT": // 자재출고
                frm.action = "<c:url value='/materialOutPage.do'/>";
                break;
            default:
                frm.action = "<c:url value='/productionWorkactPage.do'/>";
                break;
        }

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
                <h1 class="mt-4">작업실적</h1>
                <!-- ========================================================================================================================= -->
                <!-- taable list                                                                                                              -->
                <!-- ======================================================================================================================== -->
                <div class="card mb-4">
                    <div class="card-header">
                        <sapn>작업실적 목록</sapn>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
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
                                    <div class=" col-sm-12 col-md-4" style="margin-bottom: 5px;">
                                        <div id="dataTable_filter" class="dataTables_filter">
                                            <form:form commandName="search" id="searchForm" name="searchForm">
                                                <input type="hidden" name="crudType" value="R" />
                                                <input type="hidden" name="pageIndex" value="${search.pageIndex}" />
                                                <input type="hidden" name="pageSize" value="${search.pageSize}" />
                                                <input type="hidden" name="sortCol" value="${search.sortCol}" />
                                                <input type="hidden" name="sortType" value="${search.sortType}" />
                                                <input type="hidden" name="workactMstSeq" value="" />
                                                <input type="hidden" name="workactSeq" value="" />
                                                <input type="hidden" name="prodSeq" value="${search.prodSeq}" />
                                                <input type="hidden" name="operCd" value="${search.operCd}" />
                                                <input type="hidden" id="searchProdSeq" name="searchProdSeq" value="${search.searchProdSeq}" />
                                                <div id="btnClear" class="btn-logout" style="float: right; margin-top: 7px;">
                                                    <i class="xi-renew"></i>초기화
                                                </div>
                                                <div style="float: right; margin: 6px 6px; width: 230px;">
                                                    <input class="form-control2 col-6" id="searchPoCalldt" name="searchPoCalldt" type="text" value="${search.searchPoCalldt}" placeholder="실적조회 종료일자" />
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                    <div class=" col-sm-12 col-md-6" style="margin-bottom: 5px;"></div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="row" style="margin-left: 0">
                                            <!-- table table-striped table-bordered table-hover -->
                                            <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                                <thead class="thead-dark">
                                                    <tr role="row">
                                                        <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
                                                        <th id="prod_po_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 30%;">지시LOT</th>
                                                        <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 30%;">제품명</th>
                                                        <th id="po_targetdt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 30%;">완료일자</th>
                                                        <th id="po_qty" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">지시수량</th>
                                                        <th id="actok_sum_qty" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">완료수량</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${rtn.obj}" var="item" varStatus="status">
                                                        <tr role="row" class="odd">
                                                            <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                            <td class="text-ellipsis"><span class="prod_po_no">${item.prodPoNo}</span></td>
                                                            <td class="text-ellipsis"><span class="item_nm"><a href="javascript:fn_go_search_page('${item.prodSeq}')">${item.itemNm}</a></span></td>
                                                            <td class="text-ellipsis"><span class="po_targetdt">${item.poTargetdt}</span></td>
                                                            <td class="text-ellipsis"><span class="po_qty"><fmt:formatNumber value="${item.poQty}" pattern="###,###"/></span></td>
                                                            <td class="text-ellipsis"><span class="actok_sum_qty"><fmt:formatNumber value="${item.actokQty}" pattern="###,###"/></span></td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(rtn.obj) le 0}">
                                                        <tr>
                                                            <td colspan="5" class="no-data">- 표시할 내용이 없습니다. -</td>
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
                                        <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                            <thead class="thead-dark">
                                                <tr role="row">
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">공정명</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">상태</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">배정</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">작업</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">양품</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">불량</th>
                                                </tr>
                                            </thead>
                                            <tbody id="prodOrderBodyList" />
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
        <!-- layoutSidenav_content end -->
    </div>

    <form:form commandName="search" id="operListForm" name="operListForm">
        <input type="hidden" name="searchProdSeq" value="" />
    </form:form>

</body>
</html>