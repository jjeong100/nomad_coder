package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CompanyController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="companyService")
    private CompanyService companyService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/companyListPage.do")
    public String basicCompanyListPage(@ModelAttribute("search")CompanyVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = companyService.searchList(search);
        RtnVO rtnTotCnt = companyService.searchListTotCnt(search);
        
        log.info("getFactoryCd:"+proPertyService.getFactoryCd());
        
        if(log.isDebugEnabled()) {
            log.debug("getFactoryCd:"+proPertyService.getFactoryCd());
            log.debug("getPageIndex:"+search.getPageIndex());
            log.debug("getPageSize:"+search.getPageSize());
            log.debug("getPageUnit:"+search.getPageUnit());
            log.debug("getFirstIndex:"+search.getFirstIndex());
            log.debug("getLastIndex:"+search.getLastIndex());
            log.debug("getStartPage:"+search.getStartPage());
            log.debug("getEndPage:"+search.getEndPage());
        }
        
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/companyList";
    }
    
    @RequestMapping(value = "/companyDtlPage.do")
    public String companyDtlPage(@ModelAttribute("search")CompanyVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = companyService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new CompanyVO());
        }
        
        getCode("CUST_TYPE_CD",model);
        getCode("MAT_TYPE_CD",model);
        
        wedEnd(request, rtn, model);
        return "/basicinfo/companyDtl";
    }
    
    @RequestMapping(value = "/companySaveAct.do")
    public ModelAndView companySaveAct(@ModelAttribute("obj")CompanyVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
            rtn = companyService.select(obj);
            if(rtn.getObj() == null) {
                rtn = companyService.insert(obj);
            } else {
                CompanyVO company = (CompanyVO)rtn.getObj();
                if ("N".equals(company.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = companyService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
            }
        } else if ("U".equals(obj.getCrudType())) {
            rtn = companyService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = companyService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getPopCustList.do")
    public ModelAndView getItemListData(@ModelAttribute("search")CompanyVO param, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	 System.out.println(">>>> getPopCustList.do [custTypeCd] : "+request.getParameter("custTypeCd"));
    	String custTypeCd = request.getParameter("custTypeCd");
    	param.setCustTypeCd(custTypeCd);
    	
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = companyService.searchList(param);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
