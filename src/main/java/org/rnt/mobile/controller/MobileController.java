package org.rnt.mobile.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.BoxService;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.EquipService;
import org.rnt.com.entity.service.FinishQmBadService;
import org.rnt.com.entity.service.FinishQmService;
import org.rnt.com.entity.service.InspRltService;
import org.rnt.com.entity.service.ItemInService;
import org.rnt.com.entity.service.ItemOutMstService;
import org.rnt.com.entity.service.MaterialInService;
import org.rnt.com.entity.service.MaterialService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.ProductionActService;
import org.rnt.com.entity.service.ProductionMstActService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.service.WorkerService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.entity.vo.FinishQmBadVO;
import org.rnt.com.entity.vo.FinishQmVO;
import org.rnt.com.entity.vo.InspRltVO;
import org.rnt.com.entity.vo.ItemInVO;
import org.rnt.com.entity.vo.ItemOutMstVO;
import org.rnt.com.entity.vo.MaterialInVO;
import org.rnt.com.entity.vo.MaterialOutVO;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.entity.vo.WorkerVO;
import org.rnt.com.file.service.ComFileService;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.session.SessionData;
import org.rnt.com.session.SessionManager;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.production.vo.ProductionComParamVO;
import org.rnt.summary.service.SummaryMenuService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MobileController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="summaryMenuService")
    private SummaryMenuService summaryMenuService;

    @Resource(name="materialInService")
    private MaterialInService materialInService;

    @Resource(name="finishQmService")
    private FinishQmService finishQmService;

    @Resource(name="finishQmBadService")
    private FinishQmBadService finishQmBadService;

    @Resource(name="workerService")
    private WorkerService workerService;

    @Resource(name="productionActService")
    private ProductionActService productionActService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @Resource(name = "inspRltService")
	private InspRltService inspRltService;

    @Resource(name="productService")
    private ProductService productService;

    @Resource(name="productionMstActService")
    private ProductionMstActService productionMstActService;

    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;

    @Resource(name="productionActService")
    private ProductionActService ProductionActService;

    @Resource(name="itemOutMstService")
    private ItemOutMstService itemOutMstService;

    @Resource(name="itemInService")
    private ItemInService itemInService;

    @Resource(name="companyService")
    private CompanyService companyService;

    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;

    @Resource(name="materialService")
    private MaterialService materialService;

    @Resource(name="comFileService")
    private ComFileService comFileService;

    @Resource(name="equipService")
    private EquipService equipService;

    @Resource(name="boxService")
    private BoxService boxService;

    @RequestMapping(value = "/mobileMenuPage.do")
    public String mobileMenuPage(HttpServletRequest request, ModelMap model)  throws Exception {
        webViewLog(request);


        SessionData sessionData = SessionManager.getUserData();
        model.addAttribute("userName", sessionData.getUserName());
        model.addAttribute("userId",   sessionData.getUserId());
        model.addAttribute("sabunId",  sessionData.getSabunId());
        model.addAttribute("roleId",   sessionData.getRoleId());

        WorkerVO search = new WorkerVO();
        search.setLoginId(sessionData.getUserId());
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = workerService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new WorkerVO());
        }

        wedEnd(request, rtn, model);
        return "/mobile/mobileMenu";
    }

    @RequestMapping(value = "/mobileMaterialInListPage.do")
    public String mobileMaterialInListPage(@ModelAttribute("search")MaterialInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("UPDATE_DT");
            search.setSortType("DESC");
        }
        search.setPageSize(8);
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = materialInService.searchList(search);
        RtnVO rtnTotCnt = materialInService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());

        CompanyVO company = new CompanyVO();
        company.setCustTypeCd("MAT"); // 자재처
        RtnVO selCompanyRtn = companyService.searchList(company);
        if (selCompanyRtn.getRc() == 0) {
            List<CompanyVO> companyList = (List<CompanyVO>)selCompanyRtn.getObj();
            model.addAttribute("mat_cust_list", companyList);
        }

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
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }

        getCode("BARCODE_PRINT", model);
        wedEnd(request, rtn, model);
        return "/mobile/mobileMaterialInList";
    }

    @RequestMapping(value = "/mobileMaterialInDtlPage.do")
    public String mobileMaterialInDtlPage(@ModelAttribute("search")MaterialInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	 webStart(request);
         RtnVO rtn = null;
         search.setFactoryCd(proPertyService.getFactoryCd());
         if ("R".equals(search.getCrudType())) {
             rtn = materialInService.select(search);
         } else {
             rtn = new RtnVO();
             MaterialInVO obj = new MaterialInVO();
             obj.setInDt(DateUtil.formatCurrent("yyyy/MM/dd"));
             rtn.setObj(obj);
         }

         CompanyVO company = new CompanyVO();
//         company.setCustTypeCd("MAT"); // 자재처
         RtnVO selCompanyRtn = companyService.searchList(company);
         if (selCompanyRtn.getRc() == 0) {
             List<CompanyVO> companyList = (List<CompanyVO>)selCompanyRtn.getObj();
             model.addAttribute("mat_cust_list", companyList);
         }

         StoreHouseVO storeHouse = new StoreHouseVO();
         storeHouse.setSearchAreaCd("MAT_HOUSE");
         RtnVO selStoreHouseRtn = storeHouseService.searchList(storeHouse);
         if (selStoreHouseRtn.getRc() == 0) {
             List<StoreHouseVO> storeHouseList = (List<StoreHouseVO>)selStoreHouseRtn.getObj();
             model.addAttribute("store_house_list", storeHouseList);
         }

         MaterialVO material = new MaterialVO();
         RtnVO selMaterialRtn = materialService.searchList(material);
         if (selMaterialRtn.getRc() == 0) {
             List<MaterialVO> materialList = (List<MaterialVO>)selMaterialRtn.getObj();
             model.addAttribute("material_list", materialList);
         }

         getCode("MAT_IN_TYPE_CD",model);
         getCode("UNIT_CD",model);

         wedEnd(request, rtn, model);
        return "/mobile/mobileMaterialInDtl";
    }

    @RequestMapping(value = "/mobileMaterialOutPage.do")
    public String mobileMaterialOutPage(@ModelAttribute("search")ProductionComParamVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        RtnVO rtn = new RtnVO();
        MaterialOutVO obj = new MaterialOutVO();
        obj.setOutDt(DateUtil.formatCurrent("yyyy/MM/dd"));
        rtn.setObj(obj);
        StoreHouseVO storeHouse = new StoreHouseVO();
        storeHouse.setSearchAreaCd("MAT_HOUSE");
        RtnVO selStoreHouseRtn = storeHouseService.searchList(storeHouse);
        if (selStoreHouseRtn.getRc() == 0) {
            List<StoreHouseVO> storeHouseList = (List<StoreHouseVO>)selStoreHouseRtn.getObj();
            model.addAttribute("store_house_list", storeHouseList);
        }

        wedEnd(request, rtn, model);
        return "/mobile/mobileMaterialOut";
    }

    @RequestMapping(value = "/mobileMaterialInData.do")
    public ModelAndView mobileMaterialInData(@ModelAttribute("search")MaterialInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        search.setFactoryCd(proPertyService.getFactoryCd());
        RtnVO rtn =materialInService.searchMobileList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }


    @RequestMapping(value = "/mobileProductionListPage.do")
    public String mobileProductionListPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("PO_ORD DESC, PO_CALLDT");
            search.setSortType("DESC");
        }
        search.setPageSize(8);
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        if (StrUtil.isNull(search.getSearchPoCalldt())) {
        	search.setSearchPoCalldt(search.getToDay());
        }
        RtnVO rtn = productionOrderService.searchList(search);
        RtnVO rtnTotCnt = productionOrderService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/mobile/mobileProductionList";
    }
    @RequestMapping(value = "/mobileProductionInspListPage.do")
	public String mobileProductionInspListPage(@ModelAttribute("search") ProductionComParamVO search, @ModelAttribute("searchInsp") InspRltVO searchInsp, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);

		searchInsp.setPaging(true);
		RtnVO rtn = inspRltService.searchList(searchInsp);
		RtnVO rtnTotCnt = inspRltService.searchListTotCnt(searchInsp);

		rtn.setTotCnt((Integer) rtnTotCnt.getObj());
		getCode("INSP_SME_CD", model);

		wedEnd(request, rtn, model);
		return "/mobile/mobileProductionInspList";
	}
    @RequestMapping(value = "/mobileProductionInspDtlPage.do")
	public String mobileProductionInspDtlPage(@ModelAttribute("search") ProductionComParamVO search, @ModelAttribute("searchInsp") InspRltVO searchInsp, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);
		RtnVO rtn = null;

		searchInsp.setFactoryCd(proPertyService.getFactoryCd());
		searchInsp.setWorkactSeq(search.getSearchWorkactSeq());
		searchInsp.setInspTypeCd(search.getSearchInspTypeCd());

		if( !"".equals(search.getSearchInspSmeCd()) ) {
			searchInsp.setInspSmeCd(search.getSearchInspSmeCd());
		}

        rtn = inspRltService.searchInspRsltList(searchInsp);

		getCode("INSP_SME_CD", model);

		wedEnd(request, rtn, model);
		return "/mobile/mobileProductionInspDtl";
	}


    @RequestMapping(value = "/mobileProductionWorkactPage.do")
    public String mobileProductionWorkactPage(@ModelAttribute("search") ProductionComParamVO prodComVo, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	RtnVO rtn = new RtnVO();

    	// 공정 마스터
    	ProductionMstActVO paramMstAct = new ProductionMstActVO();
    	paramMstAct.setFactoryCd(proPertyService.getFactoryCd());
    	paramMstAct.setWorkactMstSeq(prodComVo.getWorkactMstSeq());
    	RtnVO rtnMstVo = productionMstActService.select(paramMstAct);
    	model.addAttribute("productionMstActVo", rtnMstVo.getObj());

    	// 공정 실적 리스트
    	ProductionActVO paramAct = new ProductionActVO();
    	paramAct.setFactoryCd(proPertyService.getFactoryCd());
    	paramAct.setSearchProdSeq(prodComVo.getProdSeq());
    	paramAct.setSearchOperCd(prodComVo.getOperCd());
    	paramAct.setItemCd(prodComVo.getItemCd());
    	RtnVO rtnProductionActList = productionActService.searchList(paramAct);
    	model.addAttribute("productionActList", rtnProductionActList.getObj());

    	EquipVO equip = new EquipVO();
    	RtnVO selEquipRtn = equipService.searchList(equip);
        if (selEquipRtn.getRc() == 0) {
            List<EquipVO> equipList = (List<EquipVO>)selEquipRtn.getObj();
            model.addAttribute("equipList", equipList);
        }

    	getCode("BAD_CD",model);
    	getCode("PERFORMANCE_TYPE_CD",model);

    	wedEnd(request, rtn, model);
    	return "/mobile/mobileWorkact";
    }

    @RequestMapping(value = "/mobileFinishQmListPage.do")
    public String mobileFinishQmListPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        search.setPageSize(8);
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
        return "/mobile/mobileFinishQmList";
    }

    @RequestMapping(value = "/mobileFinishQmDtlPage.do")
    public String mobileFinishQmDtlPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        return "/mobile/mobileFinishQmDtl";
    }

    @RequestMapping(value = "/getMobileFinishQmListData.do")
   	public ModelAndView getMobileFinishQmListData(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model) throws Exception {
   		webStart(request);
   		ModelAndView mav = new ModelAndView("jsonView");
   		RtnVO rtn = finishQmService.getFinishQmListData(search);
   		RtnVO rtnTotCnt = finishQmService.getFinishQmListDataTotCnt(search);
   	    rtn.setTotCnt((Integer)rtnTotCnt.getObj());
    	wedEnd(request, rtn, mav);
    	return mav;
    }
    @RequestMapping(value = "/mobileItemInListPage.do")
    public String mobileItemInListPage(@ModelAttribute("search")FinishQmVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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

       /* if (StrUtil.isNull(search.getSearchFromPoCalldt())) {
        	search.setSearchFromPoCalldt(DateUtil.formatCurrent("yyyyMM")+"01");
        	search.setSearchToPoCalldt(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
        	search.setSearchFromPoCalldt(search.getSearchFromPoCalldt().replace("/", ""));
        	search.setSearchToPoCalldt(search.getSearchToPoCalldt().replace("/", ""));
        }*/


        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
        	search.setSortCol("PO_CALLDT");
    		search.setSortType("DESC");
        }
        search.setPageSize(8);
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

        getCode("BARCODE_PRINT", model);
        wedEnd(request, rtn, model);
        return "/mobile/mobileItemInList";
    }

    @RequestMapping(value = "/mobileItemInDtlPage.do")
    public String mobileItemInDtlPage(@ModelAttribute("search")ItemInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        return "/mobile/mobileItemInDtl";
    }

    @RequestMapping(value = "/getMobileItemInListData.do")
    public ModelAndView getMobileItemInListData(@ModelAttribute("search")ItemInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        search.setPageSize(8);
        search.setPaging(true);
        RtnVO rtn = itemInService.searchList(search);
        RtnVO rtnTotCnt = itemInService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, mav);
        return mav;
    }


    @RequestMapping(value = "/mobileItemOutListPage.do")
    public String itemOutListPage(@ModelAttribute("search")ItemOutMstVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("ITEMIN_DT");
            search.setSortType("DESC");
        }

        search.setPageSize(8);
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = itemOutMstService.searchItemInList(search);
        RtnVO rtnTotCnt = itemOutMstService.searchItemInListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());

        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }

        getCode("BARCODE_PRINT", model);
        wedEnd(request, rtn, model);
        return "/mobile/mobileItemOutList";
    }

    @RequestMapping(value = "/mobileItemOutDtlPage.do")
    public String mobileItemOutDtlPage(@ModelAttribute("search")ItemOutMstVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        RtnVO rtn = new RtnVO();

        search.setFactoryCd(proPertyService.getFactoryCd());
        search.setWriteId(getUserId(request));
        search.setUpdateId(getUserId(request));

        ItemInVO paramItemInVo = new ItemInVO();
        paramItemInVo.setFactoryCd(proPertyService.getFactoryCd());
        paramItemInVo.setLotid(search.getLotid());
        RtnVO rtnItemIn = itemInService.selectByLotId(paramItemInVo);
        model.addAttribute("itemInVo", rtnItemIn.getObj());

        if ("R".equals(search.getCrudType())) {
            rtn = itemOutMstService.select(search);
        } else {
        	ItemOutMstVO itemOutMstVo = new ItemOutMstVO();
        	itemOutMstVo.setItemoutDt(DateUtil.formatCurrent("yyyy/MM/dd"));
            rtn.setObj(itemOutMstVo);
        }

        CompanyVO company = new CompanyVO();
        company.setCustTypeCd("COD"); // 고객사
        RtnVO selCompanyRtn = companyService.searchList(company);
        if (selCompanyRtn.getRc() == 0) {
            List<CompanyVO> companyList = (List<CompanyVO>)selCompanyRtn.getObj();
            model.addAttribute("cust_list", companyList);
        }

        getCode("ITEM_OUT_TYPE_CD",model);
        wedEnd(request, rtn, model);
        return "/mobile/mobileItemOutDtl";
    }

    @RequestMapping(value = "/getMobileItemOutListData.do")
    public ModelAndView getMobileItemOutListData(@ModelAttribute("search")ItemOutMstVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        search.setPageSize(8);
        search.setPaging(true);
        rtn = itemOutMstService.searchItemOutList(search);
        RtnVO rtnTotCnt = itemOutMstService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, mav);
        return mav;
    }

}
