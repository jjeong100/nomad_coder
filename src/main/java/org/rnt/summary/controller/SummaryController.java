package org.rnt.summary.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.OperationService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.vo.OperationVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.summary.service.SummaryMenuService;
import org.rnt.summary.vo.AssignSumVO;
import org.rnt.summary.vo.EquipSumInVO;
import org.rnt.summary.vo.FailureSumVO;
import org.rnt.summary.vo.ItemSumVO;
import org.rnt.summary.vo.LotTrackingItemOutVO;
import org.rnt.summary.vo.LotTrackingItemVO;
import org.rnt.summary.vo.LotTrackingMatVO;
import org.rnt.summary.vo.LotTrackingVO;
import org.rnt.summary.vo.LotTrackingWorkSumVO;
import org.rnt.summary.vo.OperSumVO;
import org.rnt.summary.vo.ProductionSumVO;
import org.rnt.summary.vo.SafetyStockVO;
import org.rnt.summary.vo.WorkOrderBySumVO;
import org.rnt.summary.vo.WorkerMonthSumVO;
import org.rnt.summary.vo.WorkerSumInVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SummaryController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="summaryMenuService")
    private SummaryMenuService summaryMenuService;
    
    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="operationService")
    private OperationService operationService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/produceSumListPage.do")
    public String produceSumListPage(@ModelAttribute("search")ItemSumVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        RtnVO rtn = summaryMenuService.searchItemSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchItemSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
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
        
        wedEnd(request, rtn, model);
        return "/summary/produceSumList";
    }
    
    @RequestMapping(value = "/equipSumListPage.do")
    public String equipSumListPage(@ModelAttribute("search")EquipSumInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("EQUIP_CD");
            search.setSortType("ASC");
        }
        search.setPaging(true); 
        RtnVO rtn = summaryMenuService.searchEquipSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchEquipSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/summary/equipSumList";
    }
    
    @RequestMapping(value = "/equipMonthSumListPage.do")
    public String equipMonthSumListPage(@ModelAttribute("search")EquipSumInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리 : 시작일 매월 1일, 종료일 오늘 날짜 
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
            search.setSortCol("EQUIP_CD");
            search.setSortType("ASC");
        }
        search.setPaging(true); 
        RtnVO rtn = summaryMenuService.searchEquipMonthSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchEquipMonthSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatMonthAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatMonthAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/summary/equipMonthSumList";
    }
    
    @RequestMapping(value = "/workerSumListPage.do")
    public String workerSumListPage(@ModelAttribute("search")WorkerSumInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("YMD");
            search.setSortType("DESC");
        }
        search.setPaging(true); 
        RtnVO rtn = summaryMenuService.searchWorkerSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchWorkerSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/summary/workerSumList";
    }
    
    @RequestMapping(value = "/productionSumListPage.do")
    public String productionSumListPage(@ModelAttribute("search")ProductionSumVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        RtnVO rtn = summaryMenuService.searchProductionSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchProductionSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
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
        
        wedEnd(request, rtn, model);
        return "/summary/productionSumList";
    }
    
    @RequestMapping(value = "/workerMonthSumListPage.do")
    public String workerMonthSumListPage(@ModelAttribute("search")WorkerMonthSumVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	
    	//---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리 : 시작일 매월 1일, 종료일 오늘 날짜 
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
    		search.setSortCol("YM");    
    		search.setSortType("DESC");
    	}
    	search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
    	RtnVO rtn = summaryMenuService.searchMonthSumList(search);
    	RtnVO rtnTotCnt = summaryMenuService.searchMonthSumListTotCnt(search);
    	rtn.setTotCnt((Integer)rtnTotCnt.getObj());
    	
    	//---------------------------------------------------------------------
    	// 날짜 조회 조건  화면 format 변환
    	//---------------------------------------------------------------------
    	if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatMonthAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatMonthAsSlashFormat(search.getSearchToDate()));
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
    	
    	wedEnd(request, rtn, model);
    	return "/summary/workerMonthSumList";
    }
    
    @RequestMapping(value = "/lotTrackingListPage.do")
    public String lotTrackingListPage(@ModelAttribute("search")LotTrackingVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	
    	//---------------------------------------------------------------------
    	// 날짜 조회 초기 값 처리 : 시작일 매월 1일, 종료일 오늘 날짜 
    	//---------------------------------------------------------------------
    	if (StrUtil.isNull(search.getSearchFromDate())) {
    		search.setSearchFromDate(DateUtil.formatCurrent("yyyy")+"01");
    		search.setSearchToDate(DateUtil.formatCurrent("yyyyMM"));
    	} else {
    		search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
    		search.setSearchToDate(search.getSearchToDate().replace("/", ""));
    	}
    	
    	if( search.getSearchLotId() != null ) {
	    	String[] tokens = search.getSearchLotId().split("-");
			
	    	if( tokens.length > 1 ) {
	    		search.setLotDiv(tokens[1]);
	    	}
    	}
    	
    	//---------------------------------------------------------------------
    	// 제품정보
    	//---------------------------------------------------------------------
        RtnVO selItemListRtn = summaryMenuService.searchLotTrackingItemList(search);
        if (selItemListRtn.getRc() == 0) {
            List<LotTrackingItemVO> itemList = (List<LotTrackingItemVO>)selItemListRtn.getObj();
            model.addAttribute("item_list", itemList);
        }
        
        //---------------------------------------------------------------------
    	// 자재정보
    	//---------------------------------------------------------------------
        RtnVO selMatListRtn = summaryMenuService.searchLotTrackingMatList(search);
        if (selMatListRtn.getRc() == 0) {
            List<LotTrackingMatVO> itemList = (List<LotTrackingMatVO>)selMatListRtn.getObj();
            model.addAttribute("mat_list", itemList);
        }
        
        //---------------------------------------------------------------------
        // 공정실적정보
        //---------------------------------------------------------------------
        RtnVO selWorkSumListRtn = summaryMenuService.searchLotTrackingWorkSumList(search);
        if (selWorkSumListRtn.getRc() == 0) {
        	List<LotTrackingWorkSumVO> itemList = (List<LotTrackingWorkSumVO>)selWorkSumListRtn.getObj();
        	model.addAttribute("workSum_list", itemList);
        }
        
        //---------------------------------------------------------------------
        // 출하정보
        //---------------------------------------------------------------------
        RtnVO selItemOutListRtn = summaryMenuService.searchLotTrackingItemOutList(search);
        if (selItemOutListRtn.getRc() == 0) {
        	List<LotTrackingItemOutVO> itemList = (List<LotTrackingItemOutVO>)selItemOutListRtn.getObj();
        	model.addAttribute("itemOut_list", itemList);
        }
        
        
    	//---------------------------------------------------------------------
    	// 날짜 조회 조건  화면 format 변환
    	//---------------------------------------------------------------------
    	if (!StrUtil.isNull(search.getSearchFromDate())) {
    		search.setSearchFromDate(DateUtil.formatMonthAsSlashFormat(search.getSearchFromDate()));
    		search.setSearchToDate(DateUtil.formatMonthAsSlashFormat(search.getSearchToDate()));
    	}
    	
//    	wedEnd(request, rtn, model);
    	return "/summary/lotTrackingList";
    }
    
    @RequestMapping(value = "/safetyStockListPage.do")
    public String safetyStockListPage(@ModelAttribute("search")SafetyStockVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("SAFE_STOCK_QTY >= TOT_QTY");
            search.setSortType("DESC");
        }
        search.setPaging(true); 
        RtnVO rtn = summaryMenuService.searchSafetyStockList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchSafetyStockListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/summary/safetyStockList";
    }
    
    /**
     * 신규 작업 20220401
     * 
     * 생산실적 현황
     */
    @RequestMapping(value = "/workOrderBySumListPage.do")
    public String workOrderBySumListPage(@ModelAttribute("search")WorkOrderBySumVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        RtnVO rtn = summaryMenuService.searchWorkOrderBySumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchWorkOrderBySumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
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
        
        wedEnd(request, rtn, model);
        return "/summary/workOrderBySumList";
    }
    
    @RequestMapping(value = "/operSumListPage.do")
    public String operSumListPage(@ModelAttribute("search")OperSumVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        RtnVO rtn = summaryMenuService.searchOperSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchOperSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
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
        // 공정
        //---------------------------------------------------------------------
        OperationVO operationVO = new OperationVO();
        RtnVO selOperationRtn = operationService.searchList(operationVO);
        if (selOperationRtn.getRc() == 0) {
            List<OperationVO> operationList = (List<OperationVO>)selOperationRtn.getObj();
            model.addAttribute("oper_list", operationList);
        }
//        
        
        wedEnd(request, rtn, model);
        return "/summary/operSumList";
    }
    
    @RequestMapping(value = "/failureSumListPage.do")
    public String failureSumListPage(@ModelAttribute("search")FailureSumVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        RtnVO rtn = summaryMenuService.searchFailureSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchFailureSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
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
        
        wedEnd(request, rtn, model);
        return "/summary/failureSumList";
    }
    
    @RequestMapping(value = "/assignSumListPage.do")
    public String assignSumListPage(@ModelAttribute("search")AssignSumVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        RtnVO rtn = summaryMenuService.searchAssignSumList(search);
        RtnVO rtnTotCnt = summaryMenuService.searchAssignSumListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
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
        
        wedEnd(request, rtn, model);
        return "/summary/assignSumList";
    }
}
