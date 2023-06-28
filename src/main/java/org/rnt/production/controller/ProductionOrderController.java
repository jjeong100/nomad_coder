package org.rnt.production.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.GlvConst;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.BomHistoryService;
import org.rnt.com.entity.service.CompanyService;
import org.rnt.com.entity.service.EquipService;
import org.rnt.com.entity.service.ProductService;
import org.rnt.com.entity.service.ProductionActService;
import org.rnt.com.entity.service.ProductionOrderService;
import org.rnt.com.entity.vo.BomHistoryVO;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.entity.vo.ProductionActVO;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.net.Tcp;
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
public class ProductionOrderController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="productionOrderService")
    private ProductionOrderService productionOrderService;
    
    @Resource(name="productionActService")
    private ProductionActService productionActService;
    
    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="bomHistoryService")
    private BomHistoryService bomHistoryService;
    
    @Resource(name="equipService")
    private EquipService equipService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @Resource(name="companyService")
    private CompanyService companyService;
    
    @RequestMapping(value = "/productionMonthListPage.do")
    public String productionMonthListPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);

        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.lastDay(DateUtil.formatCurrent("yyyyMMdd"), "yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        search.setLastDay(DateUtil.lastDay(search.getSearchFromDate()));
        
        RtnVO rtn = productionOrderService.searchMonthList(search);
        
        wedEnd(request, rtn, model);
        return "/production/productionMonthList";
    }
    
    @RequestMapping(value = "/productionOrderListPage.do")
    public String productionOrderListPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);

        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
            search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
            search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
            search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        
        //---------------------------------------------------------------------
        // 고객사
        //---------------------------------------------------------------------
        CompanyVO company = new CompanyVO();
        company.setCustTypeCd("COD"); // 고객사
        RtnVO selCompanyRtn = companyService.searchList(company);
        if (selCompanyRtn.getRc() == 0) {
            List<CompanyVO> companyList = (List<CompanyVO>)selCompanyRtn.getObj();
            model.addAttribute("company_list", companyList);
        }
        
        //---------------------------------------------------------------------
        // 제품
        //---------------------------------------------------------------------
        ProductVO product = new ProductVO();
        RtnVO selProductRtn = productService.searchList(product);
        if (selProductRtn.getRc() == 0) {
            List<ProductVO> productList = (List<ProductVO>)selProductRtn.getObj();
            model.addAttribute("product_list", productList);
        }
        
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("PO_CALLDT");    
            search.setSortType("DESC");
        }
        
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex 
        RtnVO rtn = productionOrderService.searchList(search);
        RtnVO rtnTotCnt = productionOrderService.searchListTotCnt(search);
        
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
            search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
            search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        getCode("BARCODE_PRINT", model);
        wedEnd(request, rtn, model);
        return "/production/productionOrderList";
    }
    
    @RequestMapping(value = "/productionOrderDtlPage.do")
    public String productionOrderDtlPage(@ModelAttribute("search")ProductionOrderVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        RtnVO rtn = null;
        search.setFactoryCd(proPertyService.getFactoryCd());
        if ("R".equals(search.getCrudType())) {
            rtn = productionOrderService.select(search);
        } else {
            rtn = new RtnVO();
            ProductionOrderVO obj = new ProductionOrderVO();
            obj.setPoCalldt(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setMdDelidt(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setProdDt(DateUtil.formatCurrent("yyyy/MM/dd"));
            obj.setPoTargetdt(DateUtil.formatCurrent("yyyy/MM/dd"));
            rtn.setObj(obj);
        }

        //---------------------------------------------------------------------
        // 제품
        //---------------------------------------------------------------------
        ProductVO product = new ProductVO();
        RtnVO selProductRtn = productService.searchList(product);
        if (selProductRtn.getRc() == 0) {
            List<ProductVO> productList = (List<ProductVO>)selProductRtn.getObj();
            model.addAttribute("product_list", productList);
        }
        
        //---------------------------------------------------------------------
        // 고객사
        //---------------------------------------------------------------------
        CompanyVO company = new CompanyVO();
        company.setCustTypeCd("COD"); // 고객사
        RtnVO selCustCompanyRtn = companyService.searchList(company);
        if (selCustCompanyRtn.getRc() == 0) {
            List<CompanyVO> custCompanyList = (List<CompanyVO>)selCustCompanyRtn.getObj();
            model.addAttribute("cust_list", custCompanyList);
        }
        
        getCode("PROD_TYPE_CD",model);
        
        wedEnd(request, rtn, model);
        return "/production/productionOrderDtl";
    }
    
    @RequestMapping(value = "/productionOrderSaveAct.do")
    public ModelAndView productionOrderSaveAct(@ModelAttribute("obj")ProductionOrderVO productionOrder, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        if(log.isDebugEnabled()) {
            log.debug("getCrudType:"+productionOrder.getCrudType());
        }
        
        String prodTypeCd = productionOrder.getProdTypeCd();
        
        productionOrder.setFactoryCd(proPertyService.getFactoryCd());
        productionOrder.setWriteId(getUserId(request));
        productionOrder.setUpdateId(getUserId(request));
        
        rtn = productionOrderService.select(productionOrder);
        
        /**
         * 저장/수정 검증 .. 
         * 상태가 완료 일때는 저장/수정이 되면 안된다.
         */
        ProductionOrderVO select = (ProductionOrderVO)rtn.getObj();
        
        String preProdtypeCd = select == null ? "WAT":select.getProdTypeCd();
        
        if(!"END".equals(preProdtypeCd)) { //지시 테이블의 상태가 종료 이면 아무작없도 할수 없다.
            if ("C".equals(productionOrder.getCrudType())) {
               
                if(rtn.getObj() == null) {
                    rtn = productionOrderService.insert(productionOrder);
                } else {
                    ProductionOrderVO order = (ProductionOrderVO) rtn.getObj();
                    if ("N".equals(order.getUseYn())) {
                        productionOrder.setUseYn("Y");
                        rtn = productionOrderService.update(productionOrder);
                    } else {
                        rtn.setRc(GlvConst.RC_ERROR);
                        rtn.setMsg("정보가 이미 등록되어 있습니다.");
                    }
                }
                
            } else if ("U".equals(productionOrder.getCrudType())) {
                rtn = productionOrderService.update(productionOrder);
                
                // 대기상태에서 수정했을 경우 자재소요량 정보 재생성
                if( "WAT".equals(preProdtypeCd) ) {
                	rtn = productionOrderService.updateMstAct(productionOrder);
                	rtn = productionOrderService.updateMatRequire(productionOrder);
                }
                
                //실적 테이블(MPO011) 변경
                //완료 상태는 변경할수 없음 1번 변경후 변경안됨.(화면처리 완료시 클릭 안됨)
                //취소,중지 변경시  호기별 모든 실적 취소, 중지
                //대기나 작업중 변경시 전 상태 복원
                /**
                 * 처리
                 * productionActService 전 상태 처리
                 * prev_prod_type_cd : 실적 테이블 이전상태 값
                 * 
                 * 지시가 대기 일때는 실적을 전상태로 업뎃 
                 * 지시가 작업중 일때는 실적을 전상태로 업뎃 
                 * 지시가 완료 일때는 실적 상태를 완료 상태로 변경
                 * 지시가 취소 일때는 실적 상태를 취소로 변경
                 * 지시가 중지 일때는 실적 상태를 중지로 변경
                 */
                ProductionActVO productionAct = new ProductionActVO();
                productionAct.setFactoryCd(productionOrder.getFactoryCd());
                productionAct.setProdSeq(productionOrder.getProdSeq());
                productionAct.setUpdateId(productionOrder.getUpdateId());
                
                switch(prodTypeCd) {
                case "WAT":  //대기
                case "ING":  //작업중
                	productionAct.setPreProdTypeCd(preProdtypeCd);
                    rtn = productionActService.updateRevertProdTypeCd(productionAct);
                    break;
                case "END":  //완료
                    productionAct.setProdTypeCd(prodTypeCd);
                    rtn = productionActService.updateEndProdTypeCd(productionAct);
                    break;
                case "CAN":  //취소
                case "STP":  //중지
                    productionAct.setProdTypeCd(prodTypeCd);
                    rtn = productionActService.updateProdTypeCd(productionAct);
                    break;
                }
                
                // 마지막 실적 정보 대기상태로 변경
                if( !"CAN".equals(prodTypeCd) && !"STP".equals(prodTypeCd) ) {
	                productionAct = setOrderToAct(productionOrder);
	                rtn = productionActService.update(productionAct);
                }
            } else if ("D".equals(productionOrder.getCrudType())) {
                rtn = productionOrderService.delete(productionOrder);
            } else {
                rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("알수없는 저장 타입 :"+productionOrder.getCrudType());
            }
        }else {
             rtn.setRc(GlvConst.RC_ERROR);
             rtn.setMsg("이미 상태가 완료 상태입니다.</br> 재 조회 하십시요.");
        }
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    @RequestMapping(value = "/getBomHistoryData.do")
    public ModelAndView getBomHistoryData(@ModelAttribute("bomHis")BomHistoryVO bomHis, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = bomHistoryService.searchList(bomHis);
        wedEnd(request, rtn, mav);
        return mav;
    }
    
    /**
     * 실적저장을위한 멤버변수 복사
     * @return
     */
    public ProductionActVO setOrderToAct(ProductionOrderVO productionOrder) {
        ProductionActVO result = new ProductionActVO();
        result.setFactoryCd(productionOrder.getFactoryCd());
        result.setWorkactSeq(productionOrder.getWorkactSeq());
        
        result.setProdSeq(productionOrder.getProdSeq());
        result.setOperCd(productionOrder.getOperCd());
        result.setOperSeq(productionOrder.getOperSeq());
        result.setItemCd(productionOrder.getItemCd());
        result.setBomVer(productionOrder.getBomVer());
        result.setBomStdt(productionOrder.getBomStdt());
        result.setWorkstDt(productionOrder.getWorkstDt());
        result.setWorkedDt(productionOrder.getWorkedDt());
        result.setProdTypeCd("WAT");
        
        result.setPoQty(productionOrder.getPoQty());
        result.setActokQty(productionOrder.getActokQty());
        result.setActbadQty(productionOrder.getActbadQty());
        result.setWriteId(productionOrder.getWriteId());
        result.setUpdateId(productionOrder.getUpdateId());
        
        //수정일때 처음 지시의 배정 값에 대해 수정안함
        
        //최초 등록자
        result.setSabunId(productionOrder.getWriteId());
        
        return result;
    }
}
