package org.rnt.production.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.InspRltService;
import org.rnt.com.entity.vo.InspRltVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.production.vo.ProductionComParamVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductionInspController extends BaseController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "inspRltService")
	private InspRltService inspRltService;

	@Resource(name = "proPertyService")
	private ProPertyService proPertyService;

	@RequestMapping(value = "/productionInspListPage.do")
	public String productionInspListPage(@ModelAttribute("search") ProductionComParamVO search, @ModelAttribute("searchInsp") InspRltVO searchInsp, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);

		searchInsp.setPaging(true);
		RtnVO rtn = inspRltService.searchList(searchInsp);
		RtnVO rtnTotCnt = inspRltService.searchListTotCnt(searchInsp);

		rtn.setTotCnt((Integer) rtnTotCnt.getObj());
		getCode("INSP_SME_CD", model);

		wedEnd(request, rtn, model);
		return "/production/productionInspList";
	}

	@RequestMapping(value = "/productionInspDtlPage.do")
	public String productionInspDtlPage(@ModelAttribute("search") ProductionComParamVO search, @ModelAttribute("searchInsp") InspRltVO searchInsp, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);
		RtnVO rtn = null;

		searchInsp.setFactoryCd(proPertyService.getFactoryCd());
		searchInsp.setWorkactSeq(search.getSearchWorkactSeq());
		searchInsp.setInspTypeCd(search.getSearchInspTypeCd());

		if( !"".equals(search.getSearchInspSmeCd()) ) {
			searchInsp.setInspSmeCd(search.getSearchInspSmeCd());
		}

        rtn = inspRltService.searchInspRsltList(searchInsp);

		getCode("INSP_SME_CD", model);

		wedEnd(request, rtn, model);
		return "/production/productionInspDtl";
	}

	@RequestMapping(value = "/getInspDaySeq.do")
    public ModelAndView getInspDaySeq(@ModelAttribute("search") ProductionComParamVO search, @ModelAttribute("searchInsp") InspRltVO searchInsp, HttpServletRequest request, ModelMap model)  throws Exception {
    	webStart(request);
    	ModelAndView mav = new ModelAndView("jsonView");
    	RtnVO rtn = new RtnVO();

    	searchInsp.setFactoryCd(proPertyService.getFactoryCd());
		searchInsp.setWorkactSeq(search.getSearchWorkactSeq());
		searchInsp.setInspTypeCd(search.getSearchInspTypeCd());
		searchInsp.setInspSmeCd(search.getSearchInspSmeCd());

		rtn = inspRltService.getInspDaySeq(searchInsp);

    	wedEnd(request, rtn, model);
    	return mav;
    }

	@RequestMapping(value = "/productionInspSaveAct.do")
	public ModelAndView productionInspSaveAct(@ModelAttribute("search") ProductionComParamVO search, @ModelAttribute("obj") InspRltVO obj, HttpServletRequest request, ModelMap model) throws Exception {
		webViewLog(request);
		ModelAndView mav = new ModelAndView("jsonView");
		RtnVO rtn = new RtnVO();

		List<InspRltVO> objList = (List<InspRltVO>) obj.getObjList();

		InspRltVO deleteVO = new InspRltVO();
		deleteVO.setFactoryCd(proPertyService.getFactoryCd());
		deleteVO.setWorkactSeq(search.getSearchWorkactSeq());
		deleteVO.setInspTypeCd(search.getSearchInspTypeCd());
		deleteVO.setInspSmeCd(search.getSearchInspSmeCd());
		deleteVO.setInspSmeCd(search.getSearchInspSmeCd());
		deleteVO.setInspDaySeq(search.getSearchInspDaySeq());

		inspRltService.deleteAll(deleteVO);

		if (objList != null) {
			// 등록
			for (int index = 0; index < objList.size(); index++) {
				InspRltVO inspRltVO = objList.get(index);

				inspRltVO.setFactoryCd(proPertyService.getFactoryCd());
				inspRltVO.setWriteId(getUserId(request));
				inspRltVO.setUpdateId(getUserId(request));
				inspRltVO.setWorkactSeq(search.getSearchWorkactSeq());
				inspRltVO.setInspTypeCd(search.getSearchInspTypeCd());
				inspRltVO.setInspSmeCd(search.getSearchInspSmeCd());
				inspRltVO.setInspDaySeq(search.getSearchInspDaySeq());

				inspRltService.insert(inspRltVO);
			}
		}

		wedEnd(request, rtn, mav);
		return mav;
	}
}
