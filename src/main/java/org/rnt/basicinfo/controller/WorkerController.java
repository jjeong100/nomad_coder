package org.rnt.basicinfo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.DivisionService;
import org.rnt.com.entity.service.WorkGroupService;
import org.rnt.com.entity.service.WorkerService;
import org.rnt.com.entity.vo.DivisionVO;
import org.rnt.com.entity.vo.WorkGroupVO;
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
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WorkerController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="workerService")
    private WorkerService workerService;
    
    @Resource(name="divisionService")
    private DivisionService divisionService;
    
    @Resource(name="workGroupService")
    private WorkGroupService workGroupService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/workerListPage.do")
    public String workerListPage(@ModelAttribute("search")WorkerVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        SessionData sessionData = SessionManager.getUserData();
        search.setLevelCd(sessionData.getRoleId());
        search.setSabunId(sessionData.getSabunId());
        
        model.addAttribute("roleId",   sessionData.getRoleId());
        
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = workerService.searchList(search);
        RtnVO rtnTotCnt = workerService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/workerList";
    }
    
    @RequestMapping(value = "/workerDtlPage.do")
    public String workerDtlPage(@ModelAttribute("search")WorkerVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        SessionData sessionData = SessionManager.getUserData();
        search.setLevelCd(sessionData.getRoleId());
        search.setSabunId(sessionData.getSabunId());
        
        model.addAttribute("roleId",   sessionData.getRoleId());
        
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = workerService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new WorkerVO());
        }
        
        getCode("JIK_CD",model);
        getCode("JIKCHAEK_CD",model);
        getCode("LEVEL_CD",model);
        
        DivisionVO division = new DivisionVO();
        RtnVO selDevisionRtn = divisionService.searchList(division);
        if (selDevisionRtn.getRc() == 0) {
            List<DivisionVO> divisionList = (List<DivisionVO>)selDevisionRtn.getObj();
            model.addAttribute("division_list", divisionList);
        }
        
        WorkGroupVO workGroup = new WorkGroupVO();
        RtnVO selWorkGroupRtn = workGroupService.searchList(workGroup);
        if (selWorkGroupRtn.getRc() == 0) {
            List<WorkGroupVO> workGroupList = (List<WorkGroupVO>)selWorkGroupRtn.getObj();
            model.addAttribute("work_group_list", workGroupList);
        }
        
        wedEnd(request, rtn, model);
        return "/basicinfo/workerDtl";
    }
    
    @RequestMapping(value = "/workerSaveAct.do")
    public ModelAndView workerSaveAct(@ModelAttribute("obj")WorkerVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
        	rtn = workerService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = workerService.insert(obj);
        	} else {
        	    WorkerVO worker = (WorkerVO)rtn.getObj();
        	    if ("N".equals(worker.getUseYn())) {
        	        obj.setUseYn("Y");
        	        rtn = workerService.update(obj);
        	    } else {
        	        rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
        	    }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = workerService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = workerService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getLoginNameByShortId.do")
    public ModelAndView getLoginNameByShortId(@ModelAttribute("worker")WorkerVO worker, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	worker.setFactoryCd(proPertyService.getFactoryCd());
        RtnVO rtn = workerService.selectByShortId(worker);
        if (rtn.getObj() == null) {
        	rtn.setRc(GlvConst.RC_ERROR);
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    /**
     * 20201111
     * jeonghwan 
     * 
     * 사용자 페스워드 변경
     * @param search
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/workerPassWordSaveAct.do")
    public ModelAndView workerPassWordSaveAct(@ModelAttribute("obj")WorkerVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        String passWord   = obj.getPassCd();
        String inPassWord = obj.getInPassWord();
        String newPassWord = obj.getNewPassWord();
        
        if(encoder.isPasswordValid(passWord, inPassWord, null)) {
             String encodedPassword = encoder.encodePassword(newPassWord, null);
             
             obj.setFactoryCd(proPertyService.getFactoryCd());
             obj.setWriteId(getUserId(request));
             obj.setUpdateId(getUserId(request));
             obj.setPassCd(encodedPassword);
             
             if("U".equals(obj.getCrudType())) {
                 rtn = workerService.update(obj);
             }else {
                 rtn.setRc(GlvConst.RC_ERROR);
                 rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
             }
        }else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("이전비밀번호가 일치하지 않습니다.");
        }
       
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    /**
     * 20210201
     * jeonghwan 
     * 
     * 사용자 페스워드 초기화
     * @param search
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/workerResetPassWord.do")
    public ModelAndView workerResetPassWord(@ModelAttribute("obj")WorkerVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
         
        //rntime8630
        obj.setPassCd("47499edbb7f7b44de59ba91c5a1ea4f27d4cf5c2b0436a66d11a52c7d4998f74");
         
        if("U".equals(obj.getCrudType())) {
            rtn = workerService.resetPassWord(obj);
        }else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
       
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    /**
     * 
     * @return
     */
    @RequestMapping(value = "/getPopUserList.do")
    public ModelAndView getPopUserList(@ModelAttribute("search")WorkerVO param, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = workerService.searchList(param);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
