package org.rnt.basicinfo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.MaterialInService;
import org.rnt.com.entity.service.MaterialOutService;
import org.rnt.com.entity.service.MaterialService;
import org.rnt.com.entity.service.OutSocService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.MaterialGrpVO;
import org.rnt.com.entity.vo.MaterialInVO;
import org.rnt.com.entity.vo.MaterialOutVO;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.entity.vo.OutSocVO;
import org.rnt.com.file.service.ComFileService;
import org.rnt.com.file.vo.ComFileVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.service.MaterialMenuService;
import org.rnt.material.vo.MonthCloseInVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OutSocController extends BaseController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "outSocService")
	private OutSocService outSocService;

	@Resource(name = "companyService")
	private CompanyService companyService;

	@Resource(name = "materialService")
	private MaterialService materialService;

	@Resource(name = "proPertyService")
	private ProPertyService proPertyService;

	@Resource(name = "comFileService")
	private ComFileService comFileService;

	@Resource(name="materialInService")
    private MaterialInService materialInService;

	@Resource(name="materialOutService")
    private MaterialOutService materialOutService;

	@Resource(name="materialMenuService")
    private MaterialMenuService materialMenuService;

	@RequestMapping(value = "/outSocListPage.do")
	public String outSocListPage(@ModelAttribute("search") OutSocVO search, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);
		// ---------------------------------------------------------------------
		// paging set
		// ---------------------------------------------------------------------
		if (StrUtil.isNull(search.getSortCol())) {
			search.setSortCol("OUT_SOC_SDT");
			search.setSortType("DESC");
		}
		search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
		RtnVO rtn = outSocService.searchList(search);
		RtnVO rtnTotCnt = outSocService.searchListTotCnt(search);

		rtn.setTotCnt((Integer) rtnTotCnt.getObj());
		wedEnd(request, rtn, model);
		return "/basicinfo/outSocList";
	}

	@RequestMapping(value = "/outSocDtlPage.do")
	public String outSocDtlPage(@ModelAttribute("search") OutSocVO search, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);
		RtnVO rtn = null;
		search.setFactoryCd(proPertyService.getFactoryCd());
		if ("R".equals(search.getCrudType())) {
			rtn = outSocService.select(search);
		} else {
			rtn = new RtnVO();
			OutSocVO obj = new OutSocVO();
			obj.setOutSocSdt(DateUtil.formatCurrent("yyyy/MM/dd"));
			rtn.setObj(obj);
		}

		CompanyVO company = new CompanyVO();
		//company.setCustTypeCd("MAT"); // 자재처
		RtnVO selCompanyRtn = companyService.searchList(company);
		if (selCompanyRtn.getRc() == 0) {
			List<CompanyVO> companyList = (List<CompanyVO>) selCompanyRtn.getObj();
			model.addAttribute("mat_cust_list", companyList);
		}

		MaterialVO material = new MaterialVO();
		RtnVO selMaterialRtn = materialService.searchList(material);
		if (selMaterialRtn.getRc() == 0) {
			List<MaterialVO> materialList = (List<MaterialVO>) selMaterialRtn.getObj();
			model.addAttribute("material_list", materialList);
		}

		ComFileVO comFileVo = new ComFileVO();
		comFileVo.setFactoryCd(proPertyService.getFactoryCd());
		comFileVo.setFileKey(search.getOutSocSeq());
		RtnVO selComFileRtn = comFileService.selectList(comFileVo);
		if (selComFileRtn.getRc() == 0) {
			List<ComFileVO> comFileList = (List<ComFileVO>) selComFileRtn.getObj();
			model.addAttribute("comFileList", comFileList);
		}

		getCode("MAT_IN_TYPE_CD", model);
		getCode("UNIT_CD", model);

		wedEnd(request, rtn, model);
		return "/basicinfo/outSocDtl";
	}

	@RequestMapping(value = "/outSocSaveAct.do")
	public ModelAndView outSocSaveAct(@ModelAttribute("obj") OutSocVO obj, HttpServletRequest request, ModelMap model) throws Exception {
		webStart(request);
		ModelAndView mav = new ModelAndView("jsonView");
		RtnVO rtn = new RtnVO();

		if (log.isDebugEnabled()) {
			log.debug("getCrudType:" + obj.getCrudType());
		}

		obj.setFactoryCd(proPertyService.getFactoryCd());
		obj.setWriteId(getUserId(request));
		obj.setUpdateId(getUserId(request));

		MaterialInVO insMaterialInVo = new MaterialInVO();
		insMaterialInVo.setFactoryCd(proPertyService.getFactoryCd());
		insMaterialInVo.setWriteId(getUserId(request));
		insMaterialInVo.setUpdateId(getUserId(request));
		insMaterialInVo.setMatInTypeCd("MIN");	// 입고구분 (MIN:입고,MRNT:반품입고) 미사용:무조건:MIN
		insMaterialInVo.setInDt(obj.getOutSocSdt());
		insMaterialInVo.setWorkshopCd(proPertyService.getWorkshopCd());
		insMaterialInVo.setCustCd(obj.getOutCustCd());
		insMaterialInVo.setMatCd(obj.getOutMatCd());
		insMaterialInVo.setOutSocSeq(obj.getOutSocSeq());

		// 자재출고 이후 수정불가 로직 작성, 수정시에만 체크
        if( !"C".equals(obj.getCrudType()) ) {
        	MaterialInVO parmaMaterialInVo = new MaterialInVO();
        	parmaMaterialInVo.setFactoryCd(proPertyService.getFactoryCd());
        	parmaMaterialInVo.setOutSocSeq(obj.getOutSocSeq());
        	RtnVO selMaterialInRtn = materialInService.select(parmaMaterialInVo);

        	if (selMaterialInRtn.getRc() == 0) {
        		MaterialInVO rtnMaterialIn = (MaterialInVO) selMaterialInRtn.getObj();

        		if( rtnMaterialIn != null ) {
	        		MaterialOutVO paramMaterialOutVo = new MaterialOutVO();
			        paramMaterialOutVo.setFactoryCd(proPertyService.getFactoryCd());
			        paramMaterialOutVo.setLotid(rtnMaterialIn.getLotid());
			        int rtnVal = materialOutService.checkMaterialOut(paramMaterialOutVo);

			        if ( rtnVal == -1 ) {
			        	wedEnd(request, rtn, mav);
			        	return mav;
			        } else if ( rtnVal > 0 ) {
			        	rtn.setRc(GlvConst.RC_ERROR);
			        	rtn.setMsg("자재출고 이후에는 수정할 수 없습니다.");
			        	wedEnd(request, rtn, mav);
			        	return mav;
			        }

			        if (!isMonthOpen(rtnMaterialIn.getWorkshopCd(),rtnMaterialIn.getInDt())) {
			        	rtn.setRc(GlvConst.RC_ERROR);
			        	rtn.setMsg("마감한 월은 수정할 수 없습니다.");
			        	wedEnd(request, rtn, mav);
			        	return mav;
			        }
        		}
        	}
        }

		if ("C".equals(obj.getCrudType())) {
			rtn = outSocService.select(obj);
			if (rtn.getObj() == null) {
				rtn = outSocService.insert(obj);

				insMaterialInVo.setOutSocSeq(obj.getOutSocSeq());
				rtn = materialInService.insert(insMaterialInVo);	// 자재입고 등록
			} else {
				MaterialGrpVO division = (MaterialGrpVO) rtn.getObj();
				if ("N".equals(division.getUseYn())) {
					obj.setUseYn("Y");
					rtn = outSocService.update(obj);
					rtn = materialInService.update(insMaterialInVo);	// 자재입고 수정
				} else {
					rtn.setRc(GlvConst.RC_ERROR);
					rtn.setMsg("정보가 이미 등록되어 있습니다.");
				}
			}
		} else if ("U".equals(obj.getCrudType())) {
			rtn = outSocService.update(obj);
			rtn = materialInService.update(insMaterialInVo);	// 자재입고 수정
		} else if ("D".equals(obj.getCrudType())) {
			rtn = outSocService.delete(obj);
			rtn = materialInService.delete(insMaterialInVo);	// 자재입고삭제
		} else {
			rtn.setRc(GlvConst.RC_ERROR);
			rtn.setMsg("알수없는 저장 타입 :" + obj.getCrudType());
		}

		// 첨부파일 업로드
		comFileService.setFileUpload(request, obj.getOutSocSeq(), rtn);

		wedEnd(request, rtn, mav);
		return mav;
	}

	public boolean isMonthOpen(String workshopCd, String indt) {
        MonthCloseInVO param = new MonthCloseInVO();
        param.setWorkshopCd(workshopCd);
        param.setMagamYyyymm(indt);
        RtnVO rtn = materialMenuService.selectMaxCloseMonthAndDiffMonth(param);

        if (rtn.getRc() == GlvConst.RC_SUCC) {
            Integer diffMonth = (Integer)rtn.getObj();
            if (diffMonth != null) {
                if (diffMonth > 0) {
                    return true;
                }
            } else {
                return true;
            }
        }
        return false;
    }

}
