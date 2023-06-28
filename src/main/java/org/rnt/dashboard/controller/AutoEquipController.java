package org.rnt.dashboard.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.service.AutoEquipMenuService;
import org.rnt.dashboard.vo.AutoEquipVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AutoEquipController extends BaseController {
    
protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="autoEquipMenuService")
    private AutoEquipMenuService autoEquipMenuService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/frontAutoEquipPage.do")
    public String frontAutoEquipPage(@ModelAttribute("search")AutoEquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchToDate())) {
            search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        search.setPageSize(5);
        if(search.getFirstIndex() == 0) search.setLastIndex(5);//최초 메뉴 조회시 리스트 사이즈 조정
        
        System.out.println("■■ search.getEndPage : "+search.getStartPage()+"|"+search.getEndPage()+"|"+search.getFirstIndex()+"|"+search.getLastIndex());
        RtnVO rtn = autoEquipMenuService.searchFrontAutoEquipList(search);
        RtnVO rtnTotCnt = autoEquipMenuService.searchFrontAutoEquipListTotCnt(search);

        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchToDate())) {
            search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }

        wedEnd(request, rtn, model);
        return "/com/frontAutoEquip";
    }
    
    @RequestMapping(value = "/rearAutoEquipPage.do")
    public String rearAutoEquipPage(@ModelAttribute("search")AutoEquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
      //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchToDate())) {
            search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        search.setPageSize(5);
        if(search.getFirstIndex() == 0) search.setLastIndex(5);//최초 메뉴 조회시 리스트 사이즈 조정
        
        RtnVO rtn = autoEquipMenuService.searchRearAutoEquipList(search);
        RtnVO rtnTotCnt = autoEquipMenuService.searchRearAutoEquipListTotCnt(search);

        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchToDate())) {
            search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        wedEnd(request, rtn, model);
        return "/com/rearAutoEquip";
    }
    
    @RequestMapping(value = "/getFrontAutoEquipSummaryData.do")
    public ModelAndView getFrontAutoEquipSummaryData(@ModelAttribute("search")AutoEquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = autoEquipMenuService.searchFrontAutoEquipSummary(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getFrontAutoEquipChartData.do")
    public ModelAndView getFrontAutoEquipChartData(@ModelAttribute("search")AutoEquipVO search,HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = autoEquipMenuService.searchFrontAutoEquipChart(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getRearAutoEquipSummaryData.do")
    public ModelAndView getRearAutoEquipSummaryData(@ModelAttribute("search")AutoEquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = autoEquipMenuService.searchRearAutoEquipSummary(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getRearAutoEquipChartData.do")
    public ModelAndView getRearAutoEquipChartData(@ModelAttribute("search")AutoEquipVO search,HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = autoEquipMenuService.searchRearAutoEquipChart(search);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getItemImageData.do")
    public ModelAndView getItemImageData(@ModelAttribute("search")AutoEquipVO search,HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = autoEquipMenuService.selectItemImage(search);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
}