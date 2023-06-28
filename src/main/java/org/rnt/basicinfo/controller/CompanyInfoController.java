package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CompanyInfoService;
import org.rnt.com.entity.vo.CompanyInfoVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CompanyInfoController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="companyInfoService")
    private CompanyInfoService companyInfoService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/companyInfoListPage.do")
    public String basicCompanyListPage(@ModelAttribute("search")CompanyInfoVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = companyInfoService.searchList(search);
        RtnVO rtnTotCnt = companyInfoService.searchListTotCnt(search);
        
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
        return "/basicinfo/companyInfoList";
    }
    
    @RequestMapping(value = "/companyInfoDtlPage.do")
    public String companyDtlPage(@ModelAttribute("search")CompanyInfoVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = companyInfoService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new CompanyInfoVO());
        }
        
        getCode("CUST_TYPE_CD",model);
        getCode("MAT_TYPE_CD",model);
        
        wedEnd(request, rtn, model);
        return "/basicinfo/companyInfoDtl";
    }
    
    @RequestMapping(value = "/companyInfoSaveAct.do")
    public ModelAndView companySaveAct(@ModelAttribute("obj")CompanyInfoVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
            rtn = companyInfoService.select(obj);
            if(rtn.getObj() == null) {
                rtn = companyInfoService.insert(obj);
            } else {
            	CompanyInfoVO company = (CompanyInfoVO)rtn.getObj();
                if ("N".equals(company.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = companyInfoService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
            }
        } else if ("U".equals(obj.getCrudType())) {
            rtn = companyInfoService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = companyInfoService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
}
