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
<title>생산지시관리</title>
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
            $("#poCalldt").datepicker({
                showOn : "button",
                buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                buttonImageOnly : true,
                buttonText : "Select date",
                dateFormat : "yy/mm/dd"
            });
            
            $("#mdDelidt").datepicker({
                showOn : "button",
                buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                buttonImageOnly : true,
                buttonText : "Select date",
                dateFormat : "yy/mm/dd",
            });

            $(".input_number, .input_number1").on("keyup", function(event) {
                $(this).val($(this).val().replace(/[^0-9,.+-]/g,""));
            }).on("focus", function() {
                this.select();
            });

            //-------------------------------------------------------------
            // jqery event
            //-------------------------------------------------------------
            $("#poCalldt, #mdDelidt").change(function(){
                if($("#poCalldt").val() > $("#mdDelidt").val()){
                   alert("지시일자는 납기일자보다 적어야 합니다");
                   $("#poCalldt").val('${rtn.obj.poCalldt}');
                   $("#mdDelidt").val('${rtn.obj.mdDelidt}');
                }
            });

            //-------------------------------------------------------------
            // 소요량 보기 클릭
            //-------------------------------------------------------------
            $("#btnCalQty").click(function() {
                if (document.objForm.crudType.value == "R") {
                    return false;
                }
                if ($("#itemCd").val().trim() == '') {
                    alert(MSG_COM_ERR_001.replace("[@]", " : 제품"));
                    $("#itemCd").focus();
                    return false;
                }
                if ($("#poQty").val().trim() == '') {
                    alert(MSG_COM_ERR_001.replace("[@]", " : 지시수량"));
                    $("#poQty").focus();
                    return false;
                }

                drawMatRequireList();
            });

            //-------------------------------------------------------------
            // 제품 select 변경
            //-------------------------------------------------------------
            $("#itemCd, #poQty").change(function() {
                $("#matRequireListBody tr").remove();
                $("#demandKg").val('');
            });

            drawMatRequireList = function() {
                document.searchMatRequireForm.searchPoQty.value = cfIsNullString($("#poQty").val(), "0").replace(/[^0-9]/gi, "");
                document.searchMatRequireForm.searchBomTypeCd.value = "MT";
                document.searchMatRequireForm.searchItemCd.value = $("#itemCd").val();

                $.ajax({
                    url : "<c:url value='/searchMatRequireListData.do'/>",
                    type: "POST",
                    data: $("#searchMatRequireForm").serialize(),
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    context:this,
                    dataType:"json",
                    beforeSend:function(){
                        $("#matRequireListBody tr").remove();
                        $("#layoutSidenav").loading();
                    },
                    success: function(data) {
                        if(!cfCheckRtnObj(data.rtn)) return;
                        var html = "";
                        $.each(data.rtn.obj, function(key, val){
                            var rtnObj = JSON.stringify(val).replace(/\"/gi, "\'");

                            html = "";
                            html += "<tr role=\"row\" class=\"odd\">";
                            html += "<td class=\"text-center text-ellipsis\" style=\"width: 25%;\"><span>" + val.matNm + "</span></td>";
                            html += "<td class=\"text-center text-ellipsis\" style=\"width: 15%;\"><span>" + cfAddComma(cfIsNullString(val.demandQty, "0")) + " KG</span></td>";
                            html += "<td class=\"text-center text-ellipsis\" style=\"width: 15%;\"><span>" + cfAddComma(cfIsNullString(val.remainQty, "0")) + " KG</span></td>";
                            html += "</tr>";
                            $("#matRequireListBody").append(html);
                            $("#demandKg").val(cfAddComma(cfIsNullString(val.demandQty, "0")));

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
            // 작업지시상태변경
            //-------------------------------------------------------------
            $("#prodTypeCd").change(function() {
                fn_change_prodType("change");
            });

            //-------------------------------------------------------------
            // 수량 천단위 콤마 처리
            //-------------------------------------------------------------
            $("input[name=poQty]").on("keyup", function(event) {
                $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            });

            //-------------------------------------------------------------
            // 닫기 버튼 클릭
            //-------------------------------------------------------------
            $('#btnUpdateClose, #btnCreateClose').click(function() {
                var frm = document.searchForm;
                frm.action = "<c:url value='/productionOrderListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 수정 가능 버튼 클릭
            //-------------------------------------------------------------
            $("#btnEnableUpdate").click(function() {
                fn_change_prodType("U");
                document.objForm.crudType.value = "U";

                fn_btn_show_hide();
            });

            //-------------------------------------------------------------
            // 수정 취소 버튼 클릭
            //-------------------------------------------------------------
            $("#btnEnableUpdateCancel").click(function() {
                document.objForm.crudType.value = "R";
                fn_btn_show_hide();
            });

            //-------------------------------------------------------------
            // 변경 이벤트
            //-------------------------------------------------------------
            $("#btnUpdate").click(function() {
                var frm = document.objForm;
                $("#poQty").val($("#poQty").val().replace(/[^0-9]/g, ""));

                if (!fn_submit_validation()) {
                    return false;
                }
                $("#glv_upd_confirm").dialog("open");
            });

            $("#glv_upd_confirm").dialog({
                autoOpen : false,
                width : 400,
                buttons : [ {
                    text : "변경",
                    click : function() {
                        $(this).dialog("close");
                        document.objForm.crudType.value = "U";
                        $(".input_number, .input_number1").each(function() {
                            $(this).val(this.value.replace(/,/gi, ""));
                        });

                        $("#poCalldt").val($("#poCalldt").val().replaceAll('/', ''));
                        $("#mdDelidt").val($("#mdDelidt").val().replaceAll('/', ''));
                        cfAjaxCallAndGoLink("<c:url value='/productionOrderSaveAct.do'/>"
                                , $("#objForm").serialize(), '수정 되었습니다.', "searchForm"
                                , "<c:url value='/productionOrderListPage.do'/>");
                    }
                }, {
                    text : "취소",
                    click : function() {
                        $(this).dialog("close");
                    }
                } ]
            });

            //-------------------------------------------------------------
            // 생성 이벤트
            //-------------------------------------------------------------
            $("#btnCreate").click(function() {
                var frm = document.objForm;
                $("#poQty").val($("#poQty").val().replace(/[^0-9]/g, ""));

                if (!fn_submit_validation()) {
                    return false;
                }
                $("#glv_ins_confirm").dialog("open");
            });

            $("#glv_ins_confirm").dialog({
                autoOpen : false,
                width : 400,
                buttons : [ {
                    text : "생성",
                    click : function() {
                        $(this).dialog("close");
                        document.objForm.crudType.value = "C";
                        $(".input_number, .input_number1").each(function() {
                            $(this).val(this.value.replace(/,/gi, ""));
                        });

                        $("#poCalldt").val($("#poCalldt").val().replaceAll('/', ''));
                        $("#mdDelidt").val($("#mdDelidt").val().replaceAll('/', ''));
                        cfAjaxCallAndGoLink("<c:url value='/productionOrderSaveAct.do'/>"
                                , $("#objForm").serialize(), '생성 되었습니다.', "searchForm"
                                , "<c:url value='/productionOrderListPage.do'/>");
                    }
                }, {
                    text : "취소",
                    click : function() {
                        $(this).dialog("close");
                    }
                } ]
            });

            //-------------------------------------------------------------
            // onLoad
            //-------------------------------------------------------------
            $(document).ready(function() {
                fn_btn_show_hide();
                fn_init_value();
                
                 /** ajax조회 **/
                $("#itemCd").select2();
            });
        });
    })(jQuery);

    //-------------------------------------------------------------
    // 설비 배정및 배정수량은 최초 작업시작시 가능
    // 수정시 불가 수정은 작업설비지정 화면에서 하세요.
    //-------------------------------------------------------------
    function fn_btn_show_hide() {
        if (document.objForm.crudType.value == "R") {
            $("#viewUpdateDisable").show();
            $("#viewProductionInfo").show();
            $("#viewUpdateEnable").hide();
            $("#viewCreate").hide();
            $(".card-body select").attr("disabled", true);
            $(".card-body select").css("background-color", "#e9ecef");
            $(".card-body input").attr("readOnly", true);
            $("#poCalldt").datepicker("option", "disabled", true);
            $("#poCalldt").css("background-color", "#e9ecef");
            $("#mdDelidt").datepicker("option", "disabled", true);
            $("#mdDelidt").css("background-color", "#e9ecef");
        } else if (document.objForm.crudType.value == "U") {
            $("#viewUpdateDisable").hide();
            $("#viewUpdateEnable").show();
            $("#viewCreate").hide();
            $("#prodTypeCd").attr("disabled", false);
            $("#prodTypeCd").css("background-color", "");
        } else if (document.objForm.crudType.value == "C") {
            $("#viewUpdateDisable").hide();
            $("#viewUpdateEnable").hide();
            $("#viewCreate").show();
        }
    }

    //-------------------------------------------------------------
    // 초기화
    //-------------------------------------------------------------
    function fn_init_value() {
        if (document.objForm.crudType.value == "R") {
            $("#mdDelidt").val('${rtn.obj.mdDelidt}');
        }

        // 작업지시상태
        if ($("#prodTypeCd").val().trim() == '') {
            $("#prodTypeCd  option:eq(1)").prop("selected", true);
        }

        // 조회시
        if( ${rtn.obj.prodSeq != null} ) {
            drawMatRequireList();
        }
    }

    //-------------------------------------------------------------
    // 저장 유효성 체크
    //-------------------------------------------------------------
    function fn_submit_validation() {
        if ($("#poCalldt").val().trim() == '') {
            alert(MSG_COM_ERR_001.replace("[@]", " : 작업지시일자"));
            $("#poCalldt").focus();
            return false;
        }
        if ($("#mdDelidt").val().trim() == '') {
            alert(MSG_COM_ERR_001.replace("[@]", " : 납기일자"));
            $("#mdDelidt").focus();
            return false;
        }
        if ($("#poQty").val().trim() == '' || $("#poQty").val().trim() == 0) {
            alert(MSG_COM_ERR_001.replace("[@]", " : 수량"));
            $("#poQty").focus();
            return false;
        }
        if ($("#itemCd").val().trim() == '') {
            alert(MSG_COM_ERR_001.replace("[@]", " : 제품"));
            $("#itemCd").focus();
            return false;
        }

        //-----------------------------------------------------------------------
        // 숫자 체크
        //-----------------------------------------------------------------------
        if (!cfCheckDigit($("#poQty").val())) {
            alert(MSG_COM_ERR_008.replace("[@]", " : 수량"));
            $("#poQty").focus();
            return false;
        }

        return true;
    }

    //-------------------------------------------------------------
    // 반제품 생산지시
    //-------------------------------------------------------------
    function fn_popHalfProduct(obj) {
        if (document.objForm.crudType.value == "R") {
            return false;
        }

        obj.poCalldt    = $("#poCalldt").val();
        obj.mdDelidt    = $("#mdDelidt").val();
        obj.poQty        = obj.demandQty;

        fn_popProductionOrder(obj);
    }

    function fn_change_prodType(pDiv) {
        // 대기상태
        if( $("#prodTypeCd").val() == "WAT" ) {
            // 전체 활성화
            $('.card-body select').attr("disabled", false);
            $('.card-body select').css("background-color","");
            $('.card-body input').attr("readOnly", false);
            $("#poCalldt").datepicker('option', 'disabled', false);
             $("#poCalldt").css("background-color","");
             $("#mdDelidt").datepicker('option', 'disabled', false);
             $("#mdDelidt").css("background-color","");

            $('#prodPoNo').attr("readOnly", true);        // 작업지시 번호
        } else {
            // 전체 비활성화
            $('.card-body select').attr("disabled", true);
            $('.card-body select').css("background-color", "#e9ecef");
            $('.card-body input').attr("readOnly", true);
            $("#poCalldt").datepicker('option', 'disabled', true);
             $("#poCalldt").css("background-color","#e9ecef");
             $("#mdDelidt").datepicker('option', 'disabled', true);
             $("#mdDelidt").css("background-color","#e9ecef");

            // div 작업지시 기본 정보
            $('#prodTypeCd').attr("disabled", false)
                            .attr("readOnly", false)
                            .css("background-color", "");    // 작업지시 상태
        }
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
                <h1 class="mt-4">생산지시 상세정보</h1>
                <form:form commandName="obj" id="objForm" name="objForm">
                    <input type="hidden" id="crudType"    name="crudType"    value="${search.crudType}" />
                    <input type="hidden" id="prodSeq"    name="prodSeq"    value="${rtn.obj.prodSeq}" />

                    <div class="card" style="margin-top: 30px;">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-1">생산지시 정보</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="poCalldt">지시일자</label>
                                        <input class="form-control3" id="poCalldt" name="poCalldt" type="text" value="${rtn.obj.poCalldt}" placeholder="지시일자" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="mdDelidt">납기일자</label>
                                        <input class="form-control3" id="mdDelidt" name="mdDelidt" type="text" value="${rtn.obj.mdDelidt}" placeholder="납기일자" />
                                    </div>
                                </div>


                            </div>

                            <div class="form-row">
                            <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="prodTypeCd">작업지시상태</label>
                                        <select class="form-control2" id="prodTypeCd" name="prodTypeCd">
                                            <option value="">작업지시 선택</option>
                                            <c:forEach items="${prod_type_cd_list}" var="item" varStatus="status">
                                                <c:choose>
                                                    <c:when test="${item.scode == rtn.obj.prodTypeCd}">
                                                        <option value="${item.scode}" selected>${item.codeNm}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${item.scode}">${item.codeNm}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="prodBigo">변경 사유</label>
                                        <input class="form-control" id="prodBigo" name="prodBigo" type="text" value="${rtn.obj.prodBigo}" placeholder="변경사유" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="itemCd">제품</label>
                                        <select class="form-control2" id="itemCd" name="itemCd">
                                            <option value="">제품 선택</option>
                                            <c:forEach items="${product_list}" var="item" varStatus="status">
                                                <c:choose>
                                                    <c:when test="${item.itemCd == rtn.obj.itemCd}">
                                                        <option value="${item.itemCd}" selected>${item.itemNm}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${item.itemCd}">${item.itemNm}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="poQty">지시수량</label>
                                        <input class="form-control input_number" id="poQty" name="poQty" type="text" value="<fmt:formatNumber value="${rtn.obj.poQty}" pattern="###,###.##"/>" placeholder="작업지시수량" />
                                    </div>
                                </div>
<!--                                 <div class="col-md-3"> -->
<!--                                     <div class="pt-4" style="padding-top: 1.5rem !important;"> -->
<!--                                         <div id="btnCalQty" class="btn btn-primary btn-block">소요량 보기</div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <div class="col-md-3"> -->
<!--                                     <div class="form-group"> -->
<!--                                         <label class="small mb-1" for="demandKg">소요 중량 (KG)</label> -->
<!--                                         <input class="form-control" id="demandKg" name="demandKg" type="text" value="" placeholder="소요중량 (KG)" readonly/> -->
<!--                                     </div> -->
<!--                                 </div> -->
                            </div>
                            <div class="form-row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="small mb-1" for="">비고</label>
                                        <input class="form-control" id="" name="" type="text" value="" placeholder="비고" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

<!--                     <div class="card"> -->
<!--                         <div class="card-header"> -->
<!--                             <h3 class="text-center font-weight-light my-1">자재 소요 정보</h3> -->
<!--                         </div> -->

<!--                         <div class="card-body"> -->
<!--                             <div class="table-responsive"> -->
<!--                                 <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4"> -->
<!--                                     <div class="col-sm-12"> -->
<!--                                         <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;"> -->
<!--                                             <thead class="thead-dark"> -->
<!--                                                 <tr role="row"> -->
<!--                                                     <th class="text-center" style="width: 25%;">자재명</th> -->
<!--                                                     <th class="text-center" style="width: 15%;">소요중량</th> -->
<!--                                                     <th class="text-center" style="width: 15%;">재고중량</th> -->
<!--                                                 </tr> -->
<!--                                             </thead> -->
<!--                                             <tbody id="matRequireListBody"/> -->
<!--                                         </table> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->

                    <div class="card" style="margin-top: 30px;">
                        <div class="card-body">
                            <!-- 변경 최초 버튼 상태 -->
                            <div id="viewUpdateDisable" class="col-md-12" style="display: none;">
                                <div class="form-row">
                                    <div class="col-md-6">
                                        <div id="btnEnableUpdate" class="btn btn-primary btn-block">수정</div>
                                    </div>
                                    <div class="col-md-6">
                                        <div id="btnUpdateClose" class="btn btn-primary btn-block">닫기</div>
                                    </div>
                                </div>
                            </div>
                            <!-- 변경 가능 상태 버튼 -->
                            <div id="viewUpdateEnable" class="col-md-12" style="display: none;">
                                <div class="form-row">
                                    <div class="col-md-6">
                                        <div id="btnEnableUpdateCancel" class="btn btn-primary btn-block">수정 취소</div>
                                    </div>
                                    <div class="col-md-6">
                                        <div id="btnUpdate" class="btn btn-primary btn-block">수정 완료</div>
                                    </div>
                                </div>
                            </div>
                            <!-- 생성 버튼 -->
                            <div id="viewCreate" class="col-md-12" style="display: none;">
                                <div class="form-row">
                                    <div class="col-md-6">
                                        <div id="btnCreate" class="btn btn-primary btn-block">생성</div>
                                    </div>
                                    <div class="col-md-6">
                                        <div id="btnCreateClose" class="btn btn-primary btn-block">닫기</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
            </main>
        </div>
    </div>

    <jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
    <jsp:include flush="false" page="/WEB-INF/jsp/popup/popProductionOrder.jsp"></jsp:include>

    <form:form commandName="search" id="searchForm" name="searchForm">
        <input type="hidden" name="pageIndex" value="1"/>
        <input type="hidden" name="searchFromDate" value="${search.searchFromDate}"/>
        <input type="hidden" name="searchToDate" value="${search.searchToDate}"/>
        <input type="hidden" name="searchProdPoNo" value="${search.searchProdPoNo}"/>
        <input type="hidden" name="searchItemCd" value="${search.searchItemCd}"/>
    </form:form>

    <form:form commandName="searchMatRequireVO" id="searchMatRequireForm" name="searchMatRequireForm">
        <input type="hidden" name="searchItemCd" value=""/>
        <input type="hidden" name="searchBomTypeCd" value=""/>
        <input type="hidden" name="searchPoQty" value=""/>
    </form:form>
</body>
</html>