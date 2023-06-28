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
    <title>거래처 상세정보 관리</title>
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
                // 닫기 버튼 클릭
                //-------------------------------------------------------------
                $('#btnUpdateClose,#btnCreateClose').click(function() {
                    var frm = document.searchForm;
                    frm.action = "<c:url value='/companyListPage.do'/>";
                    frm.submit();
                });
                $("#businessNo").keyup(function(){
                	var regex = /[^0-9]/g;	
                    $("#businessNo").val($("#businessNo").val().replace(regex,""));
                })

                //-------------------------------------------------------------
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
                    $('.card-body select').attr("disabled",false);
                    $('.card-body select').css("background-color","");
                    $('.card-body input').attr("readOnly",false);
                    $('#custCd').attr("readOnly",true);
                    document.objForm.crudType.value = 'U'
                    fn_btn_show_hide();
                });

                //-------------------------------------------------------------
                // 수정 취소 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdateCancel').click(function() {
                    $('.card-body select').attr("disabled",true);
                    $('.card-body select').css("background-color","#e9ecef");
                    $('.card-body input').attr("readOnly",true);

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
                                cfAjaxCallAndGoLink("<c:url value='/companySaveAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/companyListPage.do'/>");
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
                    if (!cfCheckDigit($("#businessNo").val()) && $("#businessNo").val() != "") {
                       alert(MSG_COM_ERR_008.replace("[@]", " : 사업자번호"));
                       $("#businessNo").focus();
                       return false;
                    }
                    if($("#custCd").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 거래처 코드"));
                        $("#custCd").focus();
                        return false;
                    }
                    if($("#custNm").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 거래처명"));
                        $("#custNm").focus();
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
                                cfAjaxCallAndGoLink("<c:url value='/companySaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/companyListPage.do'/>");
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
                    if (!cfCheckDigit($("#businessNo").val()) && $("#businessNo").val() != "") {
                       alert(MSG_COM_ERR_008.replace("[@]", " : 사업자번호"));
                       $("#businessNo").focus();
                       return false;
                    }
                    if($("#custNm").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 거래처명"));
                        $("#custNm").focus();
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
                                cfAjaxCallAndGoLink("<c:url value='/companySaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/companyListPage.do'/>");
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
                 $(document).ready(function(){
                     fn_btn_show_hide();
                     fn_change_cust_type();
                 });
            });
        })(jQuery);


        function fn_btn_show_hide() {
            if (document.objForm.crudType.value == 'R') {
                $('#viewUpdateDisable').show();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').hide();
                $('.card-body select').attr("disabled",true);
                $('.card-body select').css("background-color","#e9ecef");
                $('.card-body input').attr("readOnly",true);
            } else if (document.objForm.crudType.value == 'U') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').show();
                $('#viewCreate').hide();
            } else if (document.objForm.crudType.value == 'C') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').show();
            }
            $('#matTypeNm').attr("readOnly",true);
            $('#matTypeNm').css("background-color","#e9ecef");
        }


        // 20201125 jeonghwan
        // 고객사 일때 자재구분 안보이기
        function fn_change_cust_type(){
//             var custTypeCd = document.objForm.custTypeCd.value;
//             if(custTypeCd == 'COD') $('#divMatTypeCd').hide();
//             else $('#divMatTypeCd').show();
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
                    <!-- <h1 class="mt-4">거래처 관리</h1>  -->

                   <h1 class="mt-4">거래처 상세정보</h1>
                   <form name="objForm" id="objForm">
                   <input type="hidden" name="crudType" value="${search.crudType}"/>
                   <input type="hidden" id="custCd" name="custCd" value="${rtn.obj.custCd}"/>

                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">필수정보</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-12">
                                   <div class="form-group">
                                       <label class="small mb-1" for="custNm">거래처명</label>
                                       <input class="form-control" id="custNm" name="custNm" type="text" value="${rtn.obj.custNm}" placeholder="거래처명을 입력하세요">
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>

                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">상세정보</h3>
                       </div>
                       <div class="card-body">

                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="custTypeCd">업체구분</label>
                                       <select class="form-control2" id="custTypeCd" name="custTypeCd" onchange="javaScript:fn_change_cust_type();">
                                           <c:forEach items="${cust_type_cd_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.scode == rtn.obj.custTypeCd}">
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
                                   <div class="form-group" id="divMatTypeCd">
                                       <label class="small mb-1" for="matTypeCd">자재구분</label>
                                       <!-- <input  type="text" class="form-control" id="matTypeNm" name="matTypeNm" value="원자재" placeholder="자재구분을 입력하세요"/> -->
                                       <select class="form-control2" id="matTypeCd" name="matTypeCd">
                                           <c:forEach items="${mat_type_cd_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.scode == rtn.obj.matTypeCd}">
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

                           <div class="form-group">
                               <label class="small mb-1" for="addr1">주소1</label>
                               <input class="form-control" type="text" id="addr1" name="addr1" value="${rtn.obj.addr1}" placeholder="주소를 입력 하세요">
                           </div>

                           <div class="form-group">
                               <label class="small mb-1" for="addr2">주소2</label>
                               <input class="form-control" type="text" id="addr2" name="addr2" value="${rtn.obj.addr2}" placeholder="주소를 입력 하세요">
                           </div>

                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="telNo">전화번호</label>
                                       <input class="form-control" id="telNo" name="telNo" type="text" value="${rtn.obj.telNo}" placeholder="전화번호를 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="faxNo">팩스번호</label>
                                       <input class="form-control" id="faxNo" name="faxNo" type="text" value="${rtn.obj.faxNo}" placeholder="팩스번호를 입력하세요">
                                   </div>
                               </div>
                           </div>

                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="presidenNm">대표자명</label>
                                       <input class="form-control" id="presidenNm" name="presidenNm" type="text" value="${rtn.obj.presidenNm}" placeholder="대표자명을 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="personNm">담당자명</label>
                                       <input class="form-control" id="personNm" name="personNm" type="text" value="${rtn.obj.personNm}" placeholder="담당자명을 입력하세요">
                                   </div>
                               </div>
                           </div>

                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="personTel">담당자연락처</label>
                                       <input class="form-control" id="personTel" name="personTel" type="text" value="${rtn.obj.personTel}" placeholder="담당자연락처를 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="businessNo">사업자번호</label>
                                       <input class="form-control" id="businessNo" name="businessNo" type="text" value="${rtn.obj.businessNo}" placeholder="사업자번호를 입력하세요">
                                   </div>
                               </div>
                           </div>

                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="personEmail">EMAIL</label>
                                       <input class="form-control" id="email" name="personEmail" type="personEmail" value="${rtn.obj.personEmail}" aria-describedby="emailHelp" placeholder="EMAIL를 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="bigo">메모</label>
                                       <input class="form-control" id="bigo" name="bigo" type="text" value="${rtn.obj.bigo}" placeholder="메모를 입력 하세요">
                                   </div>
                               </div>
                           </div>

                           <!--
                           <div class="form-group mt-4 mb-0">
                               <a class="btn btn-primary btn-block" href="login.html">하나일때 샘플</a>
                           </div>
                           -->


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
    <input type="hidden" name="pageIndex" value="1"/>
    <input type="hidden" name="telNo" value="${search.telNo}"/>
    <input type="hidden" name="custNm" value="${search.custNm}"/>
</form:form>
<script>


</script>
</body>
</html>