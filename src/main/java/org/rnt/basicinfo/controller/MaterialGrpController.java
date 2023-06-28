package org.rnt.basicinfo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.ItemGrpMiddleService;
import org.rnt.com.entity.service.MaterialGrpService;
import org.rnt.com.entity.vo.ItemGrpMiddleVO;
import org.rnt.com.entity.vo.MaterialGrpVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MaterialGrpController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="materialGrpService")
    private MaterialGrpService materialGrpService;

    @Resource(name="itemGrpMiddleService")
    private ItemGrpMiddleService itemGrpMiddleService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/materialGrpListPage.do")
    public String materialGrpListPage(@ModelAttribute("search")MaterialGrpVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = materialGrpService.searchList(search);
        RtnVO rtnTotCnt = materialGrpService.searchListTotCnt(search);

        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/materialGrpList";
    }

    @RequestMapping(value = "/materialGrpDtlPage.do")
    public String materialGrpDtlPage(@ModelAttribute("search")MaterialGrpVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = materialGrpService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new MaterialGrpVO());
        }

        wedEnd(request, rtn, model);
        return "/basicinfo/materialGrpDtl";
    }

    @RequestMapping(value = "/materialGrpSaveAct.do")
    public ModelAndView materialGrpSaveAct(@ModelAttribute("obj")MaterialGrpVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
            rtn = materialGrpService.select(obj);
            if(rtn.getObj() == null) {
                rtn = materialGrpService.insert(obj);
            }else {
                MaterialGrpVO division = (MaterialGrpVO)rtn.getObj();
                if ("N".equals(division.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = materialGrpService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
            }
        } else if ("U".equals(obj.getCrudType())) {
            rtn = materialGrpService.update(obj);
        } else if ("D".equals(obj.getCrudType())) {
            rtn = materialGrpService.delete(obj);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }

}
