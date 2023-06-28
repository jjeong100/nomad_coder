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
    <title>설비 상세정보 관리</title>
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

                //-------------------------------------------------------------
                // 닫기 버튼 클릭
                //-------------------------------------------------------------
                $('#btnUpdateClose,#btnCreateClose').click(function() {
                	var frm = document.searchForm;
                    frm.action = "<c:url value='/equipListPage.do'/>";
                    frm.submit();
                });

                $("#fileupload").change( function(event) {
                	var fileInput = document.getElementById("fileupload");
                	var fileObj = fileInput.files[0];
                	var reader = new FileReader();
                	reader.readAsDataURL(fileObj);

                	reader.onload = function () {
                		$("#imgArea").fadeIn("fast").attr("src", reader.result);
                		$("#equipImageNm").val(fileObj.name);
                		$("#equipImageData").val(reader.result);
                	};

                	reader.onerror = function (error) {
                		console.log('Error: ', error);
                	};

                });

                //-------------------------------------------------------------
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
                	document.objForm.crudType.value = 'U'
                	fn_btn_show_hide();
                	 $('.card-body select').attr("disabled",true);
                     $('.card-body select').css("background-color","#e9ecef");
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
                	if($("#plcYn").val().trim() == 'Y') {
                        alert("PLC 연동여부가 Y는 설비 삭제가 불가능 합니다.");
                        return false;
                    }
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
                                cfAjaxCallAndGoLink("<c:url value='/equipSaveAct.do'/>"
                                		            ,$('#objForm').serialize(),'삭제 되었습니다.'
                                		            ,'searchForm'
                                		            ,"<c:url value='/equipListPage.do'/>");
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
                                cfAjaxCallAndGoLink("<c:url value='/equipSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/equipListPage.do'/>");
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
                                cfAjaxCallAndGoLink("<c:url value='/equipSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/equipListPage.do'/>");
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
                    // 날짜필드 초기화
                	$( "#equipGetDt" ).datepicker({
                    	showOn: "button",
                    	dateFormat: "yy/mm/dd",
                    	buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
                    	buttonImageOnly: true,
                    	buttonText: "Select date"
                    });
					var plcYn="${rtn.obj.plcYn}";
                	if(plcYn ==''){
                		$('#plcYn').val('N');
                	}
					// 입력길이제한
					$("#equipCd").prop("maxlength", 20);
                    $("#equipNo").prop("maxlength", 30);
                    $("#equipNm").prop("maxlength", 50);
                    $("#equipPg").prop("maxlength", 50);
                    $("#equipModelNo").prop("maxlength", 30);
                    $("#equipCorpNm").prop("maxlength", 30);
                    $("#equipGetDt").prop("maxlength", 10);
                    $("#equipIp").prop("maxlength", 15);

                	fn_btn_show_hide();
                });
            });
        })(jQuery);


        function fn_btn_show_hide() {
        	if (document.objForm.crudType.value == 'R') {
                $('#viewUpdateDisable').show();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').hide();

                $('.card-body textarea').attr("disabled",true);
                $('.card-body select').attr("disabled",true);
                $('.card-body select').css("background-color","#e9ecef");
                $('.card-body input').attr("readOnly",true);

                $(".hasDatepicker").each(function(idx, obj) {
                	$(obj).datepicker('option', 'disabled', true);
                	$(obj).css("background-color","#e9ecef");
                });
            } else if (document.objForm.crudType.value == 'U') {
            	$('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').show();
                $('#viewCreate').hide();

                $('.card-body textarea').attr("disabled",false);
                $('.card-body select').attr("disabled",false);
            	$('.card-body select').css("background-color","");
                $('.card-body input').attr("readOnly",false);

                $('#equipCd').attr("disabled",true);
                $('#equipCd').css("background-color","#e9ecef");
                $('#equipCd').attr("readOnly",true);

                $(".hasDatepicker").each(function(idx, obj) {
                	$(obj).datepicker('option', 'disabled', false);
                	$(obj).css("background-color","");
                });
            } else if (document.objForm.crudType.value == 'C') {
            	$('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').show();
            }
        }

		function fn_submit_validation() {

            if($("#equipNm").val().trim() == '') {
                alert(MSG_COM_ERR_001.replace("[@]", " : 장비명"));
                $("#equipNm").focus();
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

                   <h1 class="mt-4">설비 상세정보</h1>
                   <form name="objForm" id="objForm">
                   <input type="hidden" name="crudType" value="${search.crudType}"/>
                   <input type="hidden" name="equipSeq" value="${rtn.obj.equipSeq}"/>

                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">필수정보</h3>
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="equipNm">설비명</label>
                                       <input class="form-control" id="equipNm" name="equipNm" type="text" value="${rtn.obj.equipNm}" placeholder="설비명를 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="equipModelNm">모델명</label>
                                       <input class="form-control" id="equipModelNm" name="equipModelNm" type="text" value="${rtn.obj.equipModelNm}" placeholder="모델명을 입력하세요">
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="plcYn">PLC 연동 여부</label>
                                       <select class="form-control2" id="plcYn" name="plcYn">
											<option value="">PLC 연동 여부 선택</option>
											<c:forEach items="${yn_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.plcYn}">
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
<%--                                        <img id="imgArea" src="<c:url value='${rtn.obj.equipImageData == null ? "/resource/images/no_image.png":rtn.obj.equipImageData}'/>" alt="설비이미지" style="width: 100%;height: 100%;max-width: 350px;max-height: 300px;"/> --%>
                                   <img id="imgArea" src="<c:url value='${(rtn.obj.equipImageData == null || rtn.obj.equipImageData == "") ? "/resource/images/no_image.png":rtn.obj.equipImageData}'/>" alt="설비이미지" style="width: 100%; height: 100%; max-width: 350px; max-height: 300px;" />
                                   </div>
                           	   </div>
                           	   <div class="col-md-8">
                           	       <div class="form-row">
		                                <div class="col-md-6">
                                            <div class="form-group">
			                                       <label class="small mb-1" for="equipCorpNm">제작사</label>
			                                       <input class="form-control" id="equipCorpNm" name="equipCorpNm" type="text" value="${rtn.obj.equipCorpNm}" placeholder="제작사를 입력하세요">
                                           </div>
                                   		</div>
                                   		<div class="col-md-6">
		                                   <div class="form-group">
		                                       <label class="small mb-1" for="equipGetDt" style="display:block;">구입일자</label>
		                                       <input class="form-control3" id="equipGetDt" name="equipGetDt" type="text" value="${rtn.obj.equipGetDt}" placeholder="구입일자를 입력하세요">
		                                   </div>
		                               </div>

	                               </div>
									<div class="form-row">
                                       <div class="col-md-4">
				                           <div class="form-group">
				                               <label class="small mb-1" for="equipMngCustNm">유지보수업체</label>
				                               <input class="form-control" id="equipMngCustNm" name="equipMngCustNm" type="text" value="${rtn.obj.equipMngCustNm}" placeholder="유지보수업체를 입력 하세요">
				                           </div>
			                           </div>
		                               <div class="col-md-4">
		                                   <div class="form-group">
		                                       <label class="small mb-1" for="equipMngTelNo">유지보수업체 연락처</label>
		                                       <input class="form-control" id="equipMngTelNo" name="equipMngTelNo" type="text" value="${rtn.obj.equipMngTelNo}" placeholder="유지보수업체 연락처를 입력하세요">
		                                   </div>
		                               </div>
		                               <div class="col-md-4">
		                                   <div class="form-group">
		                                       <label class="small mb-1" for="equipMngNm">담당자</label>
		                                       <input class="form-control" id="equipMngNm" name="equipMngNm" type="text" value="${rtn.obj.equipMngNm}" placeholder="담당자를 입력하세요">
		                                   </div>
		                               </div>
		                           </div>
	                               <div class="form-row">
	                                   <div class="col-md-12">
	                                       <div class="form-group">
		                                       <label class="small mb-1" for="equipImageNm">첨부파일</label>
		                                       <div class="row">
			                                       <div class="col-md-10">
			                                           <input type="text" class="form-control" id="equipImageNm" name="equipImageNm" value="${rtn.obj.equipImageNm}" readonly/>
			                                       </div>
		                                           <label class="btn btn-primary" for="fileupload">
		                                               <input id="fileupload" type="file" class="d-none">파일 선택</input>
		                                           </label>
		                                           <input type="hidden" id="equipImageData" name="equipImageData" value="${rtn.obj.equipImageData}"/>
		                                       </div>
		                                   </div>
		                               </div>
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
    <input type="hidden" name="searchEquipNm" value="${search.searchEquipNm}"/>
</form:form>
<script>

</script>
</body>
</html>