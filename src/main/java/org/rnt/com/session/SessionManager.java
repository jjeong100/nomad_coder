package org.rnt.com.session;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


/**
 * 세션정보를 조회, 저장하는 클래스
 *
 */
public abstract class SessionManager{
	
	/**
     * 로그인여부 조회
     * @param request HttpServletRequest
     * @return boolean 로그인여부
     */
	public static boolean isLoggedIn(HttpServletRequest request) {
	    SessionData user = getUserData(request);
        if(user == null || user.getUserId() == null || user.getUserId().length() == 0)
            return false;
        else return true;
	}
	public static boolean isLoggedIn() {
		SessionData user = getUserData();
		if(user == null || user.getUserId() == null || user.getUserId().length() == 0)
			return false;
		else return true;
	}

	/**
     * 세션 데이터 조회
     * @return SessionData 세션데이터를 담고 있는 오브젝트
     */
	public static SessionData getUserData(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session == null) {
            return null;
        }
        if(session.getAttribute(SessionData.SESSION_DATA_KEY) == null){
        	return null;
        }
        return (SessionData)session.getAttribute(SessionData.SESSION_DATA_KEY);
    }
	public static SessionData getUserData() {
		return getUserData(getCurrentRequest());
	}
	/**
     * 세션 데이터 저장
     * @param req HttpServletRequest
     * @param sessionData 세션데이터를 담고 있는 오브젝트
     */
	public static void setUserData(HttpServletRequest req, SessionData sessionData) {
        HttpSession session = req.getSession();
        session.setAttribute(SessionData.SESSION_DATA_KEY, sessionData);
    }
	
	
	public static void removeSessionAttribute(HttpServletRequest request, String keyStr) throws Exception {
        HttpSession session = request.getSession();
        session.removeAttribute(keyStr);
    }
	
	public static void setSessionAttribute(HttpServletRequest request, String keyStr, Object obj) throws Exception {
        HttpSession session = request.getSession();
        session.setAttribute(keyStr, obj);
    }
	
	public static Object getSessionAttribute(HttpServletRequest request, String keyStr) throws Exception {
        HttpSession session = request.getSession();
        return session.getAttribute(keyStr);
    }
	
	public static void setUserData(SessionData sessionData) {
		setUserData(getCurrentRequest(), sessionData);
    }

	/**
	 * 현재 HttpServletRequest 객체 가져오는 함수
	 * @return HttpServletRequest
	 */
	public static HttpServletRequest getCurrentRequest() {
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest hsr = sra.getRequest();
		return hsr;
	}
}
