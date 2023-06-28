package org.rnt.dashboard.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.service.DashboardMenuService;
import org.rnt.dashboard.vo.DashboardProductionChartVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DashBoardController extends BaseController {
    
protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="dashboardMenuService")
    private DashboardMenuService dashboardMenuService;
    
    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    
    @RequestMapping(value = "/dashBoardAutoEquipPage.do")
    public String dashBoardAutoEquipPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd"), "yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        search.setLastDay(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd")));

        RtnVO rtn = productionOrderService.searchMonthList(search);
        
        wedEnd(request, rtn, model);
        return "/com/dashBoardAutoEquip";
    }
    
    
    @RequestMapping(value = "/dashBoardPage.do")
    public String dashBoardPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd"), "yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        search.setLastDay(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd")));

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        search.setPageSize(8);
        RtnVO rtn = productionOrderService.searchMonthList(search);
        
        RtnVO rtnTotCnt = dashboardMenuService.dashboardProductionChartTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        wedEnd(request, rtn, model);
        return "/com/dashBoard";
    }
    
    @RequestMapping(value = "/dashBoardMobilePage.do")
    public String dashBoardMobilePage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd"), "yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        search.setLastDay(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd")));

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        search.setPageSize(8);
        RtnVO rtn = productionOrderService.searchMonthList(search);
        
        RtnVO rtnTotCnt = dashboardMenuService.dashboardProductionChartTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        wedEnd(request, rtn, model);
        return "/com/dashBoardMobile";
    }
    
    @RequestMapping(value = "/getDashboardProductionMonthListData.do")
    public ModelAndView getDashboardProductionMonthListData(@ModelAttribute("search") ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd"), "yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        search.setLastDay(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd")));
        
        RtnVO rtn = productionOrderService.searchMonthList(search);
        
        if (rtn.getRc() == 0) {
            List<ProductionOrderVO> productionMonthList = (List<ProductionOrderVO>) rtn.getObj();
            model.addAttribute("productionMonthList", productionMonthList);
        }
        
        model.addAttribute("search", search);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getDashboardEquipData.do")
    public ModelAndView getDashboardEquipData(HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = dashboardMenuService.getDashboardEquipInfo();
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getDashboardAutoEquipData.do")
    public ModelAndView getDashboardAutoEquipData(HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = dashboardMenuService.getDashboardAutoEquipInfo();
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/dashboardProductionChartData.do")
    public ModelAndView dashboardProductionChartData(@ModelAttribute("search")DashboardProductionChartVO search,HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = dashboardMenuService.dashboardProductionChart(search);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/dashboardAutoEquipChartData.do")
    public ModelAndView dashboardAutoEquipChartData(@ModelAttribute("search")DashboardProductionChartVO search,HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = dashboardMenuService.dashboardAutoEquipChart(search);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getDashboardProductionActListData.do")
    public ModelAndView getDashboardProductionActListData(HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        
        RtnVO selProductWaitListRtn = dashboardMenuService.getDashboardProductionActWaitList();
        model.addAttribute("productActWaitList", selProductWaitListRtn.getObj());
        
        RtnVO selProductIngListRtn = dashboardMenuService.getDashboardProductionActIngList();
        model.addAttribute("productActIngList", selProductIngListRtn.getObj());
            
        wedEnd(request, new RtnVO(), mav);
        return mav;
    }
}