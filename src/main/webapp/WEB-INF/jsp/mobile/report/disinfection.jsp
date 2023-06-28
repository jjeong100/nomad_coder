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
    <title>방충/방서 관리일지</title>
    
    <style>
		@media print {
			body {
			-webkit-print-color-adjust: exact !important;
			margin-top: 0mm;
			margin-bottom: 0mm;
			margin-left: 0mm;
			margin-right: 0mm;
			}
		}
		
		.table-report {border-collapse: collapse;margin-bottom: 0.1rem;vertical-align: top;}
		.table-report-bordered {border: 1px solid #434546;padding: 0.1rem;}
		
		.title07b {padding: 0.3rem;font-size: 0.7rem;font-weight: bold !important;text-align:center;}
		.title08b {padding: 0.3rem;font-size: 0.8rem;font-weight: bold !important;text-align:center;}
		.title09b {padding: 0.3rem;font-size: 0.9rem;font-weight: bold !important;text-align:center;}
		.title10b {padding: 0.3rem;font-size: 1.0rem;font-weight: bold !important;text-align:center;}
		.title11b {padding: 0.3rem;font-size: 1.1rem;font-weight: bold !important;text-align:center;}
		.title12b {padding: 0.3rem;font-size: 1.2rem;font-weight: bold !important;text-align:center;}
		.title13b {padding: 0.3rem;font-size: 1.3rem;font-weight: bold !important;text-align:center;}
		.title15b {padding: 0.3rem;font-size: 1.5rem;font-weight: bold !important;text-align:center;}
		.title20b {font-size: 2.0rem;font-weight: bold !important;text-align:center;}
		.row_label {padding: 0.3rem;font-size: 1.2rem;font-weight: bold !important;text-align:center;height:61px;}
		.row_label2 {padding: 0;font-size: 1.2rem;font-weight: bold !important;text-align:center;height:61px;}
		.row_content {padding: 0.3rem;font-size: 1.2rem;text-align:center;}
		.row_content_l {padding: 0.3rem;font-size: 1.2rem;text-align:left;}
		.content {padding: 0.3rem !important;font-size: 1rem !important;text-align:left;}
		.textarea-content {border-color:transparent;font-size: 1.5rem;width: 100%;resize: none;}
		.table-ta-c {text-align:center;}
		
		.input_text {border-color:transparent;text-align:left;width:90%;}
		.input_sign {border-color:transparent;text-align:center;width:90%;}
		.input_date {border-color:transparent;font-size: 1.2rem;text-align:left !important;width:90%;}
		.input_number {border-color:transparent;text-align:center;width:90%;}
		.input_check {width:100%;}
		.readonly {background-color:darkgrey;}
		.td_na {background-color:darkgrey;}
		.td_def_h {height:55px;}
	</style>
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
                //$(".input_date").datepicker({dateFormat: "yy.mm.dd"}).datepicker("setDate", new Date());
                $(".input_date").datepicker({dateFormat: "yy.mm.dd"});
                
                //-------------------------------------------------------------
                // jqery event 
                //-------------------------------------------------------------
                $(".input_number").on("keyup", function(event) {
                	$(this).val($(this).val().replace(/[^0-9.]/g,""));
                }).on("focus", function() {
                	this.select();
                });
                
              	//-------------------------------------------------------------
                // 사원 팝업
                //-------------------------------------------------------------
                $(".sign").click(function() {
                	var kindId = $(this).attr("id");
                	$("#popWorker").data("kindId", kindId).dialog("open");
                });
                
              	//-------------------------------------------------------------
                // 등록
                //-------------------------------------------------------------
                $('#btnSave').click(function() {
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
                                cfAjaxCallAndGoLink("<c:url value='/disinfectionSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'objForm'
                                        ,"<c:url value='/disinfectionPage.do'/>");
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
                // 컬럼 소트 이벤트
                //------------------------------------------------------------- 

                //-------------------------------------------------------------
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                	 
                 });
            });
        })(jQuery);
        
        -->
    </script>
</head>

<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>

