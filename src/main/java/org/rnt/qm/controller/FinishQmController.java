package org.rnt.qm.controller;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.FinishQmBadService;
import org.rnt.com.entity.service.FinishQmService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.FinishQmBadVO;
import org.rnt.com.entity.vo.FinishQmVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
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
public class FinishQmController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="finishQmService")
    private FinishQmService finishQmService;
    
    @Resource(name="finishQmBadService")
    private FinishQmBadService finishQmBadService;
    
    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;
    
    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;
    
    @RequestMapping(value = "/finishQmListPage.do")
    public String finishQmListPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
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
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("PO_CALLDT"); 
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = finishQmService.searchJoinList(search);
        RtnVO rtnTotCnt = finishQmService.searchJoinListTotCnt(search);
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/qm/finishQmList";
    }
    
    @RequestMapping(value = "/QmCheckListPage.do")
    public String QmCheckListPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromQmCheckdt())) {
        	search.setSearchFromQmCheckdt(DateUtil.formatCurrent("yyyyMM")+"01");
        	search.setSearchToQmCheckdt(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
        	search.setSearchFromQmCheckdt(search.getSearchFromQmCheckdt().replace("/", ""));
        	search.setSearchToQmCheckdt(search.getSearchToQmCheckdt().replace("/", ""));
        }
        
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
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
        
        ProductVO product = new ProductVO();
        RtnVO selProductRtn = productService.searchList(product);
        if (selProductRtn.getRc() == 0) {
            List<ProductVO> productList = (List<ProductVO>)selProductRtn.getObj();
            model.addAttribute("product_list", productList);
        }
        
        wedEnd(request, rtn, model);
        return "/qm/QmCheckList";
    }
    
    @RequestMapping(value = "/QmWhInListPage.do")
    public String QmWhInListPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = finishQmService.searchList(search);
        RtnVO rtnTotCnt = finishQmService.searchListTotCnt(search);
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/qm/qmWhInist";
    }
    
    @RequestMapping(value = "/finishQmDtlPage.do")
    public String finishQmDtlPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        
        ProductionOrderVO ProductionOrderVo = new ProductionOrderVO();
        ProductionOrderVo.setFactoryCd(proPertyService.getFactoryCd());
        ProductionOrderVo.setProdSeq(search.getProdSeq());
        ProductionOrderVo.setWorkactSeq(search.getWorkactSeq());
        RtnVO prodOrderRtn = productionOrderService.selectQmInfo(ProductionOrderVo);
        
        ProductionOrderVO selProductionOrderVo = (ProductionOrderVO) prodOrderRtn.getObj();
        model.addAttribute("prodOrderVo", selProductionOrderVo);
        
        if ("R".equals(search.getCrudType())) {
            rtn = finishQmService.select(search);
        } else {
            rtn = new RtnVO();
            FinishQmVO obj = new FinishQmVO();
            obj.setQmCheckdt(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setActbadQty(0D);
            obj.setQmCheckid(getUserSabunId(request));
            obj.setQmCheckNm(getUserNm(request));
            rtn.setObj(obj);
        }
        
        FinishQmBadVO qmBadVo = new FinishQmBadVO();
        qmBadVo.setFactoryCd(proPertyService.getFactoryCd());
        qmBadVo.setMqcSeq(search.getMqcSeq());
        RtnVO rtnFinishQmBad = finishQmBadService.selectList(qmBadVo);
        model.addAttribute("finishQmBadList", rtnFinishQmBad.getObj());
        
        getCode("QM_STATE_CD",model);
        getCode("BAD_CD",model);
        
        wedEnd(request, rtn, model);
        return "/qm/finishQmDtl";
    }
    
    @RequestMapping(value = "/finishQmSaveAct.do")
    public ModelAndView finishQmSaveAct(@ModelAttribute("search")FinishQmVO search, @ModelAttribute("obj") FinishQmVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = finishQmService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = finishQmService.insert(obj);
        	}else {
        	    FinishQmVO division = (FinishQmVO)rtn.getObj();
                if ("N".equals(division.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = finishQmService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = finishQmService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = finishQmService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        
        List<FinishQmBadVO> objList = (List<FinishQmBadVO>) obj.getObjList();
        
        if( objList != null ) {
	        for (Iterator iterator = objList.iterator(); iterator.hasNext();) {
	        	FinishQmBadVO dtlVO = (FinishQmBadVO) iterator.next();
	        	dtlVO.setFactoryCd(proPertyService.getFactoryCd());
	        	dtlVO.setWriteId(getUserId(request));
	        	dtlVO.setUpdateId(getUserId(request));
	        	dtlVO.setMqcSeq(obj.getMqcSeq());
	        	
	        	if( StringUtils.isEmpty(dtlVO.getBadQty()) ) {
	        		continue;
	        	}
	        	
	        	if( StringUtils.isEmpty(dtlVO.getMqcBadSeq()) ) {
	        		finishQmBadService.insert(dtlVO);
	        	} else {
	        		if ("D".equals(obj.getCrudType())) {
	        			finishQmBadService.delete(dtlVO);
	        		} else {
	        			finishQmBadService.update(dtlVO);
	        		}
	        	}
			}
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getFinishQmListData.do") 
   	public ModelAndView getFinishQmListData(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model) throws Exception {
   		webStart(request); 
   		ModelAndView mav = new ModelAndView("jsonView"); 
   		RtnVO rtn = finishQmService.getFinishQmListData(search); 
    	wedEnd(request, rtn, mav); 
    	return mav;
    }
    
    @RequestMapping(value = "/getFinishQmBadListData.do") 
    public ModelAndView getFinishQmBadListData(@ModelAttribute("search")FinishQmBadVO search, HttpServletRequest request, ModelMap model) throws Exception {
    	webStart(request); 
    	ModelAndView mav = new ModelAndView("jsonView");
    	search.setFactoryCd(proPertyService.getFactoryCd());
    	RtnVO rtn = finishQmBadService.selectList(search);
    	wedEnd(request, rtn, mav); 
    	return mav;
    }
    
    @RequestMapping(value = "/delFinishQmBad.do")
    public ModelAndView delFinishQmBad(@ModelAttribute("obj")FinishQmBadVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        rtn = finishQmBadService.delete(obj);
        
        if(rtn.getRc() == GlvConst.RC_SUCC) {
        	rtn = finishQmBadService.updateActbadQty(obj);
        }
        
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
