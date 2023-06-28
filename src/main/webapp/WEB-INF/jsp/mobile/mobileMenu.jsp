<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include flush="false" page="/WEB-INF/jsp/include/include.jsp"></jsp:include>
<title>PowerMES</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
	//=====================================================================
	// jquery logic
	//=====================================================================
	(function($) {
		$(function() {
			//-------------------------------------------------------------
			// declare gloval 
			//-------------------------------------------------------------

			//-------------------------------------------------------------
			// jqery event 
			//-------------------------------------------------------------
			
			//-------------------------------------------------------------
			// 자재입고
			//-------------------------------------------------------------
			$('#btnGoMenu1').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileMaterialInListPage.do'/>";
				frm.submit();
			});
			
			//-------------------------------------------------------------
			// 생산작업
			//-------------------------------------------------------------
			$('#btnGoMenu2').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileProductionListPage.do'/>";
				frm.submit();
			});
			//-------------------------------------------------------------
			// 검품
			//-------------------------------------------------------------
			$('#btnGoMenu3').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileFinishQmListPage.do'/>";
				frm.submit();
			});
			//-------------------------------------------------------------
			// 제품입고
			//-------------------------------------------------------------
			$('#btnGoMenu4').click(function() {
				// 권한체크
                if( ${sessionData.roleId == 'WORKER'} ) {
                	cfAlert("권한이 없습니다.");
                	return false;
                }
				
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileItemInListPage.do'/>";
				frm.submit();
			});
			
			//-------------------------------------------------------------
			// 제품출하
			//-------------------------------------------------------------
			$('#btnGoMenu5').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/mobileItemOutListPage.do'/>";
				frm.submit();
			});

			$('#btnLogOut').click(function() {
				var frm = document.searchForm;
				frm.action = "<c:url value='/logoutAct.do'/>";
				frm.submit();
			});

			//-------------------------------------------------------------
			// 작업자 패스워드 변경
			// 20201111 jeonghwan
			//-------------------------------------------------------------
			$('#btnPassWordChange').click(function() {
				var inPassWord = $("#inPassWord").val().trim();
				var newPassWord = $("#newPassWord").val().trim();
				var confPassWord = $("#confPassWord").val().trim();

				var reg1 = /^[a-zA-Z0-9]{10,20}$/;
				var reg2 = /[a-zA-Z]/g;
				var reg3 = /[0-9]/g;

				if (inPassWord == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 이전비밀번호"));
					$("#inPassWord").focus();
					return false;
				}
				if (newPassWord == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 신규비밀번호"));
					$("#newPassWord").focus();
					return false;
				}
				if (confPassWord == '') {
					alert(MSG_COM_ERR_001.replace("[@]", " : 비밀번호확인"));
					$("#confPassWord").focus();
					return false;
				}

				if (newPassWord != confPassWord) {
					alert("신규비밀번호와 비밀번호 확인이 일치 하지 않습니다.");
					$("#confPassWord").focus();
					return false;
				}

				if (!(reg1.test(newPassWord) && reg2.test(newPassWord) && reg3.test(newPassWord))) {
					alert('비밀번호는 영문+숫자 혼합 10자리 이상으로 입력해주십시요');
					return false;
				}

				//그밖에 필요조건..
				if (true) {
					$("#glv_password_upd_confirm").dialog("open");
				}
			});

			$("#glv_password_upd_confirm").dialog({
				autoOpen : false,
				width : 400,
				buttons : [ {
					text : "변경",
					click : function() {
						$(this).dialog("close");
						document.objForm.crudType.value = 'U';
						cfAjaxCallAndGoLink("<c:url value='/workerPassWordSaveAct.do'/>"
                                ,$('#objForm').serialize(),'수정 되었습니다.'
                                ,'searchForm'
                                ,"<c:url value='/mobileMenuPage.do'/>");
					}
				}, {
					text : "취소",
					click : function() {
						$(this).dialog("close");
					}
				} ]
			});
			//-------------------------------------------------------------
			// 팝업 닫기
			//-------------------------------------------------------------
			$('.modal-close-button').click(function() {
				$('.modal-container').css("display", "none");
			});

			//-------------------------------------------------------------
			// 패스워드 변경 팝업
			//-------------------------------------------------------------
			$('#btnPassWord').click(function() {
				$('#passWordChangeModal').css("display", "block");
			});

			//-------------------------------------------------------------
			// onLoad  
			//-------------------------------------------------------------
			$(document).ready(function() {

			});
		});
	})(jQuery);

	//=====================================================================
	// button action funtion
	//=====================================================================
     function fn_go_page() {
            var frm = document.searchForm;
            frm.action = "<c:url value='/dashBoardMobilePage.do'/>";
            frm.submit();
      }
	-->