<form name="objForm" id="objForm">
<input type="hidden" name="crudType" value="R"/>
<input type="hidden" name="rptDivCd" value="PREVENT"/>
<input type="hidden" name="rptSeq" value="${rtn.obj.rptSeq}"/>


    <div id="container">
		<div class="card mb-4">
			<div class="card-body embed-responsive">
				<jsp:include flush="false" page="/WEB-INF/jsp/mobile/report/mobileReportBtn.jsp"></jsp:include>
                   
				<div class="reportBody mt-n2" width="100%">
			    	<div class="card-header card-header-tabs">
			    		<h6 class="float-left font-weight-bold my-1 pl-1">TF-02.매주 수요일_자체점검 / CESCO 합동점검 1회/월</h3>
			    		<h6 class="float-right font-weight-bold my-1 pr-1">TOKKI MEAL</h3>
			    	</div>
			    	
					<table border="2" width="100%" class="table-report table-report-bordered">
						<tr>
							<td colspan="12" rowspan="2" width="75%" height="80px" class="title20b">방충/방서 관리일지</td>
							<td colspan="1" rowspan="2" width="5.5%" class="title12b">결재</td>
							<td colspan="2" rowspan="1" width="8.25%" class="title12b">작성자</td>
	    	 				<td colspan="2" rowspan="1" width="8.25%" class="title12b">승인자</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1" height="70px" class="row_content sign" id="writeSign">
								<input type="hidden" id="writeId" name="writeId" class="input_sign" value="${rtn.obj.writeId}"/>
								<%-- <input type="hidden" id="writeNm" name="writeNm" class="input_sign" value="${rtn.obj.writeNm}"/> --%>
								<!-- <button type="button" class="btn ">사원 <i class="fa fa-search"></i></button> -->
								<span id="writeNm">${rtn.obj.writeNm}</span>
							</td>
							<td colspan="2" rowspan="1" height="70px" class="row_content sign" id="approveSign">
								<input type="hidden" id="approveId" name="approveId" class="input_sign" value="${rtn.obj.approveId}"/>
								<%-- <input type="text" id="approveNm" name="approveNm" class="input_sign" value="${rtn.obj.approveNm}"/> --%>
								<span id="approveNm">${rtn.obj.approveNm}</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" width="21%" class="title12b">작성일자</td>
							<td colspan="7" width="38.5%" class="row_content">
								<input type="text" id="writeYmd" name="writeYmd" class="input_date" value="${rtn.obj.writeYmd}"/>
							</td>
							<td colspan="3" width="16.5%" class="title12b">점검자</td>
							<td colspan="5" width="22%" class="row_content sign" id="inspectSign">
								<input type="hidden" id="inspectId" name="inspectId" class="input_text" value="${rtn.obj.inspectId}"/>
								<%-- <input type="text" id="inspectNm" name="inspectNm" class="input_text" value="${rtn.obj.inspectNm}"/> --%>
								<span id="inspectNm">${rtn.obj.inspectNm}</span>
							</td>
						</tr>
						<tr>
							<td colspan="2" width="21%" class="title12b">구분</td>
							<td colspan="6" width="33%" class="title12b">비래 해충</td>
							<td colspan="5" width="27.5%" class="title12b">보행 해충</td>
							<td colspan="4" width="16.5%" class="title12b">설치류</td>
						</tr>
			    	 	<tr style="border-bottom-style:double;">
			    	 		<td colspan="1" width="10%" class="title12b">설비명</td>
			    	 		<td colspan="1" width="11%" class="title12b">설치위치</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">파리</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">나방</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">모기</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">하루<br>살이</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">기타</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">합계</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">바퀴</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">거미</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">개미</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">기타</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">합계</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">쥐</td>
			    	 		<td colspan="2" width="5.5%" class="title12b">기타</td>
			    	 		<td colspan="1" width="5.5%" class="title12b">합계</td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label"><div>포충동1</div></td>
			    	 		<td colspan="1" class="row_label"><div>청결구역</div></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[0].col1" class="input_number" maxlength="3" value="${empty reportDtlList[0].col1 ? '.':reportDtlList[0].col1}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[0].col2" class="input_number" maxlength="3" value="${empty reportDtlList[0].col2 ? '.':reportDtlList[0].col2}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[0].col3" class="input_number" maxlength="3" value="${empty reportDtlList[0].col3 ? '.':reportDtlList[0].col3}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[0].col4" class="input_number" maxlength="3" value="${empty reportDtlList[0].col4 ? '.':reportDtlList[0].col4}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[0].col5" class="input_number" maxlength="3" value="${empty reportDtlList[0].col5 ? '.':reportDtlList[0].col5}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[0].col6" class="input_number" maxlength="3" value="${empty reportDtlList[0].col6 ? '.':reportDtlList[0].col6}"/></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="2" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label">포충동2</td>
			    	 		<td colspan="1" class="row_label">청결구역</td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[1].col1" class="input_number" maxlength="3" value="${empty reportDtlList[1].col1 ? '.':reportDtlList[1].col1}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[1].col2" class="input_number" maxlength="3" value="${empty reportDtlList[1].col2 ? '.':reportDtlList[1].col2}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[1].col3" class="input_number" maxlength="3" value="${empty reportDtlList[1].col3 ? '.':reportDtlList[1].col3}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[1].col4" class="input_number" maxlength="3" value="${empty reportDtlList[1].col4 ? '.':reportDtlList[1].col4}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[1].col5" class="input_number" maxlength="3" value="${empty reportDtlList[1].col5 ? '.':reportDtlList[1].col5}"/></td>
			    	 		<td colspan="1" class="row_content"><input type="text" name="reportDtlList[1].col6" class="input_number" maxlength="3" value="${empty reportDtlList[1].col6 ? '.':reportDtlList[1].col6}"/></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="2" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label"></td>
			    	 		<td colspan="1" class="row_label"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="2" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" class="row_label2">바퀴<br>트랩1</td>
			    	 		<td colspan="1" class="row_label2">출입문<br>내부(좌)</td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[2].col1" class="input_number" maxlength="3" value="${empty reportDtlList[2].col1 ? '.':reportDtlList[2].col1}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[2].col2" class="input_number" maxlength="3" value="${empty reportDtlList[2].col2 ? '.':reportDtlList[2].col2}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[2].col3" class="input_number" maxlength="3" value="${empty reportDtlList[2].col3 ? '.':reportDtlList[2].col3}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[2].col4" class="input_number" maxlength="3" value="${empty reportDtlList[2].col4 ? '.':reportDtlList[2].col4}"/></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="2" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label2">바퀴<br>트랩2</td>
			    	 		<td colspan="1" class="row_label2">출입문<br>내부(우)</td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[3].col1" class="input_number" maxlength="3" value="${empty reportDtlList[3].col1 ? '.':reportDtlList[3].col1}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[3].col2" class="input_number" maxlength="3" value="${empty reportDtlList[3].col2 ? '.':reportDtlList[3].col2}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[3].col3" class="input_number" maxlength="3" value="${empty reportDtlList[3].col3 ? '.':reportDtlList[3].col3}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[3].col4" class="input_number" maxlength="3" value="${empty reportDtlList[3].col4 ? '.':reportDtlList[3].col4}"/></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="2" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label"></td>
			    	 		<td colspan="1" class="row_label"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="2" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" class="row_label2">쥐<br>트랩1</td>
			    	 		<td colspan="1" class="row_label2">출입문<br>외부(좌)</td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[4].col1" class="input_number" maxlength="3" value="${empty reportDtlList[4].col1 ? '.':reportDtlList[4].col1}"/></td>
			    	 		<td colspan="2" class="row_content "><input type="text" name="reportDtlList[4].col2" class="input_number" maxlength="3" value="${empty reportDtlList[4].col2 ? '.':reportDtlList[4].col2}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[4].col3" class="input_number" maxlength="3" value="${empty reportDtlList[4].col3 ? '.':reportDtlList[4].col3}"/></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label2">쥐<br>트랩2</td>
			    	 		<td colspan="1" class="row_label2">출입문<br>외부(우)</td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[5].col1" class="input_number" maxlength="3" value="${empty reportDtlList[5].col1 ? '.':reportDtlList[5].col1}"/></td>
			    	 		<td colspan="2" class="row_content "><input type="text" name="reportDtlList[5].col2" class="input_number" maxlength="3" value="${empty reportDtlList[5].col2 ? '.':reportDtlList[5].col2}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[5].col3" class="input_number" maxlength="3" value="${empty reportDtlList[5].col3 ? '.':reportDtlList[5].col3}"/></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label2">쥐<br>트랩3</td>
			    	 		<td colspan="1" class="row_label2">건물<br>외부(좌)</td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[6].col1" class="input_number" maxlength="3" value="${empty reportDtlList[6].col1 ? '.':reportDtlList[6].col1}"/></td>
			    	 		<td colspan="2" class="row_content "><input type="text" name="reportDtlList[6].col2" class="input_number" maxlength="3" value="${empty reportDtlList[6].col2 ? '.':reportDtlList[6].col2}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[6].col3" class="input_number" maxlength="3" value="${empty reportDtlList[6].col3 ? '.':reportDtlList[6].col3}"/></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label2">쥐<br>트랩4</td>
			    	 		<td colspan="1" class="row_label2">검물외부<br>후면_1</td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[7].col1" class="input_number" maxlength="3" value="${empty reportDtlList[7].col1 ? '.':reportDtlList[7].col1}"/></td>
			    	 		<td colspan="2" class="row_content "><input type="text" name="reportDtlList[7].col2" class="input_number" maxlength="3" value="${empty reportDtlList[7].col2 ? '.':reportDtlList[7].col2}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[7].col3" class="input_number" maxlength="3" value="${empty reportDtlList[7].col3 ? '.':reportDtlList[7].col3}"/></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" class="row_label2">쥐<br>트랩5</td>
			    	 		<td colspan="1" class="row_label2">검물외부<br>후면_2</td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content td_na"></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[8].col1" class="input_number" maxlength="3" value="${empty reportDtlList[8].col1 ? '.':reportDtlList[8].col1}"/></td>
			    	 		<td colspan="2" class="row_content "><input type="text" name="reportDtlList[8].col2" class="input_number" maxlength="3" value="${empty reportDtlList[8].col2 ? '.':reportDtlList[8].col2}"/></td>
			    	 		<td colspan="1" class="row_content "><input type="text" name="reportDtlList[8].col3" class="input_number" maxlength="3" value="${empty reportDtlList[8].col3 ? '.':reportDtlList[8].col3}"/></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="2" width="18%" class="title12b">관리사항</td>
			    	 		<td colspan="15" width="80%" class="content">※ 외부업체(CESCO) 설치물 파손보수 및 기타 방역작업 월 1회 진행 시 증명서 확인</td>
			    	 	</tr>
			    	 	<tr style="border-bottom-style:double;">
			    	 		<td colspan="8" rowspan="1" class="title12b">기준이탈(원인파악)</td>
			    	 		<td colspan="9" rowspan="1" class="title12b">개선조치</td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="8" rowspan="1" class="title10b"><textarea name="cont3" class="textarea-content" rows="5">${rtn.obj.cont3}</textarea></td>
			    	 		<td colspan="9" rowspan="1" class="content"><textarea name="cont2" class="textarea-content" rows="5">${rtn.obj.cont2}</textarea></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="2" rowspan="1" class="title12b">기타<br>특이사항</td>
			    	 		<td colspan="15" rowspan="1" class="content"><textarea name="cont1" class="textarea-content" rows="6">${rtn.obj.cont1}</textarea></td>
			    	 	</tr>
			    	 </table>
			    	 
			    </div>
			    <!-- reportBody -->
			</div>
			<!-- card-body -->
		</div>
		<!-- card -->
    </div>
	<!-- layoutSidenav -->
	
</form>

<form:form commandName="search" id="searchForm" name="searchForm">
</form:form>

<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>
<jsp:include flush="false" page="/WEB-INF/jsp/popup/popWorker.jsp" ></jsp:include>
<script>

// popWorker.jsp 콜백함수
function fn_popWorker_callback(worker) {
	
	switch(worker.kindId) {
		case "writeSign":	// 작성자
			$("#writeId").val(worker.sabunId);
			$("#writeNm").text(worker.loginName);
			break;
		case "approveSign":	// 승인자
			$("#approveId").val(worker.sabunId);
			$("#approveNm").text(worker.loginName);
			break;
		case "inspectSign":	// 점검자
			$("#inspectId").val(worker.sabunId);
			$("#inspectNm").text(worker.loginName);
			break;
		default:
			break;
	}
	
}

</script>
</body>
</html>