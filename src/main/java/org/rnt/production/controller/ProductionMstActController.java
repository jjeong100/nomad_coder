package org.rnt.production.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.production.service.ProductionMenuService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductionMstActController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;

    @Resource(name="productionMenuService")
    private ProductionMenuService productionMenuService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/productionMstActListPage.do")
    public String productionMstActListPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("PO_ORD DESC, PO_CALLDT");
            search.setSortType("DESC");
        }

        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        if (StrUtil.isNull(search.getSearchPoCalldt())) {
        	search.setSearchPoCalldt(search.getToDay());
        }
        RtnVO rtn = productionOrderService.searchList(search);
        RtnVO rtnTotCnt = productionOrderService.searchListTotCnt(search);

        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/production/productionMstActList";
    }

    @RequestMapping(value = "/getProductionOperListData.do")
    public ModelAndView getProductionOperListData(@ModelAttribute("search")ProductionMstActVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	search.setSearchLoginId(getUserId(request));
        RtnVO rtn = productionMenuService.productionOperList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }

}
