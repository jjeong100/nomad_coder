<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 	  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"        uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
    <jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp" ></jsp:include>
    <title>작업지시 소요량 관리</title>
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
	            
	            $('#btnModalUpdate').click(function() {

	            	var totCnt = "${fn:length(rtn.obj)}";
	            	
	            	if( totCnt == 0 ) {
	            		cfAlert("처리할 내역이 없습니다.");
	            		return;
		            }
		            
		            $( "#glv_upd_confirm" ).dialog({
		                autoOpen: false,
		                width: 400,
		                buttons: [
		                    {
		                        text: "변경",
		                        click: function() {
		                            $( this ).dialog( "close" );
		                            document.modalForm.crudType.value = 'U';

		                            // 확정수량 콤마 제거
		                            $("#modalForm input[name$='confirmQty']").each(function(idx, obj){
		                                var val = $(obj).val();
		                                val = val.replace(/,/gi, "");
		                                $(obj).val(val);
		                            });
		                            
		                            var param = {}
		                            param.url = "<c:url value='/matRequireSaveAct.do'/>";
		                            param.data = $("#modalForm").serialize();
		                            param.msg = "수정 되었습니다.";
		                            param.callback = function(result) {
		                            	cfAlert(param.msg);
		                            	
		                            	// 조회목록제거
		                                $("#previewOpmatList").html("");
		                                
		                                // 팝업닫기
		                                $('.modal-close-button').click();
		                            };
		                            
		                            cfAjaxCallAndCallback(param);
		                        }
		                    },
		                    {
		                        text: "취소",
		                        click: function() {
		                            $( this ).dialog( "close" );
		                        }
		                    }
		                ]
		            }).dialog("open");
	            });
              	//-------------------------------------------------------------
                // 수정 이벤트
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
<form:form commandName="search" id="modalForm" name="modalForm">
<input type="hidden" name="crudType" value="R"/>
<input type="hidden" name="prodSeq" value="${search.prodSeq}"/>

    <div id="layoutSidenav_modal">
		<div id="layoutSidenav_modal_content">
		    <main>
		        <div class="container-fluid">
		        
                   <!-- ========================================================================================================================= -->
                    <!-- taable list                                                                                                              -->
                    <!-- ======================================================================================================================== -->
                   <div class="card mb-4">
                       <div class="card-header">
                           <sapn>작업지시 소요량 목록</sapn>
                           <div id="btnModalUpdate" class="btn btn-primary btn-sm mr-2" style="float: right;">수정</div>
                       </div>
                       <div class="card-body">
                           <div class="table-responsive">
                               <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                   <div class="row">
                                       <div class="col-sm-12" width="100%">
                                           <table class="table table-borderless table-borderbottom dataTable table-hover" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; table-layout:fixed;">
                                              <thead class="thead-dark">
                                                  <tr role="row">
                                                      <!-- th id는 소트 쿼리에 그대로 사용됨, 실체 컬럼명과 일치 해야함. -->
	                                                  <th id="rnum" class="no-sort" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 5%;">No</th>
	                                                  <th id="oper_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 8%;">공정</th>
	                                                  <th id="oper_seq" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 18%;">공정순서</th>
	                                                  <th id="mat_cd" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재코드</th>
	                                                  <th id="mat_nm" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">자재명</th>
	                                                  <th id="mat_style" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">재질</th>
	                                                  <th id="po_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">소요수량</th>
	                                                  <th id="demand_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">합계수량</th>
	                                                  <th id="confirm_qty" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 10%;">추가수량</th>
	                                                  <th id="matApp_val" class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" style="width: 12%;">확정수량</th>
                                                  </tr>
                                              </thead>

                                              <tbody>
	                                              <c:forEach items ="${rtn.obj}" var="item" varStatus="status">
					                                <tr role="row" class="odd">
					                                    <!-- 엑셀 다운로드 사용시 span class는 th id와 일치 해야함. -->
					                                    <td class="text-ellipsis"><span class="rnum">${status.count}</span></td>
					                                    <td class="text-ellipsis"><span class="oper_cd">${item.operCd}</span></td>
					                                    <td class="text-ellipsis"><span class="oper_seq">${item.operSeq}</span></td>
					                                    <td class="text-ellipsis"><span class="mat_cd">${item.matCd}</span></td>
					                                    <td class="text-ellipsis"><span class="mat_nm">${item.matNm}</span></td>
					                                    <td class="text-ellipsis"><span class="mat_style">${item.matStyle}</span></td>
					                                    <td class="text-ellipsis"><span class="po_qty">${item.poQty}</span></td>
					                                    <td class="text-ellipsis">
					                                    	<span class="demand_qty">
					                                    		<fmt:formatNumber value="${item.demandQty}" type="number"/>
															</span>
					                                    </td>
					                                    <td class="text-ellipsis">
					                                    	<span class="matApp_val">
					                                    		<fmt:formatNumber value="${item.matAppVal}" type="number"/>
					                                    	</span>
					                                    </td>
					                                    <td class="text-ellipsis">
					                                    	<fmt:formatNumber value="${item.confirmQty}" type="number" var="confirmQty"/>
					                                    	<input type="input" maxlength="10" oninput="this.value=cfAddComma(this.value);" name="objList[${status.index}].confirmQty" class="form-control form-control-sm" value="${confirmQty}" placeholder="수량을 입력하세요"/>
					                                    	<input type="hidden" name="objList[${status.index}].opmatSeq" value="${item.opmatSeq}"/>
					                                    </td>
					                                </tr>
					                              </c:forEach>
					                              <c:if test="${fn:length(rtn.obj) le 0}">
					                                <tr>
					                                    <td colspan="12" class="no-data">- 표시할 내용이 없습니다. -</td>
					                                </tr>
					                              </c:if>
                                              </tbody>
                                              
                                           </table>
                                       </div>
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
                   <!-- table card end -->
		        </div>
		    </main>
		</div>
		<!-- layoutSidenav_content end -->
    </div>
</form:form>

<script>

</script>
</body>
</html>