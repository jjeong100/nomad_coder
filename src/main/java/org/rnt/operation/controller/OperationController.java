package org.rnt.operation.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.EquipService;
import org.rnt.com.entity.service.OperationService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.entity.vo.OperationVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OperationController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="operationService")
    private OperationService operationService;
    
    @Resource(name="companyService")
    private CompanyService companyService;
    
    @Resource(name="equipService")
    private EquipService equipService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/operationListPage.do")
    public String operationListPage(@ModelAttribute("search")OperationVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = operationService.searchList(search);
        RtnVO rtnTotCnt = operationService.searchListTotCnt(search);
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/operation/operationList";
    }
    
    @RequestMapping(value = "/operationDtlPage.do")
    public String operationDtlPage(@ModelAttribute("search")OperationVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = operationService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new OperationVO());
        }
        
        CompanyVO company = new CompanyVO();
        company.setCustTypeCd("OUT"); // 외주처
        RtnVO selCustCompanyRtn = companyService.searchList(company);
        if (selCustCompanyRtn.getRc() == 0) {
            List<CompanyVO> custCompanyList = (List<CompanyVO>)selCustCompanyRtn.getObj();
            model.addAttribute("out_cust_list", custCompanyList);
        }
        
        getCode("YN_CD",model);
        wedEnd(request, rtn, model);
        return "/operation/operationDtl";
    }
    
    @RequestMapping(value = "/operationSaveAct.do")
    public ModelAndView operationSaveAct(@ModelAttribute("obj")OperationVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = operationService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = operationService.insert(obj);
        	}else {
        	    OperationVO division = (OperationVO)rtn.getObj();
                if ("N".equals(division.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = operationService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = operationService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = operationService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
