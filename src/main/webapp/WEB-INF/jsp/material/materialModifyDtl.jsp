<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <title>재고 조정 관리</title>
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
                    onComplete: function(barcode, qty) {
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
                        drawRequirMatList();
                    } else {
                        $('#requireMatCard').hide();
                    }
                });
                
                $('#searchPoCalldt').change(function() {
                    drawRequirMatList();
                });
                
                drawRequirMatList = function() {
                    $.ajax({
                        url : "<c:url value='/searchRequireMatListData.do'/>",
                        type: 'POST',
                        data: $('#requireMatForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#requireMatListBody tr").remove();
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                            var html = "";
                            $.each(data.rtn.obj, function(key, val){
                                html = "";
                                html += "<tr role=\"row\" class=\"odd\">";
                                html += "<td class=\"text-ellipsis\">";
                                html += "<input type=\"radio\" name=\"requireMatRadioBox\" value=\""+key+"\"/>";
                                html += "<div id=\"itemNm_"+key+"\" style=\"display:none;\">"+val.itemNm+"</div>";
                                html += "<div id=\"matNm_"+key+"\" style=\"display:none;\">"+val.matNm+"</div>";
                                html += "<div id=\"matCd_"+key+"\" style=\"display:none;\">"+val.matCd+"</div>";
                                html += "<div id=\"lenVal_"+key+"\" style=\"display:none;\">"+Number(cfIsNullString(val.lenVal, "0"))+"</div>";
                                html += "<div id=\"confirmQty_"+key+"\" style=\"display:none;\">"+val.confirmQty+"</div>";
                                html += "<div id=\"matEa_"+key+"\" style=\"display:none;\">"+val.matEa+"</div>";
                                html += "<div id=\"operCd_"+key+"\" style=\"display:none;\">"+val.operCd+"</div>";
                                html += "<div id=\"prodSeq_"+key+"\" style=\"display:none;\">"+val.prodSeq+"</div>";
                                html += "<div id=\"matOutCnt_"+key+"\" style=\"display:none;\">"+Number(val.matOutCnt)+"</div>";
                                html += "</td>";
                                html += "<td class=\"text-ellipsis\"><span>"+val.itemNm+"</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>"+val.poCalldt+"</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>"+val.matNm+"</span></td>";
                                //html += "<td class=\"text-ellipsis\"><span>"+cfAddComma(val.confirmQty) + " " + val.lenNm + "</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>"+cfAddComma(Number(cfIsNullString(val.lenVal, "0"))) + " " + val.lenNm + "</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>"+cfAddComma(val.matEa)+"개</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>"+cfAddComma(Number(cfIsNullString(val.matOutCnt, "0")))+"개</span></td>";
                                html += "<td class=\"text-ellipsis\"><span>"+cfIsNullString(val.lotid)+"</span></td>";
                                html += "</tr>";
                                $("#requireMatListBody").append(html);
                            });
                            $('#selRequireMatModal').css("display", "block");
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
                
                $('#btnSelRequireMat').click(function() {
                    if (cfIsNull($("input:radio[name=requireMatRadioBox]:checked").val())) {
                        alert("작업지시 소요량을 선택해 주세요"); 
                        return false;
                    }
                    $('#requireMatCd').val($('#matCd_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html());
                    $('#requireMatNm').val($('#matNm_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html());
                    //$('#requireQty').val(cfAddComma($('#confirmQty_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html()));
                    $('#lenVal').val(cfAddComma($('#lenVal_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html()));
                    $('#requireCnt').val($('#matEa_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html());
                    $('#requireOutCnt').val($('#matOutCnt_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html());
                    $('#operCd').val($('#operCd_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html());
                    $('#prodSeq').val($('#prodSeq_'+$("input:radio[name=requireMatRadioBox]:checked").val()).html());
                    
                    $('#requireMatCard').show();
                    $('#selRequireMatModal').css("display", "none");
                });
                
                
                $('#selRequireMatModalClose').click(function() {
                    $("#matOutTypeCd").val("").prop("selected", true)
                    $('#selRequireMatModal').css("display", "none");
                });
                
                
                $("#lotid").keyup(function() {
                    if ($(this).val().length >= 15) {
                        getMaterialInDataByLotId($(this).val());
                    } else {
                        $("#matCd").val('');
                        $("#matNm").val('');
                        $("#outLenNm").val('');
                        $("#outLenCd").val('');
                        $("#stockQty").val('');
                        $("#stockUnitVal").val('');
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
                                $("#matCd, #matNm, #outLenNm, #outLenCd, #stockQty, #stockUnitVal").val('');
                                return;
                            }
                                                        
                            if (data.rtn.rc == 0) {
                                
                                // 출고구분 - 공정출고 일때
                                if( $("#matOutTypeCd").val() == "GOUT" ) {
                                    // 소요자재와 LOT NO가 맞지 않는 경우
                                    if( data.rtn.obj.matCd != $("#requireMatCd").val() ) {
                                        cfAlert('LOT NO와 소요자재가 맞지 않습니다.');
                                        $("#matCd, #matNm, #outLenNm, #outLenCd, #stockQty, #stockUnitVal").val('');
                                        return;
                                    }
                                }
                                
                                $("#matCd").val(data.rtn.obj.matCd);
                                $("#matNm").val(data.rtn.obj.matNm);
                                $("#outLenNm").val(data.rtn.obj.inLenNm);
                                $("#outLenCd").val(data.rtn.obj.inLenCd);
                                $("#stockQty").val(cfAddComma(data.rtn.obj.stockQty));
                                $("#stockUnitVal").val(cfAddComma(parseInt(cfIsNullString(data.rtn.obj.stockUnitVal, "0"))));
                                if (cfCheckDigit(document.objForm.stockQty.value)) {
                                    document.objForm.stockQty.value = parseFloat(document.objForm.stockQty.value);
                                }
                            } else {
                                $("#matCd").val('');
                                $("#matNm").val('');
                                $("#outLenNm").val('');
                                $("#outLenCd").val('');
                                $("#stockQty").val('');
                                $("#stockUnitVal").val('');
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
                    frm.action = "<c:url value='/materialModifyListPage.do'/>";
                    frm.submit();
                });
                
                //-------------------------------------------------------------
                // 수정 가능 버튼 클릭
                //-------------------------------------------------------------
                $('#btnEnableUpdate').click(function() {
                    $('.card-body select').attr("disabled",false);
                    $('.card-body select').css("background-color","");
                    $('.card-body input').attr("readOnly",false);
                    $('#lotid').attr("readOnly",true);
                    $('#outLenNm').attr("readOnly",true);
                    $('#matNm').attr("readOnly",true);
                    $('#stockQty').attr("readOnly",true);
                    $('#stockUnitVal').attr("readOnly",true);
                    $("#outDt").datepicker('option', 'disabled', false);
                    $("#outDt").css("background-color","");
                    document.objForm.crudType.value = 'U'
                    $('#requireMatNm').attr("readOnly",true);
                    //$('#requireQty').attr("readOnly",true);
                    $('#lenVal').attr("readOnly",true);
                    $('#requireCnt').attr("readOnly",true);
                    $('#requireOutCnt').attr("readOnly",true);
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
                     
                     if( $("#matOutTypeCd").val() == "GOUT" ) {
                    	 $('#requireMatCard').show();
                     }
                     
                     // 재고조정 삭제
                     $("#matOutTypeCd>option").each(function () {
                    	 var code = this.value;
                    	 
                    	 if( code != "MODIFY" ) {
                    		 $("#matOutTypeCd>option[value='" + code + "']").remove();
                    	 }
                     });
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
            } else if (document.objForm.crudType.value == 'C') {
                $('#viewUpdateDisable').hide();
                $('#viewUpdateEnable').hide();
                $('#viewCreate').show();
                $('#outLenNm').attr("readOnly",true);
                $('#matNm').attr("readOnly",true);
                $('#stockQty').attr("readOnly",true);
                $('#stockUnitVal').attr("readOnly",true);
                $('#requireMatNm').attr("readOnly",true);
                //$('#requireQty').attr("readOnly",true);
                $('#lenVal').attr("readOnly",true);
                $('#requireCnt').attr("readOnly",true);
                $('#requireOutCnt').attr("readOnly",true);
            }
        }
        
        function fn_init_value() {
            if( ${rtn.obj.workshopCd == null} ) {
    			$("#workshopCd  option:eq(1)").prop("selected", true);
    		}
            
            $("#outDt").val('${rtn.obj.outDt}');
            $("#searchPoCalldt").val('${rtn.obj.searchFromDate}');
        }
        
        function fn_submit_validation() {
            
            if($("#outDt").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 재고조정 일자"));
                $("#outDt").focus();
                return false;
            }
            if($("#matOutTypeCd").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 출고 구분"));
                $("#matOutTypeCd").focus();
                return false;
            }
            /* if($("#outCnt").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 출고 수량"));
                $("#outCnt").focus();
                return false;
            }
            if (!cfCheckDigit($("#outCnt").val())) {
                alert(MSG_COM_ERR_008.replace("[@]", " : 출고 수량"));
                $("#outCnt").focus();
                return false;
            } */
            if($("#workshopCd").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 창고"));
                $("#workshopCd").focus();
                return false;
            }
            if($("#matCd").val().trim() == ''){
                alert(MSG_COM_ERR_001.replace("[@]", " : 자재"));
                return false;
            }
            
            // 재고조정 - 체크안함.
            if( $("#matOutTypeCd").val() == "MODIFY" ) {
            	return true;
            }
            
            var requireCnt		= cfIsNullString($("#requireCnt").val().replace(/[^0-9+-]/gi, ""), 0);		//소요수량
            var requireOutCnt	= cfIsNullString($("#requireOutCnt").val().replace(/[^0-9+-]/gi, ""), 0);	//출고수량
            var stockQty		= cfIsNullString($("#stockQty").val().replace(/[^0-9+-]/gi, ""), 0);		//재고수량
            var stockUnitVal	= cfIsNullString($("#stockUnitVal").val().replace(/[^0-9+-]/gi, ""), 0);	//재고중량
            var outCnt			= cfIsNullString($("#outCnt").val().replace(/[^0-9+-]/gi, ""), 0);   		//출고수량
            var outUnitVal		= cfIsNullString($("#outUnitVal").val().replace(/[^0-9+-]/gi, ""), 0);   	//출고중량
            var pMatOutcnt		= cfIsNullString($("#pMatOutcnt").val().replace(/[^0-9+-]/gi, ""), 0);		//수정전 출고 수량 
            
            if( outUnitVal == 0 ) {
            	if($("#outCnt").val().trim() == ''){
                    alert(MSG_COM_ERR_001.replace("[@]", " : 조정 수량"));
                    $("#outCnt").focus();
                    return false;
                }
                if (!cfCheckDigit($("#outCnt").val())) {
                    alert(MSG_COM_ERR_008.replace("[@]", " : 조정 수량"));
                    $("#outCnt").focus();
                    return false;
                }
            } else {
	            if( parseInt(outUnitVal) > parseInt(stockUnitVal) ) {
	            	alert("재고중량 이상 출고 할 수 없습니다.");
	            	return false;
	            }
            }
            
            
            // 출고가능수량은 = 재고수량 + 수정전 출고 수량
            if( parseInt(outCnt) > parseInt(stockQty) + parseInt(pMatOutcnt) ) {
                alert("출고가능수량은 " + (parseInt(stockQty) + parseInt(pMatOutcnt)) + "입니다.");
                $("#outCnt").focus();
                return false;
            }
            
            if( parseInt(outCnt) > parseInt(requireCnt) - parseInt(requireOutCnt) + parseInt(pMatOutcnt) ) {
            	alert("소요수량이상 출고할 수 없습니다.");
                $("#outCnt").focus();
                return false;
            }
            
            return true;
        }
        
        // popMaterialIn.jsp 콜백함수
        function fn_popMaterialIn_callback(obj) {
            $("#lotid").val(obj.lotid);
            $("#matCd").val(obj.matCd);
            $("#matNm").val(obj.matNm);
             
            getMaterialInDataByLotId(obj.lotid);
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
                   <h1 class="mt-4">재고조정 상세정보</h1>
                   <form name="objForm" id="objForm">
                   <input type="hidden" name="crudType" value="${search.crudType}"/>
                   <input type="hidden" name="matoutSeq" value="${rtn.obj.matoutSeq}"/>
                   <input type="hidden" id="operCd" name="operCd" value="${rtn.obj.operCd}"/>
                   <input type="hidden" id="prodSeq" name="prodSeq" value="${rtn.obj.prodSeq}"/>
                   
                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">재고 조정 기본 정보</h3>           
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="outDt" style="display:block;">재고조정일자</label>
                                       <input class="form-control3" id="outDt" name="outDt" type="text" value="${rtn.obj.outDt}" placeholder="재고조정를 입력하세요"/>
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="matOutTypeCd">출고구분</label>
                                       <select class="form-control2" id="matOutTypeCd" name="matOutTypeCd">
                                           <option value="">출고 구분 선택</option>
                                           <c:forEach items="${mat_out_type_cd_list}" var="item" varStatus="status">
                                               <c:choose>
                                                   <c:when test="${item.scode == rtn.obj.matOutTypeCd}">
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
                           
                           <div class="form-row">
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="workshopCd">창고</label>
                                       <select class="form-control2" id="workshopCd" name="workshopCd">
                                           <option value="">창고 선택</option>
                                           <c:forEach items="${store_house_list}" var="item" varStatus="status">
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
                                       <label class="small mb-1" for="outCnt">조정 수량</label>
                                       <input id="pMatOutcnt" name="pMatOutcnt" type="hidden" value="${rtn.obj.outCnt}"/>
                                       <input class="form-control input_number" id="outCnt" name="outCnt" type="text" value="<fmt:formatNumber value="${rtn.obj.outCnt}" pattern="#,###"/>" placeholder="출고수량을 입력하세요"/>
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="outCnt">조정 중량</label>
                                       <input class="form-control input_number" id="outUnitVal" name=outUnitVal type="text" value="<fmt:formatNumber value="${rtn.obj.outUnitVal}" pattern="#,###.##"/>" placeholder="출고중량을 입력하세요"/>
                                       <input class="form-control" id="outUnitCd" name=outUnitCd type="hidden" value="${rtn.obj.outUnitCd}"/>
                                   </div>
                               </div>
                           </div>
                           
                       </div>
                   </div>
                   
                   <div id="requireMatCard" class="card mb-4" style="margin-top:30px; display:none;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">공정 자재 소요 정보</h3>           
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="requireMatNm">소요자재명</label>
                                       <input class="form-control" id="requireMatNm" type="text" value="${rtn.obj.matNm}" />
                                       <input class="form-control" id="requireMatCd" type="hidden" value="" />
                                   </div>
                               </div>
                               <%-- <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="requireQty">소요길이</label>
                                       <input class="form-control" id="requireQty" type="text" value="<fmt:formatNumber value="${rtn.obj.requireQty}" pattern="###,###"/>" />
                                   </div>
                               </div> --%>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="lenVal">원자재길이</label>
                                       <input class="form-control input_number" id="lenVal" type="text" value="<fmt:formatNumber value="${rtn.obj.lenVal}" pattern="###,###"/>" />
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="requireCnt">소요수량</label>
                                       <input class="form-control input_number" id="requireCnt" type="text" value="<fmt:formatNumber value="${rtn.obj.requireCnt}" pattern="###,###"/>" />
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="requireOutCnt">출고수량</label>
                                       <input class="form-control input_number" id="requireOutCnt" type="text" value="<fmt:formatNumber value="${rtn.obj.requireOutCnt}" pattern="###,###"/>" />
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>    
                   
                   <div id="lotCard" class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">자재 입고 LOT 정보</h3>           
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="lotid">LOT NO</label>
                                       <div class="input-group">
                                           <input class="form-control" id="lotid" name="lotid" type="text" value="${rtn.obj.lotid}" />
                                           <span id="btnPopMaterialIn" class="input-group-btn py-1">
                                               <button class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                               </button>
                                           </span>
                                       </div>
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="matCd">자재</label>
                                       <input class="form-control" id="matCd" name="matCd" type="hidden" value="${rtn.obj.matCd}" />
                                       <input class="form-control" id="matNm" name="matNm" type="text" value="${rtn.obj.matNm}" />
                                   </div>
                               </div>
                               <div class="col-md-3" style="display:none;">
                                   <div class="form-group">
                                       <label class="small mb-1" for="outLenNm">단위</label>
                                       <input type="hidden" id="outLenCd" name="outLenCd"  value="${rtn.obj.outLenCd}" />
                                       <input class="form-control" id="outLenNm" name="outLenNm" type="text" value="${rtn.obj.outLenNm}" />
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="stockQty">재고수량</label>
                                       <input class="form-control input_number" id="stockQty" name="stockQty" type="text" value="<fmt:formatNumber value="${rtn.obj.stockQty}" pattern="#,###"/>" />
                                   </div>
                               </div>
                               <div class="col-md-3">
                                   <div class="form-group">
                                       <label class="small mb-1" for="stockUnitVal">재고중량</label>
                                       <input class="form-control input_number" id="stockUnitVal" name="stockUnitVal" type="text" value="<fmt:formatNumber value="${rtn.obj.stockUnitVal}" pattern="#,###.##"/>" />
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

    <div id="selRequireMatModal" class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <div class="txt20">작업지시 소요 자재</div>
                <span id="selRequireMatModalClose" class="modal-close-button">×</span>
            </div> 
            <div class="card mb-4" style="margin-top:30px; margin-left:30px; margin-right:30px;">
                <div class="card-header">
                    <sapn class="txt20">자재 소요 목록</sapn>
                    <div id="btnSelRequireMat" class="btn btn-primary btn-sm mr-2" style="float: right;">공정출고 선택</div>
                </div>
                
                <div class="card-body">
                    <div class="table-responsive">
                        <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                            <div class="row">
                                <div class="col-sm-12 col-md-12" style="margin-bottom:5px;">
                                    <div id="dataTable_filter" class="dataTables_filter">
                                        <form:form commandName="search" id="requireMatForm" name="requireMatForm">
                                            <div style="float: left; margin: 6px 5px;">
                                               <input class="form-control2" id="searchPoCalldt" name="searchPoCalldt" type="text" value="${rtn.obj.searchFromDate}"/>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="overflow-y:auto; height:200px;">
                                <div class="col-sm-12">
                                    <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                        <thead class="thead-dark">
                                            <tr role="row">
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 6%;">선택</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">제품명</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">작지일자</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">자재명</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">원자재길이</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">소요수량</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">출고수량</th>
                                                <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">자재출고LOT</th>
                                            </tr>
                                        </thead>
                                        <tbody id="requireMatListBody"/>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>  
<form:form commandName="search" id="searchForm" name="searchForm">
    <input type="hidden" name="pageIndex" value="1"/>
    <input type="hidden" name="searchWorkshopCd" value="${search.searchWorkshopCd}"/>
    <input type="hidden" name="searchMatOutTypeCd" value="${search.searchMatOutTypeCd}"/>
    <input type="hidden" name="searchFromDate" value="${search.searchFromDate}"/>
    <input type="hidden" name="searchToDate" value="${search.searchToDate}"/>
</form:form>
<form:form commandName="search" id="searchMaterialInForm" name="searchMaterialInForm">
    <input type="hidden" name="lotid" value=""/>
</form:form>

<jsp:include flush="false" page="/WEB-INF/jsp/popup/popMaterialIn.jsp" ></jsp:include>  

</body>
</html>