package org.rnt.statics.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.vo.RtnVO;
import org.rnt.statics.service.StaticsMenuService;
import org.rnt.statics.vo.DeliveryStaticsInVO;
import org.rnt.statics.vo.EquipStaticsInVO;
import org.rnt.statics.vo.QualityStaticsInVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StaticsController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="staticsMenuService")
    private StaticsMenuService staticsMenuService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/equipStaticsPage.do")
    public String equipStaticsPage(@ModelAttribute("search")EquipStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
//        webViewLog(request);
        webStart(request);
        RtnVO rtn = new RtnVO();
        
//        search.setPaging(true);
        search.setPageSize(12);
        RtnVO rtnTotCnt = staticsMenuService.searchEquipStaticsListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        wedEnd(request, rtn, model);
        return "/statics/equipStatics";
    }
    
    @RequestMapping(value = "/searchEquipStaticsListData.do")
    public ModelAndView searchEquipStaticsList(@ModelAttribute("search")EquipStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        
        search.setPaging(true);
        RtnVO rtn = staticsMenuService.searchEquipStaticsList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/selectEquipTotStaticsData.do")
    public ModelAndView selectEquipTotStaticsData(@ModelAttribute("search")EquipStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = staticsMenuService.selectEquipTotStatics(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/qualityStaticsPage.do")
    public String qualityStaticsPage(@ModelAttribute("search")QualityStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        return "/statics/qualityStatics";
    }
    
    @RequestMapping(value = "/searchQualityStaticsListData.do")
    public ModelAndView searchQualityStaticsList(@ModelAttribute("search")QualityStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = staticsMenuService.searchQualityStaticsList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/selectQualityTotStaticsData.do")
    public ModelAndView selectQualityTotStaticsData(@ModelAttribute("search")QualityStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = staticsMenuService.selectQualityTotStatics(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/deliveryStaticsPage.do")
    public String deliveryStaticsPage(@ModelAttribute("search")DeliveryStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        return "/statics/deliveryStatics";
    }
    
    @RequestMapping(value = "/searchDeliveryStaticsListData.do")
    public ModelAndView searchQualityStaticsList(@ModelAttribute("search")DeliveryStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = staticsMenuService.searchDeliveryStaticsList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/selectDeliveryTotStaticsData.do")
    public ModelAndView selectDeliveryTotStaticsData(@ModelAttribute("search")DeliveryStaticsInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = staticsMenuService.selectDeliveryTotStatics(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    
}
