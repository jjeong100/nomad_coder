package org.rnt.production.controller;

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
import org.rnt.com.entity.service.BomService;
import org.rnt.com.entity.service.EquipService;
import org.rnt.com.entity.service.ProductionActService;
import org.rnt.com.entity.service.ProductionMstActService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.service.WorkactErrorService;
import org.rnt.com.entity.service.WorkactPerformanceService;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.entity.vo.WorkactErrorVO;
import org.rnt.com.entity.vo.WorkactPerformanceVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.vo.RtnVO;
import org.rnt.production.vo.ProductionComParamVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;

@Controller
public class ProductionWorkactController extends BaseController {

    protected Log log = LogFactory.getLog(this.getClass());

    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;

    @Resource(name="productionMstActService")
    private ProductionMstActService productionMstActService;

    @Resource(name="productionActService")
    private ProductionActService productionActService;

    @Resource(name="workactPerformanceService")
    private WorkactPerformanceService workactPerformanceService;

    @Resource(name="workactErrorService")
    private WorkactErrorService workactErrorService;

    @Resource(name="bomService")
    private BomService bomService;

    @Resource(name="equipService")
    private EquipService equipService;

    @Resource(name="proPertyService")
    private ProPertyService proPertyService;

    @RequestMapping(value = "/productionWorkactPage.do")
    public String productionWorkactPage(@ModelAttribute("search") ProductionComParamVO prodComVo, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = new RtnVO();

        // 공정 마스터
        ProductionMstActVO paramMstAct = new ProductionMstActVO();
        paramMstAct.setFactoryCd(proPertyService.getFactoryCd());
        paramMstAct.setWorkactMstSeq(prodComVo.getWorkactMstSeq());
        RtnVO rtnMstVo = productionMstActService.select(paramMstAct);
        model.addAttribute("productionMstActVo", rtnMstVo.getObj());

        // 공정 실적 리스트
        ProductionActVO paramAct = new ProductionActVO();
        paramAct.setFactoryCd(proPertyService.getFactoryCd());
        paramAct.setSearchProdSeq(prodComVo.getProdSeq());
        paramAct.setSearchOperCd(prodComVo.getOperCd());
        paramAct.setItemCd(prodComVo.getItemCd());
        RtnVO rtnProductionActList = productionActService.searchList(paramAct);
        model.addAttribute("productionActList", rtnProductionActList.getObj());

        EquipVO equip = new EquipVO();
        RtnVO selEquipRtn = new RtnVO();
        
        
        System.out.println("prodComVo.getOperCd() ■■■■■■■■■■■■■ : "+ prodComVo.getOperCd());
        
        if("OP04".equals(prodComVo.getOperCd())) {
            selEquipRtn = equipService.searchListAutoLine(equip);
        }else {
            selEquipRtn = equipService.searchListNotAutoLine(equip);
        }
        
        if (selEquipRtn.getRc() == 0) {
            List<EquipVO> equipList = (List<EquipVO>)selEquipRtn.getObj();
            model.addAttribute("equipList", equipList);
        }

        getCode("BAD_CD",model);
        getCode("PERFORMANCE_TYPE_CD",model);

        wedEnd(request, rtn, model);
        return "/production/productionWorkact";
    }

    @RequestMapping(value = "/getProductionWorkactData.do")
    public ModelAndView productionWorkactPressPage(@ModelAttribute("search") ProductionComParamVO prodComVo, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();

        // 작업실적조회
        ProductionActVO paramProductionAct = new ProductionActVO();
        paramProductionAct.setFactoryCd(proPertyService.getFactoryCd());
        paramProductionAct.setProdSeq(prodComVo.getProdSeq());
        paramProductionAct.setWorkactSeq(prodComVo.getWorkactSeq());
        paramProductionAct.setOperCd(prodComVo.getOperCd());
        RtnVO rtnProductionAct = productionActService.select(paramProductionAct);
        model.addAttribute("productionActVo", rtnProductionAct.getObj());

//        // 생산실적 성능 (MPO013)
//        WorkactPerformanceVO workactPerformanceVo = new WorkactPerformanceVO();
//        workactPerformanceVo.setFactoryCd(proPertyService.getFactoryCd());
//        workactPerformanceVo.setWorkactSeq(prodComVo.getWorkactSeq());
//        RtnVO rtnWorkactInfo = workactPerformanceService.selectList(workactPerformanceVo);
//        model.addAttribute("workactPerformanceList", rtnWorkactInfo.getObj());

        wedEnd(request, rtn, model);
        return mav;
    }

