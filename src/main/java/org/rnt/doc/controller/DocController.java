package org.rnt.doc.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.FileUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.doc.service.DocService;
import org.rnt.doc.vo.DocVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DocController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="docService")
    private DocService docService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @Resource(name = "fileUtil")
    FileUtil fileUtil;
    
    
    @RequestMapping(value = "/inFileListPage.do")
    public String inFileListPage(@ModelAttribute("search")DocVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리 : 시작일 매월 1일, 종료일 오늘 날짜 
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
        	search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
        	search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
        	search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("WRITE_DT");
            search.setSortType("DESC");
        }
        search.setPaging(true);
        search.setSearchDocTypeCd("IN");
        
        RtnVO rtn = docService.searchDocList(search);
        RtnVO rtnTotCnt = docService.searchDocListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/doc/inFileList";
    }
    
    @RequestMapping(value = "/gjFileListPage.do")
    public String gjFileListPage(@ModelAttribute("search")DocVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	//---------------------------------------------------------------------
    	// 날짜 조회 초기 값 처리 : 시작일 매월 1일, 종료일 오늘 날짜 
    	//---------------------------------------------------------------------
    	if (StrUtil.isNull(search.getSearchFromDate())) {
    		search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
    		search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
    	} else {
    		search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
    		search.setSearchToDate(search.getSearchToDate().replace("/", ""));
    	}
    	
    	//---------------------------------------------------------------------
    	// paging set
    	//---------------------------------------------------------------------
    	if (StrUtil.isNull(search.getSortCol())) {
    		search.setSortCol("WRITE_DT");
    		search.setSortType("DESC");
    	}
    	search.setPaging(true); 
    	search.setSearchDocTypeCd("GJ");
    	
    	RtnVO rtn = docService.searchDocList(search);
        RtnVO rtnTotCnt = docService.searchDocListTotCnt(search);
    	rtn.setTotCnt((Integer)rtnTotCnt.getObj());
    	
    	//---------------------------------------------------------------------
    	// 날짜 조회 조건  화면 format 변환
    	//---------------------------------------------------------------------
    	if (!StrUtil.isNull(search.getSearchFromDate())) {
    		search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
    		search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
    	}
    	
    	wedEnd(request, rtn, model);
    	return "/doc/gjFileList";
    }
    
    @RequestMapping(value = "/outFileListPage.do")
    public String outFileListPage(@ModelAttribute("search")DocVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	//---------------------------------------------------------------------
    	// 날짜 조회 초기 값 처리 : 시작일 매월 1일, 종료일 오늘 날짜 
    	//---------------------------------------------------------------------
    	if (StrUtil.isNull(search.getSearchFromDate())) {
    		search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
    		search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
    	} else {
    		search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
    		search.setSearchToDate(search.getSearchToDate().replace("/", ""));
    	}
    	
    	//---------------------------------------------------------------------
    	// paging set
    	//---------------------------------------------------------------------
    	if (StrUtil.isNull(search.getSortCol())) {
    		search.setSortCol("WRITE_DT");
    		search.setSortType("DESC");
    	}
    	search.setPaging(true); 
    	search.setSearchDocTypeCd("OUT");
    	
    	RtnVO rtn = docService.searchDocList(search);
        RtnVO rtnTotCnt = docService.searchDocListTotCnt(search);
    	rtn.setTotCnt((Integer)rtnTotCnt.getObj());
    	
    	//---------------------------------------------------------------------
    	// 날짜 조회 조건  화면 format 변환
    	//---------------------------------------------------------------------
    	if (!StrUtil.isNull(search.getSearchFromDate())) {
    		search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
    		search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
    	}
    	
    	wedEnd(request, rtn, model);
    	return "/doc/outFileList";
    }
    
    @RequestMapping(value = "/docSaveAct.do")
   	public ModelAndView docSaveAct(@ModelAttribute("obj")DocVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
            log.debug("getDocTypeCd:"+obj.getDocTypeCd());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
			rtn = docService.insert(obj);
		} else if ("D".equals(obj.getCrudType())) {
			rtn = docService.delete(obj);
		} else {
			rtn.setRc(GlvConst.RC_ERROR);
			rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
		}
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
