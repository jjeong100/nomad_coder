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
    <title>거래처 정보 관리</title>
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
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                	var frm = document.searchForm;
                	frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/companyGetApi.do'/>";
                    frm.submit();
		        });
                
                $('#apiType').on('change', function() {
                    if ($(this).val() == 'GET') {
                    	$("#getView").show();
                    	$("#setView").hide();
                    } else if ($(this).val() == 'SET') {
                    	$("#getView").hide();
                        $("#setView").show();
                    	$("#searchTableView").hide();
                    }
                });
                
                $('#btnExcelDown').click(function() {
                	$.ajax({
                        url : "<c:url value='/companyGetApiExcel.do'/>",
                        type: 'POST',
                        data: $('#searchForm').serialize(),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                        	var url = "downloadFile.do"
                                + "?folderName="+data.folderName
                                + "&realFileName="+data.realFileName
                                + "&saveFileName="+data.saveFileName;
                             downloadFile(url);
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert('시스템 오류입니다.');
                        },
                        complete:function(){
                            $("#layoutSidenav").loadingClose();
                        }
                    });
                });
                
                $('#btnExcelUpload').click(function() {
                	$.ajax({
                        url : "<c:url value='/companySetApiExcel.do'/>",
                        type: 'POST',
                        data: JSON.stringify(arrMcc025),
                        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                        context:this,
                        dataType:'json',
                        beforeSend:function(){
                            $("#layoutSidenav").loading();
                        },
                        success: function(data) {
                        	if(!cfCheckRtnObj(data.rtn)) return;
                        	$("#layoutSidenav").loadingClose();
                        	$( "#glvForm" ).html("searchForm");
                        	$( "#glvLink" ).html("<c:url value='/companyApiPage.do'/>");
                        	cfAlertAnGo("업로드 되었습니다.");
                        },
                        error: function(request, status, error){
                            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
                            cfAlert("시스템 오류입니다.");
                        },
                        complete:function(){
                        	$("#layoutSidenav").loadingClose();
                        }
                    });
                });
                
                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                	var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/companyGetApi.do'/>";
                    frm.submit();
                });
                
                //-------------------------------------------------------------
                // 컬럼 소트 이벤트
                //------------------------------------------------------------- 
                $('#dataTable').find('th').not('.no-sort').click(function() {
                	var frm = document.searchForm;
                	var sortCol = $(this).attr("id");
                    frm.sortCol.value = sortCol;
                    var sortColType = $(this).attr('class');
                    if (sortColType == 'sorting_asc') {
                    	frm.sortType.value = 'desc'
                    } else {
                    	frm.sortType.value = 'asc'
                    }
                    frm.action = "<c:url value='/companyGetApi.do'/>";
                    frm.submit();
                });
                
                //-------------------------------------------------------------
                // onLoad  
                //-------------------------------------------------------------
                 $(document).ready(function(){
                	 $("#pageSizeItem").val(document.searchForm.pageSize.value).prop("selected", true);  
                	 if (document.searchForm.sortType.value == 'asc') {
                		 $("#${search.sortCol}").attr('class','sorting_asc'); 
                	 } else {
                		 $("#${search.sortCol}").attr('class','sorting_desc');
                	 }
                	 
                	 if ("${search.crudType}" == 'GET') {
                		 $("#searchTableView").show();
                	 }
                 });
            });
        })(jQuery);
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/companyGetApi.do'/>";
            frm.submit();
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
		            <h1 class="mt-4">고객리스트 API</h1>
		            
		            <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">API 정보</h3>           
                       </div>
                       <div class="card-body">
                           <div class="form-row">
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="method">Method</label>
                                       <input class="form-control" id="method" name="method" type="text" value="POST" readonly />
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="url">URL</label>
                                       <input class="form-control" id="url" name="url" type="text" value="/companyApi.do" readonly />
                                   </div>
                               </div>
                               <div class="col-md-4">
                                   <div class="form-group">
                                       <label class="small mb-1" for="apiType">GET/SET</label>
                                       <select class="form-control2" id="apiType" name="apiType">
	                                       <option value="GET">GET</option>
	                                       <option value="SET">SET</option>
	                                   </select>
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
                   
                   <div class="card mb-4" style="margin-top:30px;">
                       <div class="card-header">
                           <h3 class="text-center font-weight-light my-1">API PARMETER</h3>           
                       </div>
                       <div id="getView" class="card-body">
                           <form:form commandName="search" id="searchForm" name="searchForm">
                           <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                           <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                           <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                           <input type="hidden" name="sortType" value="${search.sortType}"/>
                           <input type="hidden" name="custCd" value="${search.custCd}"/>
                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="telNo">전화번호</label>
                                       <input type="text" class="form-control input-lg radius" size="35" id="telNo" name="telNo" value="${search.telNo}" />
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="custNm">거래처명</label>
                                       <input type="text" class="form-control input-lg radius" size="35" id="custNm" name="custNm" value="${search.custNm}" />
                                   </div>
                               </div>
                               
                           </div>
                           </form:form>
                           
                           <div class="col-md-12" >
                               <div class="form-row">
                                   <div class="col-md-3">
                                   </div>
                                   <div class="col-md-3">
                                      <div id="btnSearch" class="btn btn-primary btn-block">전송</div>
                                   </div>
                                   <div class="col-md-3">
                                      <div id="btnExcelDown" class="btn btn-primary btn-block">Excel 다운로드</div>
                                   </div>
                                   <div class="col-md-3">
                                   </div>
                               </div>
                           </div>
                       </div>
                       
                       <div id="setView" class="card-body" style="display:none;">
                           <form:form commandName="obj" id="objForm" name="objForm" enctype="multipart/form-data">
                           <div class="form-row">
                               <div class="col-md-12">
			                        <div class="form-group">
			                            <label class="small mb-1" for="docNm">첨부파일</label>
			                            <div class="row ml-auto">
			                                <input type="file" id="excelFile" onchange="excelExport(event)"/>
			                            </div>
			                        </div>
			                    </div>
                           </div>
                           </form:form>
                           
                           <div class="col-md-12" >
                               <div class="form-row">
                                   <div class="col-md-4">
                                   </div>
                                   <div class="col-md-4">
                                      <div id="btnExcelUpload" class="btn btn-primary btn-block">Excel 업로드</div>
                                   </div>
                                   <div class="col-md-4">
                                   </div>
                               </div>
                           </div>
                       </div>
                       
                   </div>
                   
                    <!-- ======================================================================================================================== -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                    <div id="searchTableView" class="card mb-4" style="display:none;">
                       <div class="card-header">
                           <sapn>고객사 목록</sapn>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">  <!-- @@@ style="min-width:3000px;"  -->
                                   <div class="row">
                                       <div class="col-sm-12 col-md-2" style="padding-top:5px;">
                                           <div class="dataTables_length" id="dataTable_length">
                                               <label>Show 
                                               <select id="pageSizeItem" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                                                   <option value="10">10</option>
                                                   <option value="25">25</option>
                                                   <option value="50">50</option>
                                                   <option value="100">100</option>
                                               </select> entries
                                               </label>
                                           </div>
                                       </div>
                                       
                                       
                                       
                                   </div>
                                   <div class="row">
                                       <!-- style="min-width:3000px;" -->
                                       <div class="col-sm-12" style="min-width:1200px;">
                                           <!-- table table-striped table-bordered table-hover -->
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                              <thead class="thead-dark">  
                                                  <tr role="row">
                                                      <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
	                                                  <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">No</th>
	                                                  <th id="cust_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">코드</th>
	                                                  <th id="cust_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">거래처명</th>
	                                                  <th id="cust_type_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">업체구분</th>
	                                                  <th id="mat_type_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">자재구분</th>
	                                                  <th id="tel_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">TEL</th>
	                                                  <th id="fax_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">FAX</th>
	                                                  <th id="presiden_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">대표자</th>
	                                                  <th id="person_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">담당자명</th>
	                                                  <th id="person_tel" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">담당자TEL</th>
	                                                  <th id="person_email" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">EMAIL</th>
                                                  </tr>
                                              </thead>

                                              <tbody>
	                                              <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
					                                <tr role="row" class="odd">
					                                    <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
					                                    <td class="text-ellipsis"><span class="rnum">${item.rnum}</span></td>
					                                    <td class="text-ellipsis"><span class="cust_cd">${item.custCd}</span></td>
					                                    <td class="text-ellipsis"><span class="cust_nm">${item.custNm}</span></td>
					                                    <td class="text-ellipsis"><span class="cust_type_cd">${item.custTypeCd}</span></td>
					                                    <td class="text-ellipsis"><span class="mat_type_cd">${item.matTypeCd}</span></td>
					                                    <td class="text-ellipsis"><span class="tel_no">${item.telNo}</span></td>
					                                    <td class="text-ellipsis"><span class="fax_no">${item.faxNo}</span></td>
					                                    <td class="text-ellipsis"><span class="presiden_nm">${item.presidenNm}</span></td>
					                                    <td class="text-ellipsis"><span class="person_nm">${item.personNm}</span></td>
					                                    <td class="text-ellipsis"><span class="person_tel">${item.personTel}</span></td>
					                                    <td class="text-ellipsis"><span class="person_email">${item.personEmail}</span></td>
					                                </tr>
					                              </c:forEach>
					                              <c:if test="${fn:length(rtn.obj) le 0}">
					                                <tr>
					                                    <td colspan="11" class="no-data">- 표시할 내용이 없습니다. -</td>
					                                </tr>
					                              </c:if>
                                              </tbody>
                                              
                                           </table>
                                       </div>
                                   </div>
                                   <!-- ======================================================================================================================== -->
                                   <!-- paging                                                                                                                   -->
                                   <!-- ======================================================================================================================== -->
                                   <div class="row">
                                       <div class="col-sm-12 col-md-5">
                                           <c:if test="${rtn.totCnt > 0}">
                                               <div class="dataTables_info" id="dataTable_info">Showing ${search.firstIndex+1} to ${search.lastIndex} of ${rtn.totCnt} entries</div>
                                           </c:if>
                                       </div>
                                       
                                       <div class="col-sm-12 col-md-7">
                                           <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
	                                           <ul class="pagination">
	                                           
		                                           <c:set var="isLoof" value="true" />
							                       <c:if test="${rtn.totCnt > 0}">
							                           <c:if test="${search.pageIndex > 1}">
							                               <li class="paginate_button page-item previous" id="dataTable_previous"><a href="javascript:fn_paging(${search.pageIndex-1})" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
							                           </c:if>
							                           <c:forEach begin="${search.startPage}" end="${search.endPage}" step="1" var="i">
							                               <c:if test="${isLoof}">
							                                   <c:choose>
							                                       <c:when test="${i == search.pageIndex}">
							                                           <li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="${i}" tabindex="0" class="page-link">${i}</a></li>
							                                       </c:when>
							                                       <c:otherwise>
							                                           <li class="paginate_button page-item "><a href="javascript:fn_paging(${i})" aria-controls="dataTable" data-dt-idx="${i}" tabindex="0" class="page-link">${i}</a></li>
							                                       </c:otherwise>
							                                   </c:choose>
							                                   <c:if test="${rtn.totCnt <= (search.pageSize*i)}"><c:set var="isLoof" value="false" /></c:if>
							                               </c:if>
							                           </c:forEach>
							                           <c:if test="${rtn.totCnt > (search.pageSize*search.pageIndex)}">
							                               <li class="paginate_button page-item next" id="dataTable_next"><a href="javascript:fn_paging(${search.pageIndex+1})" aria-controls="dataTable" data-dt-idx="11" tabindex="0" class="page-link">Next</a></li>
							                           </c:if>
							                       </c:if> 
	                                           </ul>
                                           </div>
                                       </div>
                                   </div>
                                   <!-- page end -->
                               </div>
                           </div>
                       </div>
                   </div>
                   <!-- table card end -->
		        </div>
		    </main>
		</div>
    </div>
    
    
