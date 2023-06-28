<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <title>검사항목 상세정보 관리</title>
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

                $('#inspItemTypeCd').change(function() {
                    if ($(this).val() == 'SECTION') {
                        $('#highVal').attr("readonly",false);
                        $('#lowVal').attr("readonly",false);
                        $('#inspDanwiCd').attr("readonly",false);
                        $('#inspDanwiCd').css("background-color","");
                    } else {
                        $('#highVal').attr("readonly",true);
                        $('#lowVal').attr("readonly",true);
                        $('#highVal').val('');
                        $('#lowVal').val('');
                        $('#inspDanwiCd').val('');
                        $('#inspDanwiCd').attr("readonly",true);
                        $('#inspDanwiCd').css("background-color","#e9ecef");
                    }
                });

                //-------------------------------------------------------------
                // 닫기 버튼 클릭
                //-------------------------------------------------------------
                $('#btnUpdateClose,#btnCreateClose').click(function() {
                    var frm = document.searchForm;
                    frm.action = "<c:url value='/inspItemListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
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
                    $( "#glv_del_confirm" ).dialog( "open" );
                });

                $( "#glv_del_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "확인",
                            click: function() {
                                $( this ).dialog( "close" );
                                document.objForm.crudType.value = 'D';
                                cfAjaxCallAndGoLink("<c:url value='/inspItemSaveAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/inspItemListPage.do'/>");
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

                //-------------------------------------------------------------
                // 변경 이벤트
                //-------------------------------------------------------------
                $('#btnUpdate').click(function() {
                    if (!fn_submit_validation()) {
                        return false;
                    }
                    $( "#glv_upd_confirm" ).dialog( "open" );
                });

                $( "#glv_upd_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "변경",
                            click: function() {
                                $( this ).dialog( "close" );

                                document.objForm.crudType.value = 'U';
                                cfAjaxCallAndGoLink("<c:url value='/inspItemSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/inspItemListPage.do'/>");
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

                //-------------------------------------------------------------
                // 생성 이벤트
                //-------------------------------------------------------------
                $('#btnCreate').click(function() {
                    if (!fn_submit_validation()) {
                        return false;
                    }
                    $( "#glv_ins_confirm" ).dialog( "open" );
                });

                $( "#glv_ins_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "생성",
                            click: function() {
                                $( this ).dialog( "close" );
                                document.objForm.crudType.value = 'C';
                                cfAjaxCallAndGoLink("<c:url value='/inspItemSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/inspItemListPage.do'/>");
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

                //-------------------------------------------------------------
                // onLoad
                //-------------------------------------------------------------
                $(document).ready(function() {
                    fn_btn_show_hide();
                });
            });
        })(jQuery);


        function fn_btn_show_hide() {
            if (document.objForm.crudType.value == 'R') {
                $('#viewUpdateDisable').show();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').hide();
                $('.card-body select').attr("readonly",true);
                $('.card-body select').css("background-color","#e9ecef");
                $('.card-body input').attr("readOnly",true);
            } else if (document.objForm.crudType.value == 'U') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').show();
                $('#viewCreate').hide();
                $('.card-body select').attr("readonly",false);
                $('.card-body select').css("background-color","");
                $('.card-body input').attr("readOnly",false);

                $('#inspTypeCd').attr("readonly",true);
                $('#inspTypeCd').css("background-color","#e9ecef");
                $('#inspItemCd').attr("readOnly",true);
                if($("#inspItemTypeCd").val().trim() != 'SECTION') {
                    $('#highVal').attr("readonly",true);
                    $('#lowVal').attr("readonly",true);
                    $('#inspDanwiCd').attr("readonly",true);
                    $('#inspDanwiCd').css("background-color","#e9ecef");
                }

            } else if (document.objForm.crudType.value == 'C') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').show();
            }
        }

        function fn_submit_validation() {
        	if($("#inspTypeCd").val().trim() == '') {
                alert(MSG_COM_ERR_001.replace("[@]", " : 검사타입구분"));
                $("#inspTypeCd").focus();
                return false;
            }
            if($("#inspItemCd").val().trim() == '') {
                alert(MSG_COM_ERR_001.replace("[@]", " : 검사항목코드"));
                $("#inspItemCd").focus();
                return false;
            }

            if($("#inspItemNm").val().trim() == '') {
                alert(MSG_COM_ERR_001.replace("[@]", " : 검사항목명"));
                $("#inspItemNm").focus();
                return false;
            }
            if($("#inspItemTypeCd").val().trim() == '') {
                alert(MSG_COM_ERR_001.replace("[@]", " : 검사방법구분"));
                $("#inspItemTypeCd").focus();
                return false;
            }

            if($("#inspItemTypeCd").val().trim() == 'SECTION') {
                if($("#highVal").val().trim() == '') {
                    alert(MSG_COM_ERR_001.replace("[@]", " : 상한값"));
                    $("#highVal").focus();
                    return false;
                }
                if($("#lowVal").val().trim() == '') {
                    alert(MSG_COM_ERR_001.replace("[@]", " : 하한값"));
                    $("#lowVal").focus();
                    return false;
                }
                if($("#inspDanwiCd").val().trim() == '') {
                    alert(MSG_COM_ERR_001.replace("[@]", " : 검사항목단위"));
                    $("#inspDanwiCd").focus();
                    return false;
                }

                if (!cfCheckDigit($("#highVal").val())) {
                    alert(MSG_COM_ERR_008.replace("[@]", " : 상한값"));
                    $("#highVal").focus();
                    return false;
                }
                if (!cfCheckDigit($("#lowVal").val())) {
                    alert(MSG_COM_ERR_008.replace("[@]", " : 하한값"));
                    $("#lowVal").focus();
                    return false;
                }
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
                   <h1 class="mt-4">검사항목 상세정보</h1>
                   <form name="objForm" id="objForm">
                   <input type="hidden" name="crudType" value="${search.crudType}"/>

                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">상세정보</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="inspTypeCd">검사타입구분</label>
                                       <select class="form-control2" id="inspTypeCd" name="inspTypeCd">
                                        <option value=''>검사 타입 구분 선택</option>
                                           <c:forEach items="${insp_type_cd_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.scode == rtn.obj.inspTypeCd}">
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
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="inspItemCd">검사항목코드</label>
                                       <input class="form-control" id="inspItemCd" name="inspItemCd" type="text" value="${rtn.obj.inspItemCd}" placeholder="검사항목코드를 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="inspItemNm">검사항목명</label>
                                       <input class="form-control" id="inspItemNm" name="inspItemNm" type="text" value="${rtn.obj.inspItemNm}" placeholder="검사항목명을 입력하세요">
                                   </div>
                               </div>
                           </div>
                           <div class="form-row">
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="inspItemTypeCd">검사방법구분</label>
                                       <select class="form-control2" id="inspItemTypeCd" name="inspItemTypeCd">
                                       <option value=''>검사 방법 구분 선택</option>
                                           <c:forEach items="${insp_item_type_cd_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.scode == rtn.obj.inspItemTypeCd}">
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
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="lowVal">하한값</label>
                                       <input class="form-control" id="lowVal" name="lowVal" type="text" value="${rtn.obj.lowVal}" placeholder="하한값를 입력하세요">
                                   </div>
                               </div>
                                  <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="highVal">상한값</label>
                                       <input class="form-control" id="highVal" name="highVal" type="text" value="${rtn.obj.highVal}" placeholder="상한값를 입력 하세요">
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="inspDanwiCd">검사항목단위</label>
                                       <select class="form-control2" id="inspDanwiCd" name="inspDanwiCd">
                                       <option value=''>검사 항목 단위 선택</option>
                                           <c:forEach items="${insp_danwi_cd_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.scode == rtn.obj.inspDanwiCd}">
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
                           </div>



                           <!-- 변경 최초 버튼 상태 -->
                           <div id="viewUpdateDisable" class="col-md-12" style="display:none;">
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
                           <div id="viewUpdateEnable" class="col-md-12" style="display:none;">
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
                           <div id="viewCreate" class="col-md-12" style="display:none;">
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


<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>
<form:form commandName="search" id="searchForm" name="searchForm">
    <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
    <input type="hidden" name="pageSize" value="${search.pageSize}"/>
    <input type="hidden" name="sortCol" value="${search.sortCol}"/>
    <input type="hidden" name="sortType" value="${search.sortType}"/>
    <input type="hidden" name="searchInspItemNm" value="${search.searchInspItemNm}"/>
    <input type="hidden" name="searchInspTypeCd" value="${search.searchInspTypeCd}"/>
</form:form>
<script>

</script>
</body>
</html>