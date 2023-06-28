<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %><head>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#btnColse').click(function() {
        var frm = document.searchForm;
        frm.action = "<c:url value='/mobileMenuPage.do'/>";
        frm.submit();
    });
	
	$("#print_init").click(function(){			
		window.print();
	});
	
});
</script>

<div class="navbar" style="margin-left: auto;">
	<div class="card-body embed-responsive">
	    <div id="btnColse" class="btn btn-primary btn-sm mr-2" style="float: right;">닫기</div>
	    <div id="btnSave" class="btn btn-primary btn-sm mr-2" style="float: right;">저장</div>
	    <div id="print_init" class="btn btn-primary btn-sm mr-2" style="float: right;">인쇄출력</div>
    </div>
</div>
