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
    <title>시설/설비/제조도구 점검표</title>
    
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
		.row_label {padding: 0.3rem;font-size: 1.2rem;font-weight: bold !important;text-align:center;height:43px;}
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
                
                $(".input_check").on("click", function() {
                	var name = $(this).attr("name");
                	var chkVal = $(this).is(":checked");
                	var colNm = name.substring(name.indexOf(".")+1);
                	
                	var obj1 = $("input[name='" + name.substring(0, name.indexOf(".")) + ".col1" + "']");
                	var obj2 = $("input[name='" + name.substring(0, name.indexOf(".")) + ".col2" + "']");
                	
                	if( colNm == "col2" ) {
                		obj1.prop("checked", !chkVal);
                	} else if ( colNm == "col1" ) {
                		obj2.prop("checked", !chkVal);
                	}
                });
                
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
                                cfAjaxCallAndGoLink("<c:url value='/equipmentSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'objForm'
                                        ,"<c:url value='/equipmentPage.do'/>");
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
<input type="hidden" name="rptDivCd" value="EQUIPMENT"/>
<input type="hidden" name="rptSeq" value="${rtn.obj.rptSeq}"/>

    <div id="container">
		<div class="card mb-4">
			<div class="card-body embed-responsive">
				<jsp:include flush="false" page="/WEB-INF/jsp/mobile/report/mobileReportBtn.jsp"></jsp:include>
                   
				<div class="reportBody mt-n2" width="100%">
			    	<div class="card-header card-header-tabs">
			    		<h6 class="float-left font-weight-bold my-1 pl-1">TF-03.시설/설비/제조도구 점검표(매일)</h3>
			    		<h6 class="float-right font-weight-bold my-1 pr-1">TOKKI MEAL</h3>
			    	</div>
			    	
			    	<table border="2" width="100%" class="table-report table-report-bordered">
						<tr>
							<td colspan="3" rowspan="2" width="74.5%" height="80px" class="title20b">시설/설비/제조도구 점검표</td>
							<td colspan="1" rowspan="2" width="5.5%" class="title12b">결재</td>
							<td colspan="1" rowspan="1" width="10%" class="title12b">작성자</td>
	    	 				<td colspan="1" rowspan="1" width="10%" class="title12b">승인자</td>
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
						
						<tr style="border-bottom-style:double;">
							<td colspan="1" width="25%" height="37px" class="title11b">작성일자</td>
							<td colspan="1" width="35%" class="row_content_l">
								<input type="text" id="writeYmd" name="writeYmd" class="input_date" value="${rtn.obj.writeYmd}"/>
							</td>
							<td colspan="2" width="20%" class="title11b">점검자</td>
	    	 				<td colspan="2" width="20%" class="row_content_l sign" id="inspectSign">
								<input type="hidden" id="inspectId" name="inspectId" class="input_sign" value="${rtn.obj.inspectId}"/>
								<span id="inspectNm">${rtn.obj.inspectNm}</span>
							</td>
						</tr>
					</table>
					
					<table border="2" width="100%" class="table-report table-report-bordered" style="margin-top: -0.13rem;">
						<tr>
			    	 		<td colspan="1" rowspan="2" width="20%" class="title11b">대상</td>
			    	 		<td colspan="1" rowspan="2" width="60%" class="title11b">점검내용</td>
			    	 		<td colspan="2" rowspan="1" width="20%" class="title11b">기록</td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="title11b" style="width:100px;">예</td>
			    	 		<td colspan="1" rowspan="1" class="title11b" style="width:100px;">아니오</td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="row_label">위생전실</td>
			    	 		<td colspan="1" rowspan="1" class="content">이물질 롤러 및 기타 위생도구에 이물 등이 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[0].col1" ${reportDtlList[0].col1 == 'Y' || reportDtlList[0].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[0].col2" ${reportDtlList[0].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="2" class="row_label">세척/</br>소독시설</td>
			    	 		<td colspan="1" rowspan="1" class="content">위생장화 건조기와 주변은 이물 등이 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[1].col1" ${reportDtlList[1].col1 == 'Y' || reportDtlList[1].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[1].col2" ${reportDtlList[1].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">손톱세척솔, 세척용 비누, 손건조기 등이 비치되어 있으며, 손세척 시설은 이물 등이 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[2].col1" ${reportDtlList[2].col1 == 'Y' || reportDtlList[2].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[2].col2" ${reportDtlList[2].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="4" class="row_label">탈의실</td>
			    	 		<td colspan="1" rowspan="1" class="content">바닥, 벽, 천정, 조명, 문 등은 이물 등이 깨끗이 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[3].col1" ${reportDtlList[3].col1 == 'Y' || reportDtlList[3].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[3].col2" ${reportDtlList[3].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">환기 시설은 정상 작동하며 이물 등이 제거되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[4].col1" ${reportDtlList[4].col1 == 'Y' || reportDtlList[4].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[4].col2" ${reportDtlList[4].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">위생복과 외출복은 구분하여 보관하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[5].col1" ${reportDtlList[5].col1 == 'Y' || reportDtlList[5].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[5].col2" ${reportDtlList[5].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">탈의실 내에 불필요한 물건은 방치되어 있지 않은가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[6].col1" ${reportDtlList[6].col1 == 'Y' || reportDtlList[6].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[6].col2" ${reportDtlList[6].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="3" class="row_label">신발장</td>
			    	 		<td colspan="1" rowspan="1" class="content">신발장은 위생화와 일반화를 구분하여 보관하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[7].col1" ${reportDtlList[7].col1 == 'Y' || reportDtlList[7].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[7].col2" ${reportDtlList[7].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">신발장에 이물 등은 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[8].col1" ${reportDtlList[8].col1 == 'Y' || reportDtlList[8].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[8].col2" ${reportDtlList[8].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">신발장 내에 불필요한 물건은 방치되어 있지 않은가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[9].col1" ${reportDtlList[9].col1 == 'Y' || reportDtlList[9].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[9].col2" ${reportDtlList[9].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="2" class="row_label">작업대</td>
			    	 		<td colspan="1" rowspan="1" class="content">생산에 사용되는 작업대에는 이물 등이 잘 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[10].col1" ${reportDtlList[10].col1 == 'Y' || reportDtlList[10].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[10].col2" ${reportDtlList[10].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">작업대 위에 불필요한 물건은 방치되어 있지 않은가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[11].col1" ${reportDtlList[11].col1 == 'Y' || reportDtlList[11].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[11].col2" ${reportDtlList[11].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="3" class="row_label">생산도구</td>
			    	 		<td colspan="1" rowspan="1" class="content">생산도구는 항상 제자리에 비치되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[12].col1" ${reportDtlList[12].col1 == 'Y' || reportDtlList[12].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[12].col2" ${reportDtlList[12].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">생산과 관련없는 도구들과 함께 있지는 않는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[13].col1" ${reportDtlList[13].col1 == 'Y' || reportDtlList[13].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[13].col2" ${reportDtlList[13].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">생산도구에 이물 등은 잘 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[14].col1" ${reportDtlList[14].col1 == 'Y' || reportDtlList[14].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[14].col2" ${reportDtlList[14].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="3" class="row_label">생산장비</td>
			    	 		<td colspan="1" rowspan="1" class="content">생산장비는 이상 없이 가동되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[15].col1" ${reportDtlList[15].col1 == 'Y' || reportDtlList[15].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[15].col2" ${reportDtlList[15].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">생산장비 주변에 생산과 관련없는 불필요한 물건은 방치되어 있지 않은가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[16].col1" ${reportDtlList[16].col1 == 'Y' || reportDtlList[16].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[16].col2" ${reportDtlList[16].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">생산장비에 이물 등은 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[17].col1" ${reportDtlList[17].col1 == 'Y' || reportDtlList[17].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[17].col2" ${reportDtlList[17].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="3" class="row_label">제품<br>이송장비</td>
			    	 		<td colspan="1" rowspan="1" class="content">이송장비는 이상 없이 가동되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[18].col1" ${reportDtlList[18].col1 == 'Y' || reportDtlList[18].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[18].col2" ${reportDtlList[18].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">이송장비 주변에 생산과 관련없는 불필요한 물건은 방치되어 있지 않은가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[19].col1" ${reportDtlList[19].col1 == 'Y' || reportDtlList[19].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[19].col2" ${reportDtlList[19].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">이송장비에 이물 등은 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[20].col1" ${reportDtlList[20].col1 == 'Y' || reportDtlList[20].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[20].col2" ${reportDtlList[20].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="4" class="row_label">보일러</td>
			    	 		<td colspan="1" rowspan="1" class="content">보일러실에 환기는 잘 되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[21].col1" ${reportDtlList[21].col1 == 'Y' || reportDtlList[21].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[21].col2" ${reportDtlList[21].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">보일러 기름은 적절하게 유지하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[22].col1" ${reportDtlList[22].col1 == 'Y' || reportDtlList[22].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[22].col2" ${reportDtlList[22].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">보일러 스팀은 작업완료 후 반출하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[23].col1" ${reportDtlList[23].col1 == 'Y' || reportDtlList[23].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[23].col2" ${reportDtlList[23].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">보일러실에 불필요한 물건은 방치되어 있지 않은가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[24].col1" ${reportDtlList[24].col1 == 'Y' || reportDtlList[24].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[24].col2" ${reportDtlList[24].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="3" class="row_label">냉동창고</td>
			    	 		<td colspan="1" rowspan="1" class="content">냉동창고는 적절한 온도를 유지하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[25].col1" ${reportDtlList[25].col1 == 'Y' || reportDtlList[25].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[25].col2" ${reportDtlList[25].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">냉동창고 내에 불필요한 물건은 방치되어 있지 않은가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[26].col1" ${reportDtlList[26].col1 == 'Y' || reportDtlList[26].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[26].col2" ${reportDtlList[26].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">냉동창고 청소상태는 양호한가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[27].col1" ${reportDtlList[27].col1 == 'Y' || reportDtlList[27].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[27].col2" ${reportDtlList[27].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	
			    	 	<tr>
			    	 		<td colspan="1" rowspan="3" class="row_label">청소도구</td>
			    	 		<td colspan="1" rowspan="1" class="content">청소도구는 청결상태가 유지되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[28].col1" ${reportDtlList[28].col1 == 'Y' || reportDtlList[28].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[28].col2" ${reportDtlList[28].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">각 실별 청소도구가 분리되어 보관되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[29].col1" ${reportDtlList[29].col1 == 'Y' || reportDtlList[29].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[29].col2" ${reportDtlList[29].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="content">청소도구에 이물 등은 제거되어 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[30].col1" ${reportDtlList[30].col1 == 'Y' || reportDtlList[30].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[30].col2" ${reportDtlList[30].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 </table>
			    	 
			    	 <table border="2" width="100%" height="150px" class="table-report-bordered" style="margin-top: -0.2rem;">
						<tr style="border-bottom-style:double;">
			    	 		<td colspan="1" rowspan="1" width="40%" class="title11b">특이사항</td>
			    	 		<td colspan="1" rowspan="1" width="40%" class="title11b">개선조치 및 결과</td>
			    	 		<td colspan="1" rowspan="1" width="10%" class="title11b">조치자</td>
			    	 		<td colspan="1" rowspan="1" width="10%" class="title11b">확인</td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="row_content"><textarea name="cont1" class="textarea-content" rows="4">${rtn.obj.cont1}</textarea></td>
			    	 		<td colspan="1" rowspan="1" class="row_content"><textarea name="cont2" class="textarea-content" rows="4">${rtn.obj.cont2}</textarea></td>
							<td colspan="1" rowspan="1" class="row_content sign" id="measureSign">
								<input type="hidden" id="measureId" name="measureId" class="input_text" value="${rtn.obj.measureId}"/>
								<span id="measureNm">${rtn.obj.measureNm}</span>
							</td>
							<td colspan="1" rowspan="1" class="row_content sign" id="confirmSign">
								<input type="hidden" id="confirmId" name="confirmId" class="input_text" value="${rtn.obj.confirmId}"/>
								<span id="confirmNm">${rtn.obj.confirmNm}</span>
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
		case "inspectSign":	// 점검자
			$("#inspectId").val(worker.sabunId);
			$("#inspectNm").text(worker.loginName);
			break;
		case "measureSign":	// 조치자
			$("#measureId").val(worker.sabunId);
			$("#measureNm").text(worker.loginName);
			break;
		case "confirmSign":	// 확인자
			$("#confirmId").val(worker.sabunId);
			$("#confirmNm").text(worker.loginName);
			break;
		default:
			break;
	}
	
}

</script>
</body>
</html>