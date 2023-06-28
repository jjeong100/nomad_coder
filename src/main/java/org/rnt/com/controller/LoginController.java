package org.rnt.com.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.entity.service.MenuService;
import org.rnt.com.entity.service.UserHistoryService;
import org.rnt.com.entity.service.WorkerService;
import org.rnt.com.entity.vo.MenuVO;
import org.rnt.com.entity.vo.UserHistoryVO;
import org.rnt.com.entity.vo.WorkerVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.session.SessionData;
import org.rnt.com.session.SessionManager;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController extends BaseController {
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="workerService")
    private WorkerService workerService;
    
    @Resource(name="userHistoryService")
    private UserHistoryService userHistoryService;
    
    @Resource(name="menuService")
    private MenuService menuService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/loginPage.do")
    public String loginPage(HttpServletRequest request,@ModelAttribute("userVo")WorkerVO userVo, ModelMap model)  throws Exception {
        webViewLog(request);
        return "/com/login";
    }
    
    
    @RequestMapping(value = "/loginAct.do")
    public String loginAct(HttpServletRequest req, HttpSession session, @ModelAttribute("userVo")WorkerVO userVo, ModelMap model)  throws Exception {
        webStart(req);
        RtnVO rtn = null;
        try {             
            ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
            String encodedPassword = encoder.encodePassword(userVo.getPassCd(), null);
            
            userVo.setFactoryCd(proPertyService.getFactoryCd());
            rtn = workerService.select(userVo);
//            rtn = qcadoosecurityUserService.select(userVo);
            
            if (rtn.getRc() == GlvConst.RC_SUCC) {
                WorkerVO selUserVo = (WorkerVO)rtn.getObj();
                if (selUserVo == null) {
                    //-----------------------------------------------------------------
                    // 사용자 미존재
                    //-----------------------------------------------------------------
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("아이디 또는 패스워드를 확인 하세요.");
                    wedEnd(req, rtn, model);
                    return "forward:/loginPage.do";
                } else if (!encodedPassword.equals(selUserVo.getPassCd())) {
                    //-----------------------------------------------------------------
                    // 사용자 패스워드 틀림
                    //-----------------------------------------------------------------
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("패스워드 또는 아이디를 확인 하세요.");
                    wedEnd(req, rtn, model);
                    return "forward:/loginPage.do";
                } else {
                    //-----------------------------------------------------------------
                    // 접속 성공 >> 최종 접속 정보 변경
                    //-----------------------------------------------------------------
                    //selUserVo.setTrycount(0);
                    //qcadoosecurityUserService.update(selUserVo);
                    
                    UserHistoryVO his = new UserHistoryVO();
                    his.setFactoryCd(proPertyService.getFactoryCd());
                    his.setLoginId(selUserVo.getLoginId());
                    his.setLogTypeCd("L");
                    his.setLoginIp(getClientIp(req));
                    his.setPageUrl("loginAct.do");
                    userHistoryService.insert(his);
                    
                    //-----------------------------------------------------------------
                    // 세션 데이터 저장
                    //-----------------------------------------------------------------
                    SessionData sessionData = new SessionData();
                    sessionData.setPosition(selUserVo.getJikCd());
                    sessionData.setRoleId(selUserVo.getLevelCd());
                    sessionData.setRoleName(null);
                    sessionData.setUserName(selUserVo.getLoginName());
                    sessionData.setUserId(selUserVo.getLoginId());
                    sessionData.setShortId(selUserVo.getShortId());
                    sessionData.setSabunId(selUserVo.getSabunId());
                    sessionData.setMobileYn(userVo.getMobileYn());
                    sessionData.setWorkCd(selUserVo.getWorkCd());
                    SessionManager.setUserData(sessionData);
                    
                    //-----------------------------------------------------------------
                    // login success !! && set session data !!
                    //-----------------------------------------------------------------
                    // 모바일인 경우
                    if ("Y".equals(userVo.getMobileYn())) {
                    	return "forward:" + proPertyService.getMobileHomeUrl();
                    } else {
                    	return "redirect:/mainAct.do";
                    }
                }
            } 
        } catch (Exception e) {
            setRtnVO(rtn, "사용자 로그인 체크 오류", e.getMessage());
        }
        wedEnd(req, rtn, model);
        return "forward:/loginPage.do";
    }
    
    @RequestMapping(value="/logoutAct.do")
    public String logoutAct(HttpServletRequest request, ModelMap model) throws Exception {
        SessionManager.removeSessionAttribute(request, SessionData.SESSION_DATA_KEY);
        SessionManager.removeSessionAttribute(request, "MY_MENU_LIST");
        SessionManager.removeSessionAttribute(request, "MY_TOP_MENU_ID");
        return "redirect:/loginPage.do";
    }
    
    @RequestMapping(value = "/mainAct.do")
    public String mainAct(HttpServletRequest request, ModelMap model)  throws Exception {
        String main_page = "/companyListPage.do";
        String myTopMenuNm = "기준정보";
        SessionData sessionData = SessionManager.getUserData();
        if (log.isDebugEnabled()) {
            log.debug("home url :"+proPertyService.getHomeUrl());
        }
        
//        if ("MOBILE".equals(sessionData.getRoleId())) {
//            return "forward:" + proPertyService.getMobileHomeUrl();
//        }
        
        if (!StrUtil.isNull(proPertyService.getHomeUrl())) {
            main_page = proPertyService.getHomeUrl();
        }
        
        MenuVO param = new MenuVO();
        param.setLevelCd(sessionData.getRoleId());
        RtnVO rtn = menuService.searchList(param);
        if (rtn.getRc() == GlvConst.RC_SUCC) {
            List<MenuVO> menuList = (List<MenuVO>)rtn.getObj();
            String myTopMenuId = null;
           
            String myMenuNm = null;
            for(int i=0; i<menuList.size(); i++) {
                MenuVO mm = menuList.get(i);
                if (main_page.equals(mm.getPageUrl()) && mm.getMenuLvl() == 2) {
                    myTopMenuId = mm.getUpMenuId();
                    myMenuNm = mm.getMenuNm();
                }
            }
            
            if (log.isDebugEnabled()) {
                log.debug("myTopMenuId :"+myTopMenuId);
            }
            SessionManager.setSessionAttribute(request, "MY_MENU_LIST", menuList);
            SessionManager.setSessionAttribute(request, "MY_TOP_MENU_ID", myTopMenuId);
            SessionManager.setSessionAttribute(request, "MY_TOP_MENU_NM", myTopMenuNm);
            SessionManager.setSessionAttribute(request, "MY_MENU_NM", myMenuNm);
        } else {
            SessionManager.setSessionAttribute(request, "MY_MENU_LIST", null);
            SessionManager.setSessionAttribute(request, "MY_TOP_MENU_ID", null);
            SessionManager.setSessionAttribute(request, "MY_TOP_MENU_NM", null);
            SessionManager.setSessionAttribute(request, "MY_MENU_NM", null);
        }
        //-----------------------------------------------------------------
        // 사용자  권한에 따른 메뉴 정보를 세션에 저장
        //-----------------------------------------------------------------
        
        return "forward:" + main_page;
    }
    
    @RequestMapping(value = "/goTopMenuPage.do")
    public String goTopMenuPage(@ModelAttribute("menuInfoVO") MenuVO menuInfoVO, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        SessionManager.setSessionAttribute(request, "MY_TOP_MENU_ID", menuInfoVO.getMenuId());
        SessionManager.setSessionAttribute(request, "MY_TOP_MENU_NM", menuInfoVO.getMenuTopNm());
        SessionManager.setSessionAttribute(request, "MY_MENU_NM", menuInfoVO.getMenuNm());
        if (log.isDebugEnabled()) {
            log.debug("myTopMenuId :"+menuInfoVO.getMenuId());
        }
        if (log.isDebugEnabled()) {
            log.debug("go url:"+menuInfoVO.getPageUrl());
        }
        return "redirect:"+menuInfoVO.getPageUrl();
    }
}
