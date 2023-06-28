package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.InspItemService;
import org.rnt.com.entity.vo.InspItemVO;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class InspItemController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="inspItemService")
    private InspItemService inspItemService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/inspItemListPage.do")
    public String inspItemListPage(@ModelAttribute("search")InspItemVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = inspItemService.searchList(search);
        RtnVO rtnTotCnt = inspItemService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        getCode("INSP_TYPE_CD",model);
        wedEnd(request, rtn, model);
        return "/basicinfo/inspItemList";
    }
    
    @RequestMapping(value = "/inspItemDtlPage.do")
    public String inspItemDtlPage(@ModelAttribute("search")InspItemVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = inspItemService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new InspItemVO());
        }
        
        getCode("INSP_TYPE_CD",model);
        getCode("INSP_ITEM_TYPE_CD",model);
        getCode("INSP_DANWI_CD",model);
        
        wedEnd(request, rtn, model);
        return "/basicinfo/inspItemDtl";
    }
    
    @RequestMapping(value = "/inspItemSaveAct.do")
    public ModelAndView inspItemSaveAct(@ModelAttribute("obj")InspItemVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+obj.getCrudType());
            log.debug("getInspTypeCd:"+obj.getInspTypeCd());
            log.debug("getInspItemCd:"+obj.getInspItemCd());
        }
        
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("C".equals(obj.getCrudType())) {
        	rtn = inspItemService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = inspItemService.insert(obj);
        	} else {
        	    ProductVO product = (ProductVO)rtn.getObj();
                if ("N".equals(product.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = inspItemService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = inspItemService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = inspItemService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getInspItemData.do")
    public ModelAndView getInspItemData(@ModelAttribute("search")InspItemVO param, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = inspItemService.searchList(param);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
