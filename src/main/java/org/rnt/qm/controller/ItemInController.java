package org.rnt.qm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.FinishQmService;
import org.rnt.com.entity.service.ItemInDtlService;
import org.rnt.com.entity.service.ItemInService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.FinishQmVO;
import org.rnt.com.entity.vo.ItemInDtlVO;
import org.rnt.com.entity.vo.ItemInVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.entity.vo.StoreHouseVO;
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
public class ItemInController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="finishQmService")
    private FinishQmService finishQmService;
    
    @Resource(name="itemInService")
    private ItemInService itemInService;
    
    @Resource(name="itemInDtlService")
    private ItemInDtlService itemInDtlService;
    
    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;
    
    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;
    
    @RequestMapping(value = "/itemInListPage.do")
    public String itemInListPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchType())) {
            search.setSearchType("NIN");
        }
        if (StrUtil.isNull(search.getSearchFromQmCheckdt())) {
        	search.setSearchFromQmCheckdt(DateUtil.formatCurrent("yyyyMM")+"01");
        	search.setSearchToQmCheckdt(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
        	search.setSearchFromQmCheckdt(search.getSearchFromQmCheckdt().replace("/", ""));
        	search.setSearchToQmCheckdt(search.getSearchToQmCheckdt().replace("/", ""));
        }
        
        if (StrUtil.isNull(search.getSearchFromPoCalldt())) {
        	search.setSearchFromPoCalldt(DateUtil.formatCurrent("yyyyMM")+"01");
        	search.setSearchToPoCalldt(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
        	search.setSearchFromPoCalldt(search.getSearchFromPoCalldt().replace("/", ""));
        	search.setSearchToPoCalldt(search.getSearchToPoCalldt().replace("/", ""));
        }
        
        
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
        	search.setSortCol("PO_CALLDT");    
    		search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        search.setSearchQmStateCd("QM_END");
        RtnVO rtn = finishQmService.searchList(search);
        RtnVO rtnTotCnt = finishQmService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromQmCheckdt())) {
        	search.setSearchFromQmCheckdt(DateUtil.formatDateAsSlashFormat(search.getSearchFromQmCheckdt()));
        	search.setSearchToQmCheckdt(DateUtil.formatDateAsSlashFormat(search.getSearchToQmCheckdt()));
        }
        if (!StrUtil.isNull(search.getSearchFromPoCalldt())) {
        	search.setSearchFromPoCalldt(DateUtil.formatDateAsSlashFormat(search.getSearchFromPoCalldt()));
        	search.setSearchToPoCalldt(DateUtil.formatDateAsSlashFormat(search.getSearchToPoCalldt()));
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
        
        getCode("BARCODE_PRINT", model);
        wedEnd(request, rtn, model);
        return "/qm/itemInList";
    }
    

    
    @RequestMapping(value = "/itemInDtlPage.do")
    public String itemInDtlPage(@ModelAttribute("search")ItemInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        
        ItemInVO paramVo = new ItemInVO();
        paramVo.setFactoryCd(proPertyService.getFactoryCd());
        paramVo.setProdSeq(search.getProdSeq());
        paramVo.setMqcSeq(search.getMqcSeq());
        paramVo.setIteminSeq(search.getIteminSeq());
        RtnVO prodOrderRtn = itemInService.selectProdOrderInfo(paramVo);
        
        ItemInVO selProductionOrderVo = (ItemInVO) prodOrderRtn.getObj();
        model.addAttribute("prodOrderVo", selProductionOrderVo);
        
        if ("R".equals(search.getCrudType())) {
            rtn = itemInService.select(search);
        } else {
            rtn = new RtnVO();
            ItemInVO obj = new ItemInVO();
            obj.setIteminDt(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setQmCheckdt(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setMatLotid(search.getMatLotid());
            rtn.setObj(obj);
        }
        
        StoreHouseVO storeHouse = new StoreHouseVO();
        storeHouse.setSearchAreaCd("PRODUCT_HOUSE");
        RtnVO selStoreHouseRtn = storeHouseService.searchList(storeHouse);
        if (selStoreHouseRtn.getRc() == 0) {
            List<StoreHouseVO> storeHouseList = (List<StoreHouseVO>)selStoreHouseRtn.getObj();
            model.addAttribute("store_house_list", storeHouseList);
        }
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        FinishQmVO param = new FinishQmVO();
        if (!StrUtil.isNull(param.getSearchFromQmCheckdt())) {
        	param.setSearchFromQmCheckdt(DateUtil.formatDateAsSlashFormat(param.getSearchFromQmCheckdt()));
        	param.setSearchToQmCheckdt(DateUtil.formatDateAsSlashFormat(param.getSearchToQmCheckdt()));
        }
        if (!StrUtil.isNull(param.getSearchFromPoCalldt())) {
        	param.setSearchFromPoCalldt(DateUtil.formatDateAsSlashFormat(param.getSearchFromPoCalldt()));
        	param.setSearchToPoCalldt(DateUtil.formatDateAsSlashFormat(param.getSearchToPoCalldt()));
        }
            param.setSearchType("NIN");
        wedEnd(request, rtn, model);
        return "/qm/itemInDtl";
    }
    
    @RequestMapping(value = "/itemInSaveAct.do")
    public ModelAndView itemInSaveAct(@ModelAttribute("obj")ItemInVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = itemInService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = itemInService.insert(obj);
        	}else {
        	    FinishQmVO division = (FinishQmVO)rtn.getObj();
                if ("N".equals(division.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = itemInService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = itemInService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = itemInService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getItemInDataByLotId.do")
    public ModelAndView getItemInDataByLotId(@ModelAttribute("search")ItemInVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        obj.setFactoryCd(proPertyService.getFactoryCd());
        rtn = itemInService.selectByLotId(obj);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getItemInListData.do")
    public ModelAndView getItemInListData(@ModelAttribute("search")ItemInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        rtn = itemInService.searchList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getItemInDtlListData.do")
    public ModelAndView getItemInDtlListData(@ModelAttribute("search")ItemInDtlVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	if (StrUtil.isNull(search.getSearchFromIteminDt())) {
    		search.setSearchFromIteminDt(DateUtil.formatCurrent("yyyyMM")+"01");
    		search.setSearchToIteminDt(DateUtil.formatCurrent("yyyyMMdd"));
    	} else {
    		search.setSearchFromIteminDt(search.getSearchFromIteminDt().replace("/", ""));
    		search.setSearchToIteminDt(search.getSearchToIteminDt().replace("/", ""));
    	}
    	ModelAndView mav = new ModelAndView("jsonView");
    	RtnVO rtn = new RtnVO();
    	rtn = itemInDtlService.searchList(search);
    	//---------------------------------------------------------------------
    	// 날짜 조회 조건  화면 format 변환
    	//---------------------------------------------------------------------
    	if (!StrUtil.isNull(search.getSearchFromIteminDt())) {
    		search.setSearchFromIteminDt(DateUtil.formatDateAsSlashFormat(search.getSearchFromIteminDt()));
    		search.setSearchToIteminDt(DateUtil.formatDateAsSlashFormat(search.getSearchToIteminDt()));
    	}
    	wedEnd(request, rtn, mav);
    	return mav;
    }
    
    @RequestMapping(value = "/getItemInDtlListData2.do")
    public ModelAndView getItemInDtlListData2(@ModelAttribute("search")ItemInDtlVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        rtn = itemInDtlService.searchList2(search);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/selectPopItemInList.do")
    public ModelAndView selectPopItemInList(@ModelAttribute("search")ItemInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromIteminDt())) {
        	search.setSearchFromIteminDt(DateUtil.formatCurrent("yyyy")+"0101");
        	search.setSearchToIteminDt(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
        	search.setSearchFromIteminDt(search.getSearchFromIteminDt().replace("/", ""));
        	search.setSearchToIteminDt(search.getSearchToIteminDt().replace("/", ""));
        }
        
        search.setFactoryCd(proPertyService.getFactoryCd());
        RtnVO rtn = itemInService.selectPopItemInList(search);
        List<ItemInVO> temp = (List<ItemInVO>) rtn.getObj();
        
        if( temp == null ) {
        	rtn.setTotCnt( 0 );
        } else {
        	rtn.setTotCnt( temp.size() );
        }
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromIteminDt())) {
        	search.setSearchFromIteminDt(DateUtil.formatDateAsSlashFormat(search.getSearchFromIteminDt()));
        	search.setSearchToIteminDt(DateUtil.formatDateAsSlashFormat(search.getSearchToIteminDt()));
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    @RequestMapping(value = "/getItemInDtlDataByLotId.do")
    public ModelAndView getItemInDtlDataByLotId(@ModelAttribute("search")ItemInDtlVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        //obj.setFactoryCd(proPertyService.getFactoryCd());
        rtn = itemInDtlService.selectByDtlLotId(obj);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
