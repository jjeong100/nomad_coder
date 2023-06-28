package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.TranSpecService;
import org.rnt.com.entity.vo.TranSpecVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TranSpecController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="tranSpecService")
    private TranSpecService tranSpecService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/getTranSpecCompanyData.do")
    public ModelAndView getTranSpecCompanyData(@ModelAttribute("obj")TranSpecVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        ModelAndView mav = new ModelAndView("jsonView");
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        if(obj.getBusinNo() == null || "".equals(obj.getBusinNo().trim())) obj.setBusinNo(proPertyService.getBusinNo());
        
        RtnVO rtn = tranSpecService.selectCompany(obj);
        wedEnd(request, rtn, mav);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
