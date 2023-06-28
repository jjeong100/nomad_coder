package org.rnt.material.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.ItemOutMstService;
import org.rnt.com.entity.service.MaterialOutService;
import org.rnt.com.entity.service.MaterialService;
import org.rnt.com.entity.service.ProductionMstActService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.ItemOutMstVO;
import org.rnt.com.entity.vo.MaterialOutVO;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.service.MaterialMenuService;
import org.rnt.material.vo.MonthCloseInVO;
import org.rnt.production.vo.ProductionComParamVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MaterialOutController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="materialOutService")
    private MaterialOutService materialOutService;

    @Resource(name="materialMenuService")
    private MaterialMenuService materialMenuService;

    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;

    @Resource(name="materialService")
    private MaterialService materialService;

    @Resource(name="companyService")
    private CompanyService companyService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @Resource(name="productionMstActService")
    private ProductionMstActService productionMstActService;

    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;

    @Resource(name="itemOutMstService")
    private ItemOutMstService itemOutMstService;

    @RequestMapping(value = "/materialOutListPage.do")
    public String materialOutListPage(@ModelAttribute("search")MaterialOutVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = materialOutService.searchList(search);
        RtnVO rtnTotCnt = materialOutService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());

        getCode("MAT_OUT_TYPE_CD",model);

        StoreHouseVO storeHouse = new StoreHouseVO();
        storeHouse.setSearchAreaCd("MAT_HOUSE");
        RtnVO selStoreHouseRtn = storeHouseService.searchList(storeHouse);
        if (selStoreHouseRtn.getRc() == 0) {
            List<StoreHouseVO> storeHouseList = (List<StoreHouseVO>)selStoreHouseRtn.getObj();
            model.addAttribute("store_house_list", storeHouseList);
        }

        CompanyVO company = new CompanyVO();
