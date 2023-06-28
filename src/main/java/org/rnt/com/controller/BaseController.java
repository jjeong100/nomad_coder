package org.rnt.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.entity.service.CodeService;
import org.rnt.com.entity.service.UserHistoryService;
import org.rnt.com.entity.vo.CodeVO;
import org.rnt.com.entity.vo.UserHistoryVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.session.SessionData;
import org.rnt.com.session.SessionManager;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

public class BaseController {
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="codeService")
    private CodeService codeService;
    
    @Resource(name="userHistoryService")
    private UserHistoryService userHistoryService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    public RtnVO setRtnVO(RtnVO rtnVO, String msg, String exceptionMsg) {
        rtnVO.setRc(GlvConst.RC_ERROR);
        rtnVO.setMsg(msg);
        rtnVO.setExceptionMsg(exceptionMsg);
        rtnVO.setExceptionClassName((new Throwable()).getStackTrace()[1].getClassName());
        rtnVO.setExceptionMethodName((new Throwable()).getStackTrace()[1].getMethodName());
        rtnVO.setExceptionLine((new Throwable()).getStackTrace()[1].getLineNumber());
        return rtnVO;
    }
    
    public String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null)
            ip = request.getRemoteAddr();
        return ip;
    }
    
    public void getCode(String grpCodeId, ModelMap model) {
        CodeVO code = new CodeVO();
//        code.setAllFetch(true);
//        code.setSearchCodeGrpId(grpCodeId);
        code.setBcode(grpCodeId);
        RtnVO rtnCode;
        try {
            rtnCode = codeService.searchList(code);
            if (rtnCode.getRc() == 0) {
                List<?> list = (List<?>)rtnCode.getObj();
                model.addAttribute(grpCodeId.toLowerCase()+"_list", list);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void webViewLog(HttpServletRequest request) {
        if (log.isInfoEnabled()) {
            String userId = "";
            SessionData sData = SessionManager.getUserData(request);
            if (sData != null) {
                userId = sData.getUserId();
            }
            
            if (StrUtil.isNull(userId)) {
                log.info("[No Seesion:"+StrUtil.getLastAfterStr(StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/").toString(),"/")+"][VIEW]");
            } else {
                log.info("["+userId+":"+StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/")+"][VIEW]");
            }
        }
        
        if (!"goTopMenuPage.do".equals(StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/"))) {
            UserHistoryVO his = new UserHistoryVO();
            his.setFactoryCd(proPertyService.getFactoryCd());
            his.setLoginId(getUserId(request));
            his.setLogTypeCd("P");
            his.setLoginIp(getClientIp(request));
            his.setPageUrl(StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/"));
            userHistoryService.insert(his);
        }
        
        
    }
    
    public void webStart(HttpServletRequest request) {
        if (log.isInfoEnabled()) {
            String userId = "";
            SessionData sData = SessionManager.getUserData(request);
            if (sData != null) {
                userId = sData.getUserId();
            }
            
            if (StrUtil.isNull(userId)) {
                log.info("[No Seesion:"+StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/")+"][START]");
            } else {
                log.info("["+userId+":"+StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/")+"][START]");
            }
        }
        if (!"goTopMenuPage.do".equals(StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/"))) {
            UserHistoryVO his = new UserHistoryVO();
            his.setFactoryCd(proPertyService.getFactoryCd());
            his.setLoginId(getUserId(request));
            his.setLogTypeCd("P");
            his.setLoginIp(getClientIp(request));
            his.setPageUrl(StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/"));
            userHistoryService.insert(his);
        }
    }
    
    public String getUserId(HttpServletRequest request) {
        String userId = "";
        SessionData sData = SessionManager.getUserData(request);
        if (sData != null) {
            userId = sData.getUserId();
        }
        return userId;
    }
    
    public String getUserNm(HttpServletRequest request) {
        String rtn = "";
        SessionData sData = SessionManager.getUserData(request);
        if (sData != null) {
        	rtn = sData.getUserName();
        }
        return rtn;
    }
    
    public String getUserSabunId(HttpServletRequest request) {
        String rtn = "";
        SessionData sData = SessionManager.getUserData(request);
        if (sData != null) {
        	rtn = sData.getSabunId();
        }
        return rtn;
    }
    
    public void wedEnd(HttpServletRequest request, RtnVO rtn, ModelMap model) {
        model.addAttribute("rtn", rtn);
        if (log.isInfoEnabled()) {
            String userId = "";
            SessionData sData = SessionManager.getUserData(request);
            if (sData != null) {
                userId = sData.getUserId();
            }
            
            if (StrUtil.isNull(userId)) {
                userId = "No Seesion";
            }
            
            if (rtn.getRc() ==0) {
                rtn.setMsg(GlvConst.RC_SUCC_MSG);
                log.info("["+userId+":"+StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/")+"][END][RC:"+rtn.getRc()+"][MSG:"+rtn.getMsg()+"]");
            } else {
                log.info("["+userId+":"+StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/")+"][END][RC:"+rtn.getRc()+"][MSG:"+rtn.getMsg()
                        +"][CLASS:"+rtn.getExceptionClassName()
                        +"][METHOD:"+rtn.getExceptionMethodName()
                        +"][LINE:"+rtn.getExceptionLine()
                        +"][EXCEPTION MSG:"+rtn.getExceptionMsg()
                        +"]");
            }
        }
    }
    
    public void wedEnd(HttpServletRequest request, RtnVO rtn, ModelAndView mav) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("rtn", rtn);
        mav.addAllObjects(map);
        if (log.isInfoEnabled()) {
            String userId = "";
            SessionData sData = SessionManager.getUserData(request);
            if (sData != null) {
                userId = sData.getUserId();
            }
            
            if (StrUtil.isNull(userId)) {
                userId = "No Seesion";
            }
            
            if (rtn.getRc() ==0) {
                rtn.setMsg(GlvConst.RC_SUCC_MSG);
                log.info("["+userId+":"+StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/")+"][END][RC:"+rtn.getRc()+"][MSG:"+rtn.getMsg()+"]");
            } else {
                log.info("["+userId+":"+StrUtil.getLastAfterStr(request.getRequestURL().toString(),"/")+"][END][RC:"+rtn.getRc()+"][MSG:"+rtn.getMsg()
                        +"][CLASS:"+rtn.getExceptionClassName()
                        +"][METHOD:"+rtn.getExceptionMethodName()
                        +"][LINE:"+rtn.getExceptionLine()
                        +"][EXCEPTION MSG:"+rtn.getExceptionMsg()
                        +"]");
            }
        }
    }
}
