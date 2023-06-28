package org.rnt.com.session;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Scope(value="session")
@Component("sessionData")
public class SessionData implements Serializable {
    private static final long serialVersionUID = 9022722988639227411L;
    
    /**
     * 로그인한 사용자 정보를 session 스코프에 담기 위한 키
     */
    public static final String SESSION_DATA_KEY = "rntimeUserSession"; //이 값을 절대 수정하지 말 것.

    private String userId;
    private String userName;
    private String roleId;
    private String position;
    private String roleName;
    private String shortId;
    private String sabunId;
    private String mobileYn;
    private String workCd;
    
    public String getWorkCd() {
        return workCd;
    }
    public void setWorkCd(String workCd) {
        this.workCd = workCd;
    }
    public String getMobileYn() {
        return mobileYn;
    }
    public void setMobileYn(String mobileYn) {
        this.mobileYn = mobileYn;
    }
    public String getSabunId() {
        return sabunId;
    }
    public void setSabunId(String sabunId) {
        this.sabunId = sabunId;
    }
    public String getShortId() {
        return shortId;
    }
    public void setShortId(String shortId) {
        this.shortId = shortId;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getRoleId() {
        return roleId;
    }
    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
    public String getPosition() {
        return position;
    }
    public void setPosition(String position) {
        this.position = position;
    }
    public String getRoleName() {
        return roleName;
    }
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
    public static String getSessionDataKey() {
        return SESSION_DATA_KEY;
    }
}