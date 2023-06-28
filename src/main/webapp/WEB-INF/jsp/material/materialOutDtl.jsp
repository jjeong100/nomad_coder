<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
<title>자재출고 상제정보 관리</title>
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
                $( "#outDt, #searchPoCalldt" ).datepicker({
			          showOn: "button",
			          buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
			          buttonImageOnly: true,
			          buttonText: "Select date",
			          dateFormat: "yy/mm/dd"
			    });

                //-------------------------------------------------------------
                // jqery event
                //-------------------------------------------------------------

                // 바코드 스캔 이벤트
                $(document).scannerDetection({
                    timeBeforeScanTest: 200, // wait for the next character for upto 200ms
                    avgTimeByChar: 100, // it's not a barcode if a character takes longer than 100ms
                    onComplete: function(barcode, qty){
                    	if( barcode.length < 15 ) {
                    		cfAlert("바코드스캔은 영문변환 후 사용 가능합니다.");
                        	return false;
                        }

                    	$('#lotid').focus();
                        $('#lotid').val(barcode);
                        getMaterialInDataByLotId(barcode);
                    } // main callback function
                });

                $('#matOutTypeCd').change(function() {
                    if ($(this).val() == 'GOUT') {
                        fn_popMatRequireList();
                    } else {
                    }
                });
                $('#outDt').change(function() {
                  var outDt=$(this).val();
                  $('#searchToDate').val(outDt);
                });

             	// 팝업 닫기
                $("#popMatRequireClose").click(function() {
                	$("#matOutTypeCd").val("").prop("selected", true);
                });

                $("#lotid").keyup(function() {
                    if ($(this).val().length >= 15) {
                        getMaterialInDataByLotId($(this).val());
                    } else {
                    	$("#matItemTypeNm, #matCd, #matNm, #inCnt, #stockQty").val('');
                    }
                });

                getMaterialInDataByLotId = function(lotid) {
                    document.searchMaterialInForm.lotid.value = lotid;
                    $.ajax({
                        url : "<c:url value='/getMaterialInDataByLotId.do'/>",
                        type: 'POST',
                        data: $('#searchMaterialInForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            $("#layoutSidenav").loadingClose();

                            if(data.rtn.obj == null) {
                                cfAlert('LOT NO가 존재하지 않습니다.');
                                $("#matItemTypeNm, #matCd, #matNm, #inCnt, #stockQty").val('');
                                return;
                            }

                            if (data.rtn.rc == 0) {

                                // 출고구분 - 공정출고 일때
                                if( $("#matOutTypeCd").val() == "GOUT" ) {
                                    // 소요자재와 LOT NO가 맞지 않는 경우
                                    if( data.rtn.obj.matCd != $("#requireMatCd").val() ) {
                                        cfAlert('LOT NO와 소요자재가 맞지 않습니다.');
                                        $("#matItemTypeNm, #matCd, #matNm, #inCnt, #stockQty").val('');
                                        return;
                                    }
                                }

                                $("#matItemTypeNm").val(data.rtn.obj.matItemTypeNm);
                                $("#matCd").val(data.rtn.obj.matCd);
                                $("#matNm").val(data.rtn.obj.matNm);
                                $("#inCnt").val(cfIsNullString(data.rtn.obj.inCnt, "0"));
                                $("#stockQty").val(cfIsNullString(data.rtn.obj.stockQty, "0"));
                            } else {
                                $("#matItemTypeNm").val('');
                                $("#matCd").val('');
                                $("#matNm").val('');
                                $("#inCnt").val('');
                                $("#stockQty").val('');
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
                // 닫기 버튼 클릭
                //-------------------------------------------------------------
                $('#btnUpdateClose,#btnCreateClose').click(function() {
                    var frm = document.searchForm;
                    frm.action = "<c:url value='/materialOutListPage.do'/>";
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
                                $(".input_number, .input_number1").each(function() {
                                    $(this).val(this.value.replace(/,/gi, ""))
                                });

                                cfAjaxCallAndGoLink("<c:url value='/materialOutSaveAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/materialOutListPage.do'/>");
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
                                $(".input_number, .input_number1").each(function() {
                                    $(this).val(this.value.replace(/,/gi, ""))
                                });

                                cfAjaxCallAndGoLink("<c:url value='/materialOutSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/materialOutListPage.do'/>");
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
                                $(".input_number, .input_number1").each(function() {
                                    $(this).val(this.value.replace(/,/gi, ""))
                                });
                                cfAjaxCallAndGoLink("<c:url value='/materialOutSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/materialOutListPage.do'/>");
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
                     fn_init_value();
                 });
            });
        })(jQuery);


        function fn_btn_show_hide() {
            if (document.objForm.crudType.value == 'R') {
                $('#viewUpdateDisable').show();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').hide();
                $('#btnPopMaterialIn').hide();
                $('.card-body select').attr("disabled",true);
                $('.card-body select').css("background-color","#e9ecef");
                $('.card-body input').attr("readOnly",true);
                $("#outDt").datepicker('option', 'disabled', true);
                $("#outDt").css("background-color","#e9ecef");
            } else if (document.objForm.crudType.value == 'U') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').show();
                $('#viewCreate').hide();
            	$('.card-body select').attr("disabled",false);
                $('.card-body select').css("background-color","");
                $('.card-body input').attr("readOnly",false);
                $('#lotid').attr("readOnly",true);
                $('#matItemTypeNm').attr("readOnly",true);
                $('#matNm').attr("readOnly",true);
                $('#stockQty').attr("readOnly",true);
                $('#inCnt').attr("readOnly",true);
                $("#outDt").datepicker('option', 'disabled', false);
                $("#outDt").css("background-color","");
            } else if (document.objForm.crudType.value == 'C') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').show();
                $('#matNm').attr("readOnly",true);
                $('#matItemTypeNm').attr("readOnly",true);
                $('#stockQty').attr("readOnly",true);
                $('#inCnt').attr("readOnly",true);
            }
        }
        function isNumberKey(evt) {
		    var charCode = (evt.which) ? evt.which : event.keyCode;
		    if (charCode != 46  && charCode > 31 && (charCode < 48 || charCode > 57))
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
// 		    var _pattern1 = /^\d{5}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
// 		    if (_pattern1.test(_value)) {
// 		        if(charCode != 46) {
// 		           alert("100000 이하의 숫자만 입력가능합니다");
// 		           return false;
// 		        }
// 		    }
		    // 소수점 둘째자리까지만 입력가능
		    var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
		    if (_pattern2.test(_value)) {

		        alert("소수점 둘째자리까지만 입력가능합니다.");

		        return false;

		    }
		    return true;

		}

        function fn_init_value() {

            $("#outDt").val('${rtn.obj.outDt}');
            $("#searchPoCalldt").val('${rtn.obj.searchFromDate}');
        }

        function fn_submit_validation() {
            if($("#outDt").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 출고 일자"));
                $("#outDt").focus();
                return false;
            }
            if($("#matOutTypeCd").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 출고 구분"));
                $("#matOutTypeCd").focus();
                return false;
            }
            if($("#matCd").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 자재"));
                return false;
            }
            if($("#outCnt").val().trim() == '' || $("#outCnt").val().trim() == 0){
                alert(MSG_COM_ERR_001.replace("[@]", " : 출고 수량"));
                $("#outCnt").focus();
                return false;
            }
            if (!cfCheckDigit($("#outCnt").val())) {
                alert(MSG_COM_ERR_008.replace("[@]", " : 출고 수량"));
                $("#outCnt").focus();
                return false;
            }
            // 재고조정 - 체크안함.
            if( $("#matOutTypeCd").val() == "MODIFY" ||$("#matOutTypeCd").val() == "GRNT" ) {
            	return true;
            }
            var stockQty		= cfIsNullString($("#stockQty").val(), 0);		//재고수량
            var outCnt			= cfIsNullString($("#outCnt").val(), 0);   		//출고수량
            if( $("#matOutTypeCd").val() == "DISUSE" || $("#matOutTypeCd").val() == "GOUT" ) {
            	  if( parseFloat(outCnt) > stockQty ) {
                  	alert("재고수량이상 출고할 수 없습니다.");
                      $("#outCnt").focus();
                      return false;
                  }
            }
            return true;

        }

        // popMaterialIn.jsp 콜백함수
        function fn_popMaterialIn_callback(obj) {
            $("#lotid").val(obj.lotid);
            $("#matCd").val(obj.matCd);
            $("#matNm").val(obj.matNm);
            $('#workshopCd').val(obj.workshopCd);
            getMaterialInDataByLotId(obj.lotid);
        }

        // popMatRequire.jsp 콜백함수
        function fn_clickMatRequire_callback(obj) {
        	$('#requireMatCd').val(obj.matCd);
            $('#prodSeq').val(obj.prodSeq);
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
				<h1 class="mt-4">자재출고 상세정보</h1>
				<form name="objForm" id="objForm">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<input type="hidden" name="matoutSeq" value="${rtn.obj.matoutSeq}" />
					<input type="hidden" id="prodSeq" name="prodSeq" value="${rtn.obj.prodSeq}" />
					<input type="hidden" id="workshopCd" name="workshopCd" value="${rtn.obj.workshopCd}" />

					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">출고 기본 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="outDt" style="display: block;">출고일자</label>
										<input class="form-control3" id="outDt" name="outDt" type="text" value="${rtn.obj.outDt}" placeholder="출고일자를 입력하세요" />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="matOutTypeCd">출고구분</label>
										<select class="form-control2" id="matOutTypeCd" name="matOutTypeCd">
											<option value="">출고 구분 선택</option>
											<c:forEach items="${mat_out_type_cd_list}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${item.scode == rtn.obj.matOutTypeCd}">
														<option value="${item.scode}" selected>${item.codeNm}</option>
													</c:when>
													<c:when test="${item.scode == 'GOUT'}">
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
										<label class="small mb-1" for="outCnt">출고 수량</label>
										<input id="pMatOutcnt" name="pMatOutcnt" type="hidden" value="${rtn.obj.outCnt}" />
										<input class="form-control" id="outCnt" name="outCnt" type="number" onkeypress="return isNumberKey(event)" value="${rtn.obj.outCnt}" placeholder="출고수량을 입력하세요" />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="lotCard" class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">자재 입고 LOT 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="small mb-1" for="lotid"> 입고LOT NO</label>
										<div class="input-group">
											<input class="form-control" id="lotid" name="lotid" type="text" value="${rtn.obj.lotid}" />
											<span id="btnPopMaterialIn" class="input-group-btn py-1">
												<button class="btn btn-default" type="button">
													<i class="fa fa-search"></i>
												</button>
											</span>
										</div>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group">
										<label class="small mb-1" for="matCd">자재명</label>
										<input class="form-control" id="matCd" name="matCd" type="hidden" value="${rtn.obj.matCd}" />
										<input class="form-control" id="matNm" name="matNm" type="text" value="${rtn.obj.matNm}" />
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="small mb-1" for="inCnt">입고 수량</label>
										<input class="form-control input_number" id="inCnt" name="inCnt" type="text" value="${rtn.obj.inCnt}" />
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="small mb-1" for="stockQty">재고 수량</label>
										<input class="form-control input_number" id="stockQty" name="stockQty" type="text" value="${rtn.obj.stockQty}" />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-body">
							<!-- 변경 최초 버튼 상태 -->
							<div id="viewUpdateDisable" class="col-md-12" style="display: none;">
								<div class="form-row">
<!-- 									<div class="col-md-4"> -->
<!-- 										<div id="btnEnableUpdate" class="btn btn-primary btn-block">수정</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-md-4"> -->
<!-- 										<div id="btnDelete" class="btn btn-primary btn-block">삭제</div> -->
<!-- 									</div> -->
									<div class="col-md-12">
										<div id="btnUpdateClose" class="btn btn-primary btn-block">닫기</div>
									</div>
								</div>
							</div>
							<!-- 변경 가능 상태 버튼 -->
<!-- 							<div id="viewUpdateEnable" class="col-md-12" style="display: none;"> -->
<!-- 								<div class="form-row"> -->
<!-- 									<div class="col-md-6"> -->
<!-- 										<div id="btnEnableUpdateCancel" class="btn btn-primary btn-block">수정 취소</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-md-6"> -->
<!-- 										<div id="btnUpdate" class="btn btn-primary btn-block">수정 완료</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
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

	<!-- 공통 -->
	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>

	<!-- 팝업 -->
	<jsp:include flush="false" page="/WEB-INF/jsp/popup/popMaterialIn.jsp"></jsp:include>
	<jsp:include flush="false" page="/WEB-INF/jsp/popup/popMatRequire.jsp"></jsp:include>

	<!-- LOTID 스캔용 -->
	<form:form commandName="search" id="searchMaterialInForm" name="searchMaterialInForm">
		<input type="hidden" name="lotid" value="" />
	</form:form>

	<!-- 조회파라미터 -->
	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" name="pageIndex" value="1" />
		<input type="hidden" name="searchWorkshopCd" value="${search.searchWorkshopCd}" />
		<input type="hidden" name="searchMatOutTypeCd" value="${search.searchMatOutTypeCd}" />
	</form:form>

</body>
</html>