    @RequestMapping(value = "/productionWorkactPerformanceSaveAct.do")
    public ModelAndView productionWorkactPerformanceSaveAct(@ModelAttribute("workactPerformanceVO") WorkactPerformanceVO workactPerformanceVo, ProductionComParamVO prodComVo, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();

        workactPerformanceVo.setFactoryCd(proPertyService.getFactoryCd());
        workactPerformanceVo.setWriteId(getUserId(request));
        workactPerformanceVo.setUpdateId(getUserId(request));

        if ("D".equals(workactPerformanceVo.getCrudType())) {
            String[] workactPerformanceSeqList = workactPerformanceVo.getWorkactPerformanceSeq().split(",");

            WorkactPerformanceVO paramWorkactPerformanceVo;
            for (int i = 0; i < workactPerformanceSeqList.length; i++) {
                paramWorkactPerformanceVo = new WorkactPerformanceVO();
                paramWorkactPerformanceVo.setFactoryCd(proPertyService.getFactoryCd());
                paramWorkactPerformanceVo.setWorkactSeq(workactPerformanceVo.getWorkactSeq());
                paramWorkactPerformanceVo.setWorkactPerformanceSeq(workactPerformanceSeqList[i]);
                paramWorkactPerformanceVo.setUpdateId(getUserId(request));
                rtn = workactPerformanceService.delete(paramWorkactPerformanceVo);

                if( rtn.getRc() == GlvConst.RC_ERROR ) {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg(rtn.getMsg());
                    wedEnd(request, rtn, model);
                    return mav;
                }
            }

        } else {
            /******************************************    배정수량 체크 [S]   ******************************************/
            ProductionActVO paramProductionActVo = new ProductionActVO();
            paramProductionActVo.setFactoryCd(proPertyService.getFactoryCd());
            paramProductionActVo.setWorkactSeq(workactPerformanceVo.getWorkactSeq());
            paramProductionActVo.setWorkactPerformanceSeq(workactPerformanceVo.getWorkactPerformanceSeq());
            RtnVO rtnProductionAct = productionActService.selectPreSumQty(paramProductionActVo);

            ProductionActVO selProductionAct = (ProductionActVO) rtnProductionAct.getObj();
            int poQty = selProductionAct.getPoQty();
            int actokQty = selProductionAct.getActokQty();
            int actbadQty = selProductionAct.getActbadQty();

            if( poQty < actokQty + actbadQty + workactPerformanceVo.getActokQty() ) {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("양품+불량수량이 배정수량을 초과하였습니다.");
                wedEnd(request, rtn, model);
                return mav;
            }
            /******************************************    배정수량 체크 [E]   ******************************************/

            rtn = workactPerformanceService.select(workactPerformanceVo);

            if( rtn.getObj() == null ) {
                workactPerformanceService.insert(workactPerformanceVo);
            } else {
                workactPerformanceService.update(workactPerformanceVo);
            }
        }

        wedEnd(request, rtn, model);
        return mav;
    }

