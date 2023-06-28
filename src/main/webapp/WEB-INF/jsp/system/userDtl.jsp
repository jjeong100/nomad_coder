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
    <title>사용자 정보 관리</title>
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
                    frm.action = "<c:url value='/userListPage.do'/>";
                    frm.submit();
                });
                
                // 팝업 닫기
                $('.modal-close-button').click(function() {
                    $('.modal-container').css("display", "none");
                });
                
                $('#levelCd').on('change', function() {
                    if($(this).val() == 'INSPECTER') {
                         $("#inspection_confirm").dialog("open");
  
                        if(cfIsNull('${rtn.obj.workCd}')) $("input:radio[name='rowRadioBox']:radio[value='JJ']").attr("checked",true);
                        else $("input:radio[name='rowRadioBox']:radio[value='"+"${rtn.obj.workCd}"+"']").attr("checked",true);
                    }
                });
                
              //-------------------------------------------------------------
                // 검사 선택 팝업
                //-------------------------------------------------------------
                $( "#inspection_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "확인",
                            click: function() {
                                $( this ).dialog( "close" );
                                
                                document.objForm.workCd.value = $("input:radio[name=rowRadioBox]:checked").val();
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
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
                    $('.card-body select').attr("disabled",false);
                    $('.card-body select').css("background-color","");
                    $('.card-body input').attr("readOnly",false);
                    $('#loginId').attr("readOnly",true);
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
                                cfAjaxCallAndGoLink("<c:url value='/userSaveAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/userListPage.do'/>");
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
                    if($("#loginId").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 아이디"));
                        $("#loginId").focus();
                        return false;
                    }
                    if($("#loginName").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 이름"));
                        $("#loginName").focus();
                        return false;
                    }
                    if($("#shortId").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 숏아이디"));
                        $("#shortId").focus();
                        return false;
                    }
                    if ($("#shortId").val() == "${rtn.obj.shortId}") {
                        $( "#glv_upd_confirm" ).dialog( "open" );
                    } else {
                        getUserNameByShortId("U");
                    }
                    
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
                                cfAjaxCallAndGoLink("<c:url value='/userSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/userListPage.do'/>");
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
                    if($("#loginId").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 아이디"));
                        $("#loginId").focus();
                        return false;
                    }
                    if($("#loginName").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 이름"));
                        $("#loginName").focus();
                        return false;
                    }
                    if($("#shortId").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 숏아이디"));
                        $("#shortId").focus();
                        return false;
                    }
                    getUserNameByShortId("C");
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
                                cfAjaxCallAndGoLink("<c:url value='/userSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/userListPage.do'/>");
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
                
                getUserNameByShortId = function(type) {
                    $.ajax({
                        url : "<c:url value='/getLoginNameByShortId.do'/>",
                        type: 'POST',
                        data: $('#objForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            $("#layoutSidenav").loadingClose();
                            if (data.rtn.rc == 0) {
                                alert("존재하는 숏 아이디 입니다.");
                                $("#shortId").focus();
                            } else {
                                if(type == 'C'){
                                    $( "#glv_ins_confirm" ).dialog( "open" );
                                } else {
                                    $( "#glv_upd_confirm" ).dialog( "open" );
                                }
                            }
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
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                     fn_btn_show_hide();
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
                    <!-- menu navigation                                                                                                          -->
                    <!-- ======================================================================================================================== -->
                   <h1 class="mt-4">사용자 상세정보</h1>
                   <form name="objForm" id="objForm">
                   <input type="hidden" name="crudType" value="${search.crudType}"/>
                   <input type="hidden" name="workCd"   value="${rtn.obj.workCd}"/>
                   
                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">필수정보</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="loginId">아이디</label>
                                       <input class="form-control" id="loginId" name="loginId" type="text" value="${rtn.obj.loginId}" placeholder="아이디를 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="loginName">이름</label>
                                       <input class="form-control" id="loginName" name="loginName" type="text" value="${rtn.obj.loginName}" placeholder="이름을 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="levelCd">권한등급</label>
                                       <select class="form-control2" id="levelCd" name="levelCd">
                                           <option value="">권한 등급 선택</option>
                                           <c:forEach items="${level_cd_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.scode == rtn.obj.levelCd}">
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
                                       <label class="small mb-1" for="shortId">숏 아이디</label>
                                       <input class="form-control" id="shortId" name="shortId" type="text" value="${rtn.obj.shortId}" placeholder="숏 아이디를 입력하세요">
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
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="departCd">부서</label>
                                       <select class="form-control2" id="departCd" name="departCd">
                                           <option value="">부서 선택</option>
                                           <c:forEach items="${division_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.departCd == rtn.obj.departCd}">
                                                       <option value="${item.departCd}" selected>${item.departNm}</option>
                                                   </c:when>
                                                   <c:otherwise>
                                                       <option value="${item.departCd}">${item.departNm}</option>
                                                   </c:otherwise>
                                               </c:choose>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="email">이메일</label>
                                       <input class="form-control" type="text" id="email" name="email" value="${rtn.obj.email}" placeholder="이메일을 입력 하세요">
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="mobileNo">전화번호</label>
                                       <input class="form-control" type="text" id="mobileNo" name="mobileNo" value="${rtn.obj.email}" placeholder="전화번호를 입력 하세요">
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

<div id="inspection_confirm" title="확인" style="display:none;">
    <div class="col-md-12">
        <div class="form-row">
            <div class="col-md-8">
                <div class="form-group">
                   <input type="radio" name="rowRadioBox" value="JJ"/>&nbsp;자주 검사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <input type="radio" name="rowRadioBox" value="PT"/>&nbsp;페트롤 검사
                </div>
            </div>
        </div>
    </div>
</div> 

<form:form commandName="search" id="searchForm" name="searchForm">
    <input type="hidden" name="pageIndex" value="1"/>
    <input type="hidden" name="searchLoginName" value="${search.searchLoginName}"/>
</form:form>
<script>

</script>
</body>
</html>