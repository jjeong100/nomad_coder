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
    <title>사내(사외) 교육일지</title>
    
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
 		.title12b {padding: 0.3rem;font-size: 1.3rem;font-weight: bold !important;text-align:center;}
 		.title13b {padding: 0.3rem;font-size: 1.3rem;font-weight: bold !important;text-align:center;}
		.title15b {padding: 0.3rem;font-size: 1.5rem;font-weight: bold !important;text-align:center;}
		.title20b {font-size: 2.0rem;font-weight: bold !important;text-align:center;}
		.row_label {padding: 0.3rem;font-size: 1.1rem;font-weight: bold !important;text-align:center;height:43px;}
		.row_content {font-size: 1.0rem !important;text-align:center;}
		.row_content_l {padding: 0.3rem;font-size: 1.2rem;text-align:left;}
		.content {padding: 0.3rem !important;font-size: 1rem !important;text-align:left;}
		.textarea-content {font-size: 1.5rem;width:100%;}
		.table-ta-c {text-align:center;}
		
		.input_text {border-color:transparent;text-align:left;width:90%;}
		.input_sign {border-color:transparent;text-align:center;width:90%;}
		.input_date {border-color:transparent;font-size: 1.2rem;text-align:left !important;width:90%;}
		.input_number {border-color:transparent;text-align:center;width:90%;}
		.input_check {width:100%;}
 		.input_size15 {font-size: 1.5rem !important;}
		.readonly {background-color:darkgrey;} 
		.td_na {background-color:darkgrey;}
		.td_def_h {height:55px;}
		
		.list-group-report {/* padding: 0; */border-color:transparent;}
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
                                cfAjaxCallAndGoLink("<c:url value='/educationSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'objForm'
                                        ,"<c:url value='/educationPage.do'/>");
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
                	 if( $("#trainYmd").val() == "" ) {
                		 $(".input_date").datepicker({dateFormat: "yy.mm.dd"}).datepicker("setDate", new Date());
                	 }
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
<input type="hidden" name="rptDivCd" value="EDUCATION"/>
<input type="hidden" name="rptSeq" value="${rtn.obj.rptSeq}"/>
<input type="hidden" name="writeYmd" class="input_date " value="${rtn.obj.writeYmd}"/>

    <div id="container">
		<div class="card mb-4">
			<div class="card-body embed-responsive">
				<jsp:include flush="false" page="/WEB-INF/jsp/mobile/report/mobileReportBtn.jsp"></jsp:include>
                   
				<div class="reportBody mt-n2" width="100%">
			    	<div class="card-header card-header-tabs">
			    		<h6 class="float-left font-weight-bold my-1 pl-1">TH-07_2.사내(사외) 교육일지</h3>
			    		<h6 class="float-right font-weight-bold my-1 pr-1">TOKKI MEAL</h3>
			    	</div>
			    	
					<table border="2" width="100%" class="table-report table-report-bordered">
						<tr>
							<td colspan="5" rowspan="2" width="75%" height="80px" class="title20b">사내(사외) 교육일지</td>
							<td colspan="1" rowspan="2" width="5%" class="title13b">결재</td>
							<td colspan="1" rowspan="1" width="8.25%" class="title13b">작성자</td>
	    	 				<td colspan="1" rowspan="1" width="8.25%" class="title13b">승인자</td>
						</tr>
						<tr>
							<td colspan="1" rowspan="1" height="70px" class="row_content sign" id="writeSign">
								<input type="hidden" id="writeId" name="writeId" class="input_sign" value="${rtn.obj.writeId}"/>
								<span id="writeNm">${rtn.obj.writeNm}</span>
							</td>
			    	 		<td colspan="1" rowspan="1" height="70px" class="row_content sign" id="approveSign">
								<input type="hidden" id="approveId" name="approveId" class="input_sign" value="${rtn.obj.approveId}"/>
								<span id="approveNm">${rtn.obj.approveNm}</span>
							</td>
						</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="15%" height="50px" class="title13b">교육일자(일정)</td>
			    	 		<td colspan="1" rowspan="1" width="25%" class="content"><input type="text" id="trainYmd" name="trainYmd" class="input_date input_size15" value="${reportEduVo.trainYmd}"/></td>
			    	 		<td colspan="2" rowspan="1" width="15%" class="title13b">강사</td>
			    	 		<td colspan="4" rowspan="1" width="45%" class="content"><input type="text" id="teacherNm" name="teacherNm" class="input_text input_size15" value="${reportEduVo.teacherNm}"/></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="15%" height="50px" class="title13b">교육명 / 비용</td>
			    	 		<td colspan="1" rowspan="1" width="25%" class="content"><input type="text" id="eduNmCost" name="eduNmCost" class="input_text input_size15" value="${reportEduVo.eduNmCost}"/></td>
			    	 		<td colspan="2" rowspan="1" width="15%" class="title13b">장소(교육기관)</td>
			    	 		<td colspan="4" rowspan="1" width="45%" class="content"><input type="text" id="eduPlace" name="eduPlace" class="input_text input_size15" value="${reportEduVo.eduPlace}"/></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="15%" height="50px" class="title13b">교육시간</td>
			    	 		<td colspan="2" rowspan="1" width="44%" class="content"><input type="text" id="eduTm" name="eduTm" class="input_text input_size15" value="${reportEduVo.eduTm}"/></td>
			    	 		<td colspan="2" rowspan="2" width="11%" class="title13b">불참자 처리</td>
			    	 		<td colspan="3" rowspan="2" width="30%" class="title10b">
			    	 			<ul class="list-group content">
			    	 				<li class="list-group-item list-group-report">
			    	 					<div class="form-check">
			    	 						<input type="checkbox" id="nonEduChk1" name="nonEduChk1" class="form-check-input " value="Y" ${reportEduVo.nonEduChk1 == 'Y' ? 'checked':''}/>
			    	 						<label class="form-check-label" for="nonEduChk1">재교육</label>
										</div>
									</li>
			    	 				<li class="list-group-item list-group-report">
			    	 					<div class="form-check">
			    	 						<input type="checkbox" id="nonEduChk2" name="nonEduChk2" class="form-check-input " value="Y" ${reportEduVo.nonEduChk2 == 'Y' ? 'checked':''}/>
			    	 						<label class="form-check-label" for="nonEduChk2">전달교육</label>
										</div>
									</li>
			    	 				<li class="list-group-item list-group-report">
			    	 					<div class="form-check">
			    	 						<input type="checkbox" id="nonEduChk3" name="nonEduChk3" class="form-check-input " value="Y" ${reportEduVo.nonEduChk3 == 'Y' ? 'checked':''}/>
			    	 						<label class="form-check-label" for="nonEduChk3">기타</label>
										</div>
			    	 				</li>
			    	 			</ul>
			    	 		</td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="15%" height="50px" class="title13b">교육대상</td>
			    	 		<td colspan="2" rowspan="1" width="85%" class="content"><input type="text" id="eduTarget" name="eduTarget" class="input_text input_size15" value="${reportEduVo.eduTarget}"/></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="8" rowspan="1" width="100%" height="50px" class="title13b">교육내용</td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="8" rowspan="1" width="100%" class="content"><textarea name="eduCont" class="textarea-content" rows="20">${reportEduVo.eduCont}</textarea></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="15%" height="50px" class="title13b">사용교재</td>
			    	 		<td colspan="7" rowspan="1" width="85%" class="content"><input type="text" id="usedBook" name="usedBook" class="input_text input_size15" value="${reportEduVo.usedBook}"/></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="15%" height="50px" class="title13b">유첨서류</td>
			    	 		<td colspan="7" rowspan="1" width="85%" class="title10b">
			    	 			<ul class="list-group list-group-horizontal col-xl-12" style="text-align:left;">
			    	 				<li class="list-group-item list-group-report col-lg-6">
			    	 					<div class="form-check">
			    	 						<input type="checkbox" id="attDocChk1" name="attDocChk1" class="form-check-input " value="Y" ${reportEduVo.attDocChk1 == 'Y' ? 'checked':''}/>
			    	 						<label class="form-check-label" for="attDocChk1">참석자 명단</label>
			    	 						(<input type="text" id="attDocCont1" name="attDocCont1" class="input_text" value="${reportEduVo.attDocCont1}" style="width: 50%;text-align:left;"/>)
										</div>
									</li>
			    	 				<li class="list-group-item list-group-report col-lg-2">
			    	 					<div class="form-check">
			    	 						<input type="checkbox" id="attDocChk2" name="attDocChk2" class="form-check-input " value="Y" ${reportEduVo.attDocChk2 == 'Y' ? 'checked':''}/>
			    	 						<label class="form-check-label" for="attDocChk2">교안</label>
										</div>
			    	 				</li>
			    	 				<li class="list-group-item list-group-report col-lg-4">
			    	 					<div class="form-check">
			    	 						<input type="checkbox" id="attDocChk3" name="attDocChk3" class="form-check-input " value="Y" ${reportEduVo.attDocChk3 == 'Y' ? 'checked':''}/>
			    	 						<label class="form-check-label" for="attDocChk3">기타</label>
			    	 						(<input type="text" id="attDocCont3" name="attDocCont3" class="input_text" value="${reportEduVo.attDocCont3}" style="width: 60%;text-align:left;"/>)
										</div>
									</li>
			    	 			</ul>
			    	 		</td>
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
		default:
			break;
	}
	
}

</script>
</body>
</html>