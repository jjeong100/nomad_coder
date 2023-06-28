package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.WorkGroupService;
import org.rnt.com.entity.vo.WorkGroupVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WorkGroupController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="workGroupService")
    private WorkGroupService workGroupService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/workGroupListPage.do")
    public String workGroupListPage(@ModelAttribute("search")WorkGroupVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = workGroupService.searchList(search);
        RtnVO rtnTotCnt = workGroupService.searchListTotCnt(search);
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/workGroupList";
    }
    
    @RequestMapping(value = "/workGroupDtlPage.do")
    public String workGroupDtlPage(@ModelAttribute("search")WorkGroupVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = workGroupService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new WorkGroupVO());
        }
        wedEnd(request, rtn, model);
        return "/basicinfo/workGroupDtl";
    }
    
    @RequestMapping(value = "/workGroupSaveAct.do")
    public ModelAndView workGroupSaveAct(@ModelAttribute("obj")WorkGroupVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = workGroupService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = workGroupService.insert(obj);
        	}else {
        	    WorkGroupVO workGroup = (WorkGroupVO)rtn.getObj();
                if ("N".equals(workGroup.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = workGroupService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = workGroupService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = workGroupService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
