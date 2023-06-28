package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StoreHouseController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/storeHouseListPage.do")
    public String storeHouseListPage(@ModelAttribute("search")StoreHouseVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");    
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = storeHouseService.searchList(search);
        RtnVO rtnTotCnt = storeHouseService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/storeHouseList";
    }
    
    @RequestMapping(value = "/storeHouseDtlPage.do")
    public String storeHouseDtlPage(@ModelAttribute("search")StoreHouseVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = storeHouseService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new StoreHouseVO());
        }
        getCode("AREA_CD",model);
        wedEnd(request, rtn, model);
        return "/basicinfo/storeHouseDtl";
    }
    
    @RequestMapping(value = "/storeHouseSaveAct.do")
    public ModelAndView storeHouseSaveAct(@ModelAttribute("obj")StoreHouseVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = storeHouseService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = storeHouseService.insert(obj);
        	} else {
        	    StoreHouseVO store = (StoreHouseVO)rtn.getObj();
        	    if ("N".equals(store.getUseYn())) {
        	        obj.setUseYn("Y");
        	        rtn = storeHouseService.update(obj);
        	    } else {
        	        rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
        	    }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = storeHouseService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = storeHouseService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
}
