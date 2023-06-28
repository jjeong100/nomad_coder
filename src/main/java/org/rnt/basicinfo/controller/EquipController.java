package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.EquipHistoryService;
import org.rnt.com.entity.service.EquipService;
import org.rnt.com.entity.vo.EquipVO;
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
public class EquipController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="equipService")
    private EquipService equipService;

    @Resource(name="equipHistoryService")
    private EquipHistoryService equipHistoryService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/equipListPage.do")
    public String equipListPage(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("EQUIP_NM ASC,UPDATE_DT");
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = equipService.searchList(search);
        RtnVO rtnTotCnt = equipService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/equipList";
    }

    @RequestMapping(value = "/equipDtlPage.do")
    public String equipDtlPage(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = equipService.select(search);
        } else {
            rtn = new RtnVO();
            EquipVO obj = new EquipVO();
            obj.setEquipGetDt(DateUtil.formatCurrent("yyyy/MM/dd"));
            rtn.setObj(obj);
        }
        getCode("YN_CD",model);
        wedEnd(request, rtn, model);
        return "/basicinfo/equipDtl";
    }

    @RequestMapping(value = "/equipSaveAct.do")
    public ModelAndView equipSaveAct(@ModelAttribute("obj")EquipVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = equipService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = equipService.insert(obj);
        	} else {
        	    EquipVO equip = (EquipVO)rtn.getObj();
        	    if ("N".equals(equip.getUseYn())) {
        	        obj.setUseYn("Y");
        	        rtn = equipService.update(obj);
        	    } else {
        	        rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
        	    }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = equipService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = equipService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }

    @RequestMapping(value = "/getEquipList.do")
    public ModelAndView getEquipList(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = equipService.searchList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }

    @RequestMapping(value = "/getEquipData.do")
    public ModelAndView getEquipData(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	search.setFactoryCd(proPertyService.getFactoryCd());
    	RtnVO rtn = equipService.select(search);
    	wedEnd(request, rtn, mav);
    	return mav;
    }

    @RequestMapping(value = "/equipHistoryListPage.do")
    public String equipHistoryListPage(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("A.WRITE_DT");
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = equipHistoryService.searchList(search);
        RtnVO rtnTotCnt = equipHistoryService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());

        wedEnd(request, rtn, model);
        return "/basicinfo/equipHistoryList";
    }

    @RequestMapping(value = "/equipHistoryDtlPage.do")
    public String equipHistoryDtlPage(@ModelAttribute("search")EquipVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);

    	search.setFactoryCd(proPertyService.getFactoryCd());
    	RtnVO selEquipRtn = equipService.select(search);
    	model.addAttribute("equipVo", selEquipRtn.getObj());

    	RtnVO selEquipDtlRtn = equipHistoryService.select(search);

    	EquipVO equipVo = new EquipVO();
    	equipVo.setPaging(false);
        RtnVO rtn = equipService.searchList(equipVo);
        model.addAttribute("equip_list", rtn.getObj());

    	wedEnd(request, selEquipDtlRtn, model);
    	return "/basicinfo/equipHistoryDtl";
    }

    @RequestMapping(value = "/equipHistorySaveAct.do")
    public ModelAndView equipHistorySaveAct(@ModelAttribute("obj")EquipVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
        	rtn = equipHistoryService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = equipHistoryService.insert(obj);
        	} else {
        	    EquipVO equip = (EquipVO) rtn.getObj();
        	    if ("N".equals(equip.getUseYn())) {
        	        obj.setUseYn("Y");
        	        rtn = equipHistoryService.update(obj);
        	    } else {
        	        rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
        	    }
        	}
        } else if ("U".equals(obj.getCrudType())) {
            rtn = equipHistoryService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = equipHistoryService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }

        wedEnd(request, rtn, mav);
        return mav;
    }

}
