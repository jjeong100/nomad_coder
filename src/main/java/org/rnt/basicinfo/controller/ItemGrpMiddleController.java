package org.rnt.basicinfo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.ItemGrpMainService;
import org.rnt.com.entity.service.ItemGrpMiddleService;
import org.rnt.com.entity.vo.ItemGrpMainVO;
import org.rnt.com.entity.vo.ItemGrpMiddleVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ItemGrpMiddleController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="itemGrpMiddleService")
    private ItemGrpMiddleService itemGrpMiddleService;
    
    @Resource(name="itemGrpMainService")
    private ItemGrpMainService itemGrpMainService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/itemGrpMiddleListPage.do")
    public String itemGrpMiddleListPage(@ModelAttribute("search")ItemGrpMiddleVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("A.UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = itemGrpMiddleService.searchList(search);
        RtnVO rtnTotCnt = itemGrpMiddleService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/itemGrpMiddleList";
    }
    
    @RequestMapping(value = "/itemGrpMiddleDtlPage.do")
    public String itemGrpMiddleDtlPage(@ModelAttribute("search")ItemGrpMiddleVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = itemGrpMiddleService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new ItemGrpMiddleVO());
        }
        
        ItemGrpMainVO itemGrpMainVO = new ItemGrpMainVO();
        RtnVO selItemGrpMainRtn = itemGrpMainService.searchList(itemGrpMainVO);
        if (selItemGrpMainRtn.getRc() == 0) {
            List<ItemGrpMainVO> itemGrpMainList = (List<ItemGrpMainVO>)selItemGrpMainRtn.getObj();
            model.addAttribute("itemGrpMainList", itemGrpMainList);
        }
        
        getCode("PERFORMANCE_TYPE_CD", model);
        
        wedEnd(request, rtn, model);
        return "/basicinfo/itemGrpMiddleDtl";
    }
    
    @RequestMapping(value = "/itemGrpMiddleSaveAct.do")
    public ModelAndView itemGrpMiddleSaveAct(@ModelAttribute("obj")ItemGrpMiddleVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
            rtn = itemGrpMiddleService.select(obj);
            if(rtn.getObj() == null) {
                rtn = itemGrpMiddleService.insert(obj);
            } else {
                ItemGrpMiddleVO itemGrpMiddle = (ItemGrpMiddleVO)rtn.getObj();
                if ("N".equals(itemGrpMiddle.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = itemGrpMiddleService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
            }
        } else if ("U".equals(obj.getCrudType())) {
            rtn = itemGrpMiddleService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = itemGrpMiddleService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