</script>
</head>
<!-- ============================================================================================================================================ -->
<!-- body                                                                                                                                         -->
<!-- ============================================================================================================================================ -->
<body>
	<div class="card">
		<div class="card-header">
			<sapn>생산관리</sapn>
			<span name="btnUpdate" class="btn btn-primary btn-sm" title="dashBoard"  onclick="javaScrip:fn_go_page();">dashBoard</span>
			<div id="btnLogOut" class="btn-logout mr-2" style="float: right;">
				<i class="xi-unlock"></i> Logout
			</div>
			<div id="btnPassWord" class="btn-logout mr-2" style="float: right;">패스워드변경</div>
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-6">
					<div id="btnGoMenu1" class="btn main-btn1 btn-block" style="font-zie: 2.4em; line-height: 2.5em; letter-spacing: 2px;">자재입고</div>
				</div>
				<div class="col-md-6">
					<div id="btnGoMenu2" class="btn main-btn1 btn-block" style="font-zie: 2.4em; line-height: 2.5em; letter-spacing: 2px;">생산작업</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div id="btnGoMenu3" class="btn main-btn1 btn-block" style="font-zie: 2.4em; line-height: 2.5em; letter-spacing: 2px;">검품</div>
				</div>
				<div class="col-md-4">
					<div id="btnGoMenu4" class="btn main-btn1 btn-block" style="font-zie: 2.4em; line-height: 2.5em; letter-spacing: 2px;">제품입고</div>
				</div>
				<div class="col-md-4">
					<div id="btnGoMenu5" class="btn main-btn1 btn-block" style="font-zie: 2.4em; line-height: 2.5em; letter-spacing: 2px;">제품출하</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include flush="false" page="/WEB-INF/jsp/include/cmmPopup.jsp"></jsp:include>
	
	<form:form commandName="search" id="searchForm" name="searchForm">
	</form:form>
	
	<form name="objForm" id="objForm">
		<input type="hidden" name="crudType" value="R" /> 
		<input type="hidden" name="passCd" value="${rtn.obj.passCd}" /> 
		<input type="hidden" name="loginId" value="${rtn.obj.loginId}" />
		
		<!-- 페스워드 변경 팝업 20201111 jeonghwan-->
		<div id="passWordChangeModal" class="modal-container">
			<div class="modal-content3">
				<div class="modal-header">
					<div class="txt20">패스워드 변경</div>
					<span class="modal-close-button">×</span>
				</div>
				<div class="card mb-4" style="margin-top: 10px; margin-left: 30px; margin-right: 30px;">
					<div class="card-header">
						<h3 class="text-left font-weight-light my-1">사번 : ${rtn.obj.sabunId}</h3>
						<h3 class="text-left font-weight-light my-1">이름 : ${rtn.obj.loginName}</h3>
					</div>
					<div id="previewPassWordChange">
						<div class="form-group">
							<label class="small mb-1" for="inPassWord">이전비밀번호</label> 
							<input class="form-control" id="inPassWord" name="inPassWord" type="password" placeholder="이전비밀번호을 입력하세요">
						</div>
						<div class="form-group">
							<label class="small mb-1" for="newPassWord">신규비밀번호</label> 
							<input class="form-control" id="newPassWord" name="newPassWord" type="password" placeholder="신규비밀번호을 입력하세요">
						</div>
						<div class="form-group">
							<label class="small mb-1" for="confPassWord">비밀번호확인</label> 
							<input class="form-control" id="confPassWord" name="confPassWord" type="password" placeholder="비밀번호확인을 입력하세요">
						</div>
					</div>
					<div id="btnPassWordChange" class="btn btn-primary btn-sm mr-2">패스워드변경</div>
				</div>
			</div>
		</div>
	</form>
	<!-- 20201111 jeonghwan -->
	<div id="glv_password_upd_confirm" title="확인" style="display: none;">
		<div style="font-size: 1.3em; text-align: center; margin-top: 20px;">
			<p>변경 하시겠습니까 ?</p>
		</div>
	</div>
	<script>
		
	</script>
</body>
</html>