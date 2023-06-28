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
                    frm.action = "<c:url value='/userGetApi.do'/>";
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
                        url : "<c:url value='/userGetApiExcel.do'/>",
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
                
                //-------------------------------------------------------------
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                	var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/userGetApi.do'/>";
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
                    frm.action = "<c:url value='/userGetApi.do'/>";
                    frm.submit();
                });
                
                $('#fileupload').fileupload({
                    url : "<c:url value='/userSetApiExcel.do'/>", 
                    formData: $('#objForm').serialize(),
                    iframe: true,
                    add: function(e, data){
                        var uploadFile = data.files[0];
                        data.submit();
                    }, progressall: function(e,data) {
                        console.log('data.loaded:'+data.loaded);
                    }, done: function (e, data) {
                        var result = eval("("+data.result+")");
                        // if(!cfCheckRtnObj(rtn)) return;
                        console.log(result);
                    }, fail: function(e, data){
                        $("#file-upload-dialog").dialog( "close" );
                        alert('서버와 통신 중 문제가 발생했습니다');
                    }
                });
                
                $('#fileupload').bind('fileuploadsubmit', function (e, data) {
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
            frm.action = "<c:url value='/userGetApi.do'/>";
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
		            <h1 class="mt-4">사용자 API</h1>
		            
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
                                       <input class="form-control" id="url" name="url" type="text" value="/userApi.do" readonly />
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
                           <div class="form-row">
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="searchLoginName">이름</label>
                                       <input type="text" class="form-control input-lg radius" size="35" placeholder="이름" id="searchLoginName" name="searchLoginName" value="${search.searchLoginName}" />
                                   </div>
                               </div>
                               <div class="col-md-6">
                                   <div class="form-group">
                                       <label class="small mb-1" for="searchSabunId">사번</label>
                                       <input type="text" class="form-control input-lg radius" size="35" placeholder="사번" id="searchSabunId" name="searchSabunId" value="${search.searchSabunId}" />
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
			                                <input class="form-control col-md-9" id="docNm" name="docNm" type="text" readonly />
			                                <input class="col-md-2 form_file" id="fileupload" name="uploadFiles" type="file" multiple="multiple"/>
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
                           <sapn>작업자 목록</sapn>
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
                                                      <th id="short_id" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">숏아이디</th>
                                                      <th id="login_id" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">아이디</th>
                                                      <th id="login_name" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">이름</th>
                                                      <th id="sabun_id" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">사번</th>
                                                      <th id="depart_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">부서</th>
                                                      <th id="jik_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">직급</th>
                                                      <th id="email" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">이메일</th>
                                                      <th id="mobile_no" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">전화번호</th>
                                                      <th id="level_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">권한등급</th>
                                                      <th id="work_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">작업조</th>
                                                  </tr>
                                              </thead>

                                              <tbody>
                                                  <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
                                                    <tr role="row" class="odd">
                                                        <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
                                                        <td class="text-ellipsis"><span class="rnum">${item.rnum}</span></td>
                                                        <td class="text-ellipsis"><span class="short_id">${item.shortId}</span></td>
                                                        <td class="text-ellipsis"><span class="login_id">${item.loginId}</span></td>
                                                        <td class="text-ellipsis"><span class="login_name">${item.loginName}</span></td>
                                                        <td class="text-ellipsis"><span class="sabun_id">${item.sabunId}</span></td>
                                                        <td class="text-ellipsis"><span class="depart_cd">${item.departNm}</span></td>
                                                        <td class="text-ellipsis"><span class="jik_cd">${item.jikNm}</span></td>
                                                        <td class="text-ellipsis"><span class="email">${item.email}</span></td>
                                                        <td class="text-ellipsis"><span class="mobile_no">${item.mobileNo}</span></td>
                                                        <td class="text-ellipsis"><span class="level_nm">${item.levelNm}</span></td>
                                                        <td class="text-ellipsis"><span class="work_nm">${item.workNm}</span></td>
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

<script src="<c:url value='/resource/js/ext/fileupload/jquery.fileupload.js'/>"></script>
<script src="<c:url value='/resource/js/ext/fileupload/jquery.iframe-transport.js'/>"></script>
<script>

</script>
</body>
</html>