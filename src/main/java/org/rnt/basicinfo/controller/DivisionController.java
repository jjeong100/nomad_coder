package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.DivisionService;
import org.rnt.com.entity.vo.DivisionVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DivisionController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="divisionService")
    private DivisionService divisionService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/divisionListPage.do")
    public String divisionListPage(@ModelAttribute("search")DivisionVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = divisionService.searchList(search);
        RtnVO rtnTotCnt = divisionService.searchListTotCnt(search);
        
        
        if(log.isDebugEnabled()) {
            log.debug("getFactoryCd:"+proPertyService.getFactoryCd());
            log.debug("getPageIndex:"+search.getPageIndex());
            log.debug("getPageSize:"+search.getPageSize());
            log.debug("getPageUnit:"+search.getPageUnit());
            log.debug("getFirstIndex:"+search.getFirstIndex());
            log.debug("getLastIndex:"+search.getLastIndex());
            log.debug("getStartPage:"+search.getStartPage());
            log.debug("getEndPage:"+search.getEndPage());
        }
        
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/divisionList";
    }
    
    @RequestMapping(value = "/divisionDtlPage.do")
    public String divisionDtlPage(@ModelAttribute("search")DivisionVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = divisionService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new DivisionVO());
        }
        
        wedEnd(request, rtn, model);
        return "/basicinfo/divisionDtl";
    }
    
    @RequestMapping(value = "/divisionSaveAct.do")
    public ModelAndView divisionSaveAct(@ModelAttribute("obj")DivisionVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = divisionService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = divisionService.insert(obj);
        	}else {
        	    DivisionVO division = (DivisionVO)rtn.getObj();
                if ("N".equals(division.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = divisionService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = divisionService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = divisionService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
