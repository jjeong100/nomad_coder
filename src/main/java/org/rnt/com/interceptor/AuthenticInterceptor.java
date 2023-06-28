package org.rnt.com.interceptor;

import java.util.Iterator;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.session.SessionData;
import org.rnt.com.session.SessionManager;
import org.rnt.com.util.StrUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class AuthenticInterceptor extends HandlerInterceptorAdapter {
    protected Log log = LogFactory.getLog(this.getClass());
    
    private Set<String> permittedURL;
    

    public void setPermittedURL(Set<String> permittedURL) {
        this.permittedURL = permittedURL;
    }
    

    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        
        String requestURI = request.getRequestURI();
        String userId = null;
        if( requestURI.lastIndexOf(";") != -1 ) {
            requestURI = requestURI.substring(0, requestURI.lastIndexOf(";"));
        }
        
        boolean isPermittedURL = false;
        SessionData sData = SessionManager.getUserData(request);
        if(sData != null){
        	userId =  (String)sData.getUserId();
        }
        
        log.debug("userId=[" + userId +"]");
        log.debug("servletContext.getContextPath()=[" + request.getContextPath() +"]");
        
        if (!StrUtil.isNull(userId)){
        	request.setAttribute("sessionData", sData);
            return true;
        }else{
            for(Iterator<String> it = this.permittedURL.iterator(); it.hasNext();){
                String urlPattern = request.getContextPath() + (String) it.next();
                log.debug("URI 패턴 : " + urlPattern);
                if(Pattern.matches(urlPattern, requestURI)){// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
                    isPermittedURL = true;
                }
            }
            if(!isPermittedURL){
                if (log.isDebugEnabled()) {
                    log.debug("=======================================================");
                    log.debug("세션종료 안내 화면으로 이동 시킨다.");
                    log.debug("=======================================================");
                }
                response.sendRedirect(request.getContextPath()+"/loginPage.do");
                return false;
            }else{
                return true;
            }
        }
    }
}
