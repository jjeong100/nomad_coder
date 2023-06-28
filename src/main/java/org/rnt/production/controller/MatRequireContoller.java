package org.rnt.production.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.MatRequireService;
import org.rnt.com.entity.vo.MatRequireVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MatRequireContoller extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="matRequireService")
    private MatRequireService matRequireService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/matRequireSaveAct.do")
    public ModelAndView matRequireSaveAct(MatRequireVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	RtnVO rtn = new RtnVO();
    	
    	if(log.isDebugEnabled()) {
    		log.debug("getCrudType:"+obj.getCrudType());
    	}
    	
    	if ("U".equals(obj.getCrudType())) {
    		for(MatRequireVO item : obj.getObjList()) {
    			item.setFactoryCd(proPertyService.getFactoryCd());
    			item.setWriteId(getUserId(request));
    			item.setUpdateId(getUserId(request));
    			
    			rtn = matRequireService.update(item);
    		}
    	} else {
    		rtn.setRc(GlvConst.RC_ERROR);
    		rtn.setMsg("알수없는 저장 타입 :" + obj.getCrudType());
    	}
    	
    	wedEnd(request, rtn, mav);
    	return mav;
    }
    
    @RequestMapping(value = "/searchRequireMatListData.do")
    public ModelAndView searchRequireMatListData(MatRequireVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	RtnVO rtn = matRequireService.searchRequireMatList(search);
    	wedEnd(request, rtn, mav);
    	return mav;
    }
    
    @RequestMapping(value = "/searchMatRequireListData.do")
    public ModelAndView searchMatRequireListData(MatRequireVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	RtnVO rtn = new RtnVO();
        rtn = matRequireService.searchMatRequireList(search);
    	wedEnd(request, rtn, mav);
    	return mav;
    }
    
    @RequestMapping(value = "/searchRequireMatListByProdSeqData.do")
    public ModelAndView searchRequireMatListByProdSeq(MatRequireVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = matRequireService.searchRequireMatListByChildProdSeq(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
}
