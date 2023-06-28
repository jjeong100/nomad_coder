package org.rnt.material.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.MaterialCloseService;
import org.rnt.com.entity.service.StoreHouseService;
import org.rnt.com.entity.vo.MaterialCloseVO;
import org.rnt.com.entity.vo.StoreHouseVO;
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
public class MaterialMonthCloseController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="materialMenuService")
    private MaterialMenuService materialMenuService;
    
    @Resource(name="materialCloseService")
    private MaterialCloseService materialCloseService;
    
    @Resource(name="storeHouseService")
    private StoreHouseService storeHouseService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/materialMonthCloseListPage.do")
    public String materialMonthCloseListPage(@ModelAttribute("search")MonthCloseInVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜(월) 조회 초기 값 처리 : 시작일 내년 1월, 종료월 당월 
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatCurrent("yyyy")+"01");
        	search.setSearchToDate(DateUtil.formatCurrent("yyyyMM"));
        } else {
        	search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
        	search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }

        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("MAGAM_YYYYMM");    
            search.setSortType("DESC");
        }
        search.setPaging(true); 
        RtnVO rtn = materialMenuService.searchMonthCloseList(search);
        RtnVO rtnTotCnt = materialMenuService.searchMonthCloseListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 창고 조회 조건 처리 select box  
        //---------------------------------------------------------------------
        StoreHouseVO storeHouse = new StoreHouseVO();
        storeHouse.setSearchAreaCd("MAT_HOUSE");
        RtnVO selStoreHouseRtn = storeHouseService.searchList(storeHouse);
        if (selStoreHouseRtn.getRc() == 0) {
            List<StoreHouseVO> storeHouseList = (List<StoreHouseVO>)selStoreHouseRtn.getObj();
            model.addAttribute("store_house_list", storeHouseList);
        }
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatMonthAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatMonthAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/material/materialMonthCloseList";
    }
    
    
    @RequestMapping(value = "/createMonthClose.do")
    public ModelAndView createMonthClose(@ModelAttribute("obj")MonthCloseInVO obj, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        if(log.isDebugEnabled()) {
            log.debug("getMagamYn:"+obj.getMagamYn());
        }
        
        if (!StrUtil.isNull(obj.getMagamYyyymm())) {
            obj.setMagamYyyymm(obj.getMagamYyyymm().replace("/", ""));
        }
        obj.setFactoryCd(proPertyService.getFactoryCd());
        obj.setWriteId(getUserId(request));
        obj.setUpdateId(getUserId(request));
        
        if ("Y".equals(obj.getMagamYn())) {
            //-----------------------------------------------------------------
            // 마감 VALIDATION : 해당 창고에 이전월 중 마감 하지 않은 월이 존재 하면 해당 월 부터 마감 해야함.  
            //-----------------------------------------------------------------
            RtnVO selRtn = materialMenuService.selectMinUnCloseMonth(obj);
            if (selRtn.getRc() == GlvConst.RC_SUCC) {
                String minUnCloseMonth = (String)selRtn.getObj();
                if (!StrUtil.isNull(minUnCloseMonth)) {
                    if (!minUnCloseMonth.equals(obj.getMagamYyyymm())) {
                        rtn.setRc(GlvConst.RC_ERROR);
                        rtn.setMsg("마감하지 않은 이전월이 존재합니다. 이전월 마감후 마감 할 수 있습니다.");
                        wedEnd(request, rtn, mav);
                        return mav;
                    }
                }
            } else {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("이전 마감월 조회 실패 !!");
                wedEnd(request, rtn, mav);
                return mav;
            }
            
            //-----------------------------------------------------------------
            // 마감 처리
            //-----------------------------------------------------------------
            MaterialCloseVO param = new MaterialCloseVO();
            param.setFactoryCd(proPertyService.getFactoryCd());
            param.setMagamYyyymm(obj.getMagamYyyymm());
            param.setMagamYn("Y");
            param.setWorkshopCd(obj.getWorkshopCd());
            param.setMcontrolId(getUserId(request));
            param.setWriteId(getUserId(request));
            param.setUpdateId(getUserId(request));
            rtn = materialCloseService.insert(param);
        } else if ("N".equals(obj.getMagamYn())) {
            //-----------------------------------------------------------------
            // 마감 해재 VALIDATION : 최종 마감 월 부터 마감 해제 가능함.  
            //-----------------------------------------------------------------
            RtnVO selRtn = materialMenuService.selectMaxCloseMonth(obj);
            if (selRtn.getRc() == GlvConst.RC_SUCC) {
                String maxCloseMonth = (String)selRtn.getObj();
                if (!StrUtil.isNull(maxCloseMonth)) {
                    if (!maxCloseMonth.equals(obj.getMagamYyyymm())) {
                        rtn.setRc(GlvConst.RC_ERROR);
                        rtn.setMsg("최종 마감 월 부터 마감 해제 가능합니다. ");
                        wedEnd(request, rtn, mav);
                        return mav;
                    }
                }
            } else {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("최종 마감월 조회 실패 !!");
                wedEnd(request, rtn, mav);
                return mav;
            }
            //-----------------------------------------------------------------
            // 마감 해제 처리 
            //-----------------------------------------------------------------
            MaterialCloseVO param = new MaterialCloseVO();
            param.setFactoryCd(proPertyService.getFactoryCd());
            param.setMendynSeq(obj.getMendynSeq());
            rtn = materialCloseService.deleteMonthClose(param);
        } else {
            rtn.setRc(GlvConst.RC_ERROR);
            rtn.setMsg("알수없는 마감 타입 :"+obj.getMagamYn());
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
}
