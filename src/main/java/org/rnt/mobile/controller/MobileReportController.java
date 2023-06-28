package org.rnt.mobile.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.report.service.ReportService;
import org.rnt.report.vo.ReportDtlVO;
import org.rnt.report.vo.ReportEduVO;
import org.rnt.report.vo.ReportVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MobileReportController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="reportService")
    private ReportService reportService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/disinfectionPage.do")
    public String disinfectionPage(@ModelAttribute("search")ReportVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        
        search.setFactoryCd(proPertyService.getFactoryCd());
        search.setRptDivCd("PREVENT");
        
        if (StrUtil.isNull(search.getWriteYmd())) {
        	search.setWriteYmd(DateUtil.format2(DateUtil.formatCurrent("yyyyMMdd"), "yyyy.MM.dd"));
        }
        
        RtnVO rtn = reportService.select(search);
	    ReportVO reportVo = (ReportVO) rtn.getObj();
	        
	    if (reportVo != null) {
	        search.setRptSeq(reportVo.getRptSeq());
	        RtnVO rtnDtlVo = reportService.selectDtlList(search);
	        if (rtnDtlVo.getRc() == 0) {
	            List<ReportDtlVO> reportDtlList = (List<ReportDtlVO>)rtnDtlVo.getObj();
	            model.addAttribute("reportDtlList", reportDtlList);
	        }
        } else {
        	rtn.setObj(search);
        }
	    
        wedEnd(request, rtn, model);
        return "/mobile/report/disinfection";
    }
    
    @RequestMapping(value = "/disinfectionSaveAct.do")
    public ModelAndView disinfectionSaveAct(@ModelAttribute("obj") ReportVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
//        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
        	rtn = reportService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = reportService.insert(obj);
        		
        		List<ReportDtlVO> objList = (List<ReportDtlVO>) obj.getReportDtlList();
        		for (ReportDtlVO reportDtlVO : objList) {
        			reportDtlVO.setFactoryCd(proPertyService.getFactoryCd());
        			reportDtlVO.setRptSeq(obj.getRptSeq());
        			
        			reportService.insertDtl(reportDtlVO);
				}
        	} else {
        	    rtn = reportService.update(obj);
                
                List<ReportDtlVO> objList = (List<ReportDtlVO>) obj.getReportDtlList();
                
                // 삭제 후 저장
                reportService.deleteDtl(obj);
                
        		for (ReportDtlVO reportDtlVO : objList) {
        			reportDtlVO.setFactoryCd(proPertyService.getFactoryCd());
        			reportDtlVO.setRptSeq(obj.getRptSeq());
        			
        			reportService.insertDtl(reportDtlVO);
				}
        	}
        } else if ("D".equals(obj.getCrudType())) {
            rtn = reportService.delete(obj);
            reportService.deleteDtl(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/hygienicPage.do")
    public String hygienicPage(@ModelAttribute("search")ReportVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webViewLog(request);
    	
    	search.setFactoryCd(proPertyService.getFactoryCd());
        search.setRptDivCd("HYGIENIC");
        
        if (StrUtil.isNull(search.getWriteYmd())) {
        	search.setWriteYmd(DateUtil.format2(DateUtil.formatCurrent("yyyyMMdd"), "yyyy.MM.dd"));
        }
        
        RtnVO rtn = reportService.select(search);
	    ReportVO reportVo = (ReportVO) rtn.getObj();
	        
	    if (reportVo != null) {
	        search.setRptSeq(reportVo.getRptSeq());
	        RtnVO rtnDtlVo = reportService.selectDtlList(search);
	        if (rtnDtlVo.getRc() == 0) {
	            List<ReportDtlVO> reportDtlList = (List<ReportDtlVO>)rtnDtlVo.getObj();
	            model.addAttribute("reportDtlList", reportDtlList);
	        }
        } else {
        	rtn.setObj(search);
        }
	    
	    model.addAttribute("ondo2", reportService.selectPlc("ONDO2"));
	    model.addAttribute("ondo3", reportService.selectPlc("ONDO3"));
	    
	    wedEnd(request, rtn, model);
    	return "/mobile/report/hygienic";
    }
    
    @RequestMapping(value = "/hygienicSaveAct.do")
    public ModelAndView hygienicSaveAct(@ModelAttribute("obj") ReportVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
//        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
        	rtn = reportService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = reportService.insert(obj);
        		
        		List<ReportDtlVO> objList = (List<ReportDtlVO>) obj.getReportDtlList();
        		for (ReportDtlVO reportDtlVO : objList) {
        			reportDtlVO.setFactoryCd(proPertyService.getFactoryCd());
        			reportDtlVO.setRptSeq(obj.getRptSeq());
        			
        			reportService.insertDtl(reportDtlVO);
				}
        	} else {
        	    rtn = reportService.update(obj);
                
                List<ReportDtlVO> objList = (List<ReportDtlVO>) obj.getReportDtlList();
                
                // 삭제 후 저장
                reportService.deleteDtl(obj);
                
        		for (ReportDtlVO reportDtlVO : objList) {
        			reportDtlVO.setFactoryCd(proPertyService.getFactoryCd());
        			reportDtlVO.setRptSeq(obj.getRptSeq());
        			
        			reportService.insertDtl(reportDtlVO);
				}
        	}
        } else if ("D".equals(obj.getCrudType())) {
            rtn = reportService.delete(obj);
            reportService.deleteDtl(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/equipmentPage.do")
    public String equipmentPage(@ModelAttribute("search")ReportVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webViewLog(request);
    	
    	search.setFactoryCd(proPertyService.getFactoryCd());
        search.setRptDivCd("EQUIPMENT");
        
        if (StrUtil.isNull(search.getWriteYmd())) {
        	search.setWriteYmd(DateUtil.format2(DateUtil.formatCurrent("yyyyMMdd"), "yyyy.MM.dd"));
        }
        
        RtnVO rtn = reportService.select(search);
	    ReportVO reportVo = (ReportVO) rtn.getObj();
	        
	    if (reportVo != null) {
	        search.setRptSeq(reportVo.getRptSeq());
	        RtnVO rtnDtlVo = reportService.selectDtlList(search);
	        if (rtnDtlVo.getRc() == 0) {
	            List<ReportDtlVO> reportDtlList = (List<ReportDtlVO>)rtnDtlVo.getObj();
	            model.addAttribute("reportDtlList", reportDtlList);
	        }
        } else {
        	rtn.setObj(search);
        }
	    
    	wedEnd(request, rtn, model);
    	return "/mobile/report/equipment";
    }
    
    @RequestMapping(value = "/equipmentSaveAct.do")
    public ModelAndView equipmentSaveAct(@ModelAttribute("obj") ReportVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
//        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
        	rtn = reportService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = reportService.insert(obj);
        		
        		List<ReportDtlVO> objList = (List<ReportDtlVO>) obj.getReportDtlList();
        		for (ReportDtlVO reportDtlVO : objList) {
        			reportDtlVO.setFactoryCd(proPertyService.getFactoryCd());
        			reportDtlVO.setRptSeq(obj.getRptSeq());
        			
        			reportService.insertDtl(reportDtlVO);
				}
        	} else {
        	    rtn = reportService.update(obj);
                
                List<ReportDtlVO> objList = (List<ReportDtlVO>) obj.getReportDtlList();
                
                // 삭제 후 저장
                reportService.deleteDtl(obj);
                
        		for (ReportDtlVO reportDtlVO : objList) {
        			reportDtlVO.setFactoryCd(proPertyService.getFactoryCd());
        			reportDtlVO.setRptSeq(obj.getRptSeq());
        			
        			reportService.insertDtl(reportDtlVO);
				}
        	}
        } else if ("D".equals(obj.getCrudType())) {
            rtn = reportService.delete(obj);
            reportService.deleteDtl(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/educationPage.do")
    public String educationPage(@ModelAttribute("search")ReportEduVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webViewLog(request);
    	
    	search.setFactoryCd(proPertyService.getFactoryCd());
        search.setRptDivCd("EDUCATION");
        
        if (StrUtil.isNull(search.getWriteYmd())) {
        	search.setWriteYmd(DateUtil.format2(DateUtil.formatCurrent("yyyyMMdd"), "yyyy.MM.dd"));
        }
        
        RtnVO rtn = reportService.select(search);
	    ReportVO reportVo = (ReportVO) rtn.getObj();
	       
	    if (reportVo != null) {
	        search.setRptSeq(reportVo.getRptSeq());
	        RtnVO rtnEduVo = reportService.selectEdu(search);
	        if (rtnEduVo.getRc() == 0) {
	            ReportEduVO reportEduVo = (ReportEduVO) rtnEduVo.getObj();
	            model.addAttribute("reportEduVo", reportEduVo);
	        }
        } else {
        	rtn.setObj(search);
        }
	    
    	wedEnd(request, rtn, model);
    	return "/mobile/report/education";
    }
    
    @RequestMapping(value = "/educationSaveAct.do")
    public ModelAndView educationSaveAct(@ModelAttribute("obj") ReportEduVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
//        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
        	rtn = reportService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = reportService.insert(obj);
        		reportService.insertEdu(obj);
        	} else {
        	    rtn = reportService.update(obj);
        	    reportService.updateEdu(obj);
        	}
        } else if ("D".equals(obj.getCrudType())) {
            rtn = reportService.deleteEdu(obj);
            reportService.deleteEdu(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
