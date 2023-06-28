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
<title>자재입고 상세정보 관리</title>
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
            $(".input_number, .input_number1").on("keyup", function(event) {
                $(this).val($(this).val().replace(/[^0-9,.+-]/g, ""));
            }).on("focus", function() {
                this.select();
            });

            $("#inDt").datepicker({
                showOn : "button",
                buttonImage : "<c:url value='/resource/images/calendar46.png'/>",
                buttonImageOnly : true,
                buttonText : "Select date",
                dateFormat : "yy/mm/dd"
            });

            //-------------------------------------------------------------
            // jqery event
            //-------------------------------------------------------------

            $("#matCd").change(function(event) {
                var custCd=$('#matCd option:selected').attr("data-custcd");
                var custNm=$('#matCd option:selected').attr("data-custnm");
                var matItemNm=$('#matCd option:selected').attr("data-matItemNm");

                $('#custCd').val(custNm);
                $('#custCd').attr("data-key",custCd);
                $('#matItemNm').val(matItemNm);
            });

            $('#btnUpdateClose,#btnCreateClose').click(function() {
                var frm = document.searchForm;
                frm.action = "<c:url value='/materialInListPage.do'/>";
                frm.submit();
            });

            //-------------------------------------------------------------
            // 수정 가능 버튼 클릭
            //-------------------------------------------------------------
            $('#btnEnableUpdate').click(function() {
                $('.card-body select').attr("disabled", false);
                $('.card-body select').css("background-color", "");
                $('.card-body input').attr("readOnly", false);
                $('#lotid').attr("readOnly", true);
                $('#custCd').attr("readOnly", true);
                $('#matItemNm').attr("readOnly", true);
                $("#inDt").datepicker('option', 'disabled', false);
                $("#inDt").css("background-color", "");
                document.objForm.crudType.value = 'U'
                fn_btn_show_hide();
            });

            //-------------------------------------------------------------
            // 수정 취소 버튼 클릭
            //-------------------------------------------------------------
            $('#btnEnableUpdateCancel').click(function() {
                document.objForm.crudType.value = 'R'
                fn_btn_show_hide();
            });

            //-------------------------------------------------------------
            // 삭제 이벤트
            //-------------------------------------------------------------
            $('#btnDelete').click(function() {
                $("#glv_del_confirm").dialog("open");
            });

            $("#glv_del_confirm").dialog({
                autoOpen : false,
                width : 400,
                buttons : [ {
                    text : "확인",
                    click : function() {
                        $(this).dialog("close");
                        document.objForm.crudType.value = 'D';
                        $(".input_number, .input_number1").each(function() {
                            $(this).val(this.value.replace(/,/gi, ""));
                        });
                        cfAjaxCallAndGoLink("<c:url value='/materialInSaveAct.do'/>", $('#objForm').serialize()
                                , '삭제 되었습니다.', 'searchForm', "<c:url value='/materialInListPage.do'/>");
                    }
                }, {
                    text : "취소",
                    click : function() {
                        $(this).dialog("close");
                    }
                } ]
            });

            //-------------------------------------------------------------
            // 변경 이벤트
            //-------------------------------------------------------------
            $('#btnUpdate').click(function() {
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
                        document.objForm.crudType.value = 'U';
                        document.objForm.custCd.value=$('#custCd').attr("data-key");
                        $(".input_number, .input_number1").each(function() {
                            $(this).val(this.value.replace(/,/gi, ""));
                        });
                        cfAjaxCallAndGoLink("<c:url value='/materialInSaveAct.do'/>", $('#objForm').serialize()
                                , '수정 되었습니다.', 'searchForm', "<c:url value='/materialInListPage.do'/>");
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
            $('#btnCreate').click(function() {
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
                        document.objForm.crudType.value = 'C';
                        document.objForm.custCd.value=$('#custCd').attr("data-key");
                        $(".input_number, .input_number1").each(function() {
                            $(this).val(this.value.replace(/,/gi, ""));
                        });
                        cfAjaxCallAndGoLink("<c:url value='/materialInSaveAct.do'/>", $('#objForm').serialize()
                                , '생성 되었습니다.', 'searchForm', "<c:url value='/materialInListPage.do'/>");
                    }
                }, {
                    text : "취소",
                    click : function() {
                        $(this).dialog("close");
                    }
                } ]
            });

            //-------------------------------------------------------------
            // 자재 선택 팝업
            //-------------------------------------------------------------
            $("#btnSearchPopMaterial").click(function() {
                if (document.objForm.crudType.value != 'R') {
                    fn_popMaterialList("");
                }
            });

            //-------------------------------------------------------------
            // 자재처 선택 팝업
            //-------------------------------------------------------------
            $("#btnSearchPopCust").click(function() {
                if (document.objForm.crudType.value != 'R') {
                    fn_popCustList($("#custNm").val());
                }
            });

            //-------------------------------------------------------------
            // onLoad
            //-------------------------------------------------------------
            $(document).ready(function() {
                fn_btn_show_hide();
                fn_init_value();
                
                  /** ajax조회 **/
                $("#matCd").select2();
            });
        });
    })(jQuery);
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            // Textbox value
            var _value = event.srcElement.value;
            // 소수점(.)이 두번 이상 나오지 못하게
            var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
            if (_pattern0.test(_value)) {
                if (charCode == 46) {
                    return false;
                }
            }

            // 1000 이하의 숫자만 입력가능
            var _pattern1 = /^\d{5}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
            if (_pattern1.test(_value)) {
                if (charCode != 46) {
                    alert("100000 이하의 숫자만 입력가능합니다");
                    return false;
                }
            }
            // 소수점 둘째자리까지만 입력가능
            var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
            if (_pattern2.test(_value)) {

                alert("소수점 둘째자리까지만 입력가능합니다.");

                return false;

            }
            return true;

        }
    function fn_btn_show_hide() {
        if (document.objForm.crudType.value == 'R') {
            $('#viewUpdateDisable').show();
            $('#viewUpdateEnable').hide();
            $('#viewCreate').hide();
            $('.card-body select').attr("disabled", true);
            $('.card-body select').css("background-color", "#e9ecef");
            $('.card-body input').attr("readOnly", true);
            $("#inDt").datepicker('option', 'disabled', true);
            $("#inDt").css("background-color", "#e9ecef");
            $('.selectpicker').prop('disabled', true);
            $('.selectpicker').selectpicker('refresh');
        } else if (document.objForm.crudType.value == 'U') {
            $('#viewUpdateDisable').hide();
            $('#viewUpdateEnable').show();
            $('#viewCreate').hide();
            $('.selectpicker').prop('disabled', false);
            $('.selectpicker').selectpicker('refresh');
        } else if (document.objForm.crudType.value == 'C') {
            $('#lotCard').hide();
            $('#viewUpdateDisable').hide();
            $('#viewUpdateEnable').hide();
            $('#viewCreate').show();
            $('#lotid').attr("readOnly", true);
            $('#realInCnt').attr("readOnly", true);
            $("#inDt").datepicker('option', 'disabled', false);
        }
    }

    function fn_init_value() {
        $("#inDt").val('${rtn.obj.inDt}');
    }

    function fn_submit_validation() {
        if ($("#inDt").val().trim() == '') {
            alert(MSG_COM_ERR_001.replace("[@]", " : 입고일자"));
            $("#inDt").focus();
            return false;
        }
        if ($("#workshopCd").val().trim() == '') {
            alert(MSG_COM_ERR_001.replace("[@]", " : 창고"));
            $("#workshopCd").focus();
            return false;
        }
        if ($("#matCd").val().trim() == '') {
            alert(MSG_COM_ERR_001.replace("[@]", " : 자재"));
            $("#matCd").focus();
            return false;
        }

        if ($("#inCnt").val().trim() == '' ||$("#inCnt").val().trim() == 0) {
            alert(MSG_COM_ERR_001.replace("[@]", " : 수량"));
            $("#inCnt").focus();
            return false;
        }

        if (!cfCheckDigit($("#inCnt").val())) {
            alert(MSG_COM_ERR_008.replace("[@]", " : 수량"));
            $("#inCnt").focus();
            return false;
        }
        return true;
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
                <!-- <h1 class="mt-4">거래처 관리</h1>  -->
                <!-- ======================================================================================================================== -->
                <!-- menu navigation                                                                                                          -->
                <!-- ======================================================================================================================== -->
                <h1 class="mt-4">자재입고 상세정보</h1>
                <form name="objForm" id="objForm" method="post"
                    enctype="multipart/form-data">
                    <input type="hidden" name="crudType" value="${search.crudType}" />
                    <input type="hidden" name="matinSeq" value="${rtn.obj.matinSeq}" />
                    <input type="hidden" name="matInTypeCd" value="MIN" />
                    <div class="card mb-4" style="margin-top: 30px;">
                        <div class="card-header">
                            <h3 class="text-center font-weight-light my-1">입고 기본 정보</h3>
                        </div>
                        <div class="card-body">

                            <div class="form-row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="small mb-1" for="inDt" style="display: block;">입고일자</label>
                                        <input class="form-control3" id="inDt" name="inDt" type="text"
                                            value="${rtn.obj.inDt}" placeholder="입고일자를 입력하세요" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="small mb-1" for="workshopCd">창고</label> <select
                                            class="form-control2" id="workshopCd" name="workshopCd">
                                            <option value="">창고 선택</option>
                                            <c:forEach items="${store_house_list}" var="item"
                                                varStatus="status">
                                                <c:choose>
                                                    <c:when test="${item.workshopCd == rtn.obj.workshopCd}">
                                                        <option value="${item.workshopCd}" selected>${item.workshopNm}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${item.workshopCd}">${item.workshopNm}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="small mb-1" for="inCnt" style="display: block;">수량</label>
                                        <input class="form-control" id="inCnt" name="inCnt"
                                            type="text" onkeypress="return isNumberKey(event)"
                                            value="${rtn.obj.inCnt}" placeholder="수량을 입력하세요" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="small mb-1" for="matCd">자재</label> <select
                                            class="form-control2" id="matCd" name="matCd">
                                            <option value="">자재 선택</option>
                                            <c:forEach items="${material_list}" var="item"
                                                varStatus="status">
                                                <c:choose>
                                                    <c:when test="${item.matCd == rtn.obj.matCd}">
                                                        <option value="${item.matCd}"
                                                            data-custCd="${item.matCustCd}"
                                                            data-custNm="${item.matCustNm}"
                                                            data-matItemNm="${item.matItemNm}" selected>${item.matNm}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${item.matCd}"
                                                            data-custCd="${item.matCustCd}"
                                                            data-custNm="${item.matCustNm}"
                                                            data-matItemNm="${item.matItemNm}">${item.matNm}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="small mb-1" for="custCd" style="display: block;">자재처</label>
                                        <input class="form-control" id="custCd" name="custCd"
                                            type="text" value="${rtn.obj.custNm}"
                                            data-key="${rtn.obj.custCd}" readonly />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="small mb-1" for="matItemNm"
                                            style="display: block;">품명</label> <input
                                            class="form-control" id="matItemNm" name="matItemNm"
                                            type="text" value="${rtn.obj.matItemNm}" readonly />
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="bigo">비고</label> <input
                                            class="form-control" id="bigo" name="bigo" type="text"
                                            value="${rtn.obj.bigo}" placeholder="비고를 입력하세요">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="small mb-1" for="lotid">LOT NO</label> <input
                                            class="form-control" id="lotid" name="lotid" type="text"
                                            value="${rtn.obj.lotid}" />
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="card mb-4" style="">
                        <div class="card-body">
                            <!-- 변경 최초 버튼 상태 -->
                            <div id="viewUpdateDisable" class="col-md-12"
                                style="display: none;">
                                <div class="form-row">
                                    <div class="col-md-4">
                                        <div id="btnEnableUpdate" class="btn btn-primary btn-block">수정</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div id="btnDelete" class="btn btn-primary btn-block">삭제</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div id="btnUpdateClose" class="btn btn-primary btn-block">닫기</div>
                                    </div>
                                </div>
                            </div>
                            <!-- 변경 가능 상태 버튼 -->
                            <div id="viewUpdateEnable" class="col-md-12"
                                style="display: none;">
                                <div class="form-row">
                                    <div class="col-md-6">
                                        <div id="btnEnableUpdateCancel"
                                            class="btn btn-primary btn-block">수정 취소</div>
                                    </div>
                                    <div class="col-md-6">
                                        <div id="btnUpdate" class="btn btn-primary btn-block">수정
                                            완료</div>
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
                </form>
            </div>
            </main>
        </div>
    </div>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
    <!-- 자재 선택 팝업 -->
    <form:form commandName="search" id="searchForm" name="searchForm">
        <input type="hidden" name="pageIndex" value="1" />
        <input type="hidden" name="searchWorkshopCd"
            value="${search.searchWorkshopCd}" />
        <input type="hidden" name="searchCustCd"
            value="${search.searchCustCd}" />
        <input type="hidden" name="searchFromDate"
            value="${search.searchFromDate}" />
        <input type="hidden" name="searchToDate"
            value="${search.searchToDate}" />
    </form:form>
</body>
</html>