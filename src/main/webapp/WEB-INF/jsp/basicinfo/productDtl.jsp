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
    <title>제품 상세정보 관리</title>
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
                

                $("#fileupload").change( function(event) {
                    var fileInput = document.getElementById("fileupload");
                    var fileObj = fileInput.files[0];
                    var reader = new FileReader();
                    reader.readAsDataURL(fileObj);

                    reader.onload = function () {
                        console.log(reader.result);//base64encoded string
                        $("#imgArea").fadeIn("fast").attr("src", reader.result);
                        $("#itemImage").val(fileObj.name);
                        $("#itemImageData").val(reader.result);
                    };

                    reader.onerror = function (error) {
                        console.log('Error: ', error);
                    };

                });

                //-------------------------------------------------------------
                // 닫기 버튼 클릭
                //-------------------------------------------------------------
                $('#btnUpdateClose,#btnCreateClose').click(function() {
                    var frm = document.searchForm;
                    frm.action = "<c:url value='/productListPage.do'/>";
                    frm.submit();
                });

                //-------------------------------------------------------------
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
                    $('.card-body select').attr("disabled",false);
                    $('.card-body select').css("background-color","");
                    $('.card-body input').attr("readOnly",false);
                    $('#itemNm').attr("readOnly",true);
                    $('#itemTypeCd').attr("disabled",true);
                    $('#itemTypeCd').css("background-color","rgb(233, 236, 239)");
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

                //-------------------------------------------------------------
                // 삭제 이벤트 dialog
                //-------------------------------------------------------------
                $( "#glv_del_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "확인",
                            click: function() {
                                $( this ).dialog( "close" );
                                document.objForm.crudType.value = 'D';
                                cfAjaxCallAndGoLink("<c:url value='/productSaveAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/productListPage.do'/>");
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

                //-------------------------------------------------------------
                // 변경 이벤트 dialog
                //-------------------------------------------------------------
                $( "#glv_upd_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "변경",
                            click: function() {
                                $( this ).dialog( "close" );
                                document.objForm.crudType.value = 'U';
                                cfAjaxCallAndGoLink("<c:url value='/productSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/productListPage.do'/>");
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

                //-------------------------------------------------------------
                // 생성 이벤트 dialog
                //-------------------------------------------------------------
                $( "#glv_ins_confirm" ).dialog({
                    autoOpen: false,
                    width: 400,
                    buttons: [
                        {
                            text: "생성",
                            click: function() {
                                $( this ).dialog( "close" );
                                document.objForm.crudType.value = 'C';
                                cfAjaxCallAndGoLink("<c:url value='/productSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/productListPage.do'/>");
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

        //=====================================================================
        // fn_submit_validation
        //=====================================================================
        function fn_submit_validation() {
            if($("#itemNm").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 품명"));
                $("#itemNm").focus();
                return false;
            }
            return true;
        }

        //=====================================================================
        // fn_btn_show_hide
        //=====================================================================
        function fn_btn_show_hide() {
            if (document.objForm.crudType.value == 'R') {
                $('#viewUpdateDisable').show();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').hide();
                $('.card-body select').attr("disabled",true);
                $('.card-body select').css("background-color","#e9ecef");
                $('.card-body input').attr("readOnly",true);
                $('.card-body input[type="file"]').attr("disabled", true);

                if(${rtn.obj.bomCnt > 0} || ${rtn.obj.prodOrdCnt > 0}) {
                    $("#btnDelete").addClass("disabled");

                    $("#btnDelete").unbind().click(function(){
                        cfAlert("BOM이 등록되어 있거나 작업지시가 등록되어있는 경우의 제품은 삭제 할 수 없습니다.");
                        return false;
                    });
                }
            } else if (document.objForm.crudType.value == 'U') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').show();
                $('#viewCreate').hide();
                $('.card-body input[type="file"]').attr("disabled", false);
                $('#itemImage').attr("readOnly",true);
            } else if (document.objForm.crudType.value == 'C') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').show();
                $('#weightCd').val('G').prop("selected",true);
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
                   <h1 class="mt-4">제품 상세 정보</h1>
                   <form name="objForm" id="objForm">
                   <input type="hidden" name="crudType" value="${search.crudType}"/>

                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">필수정보</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-4">
                                    <div class="form-group">
                                         <img id="imgArea" src="<c:url value='${rtn.obj.itemImageData == null ? "/resource/images/no_image.png":rtn.obj.itemImageData}'/>" alt="제품이미지" style="width: 100%;height: 100%;max-width: 350px;max-height: 300px;"/>
                                     </div>
                                </div>
                               
                               <div class="col-md-8">
                                   <div class="form-row">
                                           <div class="col-md-6">
                                               <div class="form-group">
                                                   <label class="small mb-1" for="itemNm">제품명</label>
                                                   <input class="form-control py-4" id="itemCd" name="itemCd" type="hidden" value="${rtn.obj.itemCd}" >
                                                   <input class="form-control py-4" id="itemNm" name="itemNm" type="text" value="${rtn.obj.itemNm}" placeholder="품명을 입력하세요">
                                               </div>
                                           </div>
                                           <div class="col-md-6">
                                               <div class="form-group">
                                                   <label class="small mb-1" for="itemSize">규격</label>
                                                   <input class="form-control py-4" id="itemSize" name="itemSize" type="text" value="${rtn.obj.itemSize}" placeholder="규격을 입력하세요">
                                               </div>
                                           </div>
                                       </div>
                                       <div class="form-row">
                                           <div class="col-md-12">
                                               <div class="form-group">
                                                   <label class="small mb-1" for="bigo">비고</label>
                                                   <input class="form-control py-4" id="bigo" name="bigo" type="text" value="${rtn.obj.bigo}" placeholder="비고를 입력하세요">
                                               </div>
                                           </div>
                                       </div>
                                       
                                       <div class="form-row">
                                           <div class="col-md-12">
                                               <div class="form-group">
                                                   <label class="small mb-1" for="popShortId">첨부파일</label>
                                                   <div class="row">
                                                       <div class="col-md-6">
                                                           <input type="text" class="form-control" id="itemImage" name="itemImage" value="${rtn.obj.itemImage}" readonly/>
                                                       </div>   
                                                       <label class="btn btn-primary" for="fileupload">
                                                           <input id="fileupload" type="file" class="d-none"/>파일 선택</label>
                                                       <input type="hidden" id="itemImageData" name="itemImageData"/>
                                                   </div>
                                               </div>
                                           </div>
                                       </div>
                                 </div>
                           </div>
                       </div>
                   </div>

                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-body">
                           <!-- 변경 최초 버튼 상태 -->
                           <div id="viewUpdateDisable" class="col-md-12" style="display:none;">
                               <div class="form-row">
                                   <div class="col-md-4">
                                      <div id="btnEnableUpdate" class="btn btn-dark btn-block">수정</div>
                                   </div>
                                   <div class="col-md-4">
                                      <div id="btnDelete" class="btn btn-dark btn-block">삭제</div>
                                   </div>
                                   <div class="col-md-4">
                                       <div id="btnUpdateClose" class="btn btn-dark btn-block">닫기</div>
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
    <input type="hidden" name="searchItemCd" value="${search.searchItemCd}"/>
    <input type="hidden" name="searchCustNm" value="${search.searchCustNm}"/>
</form:form>
<script>

</script>
</body>
</html>