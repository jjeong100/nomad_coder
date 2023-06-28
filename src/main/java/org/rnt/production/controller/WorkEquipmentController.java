package org.rnt.production.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.EquipService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.ProductionActService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.service.WorkEquipmentService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.entity.vo.WorkEquipmentVO;
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
public class WorkEquipmentController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;
    
    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="productionActService")
    private ProductionActService productionActService;
    
    @Resource(name="workEquipmentService")
    private WorkEquipmentService workEquipmentService;
    
    @Resource(name="companyService")
    private CompanyService companyService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @Resource(name="equipService")
    private EquipService equipService;
    
    @RequestMapping(value = "/workEquipmentListPage.do")
    public String mobileWorkEquipmentListPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        search.setFactoryCd(proPertyService.getFactoryCd());
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        
        //---------------------------------------------------------------------
        // 장비
        //---------------------------------------------------------------------
        EquipVO equip = new EquipVO();
        RtnVO selEquipRtn = equipService.searchList(equip);
        if (selEquipRtn.getRc() == 0) {
            List<EquipVO> equipList = (List<EquipVO>)selEquipRtn.getObj();
            model.addAttribute("equip_list", equipList);
        }
        
        //---------------------------------------------------------------------
        // 제품
        //---------------------------------------------------------------------
        ProductVO product = new ProductVO();
        RtnVO selProductRtn = productService.searchList(product);
        if (selProductRtn.getRc() == 0) {
            List<ProductVO> productList = (List<ProductVO>)selProductRtn.getObj();
            model.addAttribute("product_list", productList);
        }
        
        
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("PO_CALLDT");    
            search.setSortType("DESC");
        }
        
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn       = productionOrderService.searchList(search);
        RtnVO rtnTotCnt = productionOrderService.searchListTotCnt(search);
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
            search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        getCode("PROD_TYPE_CD",model);
        
        wedEnd(request, rtn, model);
        return "/production/workEquipmentList";
    }
    
    @RequestMapping(value = "/getEquipListData.do")
    public ModelAndView getEquipListData(@ModelAttribute("equipment")WorkEquipmentVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        search.setFactoryCd(proPertyService.getFactoryCd());
        ModelAndView mav = new ModelAndView("jsonView");
        
        RtnVO rtn = new RtnVO();
         rtn = workEquipmentService.searchList(search);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/workEquipmentUpdateAct.do")
    public ModelAndView workEquipmentUpdateAct(@ModelAttribute("search")WorkEquipmentVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	
    	search.setFactoryCd(proPertyService.getFactoryCd());
    	ModelAndView mav = new ModelAndView("jsonView");
    	search.setWriteId(getUserId(request));
        search.setUpdateId(getUserId(request));
    	RtnVO rtn = new RtnVO();
    	rtn = workEquipmentService.insert(search);
    	
    	wedEnd(request, rtn, mav);
    	return mav;
    }
}
