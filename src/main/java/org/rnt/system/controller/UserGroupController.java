package org.rnt.system.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CodeService;
import org.rnt.com.entity.vo.CodeVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserGroupController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="codeService")
    private CodeService codeService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/userGroupListPage.do")
    public String userGroupListPage(@ModelAttribute("search")CodeVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        search.setBcode("LEVEL_CD");
        RtnVO rtn = codeService.searchList(search);
        RtnVO rtnTotCnt = codeService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/system/userGroupList";
    }
    
    @RequestMapping(value = "/userGroupDtlPage.do")
    public String userGroupDtlPage(@ModelAttribute("search")CodeVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        search.setBcode("LEVEL_CD");
        if ("R".equals(search.getCrudType())) {
            rtn = codeService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new CodeVO());
        }
        
        wedEnd(request, rtn, model);
        return "/system/userGroupDtl";
    }
    
    @RequestMapping(value = "/userGroupSaveAct.do")
    public ModelAndView userGroupSaveAct(@ModelAttribute("obj")CodeVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        obj.setBcode("LEVEL_CD");
        
        if ("C".equals(obj.getCrudType())) {
            obj.setSortOrder(9);
        	rtn = codeService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = codeService.insert(obj);
        	} else {
        	    CodeVO sel = (CodeVO)rtn.getObj();
        	    if ("N".equals(sel.getUseYn())) {
        	        obj.setUseYn("Y");
        	        rtn = codeService.update(obj);
        	    } else {
        	        rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
        	    }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = codeService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = codeService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
