package org.rnt.production.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.ProductionActService;
import org.rnt.com.entity.service.ProductionStatusService;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.entity.vo.ProductionStatusVO;
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
public class ProductionStatusController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="productionStatusService")
    private ProductionStatusService productionStatusService;
    
    @Resource(name="productionActService")
    private ProductionActService productionActService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/mobileProductionStatusListPage.do")
    public String productionOrderListPage(@ModelAttribute("search")ProductionActVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        // 진행중인 작업지시 조회
        search.setFactoryCd(proPertyService.getFactoryCd());
//        search.setOperCd("PRODUCTION");
//        search.setProdTypeCd("ING");
//        
        RtnVO rtnProductionAct = productionActService.select(search);
        ProductionActVO productionActVo = (ProductionActVO) rtnProductionAct.getObj();
        model.addAttribute("productionActVo", productionActVo);
        
        wedEnd(request, new RtnVO(), model);
        return "/mobile/mobileProductionStatusList";
    }
    
    @RequestMapping(value = "/mobileProductionStatusListData.do")
    public ModelAndView mobileMerterialInData(@ModelAttribute("search")ProductionActVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        
        ProductionStatusVO param = new ProductionStatusVO();
        param.setFactoryCd(proPertyService.getFactoryCd());
        param.setWorkDt(search.getWorkDt());
        param.setProdSeq(search.getProdSeq());
        
        RtnVO rtn = productionStatusService.searchList(param);
        wedEnd(request, rtn, mav);
        return mav;
    }
    @RequestMapping(value = "/mobileProductionStatusListData2.do")
    public ModelAndView mobileMerterialInData2(@ModelAttribute("search")ProductionActVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	ProductionStatusVO param = new ProductionStatusVO();
        param.setFactoryCd(proPertyService.getFactoryCd());
        param.setWorkDt(search.getWorkDt());
        param.setProdSeq(search.getProdSeq());
        
    	RtnVO rtn = productionStatusService.searchList2(param);
    	wedEnd(request, rtn, mav);
    	return mav;
    }
    
    @RequestMapping(value = "/mobileProductionStatusSaveAct.do")
    public ModelAndView productionOrderSaveAct(@ModelAttribute("obj")ProductionStatusVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
//        obj.setWriteId(getUserId(request));
//        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
        	rtn = productionStatusService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = productionStatusService.insert(obj);
        	}else {
        	    ProductionStatusVO order = (ProductionStatusVO)rtn.getObj();
//                if ("N".equals(order.getUseYn())) {
//                    obj.setUseYn("Y");
//                    rtn = productionStatusService.update(obj);
//                } else {
//                    rtn.setRc(GlvConst.RC_ERROR);
//                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
//                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = productionStatusService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            //rtn = productionStatusService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
