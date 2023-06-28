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
<title>완제품 입고 관리</title>
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
            $("#searchFromQmCheckdt, #searchToQmCheckdt, #searchFromPoCalldt, #searchToPoCalldt").datepicker({
                showOn : "button",
                buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                buttonImageOnly : true,
                buttonText : "Select date",
                dateFormat : "yy/mm/dd"
            }).css("z-index", 3);

            //-------------------------------------------------------------
            // jqery event
            //-------------------------------------------------------------
            $("#searchType").change(function() {
                if ($(this).val() == "IN") {
                    $("#searchTypeInView").show();
                    $("#searchTypeNinView").hide();
                } else {
                    $("#searchTypeInView").hide();
                    $("#searchTypeNinView").show();
                }
            });

            //-------------------------------------------------------------
            // 검색 이벤트
            //-------------------------------------------------------------
            $("#btnSearch").click(function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.action = "<c:url value='/itemInListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 페이징 사이즈 변경 이벤트
            //-------------------------------------------------------------
            $("#pageSizeItem").on("change", function() {
                var frm = document.searchForm;
                frm.pageIndex.value = 1;
                frm.pageSize.value = $("#pageSizeItem").val();
                frm.action = "<c:url value='/itemInListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 컬럼 소트 이벤트
            //-------------------------------------------------------------
            $("#dataTable").find("th").not(".no-sort").click(function() {
                var frm = document.searchForm;
                var sortCol = $(this).attr("id");
                var sortColType = $(this).attr("class");
                frm.sortCol.value = sortCol;

                if (sortColType == "sorting_asc") {
                    frm.sortType.value = "desc";
                } else {
                    frm.sortType.value = "asc";
                }

                frm.action = "<c:url value='/itemInListPage.do'/>";
                frm.submit();
            });

            $("#searchTypeInView").click(function() {
                var frm = document.searchForm;
                frm.sortCol.value = "ITEMIN_DT"
                frm.sortType.value = "DESC"
            })

            $("input[name=rowRadio]").click(function() {
                drawItemInList($(this).data("mqcseq"));
            });

            //-------------------------------------------------------------
            // 엑셀 다운로드 이벤트
            //-------------------------------------------------------------
            $("#btnExcel").click(function() {
                downloadExcelFromTable($("#dataTable"));
            });

            //-------------------------------------------------------------
            // 생성 이벤트
            //-------------------------------------------------------------
            $("#btnCreate").click(function() {
                if (cfIsNull($("input:radio[name=rowRadio]:checked").val())) {
                    alert("입고 대상 검품을 선택해 주세요");
                    return false;
                }

                if ($("input[name='rowRadio']:checked").data("qmstockqty") <= 0) {
                    alert("입고 대상 검품 잔여량이 없습니다. ");
                    return false;
                }

                var frm = document.searchForm;
                frm.crudType.value = "C";
                frm.prodSeq.value = $("input[name='rowRadio']:checked").data("prodseq");
                frm.mqcSeq.value = $("input[name='rowRadio']:checked").data("mqcseq");
                frm.action = "<c:url value='/itemInDtlPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 출하 목록
            //-------------------------------------------------------------
            drawItemInList = function(mqcSeq) {
                document.itemInForm.searchMqcSeq.value = mqcSeq;

                $.ajax({
                    url : "<c:url value='/getItemInListData.do'/>",
                    type : "POST",
                    data : $("#itemInForm").serialize(),
                    contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
                    context : this,
                    dataType : "json",
                    beforeSend : function() {
                        $("#itemInListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success : function(data) {
                        if (!cfCheckRtnObj(data.rtn))
                            return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val) {
                            var valObj = JSON.stringify(val).replace(/\"/gi, "\'");

                            html = "";
                            html = "<tr role=\"row\" class=\"odd\" style=\"display:table;width:100%;table-layout:fixed;\">";
                            html += "<td class=\"text-ellipsis\" style=\"width:8%;\"><span>";
                            html += "<div id=\"" + val.lotid + "_itemNm\" style=\"display:none;\">" + val.itemNm + "</div>";
                            html += "<div id=\"" + val.lotid + "_inokQty\" style=\"display:none;\">" + cfAddComma(cfIsNullString(val.inokQty,"0")) + "</div>";
                            html += "<div id=\"" + val.lotid + "_iteminDt\" style=\"display:none;\">" + val.iteminDt + "</div>";
                            html += "<input type=\"checkbox\" name=\"rowCheckBox\" value=\""+val.lotid+"\"/>";
                            html += "</span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width:20%;\"><span><a href=\"javascript:fn_go_dtl_page(eval(" + valObj + "))\">" + val.iteminDt + "</a></span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width:20%;\"><span>" + cfAddComma(cfIsNullString(val.inokQty,"0")) + "개</span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width:25%;\"><span>" + val.workshopNm + "</span></td>";
                            html += "<td class=\"text-ellipsis\" style=\"width:25%;\"><span>" + val.lotid + "</span></td>";
                            html += "</tr>";
                            $("#itemInListBody").append(html);
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
            // 바코드 출력
            //-------------------------------------------------------------
            $("#btnBarCodePrint").click(function() {
                if( $("#barcodePrinter").val() == "" ) {
                    cfAlert("프린터를 선택하세요.");
                    return false;
                }

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
                            Port: $("#barcodePrinter").val(),
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
                $(".modal-container").css("display", "none");
            });

            //-------------------------------------------------------------
            // onLoad
            //-------------------------------------------------------------
            $(document).ready(function() {
                $("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);

                if (document.searchForm.sortType.value == "asc") {
                    $("#${search.sortCol}").attr("class", "sorting_asc");
                } else {
                    $("#${search.sortCol}").attr("class", "sorting_desc");
                }

                $("#searchFromQmCheckdt").val("${search.searchFromQmCheckdt}");
                $("#searchToQmCheckdt").val("${search.searchToQmCheckdt}");
                $("#searchFromPoCalldt").val("${search.searchFromPoCalldt}");
                $("#searchToPoCalldt").val("${search.searchToPoCalldt}");
                $("#searchTypeNinView").show();
                $("#searchType").val("${search.searchType}");

                if("${search.mqcSeq}" != "") {
                    drawItemInList('${search.mqcSeq}');
                }
                
                /** ajax조회 **/
                $("#searchItemCd").select2();
                
                /** 최상위 올리기 **/
                $("#btnSearch").css("z-index",9999);
                
                /** 리스트의 첫 번째 클릭 **/
                fn_select_position("mainLeftListBody",0);
            });
        });
    })(jQuery);


    //=====================================================================
    // 위치 클릭 
    //=====================================================================
    function fn_select_position(body,index){
        var col01 = $("#"+body+" tr:eq("+index+")>td:eq(0)").children();
        var td = $("#"+body+" tr").eq(index).children();
        var col02 = td.eq(0).find("input[type=hidden]").val();
        
        if(fn_undefined(col02) != "") {
           fn_drawItemInList(col02);
        }
    }

    //-------------------------------------------------------------
    // 바코드 출력 html
    //-------------------------------------------------------------
    function createHtmlBarCode(lotid) {
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
        html += "<div id=\""+lotid+"\"/>";
        html += "</div>";
        // barcode text
        html += "<div style=\"font-weight: bold; font-size: 1.6em; width:100%; float:left;\">"+lotid+"</div>";
        html += "</td>";
        html += "</tr>";
        //---------------------------------------------------------------------------------------------
        // 제품명, 수 량, 입고일자
        //---------------------------------------------------------------------------------------------
        html += "<tr style=\"height:130px;\">";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">제품명</td>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.8em;\">"+$('#'+lotid+'_itemNm').html()+"</td>";
        html += "</tr>";

        html += "<tr>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">수 량</td>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+$('#'+lotid+'_inokQty').html()+" EA</td>";
        html += "</tr>";

        html += "<tr>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">입고일자</td>";
        html += "<td class=\"barcode-table-td barcode-table-td-p5\" style=\"font-weight: bold; font-size: 1.6em;\">"+$('#'+lotid+'_iteminDt').html()+"</td>";
        html += "</tr>";

        html += "</tbody>";
        html += "</table>";
        html += "</div>";
        html += "</div>";
        html += "</div>";

        return html;
    }

    //=====================================================================
    // 입고 리스트 조회
    //=====================================================================
    function fn_drawItemInList(mqcSeq) {
        drawItemInList(mqcSeq);
      }

      //=====================================================================
    // QM추가
    //=====================================================================
    function fn_createItemIn(prodSeq, mqcSeq, qmStockQty) {
        if ( parseInt(qmStockQty) <= 0) {
            alert("잔여량이 없습니다.");
            return false;
        }

        var frm = document.searchForm;
        frm.crudType.value        = "C";
        frm.prodSeq.value        = prodSeq;
        frm.mqcSeq.value        = mqcSeq;

        frm.action = "<c:url value='/itemInDtlPage.do'/>";
        frm.submit();
    }

    //=====================================================================
    // button action funtion
    //=====================================================================
    function fn_go_dtl_page(obj) {
        var frm = document.searchForm;
        frm.crudType.value = "R";
        frm.iteminSeq.value = obj.iteminSeq;
        frm.prodSeq.value = obj.prodSeq;
        frm.mqcSeq.value = obj.mqcSeq;
        frm.action = "<c:url value='/itemInDtlPage.do'/>";
        frm.submit();
    }

    //=====================================================================
    // paging
    //=====================================================================
    function fn_paging(pageIndex) {
        var frm = document.searchForm;
        frm.pageIndex.value = pageIndex;
        frm.action = "<c:url value='/itemInListPage.do'/>";
        frm.submit();
    }
    
    //=====================================================================
    // 데이타 null,0 처리
    //=====================================================================
    function fn_undefined(values) {
        var result = "";
        if(values != null && values != 'undefined') result = values;
        
        //0숫자 처리
        if(values == 0) result = "";
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
                <h1 class="mt-4">완제품 입고 관리</h1>
                <!-- ========================================================================================================================= -->
                <!-- taable list                                                                                                              -->
                <!-- ======================================================================================================================== -->
                <div class="card mb-4">
                    <div class="card-header">
                        <sapn>검품 /입고 목록</sapn>
                        <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                        <!-- <div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">완제품입고</div> -->
                        <div id="btnPrintBarCode" class="btn btn-primary btn-sm mr-2" style="float: right;">바코드발행</div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4 vh-100">
                                <div class="row col-sm-12">
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
                                        <div id="dataTable_filter" class="dataTables_wrapper">
                                            <form:form commandName="search" id="searchForm" name="searchForm">
                                                <input type="hidden" name="crudType" value="R" />
                                                <input type="hidden" name="pageIndex" value="${search.pageIndex}" />
                                                <input type="hidden" name="pageSize" value="${search.pageSize}" />
                                                <input type="hidden" name="sortCol" value="${search.sortCol}" />
                                                <input type="hidden" name="sortType" value="${search.sortType}" />
                                                <input type="hidden" name="mqcSeq" value="" />
                                                <input type="hidden" name="prodSeq" value="" />
                                                <input type="hidden" name="iteminSeq" value="" />

                                                <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
                                                    <img alt="" src="<c:url value='/resource/images/icon_search.png'/>" />
                                                </div>
                                                <div style="float:right;margin:6px 5px;width:250px;">
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
                                                
                                                <div id="searchTypeNinView" style="display: none;">
	                                                <div class="float-right margin-dt">
	                                                    <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchToQmCheckdt" name="searchToQmCheckdt" type="text" value="${search.searchToQmCheckdt}" placeholder="수불조회 종료일자" />
	                                                </div>
	                                                <div class="float-right margin-dt">
	                                                    <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchFromQmCheckdt" name="searchFromQmCheckdt" type="text" value="${search.searchFromQmCheckdt}" placeholder="수불조회 시작일자" />
	                                                </div>
                                                </div>
                                                
                                                <div id="searchTypeInView" style="display: none;">
	                                                <div class="float-right margin-dt">
	                                                    <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchToPoCalldt" name="searchToPoCalldt" type="text" value="${search.searchToPoCalldt}" placeholder="수불조회 종료일자" />
	                                                </div>
	                                                <div class="float-right margin-dt">
	                                                    <input class="form-control3 dt-w55 py-4 col-xs-2" id="searchFromPoCalldt" name="searchFromPoCalldt" type="text" value="${search.searchFromPoCalldt}" placeholder="수불조회 시작일자" />
	                                                </div>
                                                </div>
                                                
                                                <div style="float: right; margin: 6px 5px; width: 120px;">
                                                    <select class="form-control2" id="searchType" name="searchType">
                                                        <option value="NIN">검품일자</option>
                                                        <option value="IN">작지일자</option>
                                                    </select>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="row" style="margin-left: 0">
                                            <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout: fixed;">
                                                <thead class="thead-dark">
                                                    <tr role="row">
                                                        <!-- <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 7%;">선택</th> -->
                                                        <th id="qm_checkdt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">검품일자</th>
                                                        <th id="item_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">제품명</th>
                                                        <th id="prod_qm_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 19%;">검품LOT</th>
                                                        <th id="actok_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">검품수량</th>
                                                        <th id="use_check_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">입고수량</th>
                                                        <th id="qm_stock_qty" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">추가</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="mainLeftListBody">
                                                    <c:forEach items="${rtn.obj}" var="item" varStatus="status">
                                                        <tr role="row" class="odd">
                                                            <%-- <td class="text-ellipsis"><input type="radio" name="rowRadio" value="${status.count}" data-prodseq="${item.prodSeq}" data-mqcseq="${item.mqcSeq}" data-qmstockqty="${item.qmStockQty}" /></td> --%>
                                                            <td class="text-ellipsis text-center"><span class="qm_checkdt">
                                                            <input type="hidden" name="mqcSeq"   value="${item.mqcSeq}"/>
                                                            ${item.qmCheckdt}</span></td>
                                                            <td class="text-ellipsis text-center"><span class="item_nm">${item.itemNm}</span></td>
                                                            <td class="text-ellipsis text-center"><span class="prod_qm_no">${item.prodQmNo}</span></td>
                                                            <td class="text-ellipsis text-center"><span class="actok_qty"><fmt:formatNumber value="${item.actokQty}" pattern="###,###"/>개</span></td>
                                                            <td class="text-ellipsis text-center"><span class="use_check_qty"><a href="javascript:fn_drawItemInList('${item.mqcSeq}');"><fmt:formatNumber value="${item.useCheckQty}" pattern="###,###"/>개</a></span></td>
                                                            <td class="text-ellipsis text-center"><span><a href="javascript:fn_createItemIn('${item.prodSeq}', '${item.mqcSeq}', ${item.qmStockQty});">입고추가</a></span></td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(rtn.obj) le 0}">
                                                        <tr>
                                                            <td colspan="6" class="no-data">- 표시할 내용이 없습니다. -</td>
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
                                            <thead class="thead-dark" style="display: table; width: 100%; table-layout: fixed;">
                                                <tr role="row">
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">선택</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">입고일자</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 20%;">입고수량</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">창고</th>
                                                    <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 25%;">LOT</th>
                                                </tr>
                                            </thead>
                                            <tbody id="itemInListBody" style="display: block; max-height: 500px; overflow: auto; table-layout: fixed;" />
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
                        <select class="form-control mt-n1 mb-n1 mr-2" id="barcodePrinter" name="barcodePrinter">
                            <option value="">프린터 선택</option>
                            <c:forEach items="${barcode_print_list}" var="item" varStatus="status">
                                <option value="${item.scode}">${item.codeNm}</option>
                            </c:forEach>
                        </select>
                        <div id="btnBarCodePrint" class="btn btn-primary btn-sm mr-2">바코드출력</div>
                    </div>
                </div>
                <div id="previewBarCode" class="card-body" style="margin: auto;">
                </div>
            </div>
        </div>
    </div>

    <form:form commandName="search" id="itemInForm" name="itemInForm">
        <input type="hidden" name="searchMqcSeq" value="" />
    </form:form>

</body>
</html>