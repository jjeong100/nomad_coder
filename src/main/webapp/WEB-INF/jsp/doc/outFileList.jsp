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
    <title>출하검사성적서</title>
    
    <style>
		.ui-widget-header {
			border-bottom: 1px solid rgba(0, 62, 255, 0.125);
			border: 1px solid #aed0ea;
			background: #deedf7 url("../images/jquery/ui-bg_highlight-soft_100_deedf7_1x100.png") 50% 50% repeat-x;
			background-color:#343a40;
			font-weight: bold;
		}
		
		.ui-dialog .ui-dialog-titlebar-close {
			position: absolute;
			right: .3em;
			top: 50%;
			width: 20px;
			margin: -10px 0 0 0;
			padding: 1px;
			height: 20px;
			display: block;
		}
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
                
                //-------------------------------------------------------------
                // jqery event 
                //-------------------------------------------------------------
                // 검색 이벤트
                //-------------------------------------------------------------
                $('#btnSearch').click(function() {
                	var frm = document.searchForm;
                	frm.pageIndex.value = 1;
                    frm.action = "<c:url value='/outFileListPage.do'/>";
                    frm.submit();
		        });
                
              	//-------------------------------------------------------------
                // 바코드 출력 팝업
                //-------------------------------------------------------------
                $('#btnCreate').click(function() {
                	$( "#docReportModal" ).dialog( "open" );
                });
              	
             	// 팝업 닫기
                $('.modal-close-button').click(function() {
                    $('.modal-container').css("display", "none");
                });
             	
                $('#fileupload').fileupload({
                    url : "<c:url value='/fileSaveAct.do'/>", 
                    formData: $('#fileForm').serialize(),
                    iframe: true,
                    add: function(e, data){
                        var uploadFile = data.files[0];
                        //data.formData = $('#fileForm').serializeArray();
                        //console.log(data)
                        data.submit();
                    }, progressall: function(e,data) {
                        console.log('data.loaded:'+data.loaded);
                    }, done: function (e, data) {
                   	 	var result = eval("("+data.result+")");
                        // if(!cfCheckRtnObj(rtn)) return;
                        console.log(result);
                        document.fileForm.docFilePath.value = result.file.docFilePath;
                        document.fileForm.docNm.value = result.file.docNm;
                        document.fileForm.docOrgNm.value = result.file.docOrgNm;
                    }, fail: function(e, data){
                        $("#file-upload-dialog").dialog( "close" );
                        alert('서버와 통신 중 문제가 발생했습니다');
                    }
                });
              
              	//-------------------------------------------------------------
                // 성적서등록 팝업
                //-------------------------------------------------------------
                $( "#docReportModal" ).dialog({
                    autoOpen: false,
                    draggable:false, //창 드래그 못하게
                    modal:true,
                    resizable:false,
                    position:{
                        my:"center",
                        at:"center",
                        of:"#layoutSidenav" 
                        },
                    width: 600,
                    buttons: [
                        {
                            text: "등록",
                            click: function() {
                            	if($("#docNm").val().trim() == ''){
                                    alert(MSG_COM_ERR_001.replace("[@]", " : 첨부파일"));
                                    $("#docNm").focus();
                                    return;
                                }
                            	$( this ).dialog( "close" );
                            	
                                document.fileForm.crudType.value = 'C';
                                cfAjaxCallAndGoLink("<c:url value='/docSaveAct.do'/>"
                                        ,$('#fileForm').serialize(),'등록 되었습니다.'
                                        ,'searchForm'
                                        ,"<c:url value='/outFileListPage.do'/>");
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
                // 페이징 사이즈 변경 이벤트
                //-------------------------------------------------------------
                $('#pageSizeItem').on('change', function() {
                	var frm = document.searchForm;
                    frm.pageIndex.value = 1;
                    frm.pageSize.value = $("#pageSizeItem").val();
                    frm.action = "<c:url value='/outFileListPage.do'/>";
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
                    frm.action = "<c:url value='/outFileListPage.do'/>";
                    frm.submit();
                });
                
                //-------------------------------------------------------------
                // 엑셀 다운로드 이벤트
                //-------------------------------------------------------------
                $('#btnExcel').click(function() {
                	downloadExcelFromTable($('#dataTable'));
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
                	 
                	 $("#searchFromDate").val("${search.searchFromDate}");
                	 $("#searchToDate").val("${search.searchToDate}");
                	 
                 });
            });
        })(jQuery);
        
        //=====================================================================
        // button action funtion
        //=====================================================================
        function fn_download(docSeq) {
            downloadFile("<c:url value='/downloadDocFile.do'/>?docSeq=" + docSeq);
        }
        
        function fn_delete(docSeq) {
        	var frm = document.fileForm;
        	frm.crudType.value = 'D';
        	frm.docSeq.value = docSeq;
        	
        	cfAjaxCallAndGoLink("<c:url value='/docSaveAct.do'/>"
                    ,$('#fileForm').serialize(),'삭제 되었습니다.'
                    ,'searchForm'
                    ,"<c:url value='/outFileListPage.do'/>");
        }
        
        //=====================================================================
        // paging
        //===================================================================== 
        function fn_paging(pageIndex) {
            var frm = document.searchForm;
            frm.pageIndex.value = pageIndex;
            frm.action = "<c:url value='/outFileListPage.do'/>";
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
		            <h1 class="mt-4">출하검사성적서</h1>
                   
                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>출하검사성적서 목록</sapn>
                           <div id="btnExcel" class="btn btn-primary btn-sm mr-2" style="float: right;">엑셀다운로드</div>
                           <div id="btnCreate" class="btn btn-primary btn-sm mr-2" style="float: right;">출하성적서 추가</div>
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
                                       
                                       <div class="col-sm-12 col-md-10" style="margin-bottom:5px;">
                                           <div id="dataTable_filter" class="dataTables_filter">
                                               <form:form commandName="search" id="searchForm" name="searchForm">
                                                   <!-- <input type="hidden" name="crudType" value="R"/> -->
                                                   <input type="hidden" name="pageIndex" value="${search.pageIndex}"/>
                                                   <input type="hidden" name="pageSize" value="${search.pageSize}"/>
                                                   <input type="hidden" name="sortCol" value="${search.sortCol}"/>
                                                   <input type="hidden" name="sortType" value="${search.sortType}"/>
                                                   <input type="hidden" name="searchDocTypeCd" value="OUT"/>
	                                               <div id="btnSearch" class="button-cr radius blue" style="float: right; margin: 6px 5px 0 -44px; position: relative;">
								                        <img alt="" src="<c:url value='/resource/images/icon_search.png'/>"/>
								                   </div>
                                                   
								                   <div style="float: right; margin: 6px 5px;">
								                       <input class="form-control" id="searchDocNm" name="searchDocNm" type="text" value="${search.searchDocNm}" placeholder="성적서명"/>
								                   </div>
								                   <div style="float: right; margin: 6px 5px;">
								                       <input class="form-control2" id="searchToDate" name="searchToDate" type="text" value="${search.searchToDate}" placeholder="성적서등록 종료일자"/>
								                   </div>
								                   <div style="float: right; margin: 6px 5px;">
								                       <input class="form-control2" id="searchFromDate" name="searchFromDate" type="text" value="${search.searchFromDate}" placeholder="성적서등록 시작일자"/>
								                   </div>
								                   
								               </form:form>
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
	                                                  <th id="doc_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">문서명</th>
	                                                  <th id="doc_bigo" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 15%;">비고</th>
	                                                  <th id="write_dt" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">등록일자</th>
	                                                  <th class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">삭제</th>
                                                  </tr>
                                              </thead>
                                              <tbody>
	                                              <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
					                                <tr role="row" class="odd">
					                                    <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
					                                    <td class="text-ellipsis"><span class="rnum">${item.rnum}</span></td>
					                                    <td class="text-ellipsis"><span class="doc_nm"><a href="javascript:fn_download('${item.docSeq}')">${item.docOrgNm}</a></span></td>
					                                    <td class="text-ellipsis"><span class="doc_bigo">${item.docBigo}</span></td>
					                                    <td class="text-ellipsis"><span class="write_dt">${item.writeDate}</span></td>
					                                    <td class="text-ellipsis"><div name="btnDelete" class="btn btn-primary btn-sm mr-2" key-vlaue="${item.docSeq}" onclick="javascript:fn_delete('${item.docSeq}');">삭제</div></td>
					                                </tr>
					                              </c:forEach>
					                              
					                              <c:if test="${fn:length(rtn.obj) le 0}">
					                                <tr>
					                                    <td colspan="5" class="no-data">- 표시할 내용이 없습니다. -</td>
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
    
	<div id="docReportModal" title="성적서등록" >
	    <form:form id="fileForm" name="fileForm" action="<c:url value='/docSaveAct.do'/>" enctype="multipart/form-data">
		    <input type="hidden" name="crudType" value="R"/>
		    <input type="hidden" name="docSeq" value=""/>
		    <input type="hidden" name="docTypeCd" value="OUT"/>
		    <input type="hidden" name="docFilePath" value=""/>
		    <div class="col-md-12">
		        <div class="form-row">
		            <div class="col-md-12">
		                <div class="form-group">
		                    <label class="small mb-1" for="popShortId">첨부파일</label>
		                    <div class="row ml-auto">
			                    <input class="form-control col-md-9" id="docNm" name="docNm" type="hidden" readonly />
			                    <input class="form-control col-md-9" id="docOrgNm" name="docOrgNm" type="text" readonly />
			                    <input class="col-md-2 form_file" id="fileupload" name="uploadFiles" type="file" multiple="multiple"/>
		                    </div>
		                </div>
		                <div class="form-group">
		                    <label class="small mb-1" for="popShortId">비고</label>
		                    <input class="form-control" id="docBigo" name="docBigo" type="text" value=""/>
		                </div>
		            </div>
		        </div>
		    </div>
		</form:form>
	</div> 
	
<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>	
<script src="<c:url value='/resource/js/ext/fileupload/jquery.fileupload.js'/>"></script>
<script src="<c:url value='/resource/js/ext/fileupload/jquery.iframe-transport.js'/>"></script>

<script>
$( "#searchFromDate" ).datepicker({ 
    showOn: "button",
    buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
    buttonImageOnly: true,
    buttonText: "Select date"
  });
$( "#searchFromDate" ).datepicker("option", "dateFormat", "yy/mm/dd");

$( "#searchToDate" ).datepicker({ 
    showOn: "button",
    buttonImage: "<c:url value='/resource/images/calendar46.png'/>",
    buttonImageOnly: true,
    buttonText: "Select date"
  });
$( "#searchToDate" ).datepicker("option", "dateFormat", "yy/mm/dd");
</script>
</body>
</html>