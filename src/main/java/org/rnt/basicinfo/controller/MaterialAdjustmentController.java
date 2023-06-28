package org.rnt.basicinfo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.MaterialAdjustmentService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.MaterialAdjustmentVO;
import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.service.MaterialMenuService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MaterialAdjustmentController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="materialMenuService")
    private MaterialMenuService materialMenuService;
    
    @Resource(name="materialAdjustmentService")
    private MaterialAdjustmentService materialAdjustmentService;
    
    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
   
    @SuppressWarnings("unchecked")
	@RequestMapping(value = "/materialAdjustmentListPage.do")
    public String materialAdjustmentListPage(@ModelAttribute("search")MaterialAdjustmentVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜(월) 조회 초기 값 처리 : 시작일 내년 1월, 종료월 당월 
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatCurrent("yyyy")+"01");
        	search.setSearchToDate(DateUtil.formatCurrent("yyyyMM"));
        } else {
        	search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
        	search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }

        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); 
        RtnVO rtn = materialAdjustmentService.searchList(search);
        RtnVO rtnTotCnt = materialAdjustmentService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 창고 조회 조건 처리 select box  
        //---------------------------------------------------------------------
        StoreHouseVO storeHouse = new StoreHouseVO();
        storeHouse.setSearchAreaCd("MAT_HOUSE");
        RtnVO selStoreHouseRtn = storeHouseService.searchList(storeHouse);
        if (selStoreHouseRtn.getRc() == 0) {
            List<StoreHouseVO> storeHouseList = (List<StoreHouseVO>)selStoreHouseRtn.getObj();
            model.addAttribute("store_house_list", storeHouseList);
        }
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatMonthAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatMonthAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/material/materialAdjustmentList";
    }
    
    /**
     * 자재 조정 입고, 출고
     * @param obj
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateMaterialAdjustment.do")
    public ModelAndView assignmentCreateAct(@ModelAttribute("obj")MaterialAdjustmentVO param, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+param.getCrudType());
        }
        
        param.setFactoryCd(proPertyService.getFactoryCd());
        param.setWriteId(getUserId(request));
        param.setUpdateId(getUserId(request));

        materialAdjustmentService.updateMaterialIn(param);
        materialAdjustmentService.updateMaterialOut(param);
        
        wedEnd(request, rtn, mav);
        return mav;
    }
}
