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
            $(function(){
                //-------------------------------------------------------------
                // declare gloval
                //-------------------------------------------------------------
                $("#iteminDt, #qmCheckdt").datepicker({
                	showOn: "button",
                	buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
                	buttonImageOnly: true,
                	buttonText: "Select date",
                	dateFormat: "yy/mm/dd"
                });

                $(".input_number, .input_number1").on("keyup", function(event) {
    				$(this).val($(this).val().replace(/[^0-9,.+-]/g,""));
    			}).on("focus", function() {
    				this.select();
    			});
                $("input[name=inokQty]").on("keyup", function(event) {
    				$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    			});


                //-------------------------------------------------------------
                // jqery event
                //-------------------------------------------------------------
                // 닫기 버튼 클릭
                //-------------------------------------------------------------
                $('#btnUpdateClose, #btnClose').click(function() {
                    var frm = document.searchForm;
                    frm.action = "<c:url value='/itemInListPage.do'/>";
                    frm.submit();
                });
                var stockQty=parseInt($('#stockQty').val());
                var inokQty=parseInt($('#inokQty').val());
                //-------------------------------------------------------------
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
                    $('.card-body select').attr("disabled",false);
                    $('.card-body select').css("background-color","");
                    $('.card-body input').attr("readOnly",false);
                    $('#departCd').attr("readOnly",true);
                    $('#stockQty').val(stockQty+inokQty);
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
                   	$('#stockQty').val(stockQty);
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
                             	// 숫자콤마제거
                				$(".input_number, .input_number1").each(function() {
                				    $(this).val(this.value.replace(/,/gi, ""))
                				});
                                cfAjaxCallAndGoLink("<c:url value='/itemInSaveAct.do'/>"
                                                    ,$('#objForm').serialize(),'삭제 되었습니다.'
                                                    ,'searchForm'
                                                    ,"<c:url value='/itemInListPage.do'/>");
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
                             	// 숫자콤마제거
                				$(".input_number, .input_number1").each(function() {
                				    $(this).val(this.value.replace(/,/gi, ""))
                				});
                                cfAjaxCallAndGoLink("<c:url value='/itemInSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'수정 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/itemInListPage.do'/>");
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
                             	// 숫자콤마제거
                				$(".input_number, .input_number1").each(function() {
                				    $(this).val(this.value.replace(/,/gi, ""))
                				});
                                cfAjaxCallAndGoLink("<c:url value='/itemInSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/itemInListPage.do'/>");
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
                     fn_init_value();
                     fn_btn_show_hide();
                 });
            });
        })(jQuery);


        function fn_init_value() {

            if( ${rtn.obj.workshopCd == null} ) {
    			$("#workshopCd  option:eq(1)").prop("selected", true);
    		}
        }

        function fn_submit_validation() {

            if($("#iteminDt").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 입고일자"));
                $("#iteminDt").focus();
                return false;
            }

            if($("#workshopCd").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 창고"));
                $("#workshopCd").focus();
                return false;
            }

            if($("#inokQty").val().trim() == '' || $("#inokQty").val().trim() == 0){
                alert(MSG_COM_ERR_001.replace("[@]", " : 입고수량"));
                $("#inokQty").focus();
                return false;
            }

            if (!cfCheckDigit($("#inokQty").val())) {
                alert(MSG_COM_ERR_008.replace("[@]", " : 입고수량"));
                $("#inokQty").focus();
                return false;
            }


            var stockQty = parseInt(cfIsNullString($("#stockQty").val().replace(/[^0-9]/gi, ""), 0));
            var qmActokQty = parseInt(cfIsNullString($("#qmActokQty").val().replace(/[^0-9]/gi, ""), 0));
            var inokQty = parseInt(cfIsNullString($("#inokQty").val().replace(/[^0-9]/gi, ""), 0));

            var crudType = document.objForm.crudType.value;

            //미입고수량
            if(parseInt(inokQty) > parseInt(stockQty)){
                 alert("입고는 미입고수량을 넘을수 없습니다.");
                 $("#inokQty").focus();
                 return false;
            }

            return true;
        }

        function fn_btn_show_hide() {
            if (document.objForm.crudType.value == 'R') {
                $('#viewUpdateDisable').show();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').hide();
                $('.card-body select').attr("disabled",true);
                $('.card-body select').css("background-color","#e9ecef");
                $('.card-body input').attr("readOnly",true);

                $('#prodPoNo').attr("readOnly",true);
                $('#itemNm').attr("readOnly",true);
                $("#iteminDt").datepicker('option', 'disabled', true);
                $("#iteminDt").css("background-color","#e9ecef");

                $("#qmCheckdt").datepicker('option', 'disabled', true);
                $("#qmCheckdt").css("background-color","#e9ecef");

                $("#stockQty").datepicker('option', 'disabled', true);
                $("#stockQty").css("background-color","#e9ecef");
                if( ${rtn.obj.outQty > 0} ) {
    				$("#btnEnableUpdate, #btnDelete").addClass("disabled");

    				$("#btnEnableUpdate, #btnDelete").unbind().click(function(){
    					cfAlert("제품출하가 등록되어있는 입고는 수정 또는 삭제 할 수 없습니다.");
    					return false;
    				});
    			}
            } else if (document.objForm.crudType.value == 'U') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').show();
                $('#viewCreate').hide();
                $('#prodPoNo').attr("readOnly",true);
                $('#qmActokQty').attr("readOnly",true);
                $('#itemNm').attr("readOnly",true);
                $("#iteminDt").datepicker('option', 'disabled', false);
                $("#iteminDt").css("background-color","");
                $('#lotid').attr("readOnly",true);
                $("#lotid").css("background-color","");
            } else if (document.objForm.crudType.value == 'C') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').show();
                $("#qmCheckdt").datepicker('option', 'disabled', true);
                $("#qmCheckdt").css("background-color","#e9ecef");
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
				<!-- <h1 class="mt-4">거래처 관리</h1>  -->
				<!-- ======================================================================================================================== -->
				<!-- menu navigation                                                                                                          -->
				<!-- ======================================================================================================================== -->
				<h1 class="mt-4">완제품 입고 관리</h1>
				<form:form commandName="obj" id="objForm" name="objForm">
					<input type="hidden" name="crudType" value="${search.crudType}" />
					<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
					<input type="hidden" name="iteminSeq" value="${search.iteminSeq}" />
					<input type="hidden" name="mqcSeq" value="${search.mqcSeq}" />
					<input type="hidden" name="itemInTypeCd" value="IN" />

					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">검품 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="prodPoNo">검품일자</label>
										<input class="form-control3" id="qmCheckdt" name="qmCheckdt" type="text" value="${prodOrderVo.qmCheckdt}" readonly />
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="itemNm">제품명</label>
										<input class="form-control" id="itemCd" name="itemCd" type="hidden" value="${prodOrderVo.itemCd}" />
										<input class="form-control" id="itemNm" name="itemNm" type="text" value="${prodOrderVo.itemNm}" readonly />
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="prodQmNo">검품LOT</label>
										<input class="form-control" id="prodQmNo" name="prodQmNo" type="text" value="${prodOrderVo.prodQmNo}" readonly />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="qmActokQty">검품 수량</label>
										<input class="form-control input_number" id="qmActokQty" name="qmActokQty" type="text" value="<fmt:formatNumber value="${prodOrderVo.qmActokQty}" pattern="###,###"/>" readonly />
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="small mb-1" for="stockQty">미입고수량</label>
										<input class="form-control input_number" id="stockQty" name="stockQty" type="text" value="<fmt:formatNumber value="${prodOrderVo.stockQty}" pattern="###,###"/>" readonly />
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card mb-4" style="margin-top: 30px;">
						<div class="card-header">
							<h3 class="text-center font-weight-light my-1">완제품 입고 정보</h3>
						</div>
						<div class="card-body">
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="iteminDt" style="display: block;">입고일자</label>
										<input class="form-control3" id="iteminDt" name="iteminDt" type="text" value="${rtn.obj.iteminDt}" />
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="workshopCd">창고</label>
										<select class="form-control2" id="workshopCd" name="workshopCd">
											<option value="">창고 선택</option>
											<c:forEach items="${store_house_list}" var="item" varStatus="status">
												<c:if test="${item.workshopCd != 'STORE'}">
													<c:choose>
														<c:when test="${item.workshopCd == rtn.obj.workshopCd}">
															<option value="${item.workshopCd}" selected>${item.workshopNm}</option>
														</c:when>
														<c:otherwise>
															<option value="${item.workshopCd}">${item.workshopNm}</option>
														</c:otherwise>
													</c:choose>
												</c:if>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>

							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="inokQty" style="display: block;">입고수량</label>
										<input class="form-control input_number" id="inokQty" name="inokQty" type="text" value="<fmt:formatNumber value="${rtn.obj.inokQty == null ? 0:rtn.obj.inokQty}" pattern="###,###"/>" />
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="small mb-1" for="lotid" style="display: block;">입고Lot</label>
										<input class="form-control" id="lotid" name="lotid" type="text" value="${rtn.obj.lotid}" readonly />
									</div>
								</div>
							</div>

							<!-- 변경 최초 버튼 상태 -->
							<div id="viewUpdateDisable" class="col-md-12" style="display: none;">
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
										<div id="btnClose" class="btn btn-primary btn-block">닫기</div>
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

	<form:form commandName="search" id="searchForm" name="searchForm">
		<input type="hidden" name="pageIndex" value="${search.pageIndex}" />
		<input type="hidden" name="pageSize" value="${search.pageSize}" />
		<input type="hidden" name="sortCol" value="${search.sortCol}" />
		<input type="hidden" name="sortType" value="${search.sortType}" />
		<input type="hidden" name="prodSeq" value="${search.prodSeq}" />
		<input type="hidden" name="iteminSeq" value="${search.iteminSeq}" />
		<input type="hidden" name="mqcSeq" value="${search.mqcSeq}" />
		<input type="hidden" id="searchToQmCheckdt" name="searchToQmCheckdt" type="text" value="${param.searchToQmCheckdt}" />
		<input type="hidden" id="searchFromQmCheckdt" name="searchFromQmCheckdt" type="text" value="${param.searchFromQmCheckdt}" />
		<input type="hidden" id="searchToPoCalldt" name="searchToPoCalldt" type="text" value="${param.searchToPoCalldt}" />
		<input type="hidden" id="searchFromPoCalldt" name="searchFromPoCalldt" type="text" value="${param.searchFromPoCalldt}" />
		<input type="hidden" id="searchType" name="searchType" value="${param.searchType}">
	</form:form>

</body>
</html>