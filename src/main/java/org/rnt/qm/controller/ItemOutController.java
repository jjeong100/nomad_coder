package org.rnt.qm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.BoxService;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.ItemInService;
import org.rnt.com.entity.service.ItemOutDtlService;
import org.rnt.com.entity.service.ItemOutMstService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.FinishQmVO;
import org.rnt.com.entity.vo.ItemInVO;
import org.rnt.com.entity.vo.ItemOutMstVO;
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
public class ItemOutController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="itemOutMstService")
    private ItemOutMstService itemOutMstService;

    @Resource(name="itemOutDtlService")
    private ItemOutDtlService itemOutDtlService;

    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;

    @Resource(name="productService")
    private ProductService productService;

    @Resource(name="companyService")
    private CompanyService companyService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @Resource(name="boxService")
    private BoxService boxService;

    @Resource(name="itemInService")
    private ItemInService itemInService;

    @RequestMapping(value = "/itemOutListPage.do")
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
        getCode("ITEM_OUT_TYPE_CD",model);
        wedEnd(request, rtn, model);
        return "/qm/itemOutList";
    }
    @RequestMapping(value = "/itemOutSetPage.do")
    public String itemOutSetPage(@ModelAttribute("search")ItemOutMstVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("ITEMOUT_SEQ");
            search.setSortType("DESC");
        }
        if (StrUtil.isNull(search.getSearchType())) {
            search.setSearchType("OUT_WAIT");
        }

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = itemOutMstService.searchList(search);
        RtnVO rtnTotCnt = itemOutMstService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());

        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }

        getCode("BARCODE_PRINT", model);
        getCode("ITEM_OUT_TYPE_CD",model);
        wedEnd(request, rtn, model);
        return "/qm/itemOutSet";
    }
    @RequestMapping(value = "/itemOutSetSave.do")
    public ModelAndView itemOutSetSave(@ModelAttribute("search")ItemOutMstVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");

        search.setFactoryCd(proPertyService.getFactoryCd());
        search.setWriteId(getUserId(request));
        RtnVO rtn = new RtnVO();
        rtn = itemOutMstService.selectByLotId(search);
        ItemOutMstVO itemOutVo =(ItemOutMstVO)rtn.getObj();

        if("OUT".equals(itemOutVo.getItemOutTypeCd())) {
        	 rtn.setRc(GlvConst.RC_ERROR);
             rtn.setMsg("이미 출고처리 된 Lot 입니다.");
    	}else {
    		rtn = itemOutMstService.updateOutSet(search);
    	}
        wedEnd(request, rtn, mav);
        return mav;
    }


    @RequestMapping(value = "/itemOutDtlPage.do")
    public String itemOutDtlPage(@ModelAttribute("search")ItemOutMstVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
        return "/qm/itemOutDtl";
    }

    @RequestMapping(value = "/itemOutSaveAct.do")
    public ModelAndView itemOutSaveAct(@ModelAttribute("obj")ItemOutMstVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = itemOutMstService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = itemOutMstService.insert(obj);
        	}else {
        	    FinishQmVO division = (FinishQmVO)rtn.getObj();
                if ("N".equals(division.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = itemOutMstService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = itemOutMstService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = itemOutMstService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }

        wedEnd(request, rtn, mav);
        return mav;
    }

    @RequestMapping(value = "/getItemOutListData.do")
    public ModelAndView getItemOutDtlListData(@ModelAttribute("search")ItemOutMstVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        rtn = itemOutMstService.searchItemOutList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }


}
