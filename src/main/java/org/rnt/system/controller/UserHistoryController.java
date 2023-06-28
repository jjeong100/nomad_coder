package org.rnt.system.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.UserHistoryService;
import org.rnt.com.entity.vo.UserHistoryVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserHistoryController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="userHistoryService")
    private UserHistoryService userHistoryService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/userHistoryListPage.do")
    public String userHistoryListPage(@ModelAttribute("search")UserHistoryVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("WRITE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        search.setSearchLogTypeCd("L");
        RtnVO rtn = userHistoryService.searchList(search);
        RtnVO rtnTotCnt = userHistoryService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/system/userHistoryList";
    }
    
    @RequestMapping(value = "/createHistorySaveAct.do")
    public ModelAndView createHistorySaveAct(@ModelAttribute("obj")UserHistoryVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        obj.setSearchFromDate(obj.getSearchFromDate().replace("/", ""));
        obj.setSearchToDate(obj.getSearchToDate().replace("/", ""));
    	
        rtn = userHistoryService.createHistory(obj);
        
        if (rtn.getRc() == GlvConst.RC_ERROR) {
        	setRtnVO(rtn, "이력생성에 실패하였습니다.", rtn.getExceptionMsg());
		}
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getUserHistoryListExcelData.do")
    public ModelAndView getUserHistoryListExcelData(@ModelAttribute("search")UserHistoryVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
    	search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        
        RtnVO rtn = userHistoryService.selectListExcel(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
}