//        company.setCustTypeCd("MAT"); // 자재처
        RtnVO selCompanyRtn = companyService.searchList(company);
        if (selCompanyRtn.getRc() == 0) {
            List<CompanyVO> companyList = (List<CompanyVO>)selCompanyRtn.getObj();
            model.addAttribute("mat_cust_list", companyList);
        }

        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }

        wedEnd(request, rtn, model);
        return "/material/materialOutList";
    }

    @RequestMapping(value = "/materialOutDtlPage.do")
    public String materialOutDtlPage(@ModelAttribute("search")MaterialOutVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = materialOutService.select(search);
            MaterialOutVO obj = (MaterialOutVO)rtn.getObj();
            obj.setSearchFromDate(DateUtil.formatCurrent("yyyy/MM/dd"));
        } else {
        	rtn = new RtnVO();
        	MaterialOutVO obj = new MaterialOutVO();
            obj.setSearchFromDate(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setOutDt(DateUtil.formatCurrent("yyyy/MM/dd"));
            rtn.setObj(obj);
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

        getCode("MAT_OUT_TYPE_CD",model);

        wedEnd(request, rtn, model);
        return "/material/materialOutDtl";
    }

    @RequestMapping(value = "/materialOutSaveAct.do")
    public ModelAndView materialOutSaveAct(@ModelAttribute("obj")MaterialOutVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();

        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
            log.debug("getIndt:"+obj.getOutDt());
        }

        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        // 반제품 출고
        if( "H".equals(obj.getMatTypeCd()) ) {

        	ItemOutMstVO paramItemOutMstVo = new ItemOutMstVO();
        	paramItemOutMstVo.setFactoryCd(proPertyService.getFactoryCd());
            paramItemOutMstVo.setWriteId(getUserId(request));
            paramItemOutMstVo.setUpdateId(getUserId(request));
            paramItemOutMstVo.setProdSeq(obj.getProdSeq());
            paramItemOutMstVo.setItemoutDt(obj.getOutDt());
            paramItemOutMstVo.setItemCd(obj.getMatCd());
            paramItemOutMstVo.setItemOutTypeCd(obj.getMatOutTypeCd());
            paramItemOutMstVo.setLotid(obj.getLotid());

        	if ("C".equals(obj.getCrudType())) {
        		rtn = itemOutMstService.insert(paramItemOutMstVo);
            } else if ("U".equals(obj.getCrudType())) {
                rtn = itemOutMstService.update(paramItemOutMstVo);
            } else if ("D".equals(obj.getCrudType())) {
                rtn = itemOutMstService.delete(paramItemOutMstVo);
            } else {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
            }

        } else {
	        if ("C".equals(obj.getCrudType())) {
	            if (isMonthOpen(obj.getWorkshopCd(),obj.getOutDt())) {
	                rtn = materialOutService.insert(obj);
	            } else {
	                rtn.setRc(GlvConst.RC_ERROR);
	                rtn.setMsg("마감한 월은 입출고 할 수 없습니다.");
	            }
	        } else if ("U".equals(obj.getCrudType())) {
	            if (isMonthOpen(obj.getWorkshopCd(),obj.getOutDt())) {
	                rtn = materialOutService.update(obj);
	            } else {
	                rtn.setRc(GlvConst.RC_ERROR);
	                rtn.setMsg("마감한 월은 입출고 할 수 없습니다.");
	            }
	        } else if ("D".equals(obj.getCrudType())) {
	            rtn = materialOutService.delete(obj);
	        } else {
	            rtn.setRc(GlvConst.RC_ERROR);
	            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
	        }

        }

        // 출고 이후 첫번째 공정 배정수량 업데이트
        RtnVO rtnEnd = materialOutService.checkMatOutEndYn(obj);
        if (rtnEnd.getRc() == GlvConst.RC_ERROR ) {
        	rtn.setMsg("자재출고 완료후 배정수량 등록에 실패하였습니다.");
        } else {
        	String endYn = (String) rtnEnd.getObj();

        	// 자재출고 완료시에 첫번째 공정마스터에 배정수량등록
        	if( "Y".equals(endYn) ) {
        		ProductionOrderVO paramProdOrder = new ProductionOrderVO();
        		paramProdOrder.setFactoryCd(proPertyService.getFactoryCd());
        		paramProdOrder.setProdSeq(obj.getProdSeq());
        		RtnVO rtnProdOrder = productionOrderService.select(paramProdOrder);
        		ProductionOrderVO selProdOrder = (ProductionOrderVO) rtnProdOrder.getObj();

        		ProductionMstActVO paramMstAct = new ProductionMstActVO();
        		paramMstAct.setFactoryCd(proPertyService.getFactoryCd());
        		paramMstAct.setUpdateId(getUserId(request));
        		paramMstAct.setProdSeq(selProdOrder.getProdSeq());
        		paramMstAct.setAssignQty(selProdOrder.getPoQty());
        		paramMstAct.setOperLvl(1);
        		productionMstActService.updateAssignQty(paramMstAct);
        	}
        }

        wedEnd(request, rtn, mav);
        return mav;
    }

    public boolean isMonthOpen(String workshopCd, String outdt) {
        MonthCloseInVO param = new MonthCloseInVO();
        param.setWorkshopCd(workshopCd);
        param.setMagamYyyymm(outdt);
        RtnVO rtn = materialMenuService.selectMaxCloseMonthAndDiffMonth(param);

        if (rtn.getRc() == GlvConst.RC_SUCC) {
            Integer diffMonth = (Integer)rtn.getObj();
            if (diffMonth != null) {
                if (diffMonth > 0) {
                    return true;
                }
            } else {
                return true;
            }
        }
        return false;
    }

    @RequestMapping(value = "/materialModifyListPage.do")
    public String materialModifyListPage(@ModelAttribute("search")MaterialOutVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        search.setSearchMatOutTypeCd("MODIFY");
        RtnVO rtn = materialOutService.searchList(search);
        RtnVO rtnTotCnt = materialOutService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());

        getCode("MAT_OUT_TYPE_CD",model);

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

        wedEnd(request, rtn, model);
        return "/material/materialModifyList";
    }

    @RequestMapping(value = "/materialModifyDtlPage.do")
    public String materialModifyDtlPage(@ModelAttribute("search")MaterialOutVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = materialOutService.select(search);
            MaterialOutVO obj = (MaterialOutVO)rtn.getObj();
            obj.setSearchFromDate(DateUtil.formatCurrent("yyyy/MM/dd"));
        } else {
        	rtn = new RtnVO();
        	MaterialOutVO obj = new MaterialOutVO();
            obj.setSearchFromDate(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setOutDt(DateUtil.formatCurrent("yyyy/MM/dd"));
            rtn.setObj(obj);
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

        getCode("MAT_OUT_TYPE_CD",model);

        wedEnd(request, rtn, model);
        return "/material/materialModifyDtl";
    }

    @RequestMapping(value = "/materialOutPage.do")
    public String materialOutPage(@ModelAttribute("search")ProductionComParamVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        return "/material/materialOut";
    }
}
