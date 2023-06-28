package org.rnt.material.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.MaterialService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.service.MaterialMenuService;
import org.rnt.material.vo.StockInVO;
import org.rnt.material.vo.StockOutVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MaterialStockController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="materialMenuService")
    private MaterialMenuService materialMenuService;

    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;

    @Resource(name="materialService")
    private MaterialService materialService;

    @Resource(name="productService")
    private ProductService productService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/materialStockListPage.do")
    public String materialStockListPage(@ModelAttribute("search")StockInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("MAT_CD");
            search.setSortType("ASC");
        }
        search.setPaging(true);
        RtnVO rtn = materialMenuService.searchStockList(search);
        List<StockOutVO> stockOutList = (List<StockOutVO>)rtn.getObj();
        for(StockOutVO item : stockOutList) {
        	StockInVO vo=new StockInVO();
        	vo.setSbDt(item.getSbDt());
        	vo.setSearchMatCd(item.getMatCd());
        	vo.setSearchWorkshopCd(item.getWorkshopCd());
        	RtnVO rtnBaseQty=materialMenuService.searchBaseQty(vo);
        	item.setBaseQty((String)rtnBaseQty.getObj());
        	double totalqty=Double.parseDouble(item.getBaseQty())+Double.parseDouble(item.getInQty())-Double.parseDouble(item.getGoutQty())+Double.parseDouble(item.getGrntQty())-Double.parseDouble(item.getDisuseQty())+Double.parseDouble(item.getModifyQty());
        	item.setTotQty(String.valueOf(totalqty));
		}

        RtnVO rtnTotCnt = materialMenuService.searchStockListTotCnt(search);
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
        // 자재
        //---------------------------------------------------------------------
        MaterialVO material = new MaterialVO();
        RtnVO selMaterialRtn = materialService.searchList(material);
        if (selMaterialRtn.getRc() == 0) {
            List<MaterialVO> materialList = (List<MaterialVO>)selMaterialRtn.getObj();
            model.addAttribute("material_list", materialList);
        }

        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }

        wedEnd(request, rtn, model);
        return "/material/materialStockList";
    }



}