<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>	
<script type="text/javascript" src="<c:url value='/resource/js/ext/excel/xlsx.full.min.js'/>" ></script>
<script>
function excelExport(event){
	excelExportCommon(event, handleExcelDataAll);
}

function excelExportCommon(event, callback){
    var input = event.target;
    var reader = new FileReader();
    reader.onload = function(){
        var fileData = reader.result;
        var wb = XLSX.read(fileData, {type : 'binary'});
        var sheetNameList = wb.SheetNames; // 시트 이름 목록 가져오기 
        var firstSheetName = sheetNameList[0]; // 첫번째 시트명
        var firstSheet = wb.Sheets[firstSheetName]; // 첫번째 시트 
        callback(firstSheet);      
    };
    reader.readAsBinaryString(input.files[0]);
}

function handleExcelDataAll(sheet){
	handleExcelDataJson(sheet); // json 형태
}

var arrMcc025 = new Array();
function handleExcelDataJson(sheet){
	var sheetData = XLSX.utils.sheet_to_json(sheet);
    
	for(var i=0; i<sheetData.length; i++) {
	    var mcc025 = new Object();
	    
// 	    mcc025.factoryCd	= sheetData[i][""];
	    mcc025.custCd		= sheetData[i]["코드"];
	    mcc025.custNm		= sheetData[i]["거래처명"];
	    mcc025.custTypeCd	= sheetData[i]["업체구분"];
	    mcc025.matTypeCd	= sheetData[i]["자재구분"];
// 	    mcc025.addr1		= sheetData[i][""];
// 	    mcc025.addr2		= sheetData[i][""];
// 	    mcc025.postCd		= sheetData[i][""];
	    mcc025.telNo		= sheetData[i]["TEL"];
	    mcc025.faxNo		= sheetData[i]["FAX"];
	    mcc025.presidenNm	= sheetData[i]["대표자"];
	    mcc025.personNm		= sheetData[i]["담당자명"];
	    mcc025.personTel	= sheetData[i]["담당자TEL"];
	    mcc025.personEmail	= sheetData[i]["EMAIL"];
// 	    mcc025.businessNo	= sheetData[i][""];
// 	    mcc025.bigo			= sheetData[i][""];
	    mcc025.useYn		= "Y";

	    arrMcc025.push(mcc025);
	}
    
}

</script>
</body>
</html>