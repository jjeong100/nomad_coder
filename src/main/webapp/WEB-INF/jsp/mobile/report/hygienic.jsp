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
    <title>일반 위생관리 및 공정점검표</title>
    
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
                $(".input_number").on("keyup", function(event) {
                	$(this).val($(this).val().replace(/[^0-9.+-]/g,""));
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
                                cfAjaxCallAndGoLink("<c:url value='/hygienicSaveAct.do'/>"
                                        ,$('#objForm').serialize(),'생성 되었습니다.'
                                        ,'objForm'
                                        ,"<c:url value='/hygienicPage.do'/>");
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
<input type="hidden" name="rptDivCd" value="HYGIENIC"/>
<input type="hidden" name="rptSeq" value="${rtn.obj.rptSeq}"/>

    <div id="container">
        <div class="card mb-4">
			<div class="card-body embed-responsive">
				<jsp:include flush="false" page="/WEB-INF/jsp/mobile/report/mobileReportBtn.jsp"></jsp:include>
                
                <div class="reportBody mt-n2" width="100%">
			    	<div class="card-header card-header-tabs">
			    		<h6 class="float-left font-weight-bold my-1 pl-1">TF-01.일반 위생관리 및 공정점검표(매일)</h3>
			    		<h6 class="float-right font-weight-bold my-1 pr-1">TOKKI MEAL</h3>
			    	</div>
			    	
			    	<table border="2" width="100%" class="table-report table-report-bordered">
						<tr>
			    	 		<td colspan="5" rowspan="2" width="77%" height="80px" class="title20b">일반 위생관리 및 공정점검표</td>
			    	 		<td colspan="1" rowspan="2" width="3%" class="title12b">결재</td>
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

			    	 	<tr>
			    	 		<td colspan="2" width="18%" class="title12b">작성일자</td>
			    	 		<td colspan="1" width="32%" class="row_content_l">
			    	 			<input type="text" id="writeYmd" name="writeYmd" class="input_date" value="${rtn.obj.writeYmd}"/>
			    	 		</td>
			    	 		<td colspan="1" width="17%" class="title12b">점검자</td>
			    	 		<td colspan="4" width="33%" class="row_content_l sign" id="inspectSign">
								<input type="hidden" id="inspectId" name="inspectId" class="input_sign" value="${rtn.obj.inspectId}"/>
								<span id="inspectNm">${rtn.obj.inspectNm}</span>
							</td>
			    	 	</tr>

			    	 	<tr>
			    	 		<td colspan="1" rowspan="2" height="50px" class="title12b">주기</td>
			    	 		<td colspan="1" rowspan="2" height="50px" class="title12b">관리</td>
			    	 		<td colspan="4" rowspan="2" class="title12b">점검내용</td>
			    	 		<td colspan="2" rowspan="1" class="title12b">기록</td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="title12b">예</td>
			    	 		<td colspan="1" rowspan="1" class="title12b">아니오</td>
			    	 	</tr>
			    	 </table>
					 
					 <table border="1" width="100%" class="table-report-bordered" style="margin-top:-0.15rem;">
						<tr>
			    	 		<td colspan="1" rowspan="6" width="9%" class="title10b">일일<br>(작업 전)</td>
			    	 		<td colspan="1" rowspan="3" width="9%" class="title10b">개인위생</td>
			    	 		<td colspan="2" rowspan="1" width="62%" class="content">위생복장과 외출복장이 구분하여 보관되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" width="10%" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[0].col1" ${reportDtlList[0].col1 == 'Y' || reportDtlList[0].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" width="10%" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[0].col2" ${reportDtlList[0].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="2" rowspan="1" class="content">종사자의 건강상태가 양호하고 개인장신구 등을 소지하지 않으며, 청결한 위생복장을 착용하고 작업하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[1].col1" ${reportDtlList[1].col1 == 'Y' || reportDtlList[1].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[1].col2" ${reportDtlList[1].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="2" rowspan="1" class="content">위생설비(손세척,소동기 등) 중 이상이 있는 것이 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[2].col1" ${reportDtlList[2].col1 == 'Y' || reportDtlList[2].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[2].col2" ${reportDtlList[2].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
							<td colspan="1" rowspan="1" width="9%" class="title10b">방충방서</td>
			    	 		<td colspan="2" rowspan="1" class="content">작업장은 밀폐가 잘 이루어지고 있으며, 방충시설에는 이상이 없는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[3].col1" ${reportDtlList[3].col1 == 'Y' || reportDtlList[3].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[3].col2" ${reportDtlList[3].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
							<td colspan="1" rowspan="1" width="9%" class="title10b">설비</td>
			    	 		<td colspan="2" rowspan="1" class="content">파손되거나 고장 난 제조설비가 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[4].col1" ${reportDtlList[4].col1 == 'Y' || reportDtlList[4].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[4].col2" ${reportDtlList[4].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
							<td colspan="1" rowspan="1" width="9%" class="title10b">입고보관</td>
			    	 		<td colspan="1" rowspan="1" width="50%" class="content">냉동 창고의 온도가 적절히 관리되고 있는가?</td>
			    	 		<td colspan="3" rowspan="1" class="content">
			    	 			▶냉동창고: <input type="text" class="input_number" name="reportDtlList[5].col1" style="text-align:right;width:20%;" value="${reportDtlList[5].col1 == null || reportDtlList[5].col1 == '' ? ondo2.data1:reportDtlList[5].col1}"/>℃
			    	 					, <input type="text" class="input_number" name="reportDtlList[5].col2" style="text-align:right;width:20%;" value="${reportDtlList[5].col2 == null || reportDtlList[5].col2 == '' ? ondo3.data1:reportDtlList[5].col2}"/>℃
							</td>
			    	 	</tr>
			    	 </table>

					 <table border="1" width="100%" class="table-report-bordered" style="margin-top: -0.05rem;">
						<tr>
			    	 		<td colspan="1" rowspan="4" width="9%" class="title10b">일일<br>(작업 중)</td>
			    	 		<td colspan="1" rowspan="3" width="9%" class="title10b">공정관리</td>
			    	 		<td colspan="3" rowspan="1" width="62%" class="content">(구획이 안된 작업장의 경우)청결구역작업과 일반구역작업이 시간차를 두고 이루어지고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" width="10%" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[6].col1" ${reportDtlList[6].col1 == 'Y' || reportDtlList[6].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" width="10%" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[6].col2" ${reportDtlList[6].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="3" rowspan="1" class="content">완제품의 포장상태가 양호한가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[7].col1" ${reportDtlList[7].col1 == 'Y' || reportDtlList[7].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[7].col2" ${reportDtlList[7].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="3" rowspan="1" class="content">모니터링장비(온도계등)는 사용전, 후 세척/소독을 실시하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[8].col1" ${reportDtlList[8].col1 == 'Y' || reportDtlList[8].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[8].col2" ${reportDtlList[8].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
							<td colspan="1" rowspan="1" width="9%" class="title10b">점검</td>
			    	 		<td colspan="1" rowspan="1" width="30%" class="content">자재창고 온습도 점검?</td>
			    	 		<td colspan="1" rowspan="1" width="20%" class="content">▶점검시간: <input type="text" class="input_text" name="reportDtlList[9].col1" style="width:50%;" value="${reportDtlList[9].col1}"/></td>
							<td colspan="3" rowspan="1" class="content">
								▶온도: <input type="text" class="input_number" name="reportDtlList[9].col2" style="text-align:right;width:20%;" value="${reportDtlList[9].col2}"/>℃, 
								▶습도: <input type="text" class="input_number" name="reportDtlList[9].col3" style="text-align:right;width:20%;" value="${reportDtlList[9].col3}"/>%
							</td>
			    	 	</tr>
			    	 </table>

					 <table border="1" width="100%" class="table-report-bordered" style="margin-top: -0.06rem;">
						<tr>
			    	 		<td colspan="1" rowspan="3" width="9%" class="title10b">일일<br>(작업 후)</td>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">방충방서</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">작업장 주변의 음식물 폐기물은 잘 정리되어 보관되어지고 있고, 주기적으로 반출되고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" width="10%" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[10].col1" ${reportDtlList[10].col1 == 'Y' || reportDtlList[10].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" width="10%" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[10].col2" ${reportDtlList[10].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="title10b">청소소독</td>
							<td colspan="1" rowspan="1" class="content">작업장 바닥, 배수로, 위생시설, 제조설비(식품과 직접 닿는 부분)의 청소, 소독 상태는 양호한가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[11].col1" ${reportDtlList[11].col1 == 'Y' || reportDtlList[11].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[11].col2" ${reportDtlList[11].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" class="title10b">점검</td>
							<td colspan="1" rowspan="1" class="content">중요관리점(CCP)점검표를 작성 주기에 맞게 작성하고, 한계기준 이탈 시 적절히 개선조치 하였는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[12].col1" ${reportDtlList[12].col1 == 'Y' || reportDtlList[12].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[12].col2" ${reportDtlList[12].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">일일<br>(입고 시)</td>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">입고검수</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">원/부재료 입고 시 시험성적서를 수령하거나 육안검사를 실시하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[13].col1" ${reportDtlList[13].col1 == 'Y' || reportDtlList[13].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[13].col2" ${reportDtlList[13].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
			    	 		<td colspan="1" rowspan="4" width="9%" class="title10b">주간<br>(목요일)</td>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">방충방서</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">쥐덫, 해충유인 포획장치(날파리, 바퀴벌레 등)에 포획된 개체수는 확인하고 있는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[14].col1" ${reportDtlList[14].col1 == 'Y' || reportDtlList[14].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[14].col2" ${reportDtlList[14].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="3" width="9%" class="title10b">청소소독</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">냉장, 냉동창고 내부 청소상태는 양호한가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[15].col1" ${reportDtlList[15].col1 == 'Y' || reportDtlList[15].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[15].col2" ${reportDtlList[15].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">작업장 벽, 제조설비(제품과 직접 닿지 않는 부분)에 대한 청소, 소독상태는 양호한가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[16].col1" ${reportDtlList[16].col1 == 'Y' || reportDtlList[16].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[16].col2" ${reportDtlList[16].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">위생복 세탁은 실시하였는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[17].col1" ${reportDtlList[17].col1 == 'Y' || reportDtlList[17].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[17].col2" ${reportDtlList[17].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
			    	 		<td colspan="1" rowspan="4" width="9%" class="title10b">매월<br>(마지막<br>목요일)</td>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">청소</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">작업장 전체 청소 상태는 양호한가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[18].col1" ${reportDtlList[18].col1 == 'Y' || reportDtlList[18].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[18].col2" ${reportDtlList[18].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">교육</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">작업장 전체 청소 상태는 양호한가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[19].col1" ${reportDtlList[19].col1 == 'Y' || reportDtlList[19].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[19].col2" ${reportDtlList[19].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">검사</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">완제품에 대한 검사를 실시하였는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[20].col1" ${reportDtlList[20].col1 == 'Y' || reportDtlList[20].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[20].col2" ${reportDtlList[20].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="9%" class="title10b">검증</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">중요관리공정(CCP) 검증표를 작성하였는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[21].col1" ${reportDtlList[21].col1 == 'Y' || reportDtlList[21].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[21].col2" ${reportDtlList[21].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>

						<tr>
			    	 		<td colspan="1" rowspan="2" width="9%" class="title10b">연간</td>
			    	 		<td colspan="1" rowspan="2" width="9%" class="title10b">점검</td>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">증숙기 및 냉동창고의 온고계는 검/교정 하였는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[22].col1" ${reportDtlList[22].col1 == 'Y' || reportDtlList[22].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[22].col2" ${reportDtlList[22].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
						<tr>
			    	 		<td colspan="1" rowspan="1" width="62%" class="content">금속검출기에 대한 정기점검을 실시하였는가?</td>
			    	 		<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="Y" data-name="chkYes" name="reportDtlList[23].col1" ${reportDtlList[23].col1 == 'Y' || reportDtlList[23].col2 == null ? 'checked':''} /></td>
							<td colspan="1" rowspan="1" class="table-ta-c"><input type="checkbox" class="input_check" value="N" data-name="chkNo"  name="reportDtlList[23].col2" ${reportDtlList[23].col2 == 'N' ? 'checked':''} /></td>
			    	 	</tr>
			    	 </table>

					 <table border="2" width="100%" height="150px" class="table-report-bordered" style="margin-top: -0.1rem;">
						<tr>
			    	 		<td colspan="1" rowspan="1" width="40%" class="title12b">특이사항</td>
			    	 		<td colspan="1" rowspan="1" width="40%" class="title12b">개선조치 및 결과</td>
			    	 		<td colspan="1" rowspan="1" width="10%" class="title12b">조치자</td>
			    	 		<td colspan="1" rowspan="1" width="10%" class="title12b">확인</td>
			    	 	</tr>
			    	 	<tr>
			    	 		<td colspan="1" rowspan="1" class="row_content"><textarea name="cont1" class="textarea-content" rows="6">${rtn.obj.cont1}</textarea></td>
			    	 		<td colspan="1" rowspan="1" class="row_content"><textarea name="cont2" class="textarea-content" rows="6">${rtn.obj.cont2}</textarea></td>
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