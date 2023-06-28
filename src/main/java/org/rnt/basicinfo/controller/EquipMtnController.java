package org.rnt.basicinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.EquipMtnService;
import org.rnt.com.entity.vo.EquipMtnVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EquipMtnController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="equipMtnService")
    private EquipMtnService equipMtnService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/getEquipMtnListData.do")
    public ModelAndView getEquipMtnListData(@ModelAttribute("search")EquipMtnVO search, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = equipMtnService.searchList(search);
        wedEnd(request, rtn, mav);
        return mav;
    }

	@RequestMapping(value = "/equipMtnDtlPage.do")
	public String equipMtnDtlPage(@ModelAttribute("search") EquipMtnVO search, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);
		RtnVO rtn = null;
		search.setFactoryCd(proPertyService.getFactoryCd());

		if ("R".equals(search.getCrudType())) {
			rtn = equipMtnService.select(search);
		} else {
			rtn = new RtnVO();
			EquipMtnVO obj = new EquipMtnVO();
			obj.setEquipSeq(search.getEquipSeq());
			obj.setEquipChkDt(DateUtil.formatCurrent("yyyy/MM/dd"));
			rtn.setObj(obj);
		}

		wedEnd(request, rtn, model);
		return "/basicinfo/equipMtnDtl";
	}

	@RequestMapping(value = "/equipMtnSaveAct.do")
	public ModelAndView equipMtnSaveAct(@ModelAttribute("obj") EquipMtnVO obj, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);
		ModelAndView mav = new ModelAndView("jsonView");
		RtnVO rtn = new RtnVO();

		if (log.isDebugEnabled()) {
			log.debug("getCrudType:" + obj.getCrudType());
		}

		obj.setFactoryCd(proPertyService.getFactoryCd());
		obj.setWriteId(getUserId(request));
		obj.setUpdateId(getUserId(request));

		if ("C".equals(obj.getCrudType())) {
			rtn = equipMtnService.select(obj);
			if (rtn.getObj() == null) {
				rtn = equipMtnService.insert(obj);
			} else {
				EquipMtnVO equip = (EquipMtnVO) rtn.getObj();
				if ("N".equals(equip.getUseYn())) {
					obj.setUseYn("Y");
					rtn = equipMtnService.update(obj);
				} else {
					rtn.setRc(GlvConst.RC_ERROR);
					rtn.setMsg("정보가 이미 등록되어 있습니다.");
				}
			}
		} else if ("U".equals(obj.getCrudType())) {
			rtn = equipMtnService.update(obj);
		} else if ("D".equals(obj.getCrudType())) {
			rtn = equipMtnService.delete(obj);
		} else {
			rtn.setRc(GlvConst.RC_ERROR);
			rtn.setMsg("알수없는 저장 타입 :" + obj.getCrudType());
		}
		wedEnd(request, rtn, mav);
		return mav;
	}


}
