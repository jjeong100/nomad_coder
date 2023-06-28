package org.rnt.basicinfo.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.MaterialGrpService;
import org.rnt.com.entity.service.MaterialService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.MaterialGrpVO;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;

@Controller
public class MaterialController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="materialGrpService")
    private MaterialGrpService materialGrpService;

    @Resource(name="materialService")
    private MaterialService materialService;

    @Resource(name="companyService")
    private CompanyService companyService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @Resource(name="productService")
    private ProductService productService;

    @RequestMapping(value = "/materialListPage.do")
    public String materialListPage(@ModelAttribute("search")MaterialVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");
            search.setSortType("DESC");
        }
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = materialService.searchList(search);
        RtnVO rtnTotCnt = materialService.searchListTotCnt(search);

        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        wedEnd(request, rtn, model);
        return "/basicinfo/materialList";
    }

    @RequestMapping(value = "/materialDtlPage.do")
    public String materialDtlPage(@ModelAttribute("search")MaterialVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = materialService.select(search);
        } else {
            rtn = new RtnVO();
            rtn.setObj(new MaterialVO());
        }


        CompanyVO company = new CompanyVO();
        company.setCustTypeCd("MAT"); // 자재처
        RtnVO selCompanyRtn = companyService.searchList(company);
        if (selCompanyRtn.getRc() == 0) {
        	List<CompanyVO> companyList = (List<CompanyVO>)selCompanyRtn.getObj();
        	model.addAttribute("mat_cust_list", companyList);
        }

        wedEnd(request, rtn, model);
        return "/basicinfo/materialDtl";
    }

    @RequestMapping(value = "/materialSaveAct.do")
    public ModelAndView materialSaveAct(@ModelAttribute("obj")MaterialVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
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
            rtn = materialService.select(obj);
            if(rtn.getObj() == null) {
                rtn = materialService.insert(obj);
            }else {
                MaterialVO division = (MaterialVO)rtn.getObj();
                if ("N".equals(division.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = materialService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.");
                }
            }
        } else if ("U".equals(obj.getCrudType())) {
        	rtn = materialService.select(obj);
        	if(rtn.getObj() == null) {
        		rtn = materialService.update(obj);
            }else {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("정보가 이미 등록되어 있습니다.");
            }
        } else if ("D".equals(obj.getCrudType())) {
            rtn = materialService.delete(obj);
            ProductVO param = new ProductVO();
            param.setFactoryCd("HW");
            param.setItemCd(obj.getMatCd());
            productService.delete(param);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 저장 타입 :"+obj.getCrudType());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }

    @RequestMapping(value = "/getPopMaterialList.do")
    public ModelAndView getPopMaterialList(@ModelAttribute("search")MaterialVO param, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = materialService.searchList(param);
        wedEnd(request, rtn, mav);
        return mav;
    }

    /**
     * @param paramData
     * @param request
     * @param model
     * @throws Exception
     */
    @RequestMapping(value = "/uploadMaterialExcel.do", method = RequestMethod.POST)
    public ModelAndView companySetApiExcel(@RequestBody String paramData, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();

        String temp = URLDecoder.decode(paramData, "UTF-8");
        temp = temp.replaceAll("=", "");    // json 문자열 뒤에 '='문자가 붙어와서 제거함.

        List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
        resultMap = (List<Map<String,Object>>)JSONArray.fromObject(temp);

        for (Map<String, Object> map : resultMap ) {
            MaterialVO obj = new MaterialVO();

            obj.setFactoryCd(String.valueOf(proPertyService.getFactoryCd()));
            obj.setWriteId(String.valueOf(getUserId(request)));
            obj.setUpdateId(String.valueOf(getUserId(request)));
            obj.setMatCd(String.valueOf(map.get("matCd")==null?"":map.get("matCd")));
            obj.setMatTypeCd(String.valueOf(map.get("matTypeCd")==null?"":map.get("matTypeCd")));
            obj.setMatNm(String.valueOf(map.get("matNm")==null?"":map.get("matNm")));
            obj.setMatCustCd(String.valueOf(map.get("matCustCd")==null?"":map.get("matCustCd")));
//            obj.setMatCustNm(String.valueOf(map.get("matCustNm")==null?"":map.get("matCustNm")));
            //obj.setMatStyle(String.valueOf(map.get("matStyle")==null?"":map.get("matStyle")));
            //double meight = 0;
            String matWeight = (String.valueOf(map.get("matWeight"))).replaceAll("\\,","");
            if(matWeight == null || "".equals(matWeight.trim())) matWeight = "0";
            //obj.setMatWeight(Double.parseDouble(matWeight));
            //obj.setWeightCd(String.valueOf(map.get("weightCd")==null?"":map.get("weightCd")));
//            obj.setUseYn(String.valueOf(map.get("useYn")));
            obj.setUseYn("Y");

            rtn = materialService.select(obj);
            if(rtn.getObj() == null) {
                rtn = materialService.insert(obj);
            } else {
                MaterialVO material = (MaterialVO)rtn.getObj();
                if ("N".equals(material.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = materialService.update(obj);
                } else {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg("정보가 이미 등록되어 있습니다.엑셀의 </br>코드값을 지우거나 기존값을 삭제하세요.");
                }
            }
        }

        wedEnd(request, rtn, mav);
        return mav;
    }

}
