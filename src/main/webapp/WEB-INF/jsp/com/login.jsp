<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    String rtnMsg = request.getParameter("rtnMsg") == null? "" : request.getParameter("rtnMsg");
    String failCount = request.getParameter("failCount") == null? "" : request.getParameter("failCount");
%>
<!DOCTYPE html>
<html>
<head>
    <title>PowerPOP - Login</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link type="text/css" rel="stylesheet" href="<c:url value='/resource/css/login.css'/>" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ext/jquery/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ext/jquery/jquery.cookie.js"></script>
    <link rel="shortcut icon" href="<c:url value='/img/favicon.ico'/>" />
    
    <script type="text/javascript">
  	CTX_ROOT      = "<c:out value="${pageContext.request.contextPath}"/>";
	$(function() {
		
		var username = $.cookie('username');
		var password = $.cookie('password');
		
		// username과 password에 저장된 값이 있다면 입력요소에 값 출력
		if(username && password) {
			$("#username").val(username);
			$("#password").val(password);
			
			// 체크박스 다시 체크
			$("#saveUserName").prop("checked", true);
		}
		
		$("#username, #password").keydown(function (key) {
			if (key.keyCode == 13) {
				key.preventDefault();
            	login('${pageContext.request.contextPath}/loginAct.do');
            }
        });
		
		$("#loginButton, #loginButtonMobile").click(function() {
			if ($("#saveUserName").is(":checked")) {
                //체크 되어있다면, 해당 정보를 1년간 유효하도록 쿠키 저장
                $.cookie("username", $("#username").val(), {
                    "expires" : 365                
                });                        
                $.cookie("password", $("#password").val(), {
                    "expires" : 365
                });
            } else {
                //체크가 해제되었다면 쿠키 삭제.
                $.removeCookie("username");
                $.removeCookie("password");
            }
			
			if( $(this).attr("id") == "loginButtonMobile" ) {
				document.form0.mobileYn.value = "Y";
			} else {
				document.form0.mobileYn.value = "N";
			}
			
			login('${pageContext.request.contextPath}/loginAct.do');
		});
		
		function login(targetUrl) {
			var username = $('#username').val();                 
			var password = $('#password').val();
			
			var reg1 = /^[a-zA-Z0-9]{8,20}$/;
	        var reg2 = /[a-zA-Z]/g; 
	        var reg3 = /[0-9]/g;
	        var reg4 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}/; 
	        //reg1 => 문자로 8 ~ 20 자리 이내로 입력
	        //reg2 => 문자 입력 
	        //reg3 => 숫자 입력
	        //reg4 => 최소 8 자, 대문자 하나 이상, 소문자 하나, 숫자 하나 및 특수 문자 하나 이상

			if (username == null || username.trim().length == 0) {
				alert("아이디를 입력해주세요.");
				$('#username').focus();
				return false;
			} else if (password == null || password.trim().length == 0) {
				alert("패스워드를 입력해주세요.");
				$('#password').focus();
				return false;
			}
			else {
				var matchString = "";
				matchString += "iPhone|iPod|iPad|Android";
				matchString += "|Windows CE|BlackBerry|Symbian|Windows Phone";
				matchString += "|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson";
				
				if ( navigator.userAgent.match(/SMART-TV/) == null
						&& ( navigator.userAgent.match(new RegExp(matchString, "i")) != null
								|| navigator.userAgent.match(/LG|SAMSUNG|Samsung/) != null ) ) {
					document.form0.mobileYn.value = "Y";
				}
				
				document.form0.action = targetUrl;
				document.form0.submit();
			}
		}
		
		$('#username').focus();
	});
	
	window.onload = pageLoad;
    
	function pageLoad(){
		var message = document.form0.message.value;
        if (message != "") {
            alert(message);
        }
	}

    </script>
</head>
<body id="fullground">
    <div id="login-background" >
        <form:form commandName="userVo" id="slick-login" name="form0">
        <input type="hidden" name="mobileYn" value=""/>
            <input type="hidden" name="message" value="${rtn.msg}"/>
            <!-- Login Content -->        
            <div id="login-content">
                <div class="entryOne"><h1 id="h1Style">Quality First <br/>Value Creation<br> Think different!</h1></div>
                <div class="entryTwo" >
                    <img id="logoImg" src="<c:out value="${pageContext.request.contextPath}"/>/resource/images/PowerPOP.png" width="300" height="auto"/><br/>                            
                    <img id="idImg" src="<c:out value="${pageContext.request.contextPath}"/>/resource/images/icon_id.jpg" />
                    <input type="text" class="username" name="loginId" id="username" placeholder="아이디" tabindex="1"><br/>
                    <img id="pwImg" src="<c:out value="${pageContext.request.contextPath}"/>/resource/images/icon_pw.jpg" />
                    <input type="password" class="password" name="passCd" id="password" placeholder="비밀번호" tabindex="2"><br/>          
                    <input type="checkbox" id="saveUserName"><span style="color:#4e4e4e; font-size:15px;">아이디 저장</span><br/>
                    <button class="login-button" id="loginButton"  tabindex="3" >
                        <strong>로그인</strong>
                    </button>
<%--                         <c:if test="${pageContext.request.serverName == 'localhost'}"> --%>
                            <button class="login-button" id="loginButtonMobile" tabindex="3" >
                                <strong>모바일로그인</strong>
                            </button>
<%--                         </c:if> --%>
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>
