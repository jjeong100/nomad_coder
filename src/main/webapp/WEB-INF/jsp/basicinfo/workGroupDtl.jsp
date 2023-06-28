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
    <title>작업조 상제정보 관리</title>
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
                    frm.action = "<c:url value='/workGroupListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
                	$('.card-body select').attr("disabled",false);
                	$('.card-body select').css("background-color","");
                    $('.card-body input').attr("readOnly",false);
                    $('#workCd').attr("readOnly",true);
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
                                cfAjaxCallAndGoLink("<c:url value='/workGroupSaveAct.do'/>"
                                		            ,$('#objForm').serialize(),'삭제 되었습니다.'
                                		            ,'searchForm'
                                		            ,"<c:url value='/workGroupListPage.do'/>");
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
                	if($("#workCd").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 작업조 코드"));
                        $("#workCd").focus();
                        return false;
                    }
                	if($("#workNm").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 작업조명"));
                        $("#workNm").focus();
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
                                cfAjaxCallAndGoLink("<c:url value='/workGroupSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/workGroupListPage.do'/>");
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
                	if($("#workCd").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 작업조 코드"));
                        $("#workCd").focus();
                        return false;
                    }
                    if($("#workNm").val().trim() == ''){
                        alert(MSG_COM_ERR_001.replace("[@]", " : 작업조명"));
                        $("#workNm").focus();
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
                                cfAjaxCallAndGoLink("<c:url value='/workGroupSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/workGroupListPage.do'/>");
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
                    <!-- title                                                                                                                    -->
                    <!-- ======================================================================================================================== -->
                    <!-- <h1 class="mt-4">거래처 관리</h1>  -->
                    <!-- ======================================================================================================================== -->
                    <!-- menu navigation                                                                                                          -->
                    <!-- ======================================================================================================================== -->
                   <h1 class="mt-4">작업조 상세정보</h1>
                   <form name="objForm" id="objForm">
                   <input type="hidden" name="crudType" value="${search.crudType}"/>

                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">필수정보</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="workCd">작업조 코드</label>
                                       <input class="form-control" id="workCd" name="workCd" type="text" value="${rtn.obj.workCd}" placeholder="작업조코드를 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="workNm">작업조명</label>
                                       <input class="form-control" id="workNm" name="workNm" type="text" value="${rtn.obj.workNm}" placeholder="작업조명을 입력하세요">
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
                                       <label class="small mb-1" for="startWrtm">근무시작시간</label>
                                       <input class="form-control" id="startWrtm" name="startWrtm" type="text" value="${rtn.obj.startWrtm}" placeholder="근무시작시간을 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="endWrtm">근무종료시간</label>
                                       <input class="form-control" id="endWrtm" name="endWrtm" type="text" value="${rtn.obj.endWrtm}" placeholder="근무종료시간을 입력하세요">
                                   </div>
                               </div>
                           </div>

                           <div class="form-row">
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="foodWrtm">식사시간</label>
                                       <input class="form-control" id="foodWrtm" name="foodWrtm" type="text" value="${rtn.obj.foodWrtm}" placeholder="식사시간을 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="idleWrtm">휴식시간</label>
                                       <input class="form-control" id="idleWrtm" name="idleWrtm" type="text" value="${rtn.obj.idleWrtm}" placeholder="휴식시간을 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="changeWrtm">교대시간</label>
                                       <input class="form-control" id="changeWrtm" name="changeWrtm" type="text" value="${rtn.obj.changeWrtm}" placeholder="교대시간을 입력하세요">
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
    <input type="hidden" name="pageIndex" value="1"/>
    <input type="hidden" name="searchWorkNm" value="${search.searchWorkNm}"/>
</form:form>
<script>

</script>
</body>
</html>