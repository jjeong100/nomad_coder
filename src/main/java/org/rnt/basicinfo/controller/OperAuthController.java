package org.rnt.basicinfo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.OperAuthDtlService;
import org.rnt.com.entity.service.OperAuthService;
import org.rnt.com.entity.vo.OperAuthVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OperAuthController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="operAuthService")
    private OperAuthService operAuthService;
    
    @Resource(name="operAuthDtlService")
    private OperAuthDtlService operAuthDtlService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/operAuthListPage.do")
    public String operAuthListPage(@ModelAttribute("search")OperAuthVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("SORT_ORD");    
            search.setSortType("ASC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = operAuthService.searchList(search);
        RtnVO rtnTotCnt = operAuthService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/operAuthList";
    }
    
    @RequestMapping(value = "/operAuthSaveAct.do")
    public ModelAndView operAuthSaveAct(@ModelAttribute("operAuth")OperAuthVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = operAuthService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = operAuthService.insert(obj);
        	} else {
        	    OperAuthVO operAuth = (OperAuthVO)rtn.getObj();
        	    if ("N".equals(operAuth.getUseYn())) {
        	        obj.setUseYn("Y");
        	        rtn = operAuthService.update(obj);
        	    } else {
        	        rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
        	    }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = operAuthService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
        	
        	RtnVO rtnWorkerCnt = operAuthService.selectWorkerCnt(obj);
        	
            int workCnt = (Integer)rtnWorkerCnt.getObj();
            
            if( workCnt > 0 ) {
	            rtn.setRc(GlvConst.RC_ERROR);
	            rtn.setMsg("해당 권한 사용자가 존재합니다.");
            } else {
            	rtn = operAuthService.delete(obj);
            }
            
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getOperAuthDtlListData.do")
    public ModelAndView getOperAuthDtlListData(@ModelAttribute("search")OperAuthVO param, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = operAuthDtlService.searchList(param);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/operAuthDtlSaveAct.do")
    public ModelAndView operAuthDtlSaveAct(@ModelAttribute("obj") OperAuthVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        operAuthDtlService.delete(obj);
        
        List<OperAuthVO> objList = (List<OperAuthVO>) obj.getOperAuthDtlList();
		for (OperAuthVO operAuthVO : objList) {
			operAuthVO.setFactoryCd(proPertyService.getFactoryCd());
			operAuthVO.setWriteId(getUserId(request));
			operAuthVO.setUpdateId(getUserId(request));
			
			operAuthVO.setOperAuthCd(obj.getOperAuthCd());
			
			if( "Y".equals(operAuthVO.getOperChkYn()) ) {
				operAuthDtlService.insert(operAuthVO);
			}
		}
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