    @RequestMapping(value = "/productionWorkactErrorSaveAct.do")
    public ModelAndView productionWorkactErrorSaveAct(@ModelAttribute("workactErrorVo") WorkactErrorVO workactErrorVo, ProductionComParamVO prodComVo, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();

        workactErrorVo.setFactoryCd(proPertyService.getFactoryCd());
        workactErrorVo.setWriteId(getUserId(request));
        workactErrorVo.setUpdateId(getUserId(request));

        if ("D".equals(workactErrorVo.getCrudType())) {
            String[] workactBadSeqList = workactErrorVo.getWorkactBadSeq().split(",");

            WorkactErrorVO paramWorkactErrorVo;
            for (int i = 0; i < workactBadSeqList.length; i++) {
                paramWorkactErrorVo = new WorkactErrorVO();
                paramWorkactErrorVo.setFactoryCd(proPertyService.getFactoryCd());
                paramWorkactErrorVo.setWorkactSeq(workactErrorVo.getWorkactSeq());
                paramWorkactErrorVo.setWorkactBadSeq(workactBadSeqList[i]);
                paramWorkactErrorVo.setUpdateId(getUserId(request));
                rtn = workactErrorService.delete(paramWorkactErrorVo);

                if( rtn.getRc() == GlvConst.RC_ERROR ) {
                    rtn.setRc(GlvConst.RC_ERROR);
                    rtn.setMsg(rtn.getMsg());
                    wedEnd(request, rtn, model);
                    return mav;
                }
            }

        } else {
            /******************************************    배정수량 체크 [S]   ******************************************/
            ProductionActVO paramProductionActVo = new ProductionActVO();
            paramProductionActVo.setFactoryCd(proPertyService.getFactoryCd());
            paramProductionActVo.setWorkactSeq(workactErrorVo.getWorkactSeq());
            paramProductionActVo.setWorkactBadSeq(workactErrorVo.getWorkactBadSeq());
            RtnVO rtnProductionAct = productionActService.selectPreSumQty(paramProductionActVo);

            ProductionActVO selProductionAct = (ProductionActVO) rtnProductionAct.getObj();
            int poQty = selProductionAct.getPoQty();
            int actokQty = selProductionAct.getActokQty();
            int actbadQty = selProductionAct.getActbadQty();

            if( poQty < actokQty + actbadQty + workactErrorVo.getBadQty() ) {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("양품+불량수량이 배정수량을 초과하였습니다.");
                wedEnd(request, rtn, model);
                return mav;
            }
            /******************************************    배정수량 체크 [E]   ******************************************/

            rtn = workactErrorService.select(workactErrorVo);

            if( rtn.getObj() == null ) {
                workactErrorService.insert(workactErrorVo);
            } else {
                workactErrorService.update(workactErrorVo);
            }
        }

        wedEnd(request, rtn, model);
        return mav;
    }

    /**
     * @param paramData
     * @param request
     * @param model
     * @throws Exception
     */
    @RequestMapping(value = "/uploadExcelProductionWorkactError.do", method = RequestMethod.POST)
    public ModelAndView uploadExcelProductionWorkactError(@RequestBody String paramData, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();

        String temp = URLDecoder.decode(paramData, "UTF-8");
        temp = temp.replaceAll("=", "");    // json 문자열 뒤에 '='문자가 붙어와서 제거함.

        List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
        resultMap = (List<Map<String,Object>>)JSONArray.fromObject(temp);

        for (Map<String, Object> map : resultMap ) {
            WorkactErrorVO obj = new WorkactErrorVO();
            obj.setFactoryCd(proPertyService.getFactoryCd());
            obj.setWriteId(getUserId(request));
            obj.setUpdateId(getUserId(request));
            obj.setUseYn("Y");

            obj.setWorkactSeq(String.valueOf(map.get("workactSeq")==null?"":map.get("workactSeq")));
            obj.setBadCd(String.valueOf(map.get("badCd")==null?"":map.get("badCd")));
            obj.setBadQty(map.get("badQty")==null?0:Integer.parseInt(String.valueOf(map.get("badQty"))));

            rtn = workactErrorService.select(obj);
            if(rtn.getObj() == null) {
                rtn = workactErrorService.insert(obj);
            } else {
                WorkactErrorVO workactErrorVo = (WorkactErrorVO) rtn.getObj();
                if ("N".equals(workactErrorVo.getUseYn())) {
                    obj.setUseYn("Y");
                    rtn = workactErrorService.update(obj);
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
