package org.rnt.qm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.ItemStockService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.ItemStockVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.vo.StockInVO;
import org.rnt.material.vo.StockOutVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemStockController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="itemStockService")
    private ItemStockService itemStockService;

    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;

    @Resource(name="productService")
    private ProductService productService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/itemStockListPage.do")
    public String itemStockListPage(@ModelAttribute("search")ItemStockVO search, HttpServletRequest request, ModelMap model)  throws Exception {
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
            search.setSortCol("SB_DT");
            search.setSortType("ASC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = itemStockService.searchItemStockList(search);
        List<ItemStockVO> stockOutList = (List<ItemStockVO>)rtn.getObj();
        for(ItemStockVO item : stockOutList) {
        	ItemStockVO vo=new ItemStockVO();
        	vo.setSbDt(item.getSbDt());
        	vo.setItemCd(item.getItemCd());
        	vo.setSearchWorkshopCd(item.getWorkshopCd());
        	RtnVO rtnBaseQty=itemStockService.searchBaseQty(vo);
        	item.setBaseQty((String)rtnBaseQty.getObj());
        	int totalqty=Integer.parseInt(item.getBaseQty().replaceAll(",", ""))
        			+Integer.parseInt(item.getItemInQty().replaceAll(",", ""))
        			-Integer.parseInt(item.getItemOutQty().replaceAll(",", ""))
        			-Integer.parseInt(item.getItemOutWaitQty().replaceAll(",", ""))
        			+Integer.parseInt(item.getItemOutCanQty().replaceAll(",", ""))
        			+Integer.parseInt(item.getItemModifyQty().replaceAll(",", ""))
        			-Integer.parseInt(item.getItemDisuseQty().replaceAll(",", ""));
        	item.setStockQty(String.valueOf(totalqty));
		}



        RtnVO rtnTotCnt = itemStockService.searchItemStockListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());

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
        // 창고 조회 조건 처리 select box
        //---------------------------------------------------------------------
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
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }

        wedEnd(request, rtn, model);
        return "/qm/itemStockList";
    }

}
