package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.NotNullToStringStyle;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CalanderService;
import org.rnt.com.entity.vo.CalanderVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CalanderController extends BaseController {
    
protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="calanderService")
    private CalanderService calanderService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/calanderListPage.do")
    public String calanderListPage(@ModelAttribute("search")CalanderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchToDate())) {
            search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = calanderService.searchList(search);
        RtnVO rtnTotCnt = calanderService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchToDate())) {
            search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        wedEnd(request, rtn, model);
        return "/basicinfo/calanderList";
    }
    
    @RequestMapping(value = "/calanderDtlPage.do")
    public String calanderDtlPage(@ModelAttribute("search")CalanderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = calanderService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new CalanderVO());
        }
        
        wedEnd(request, rtn, model);
        return "/basicinfo/calanderDtl";
    }

    @RequestMapping(value = "/getCalendarListData.do")
    public ModelAndView getCalendarListData(@ModelAttribute("obj")CalanderVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        obj.setSearchFromDate(obj.getSearchFromDate().replace("/", ""));
         rtn = calanderService.searchList(obj);
        
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/calanderSaveAct.do")
    public ModelAndView calanderSaveAct(@ModelAttribute("obj")CalanderVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
//        #사용
        log.debug("■ "+Thread.currentThread().getStackTrace()[1].getMethodName()+" ■■■■ Parameter \r\n"+ToStringBuilder.reflectionToString(obj,NotNullToStringStyle.NOT_NULL_STYLE));
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        obj.setYyymmdd(obj.getSearchToDate().replace("/", ""));
        obj.setBigo(obj.getContent());
        
        rtn = calanderService.select(obj);
    	if(rtn.getObj() == null) {
    		rtn = calanderService.insert(obj);
    	} else {
    		rtn = calanderService.update(obj);
    	}
        
        
//        if ("C".equals(obj.getCrudType())) {
//        	rtn = calanderService.select(obj);
//        	if(rtn.getObj() == null) {
//        		rtn = calanderService.insert(obj);
//        	} else {
//        		  rtn = calanderService.update(obj);
        		  
//        	    CalanderVO cal = (CalanderVO)rtn.getObj();
//        	    if ("N".equals(cal.getUseYn())) {
//        	        obj.setUseYn("Y");
//        	        rtn = calanderService.update(obj);
//        	    } else {
//        	        rtn.setRc(GlvConst.RC_ERROR);
//                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
//        	    }
//        	}
//        } else if ("U".equals(obj.getCrudType())) {
//            rtn = calanderService.update(obj);
//        } else if ("D".equals(obj.getCrudType())) {
//            rtn = calanderService.delete(obj);
//        } else {
//            rtn.setRc(GlvConst.RC_ERROR);
//            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
//        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
