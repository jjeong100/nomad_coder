package org.rnt.com.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.entity.service.WorkerService;
import org.rnt.com.entity.vo.WorkerVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PopController extends BaseController {
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="workerService")
    private WorkerService workerService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value="/popWorkerList.do")
    public ModelAndView popWorkerList(@ModelAttribute("searchPopWorker")WorkerVO search, HttpServletRequest request, HttpServletResponse response) throws Exception{
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        search.setFactoryCd(proPertyService.getFactoryCd());
//        search.setPaging(true);
        RtnVO rtn = workerService.searchList(search);
        RtnVO rtnTotCnt = workerService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, mav);
        return mav;
    }
}
